<?php

use Dotenv\Dotenv;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface;
use Slim\Factory\AppFactory;
use PDO;

require_once dirname(__DIR__) . '/vendor/autoload.php';
(new Entrypoint())->main();

class Entrypoint {
    function main(): void {
        Dotenv::createImmutable(dirname(__DIR__))->load();
        $app = AppFactory::create();
        $app->add(array($this, 'authenticate'));
//        phpinfo();
        $pdo = new PDO(
            dsn: "mysql:host={$_ENV['DB_HOST']};port={$_ENV['DB_PORT']};dbname={$_ENV['DB_NAME']}",
            username: $_ENV['DB_USERNAME'],
            password: $_ENV['DB_PASSWORD'],
            options: array(
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            )
        );
        phpinfo();

        $app->any('/ping', function(Request $request, Response $response) {
            $response->getBody()->write('meow');
            return $response;
        });
        $app->post('/admin/initDatabase', function(Request $request, Response $response){
            return $this->response($response);
        });
        $app->run();
    }
    protected function response(Response $r, $body = array(), $code = 200): Response {
        $r->getBody()->write(json_encode($body));
        $r = $r->withHeader('Content-Type', 'application/json');
        $r = $r->withStatus($code);
        return $r;
    }

    protected function getPostParams(Request $req): ?array {
        return json_decode($req->getBody(), true);
    }

    protected function getGetParams(Request $req): ?array {
        return $req->getQueryParams();
    }

    /** Проверяет авторизацию запроса и добавляет в объект Request аутентифицированную информацию о пользователе */
    function authenticate(Request $request, RequestHandlerInterface $handler): Response {
        $authHeader = $request->getHeader('X-Authorization')[0];
        $username = explode(':', $authHeader)[0] ?? '';
        $password = explode(':', $authHeader)[1] ?? '';

        $isAdmin= false;
        if ($username === $_ENV['ADMIN_USERNAME'] && $password === $_ENV['ADMIN_PASSWORD']) $isAdmin = true;
        $request = $request->withAttribute('admin', $isAdmin);
        return $handler->handle($request);

    }


}

