<?php

use Dotenv\Dotenv;
use eduard\controllers\sys\SysController;
use eduard\models\Config;
use eduard\review\ReviewController;
use eduard\server\Server;
use eduard\services\auth\AuthService;
use eduard\storage\database\Database;
use Psr\Http\Message\ResponseInterface as Response;
use Psr\Http\Message\ServerRequestInterface as Request;
use Slim\Factory\AppFactory;
use PDO;

require_once dirname(__DIR__) . '/vendor/autoload.php';
(new Entrypoint())->main();

class Entrypoint {
    function main(): void {
        $env = Dotenv::createArrayBacked(dirname(__DIR__))->load();
        $app = AppFactory::create();
        $pdo = new PDO(
            dsn: "mysql:host={$env['DB_HOST']};port={$env['DB_PORT']};dbname={$env['DB_NAME']}",
            username: $env['DB_USERNAME'],
            password: $env['DB_PASSWORD'],
            options: array(
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            )
        );

        $app->any('/ping', function(Request $request, Response $response) {
            $this->m();
            $response->getBody()->write('meow');
            return $response;
        });

        $app->run();
    }

    function m(){}
}

