<?php

use Dotenv\Dotenv;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Psr\Http\Server\RequestHandlerInterface;
use Slim\Factory\AppFactory;

require_once dirname(__DIR__) . '/vendor/autoload.php';
(new Entrypoint())->main();

class Entrypoint {
    function main(): void {
        Dotenv::createImmutable(dirname(__DIR__))->load();
        $app = AppFactory::create();
        $app->add(array($this, 'authenticate'));

        $app->any('/ping', function(Request $request, Response $response) {
            $response->getBody()->write('meow');
            return $response;
        });

//        $app->post('/admin/initDatabase', function(Request $request, Response $response){
//            if (!$request->getAttribute('admin')) return $this->response($response, ['status' => 'нет подключения'],403);
//            return $this->response($response, ['status' => 'OK'],201);
//        });

        $tables = [
            'accommodation',
            'city',
            'customer',
            'excursion',
            'travel',
            'voucher',
            'voucher_accommodation',
            'voucher_excursion',
            'voucher_travel'
        ];

        foreach ($tables as $table) {
            $dbEditor = new DbEditor($table);
            $app->any("/$table/getAll", function(Request $request, Response $response) use ($dbEditor) {
                return $this->response($response, $dbEditor->getAll());
            });

            $app->post("/$table/create", function(Request $request, Response $response) use ($dbEditor) {
                $dbEditor->create($this->getPostParams($request));
                return $this->response($response);
            });

            $app->post("/$table/update", function(Request $request, Response $response) use ($dbEditor) {
                $dbEditor->update($this->getGetParams($request)['id'], $this->getPostParams($request));
                return $this->response($response);
            });

            $app->post("/$table/delete", function(Request $request, Response $response) use ($dbEditor) {
                $dbEditor->delete($this->getGetParams($request)['id']);
                return $this->response($response);
            });
        }


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

