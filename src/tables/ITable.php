<?php

class DbEditor {
    public PDO $pdo;

    function __construct(
        public string $table,
    ) {

        $this->pdo = new PDO(
            dsn: "mysql:host={$_ENV['DB_HOST']};port={$_ENV['DB_PORT']};dbname={$_ENV['DB_NAME']}",
            username: $_ENV['DB_USERNAME'],
            password: $_ENV['DB_PASSWORD'],
            options: array(
                PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            )
        );
    }


    function create(array $fields): void {
        $columns = '';
        foreach ($fields as $key => $value) {
            $columns .= ' ' . $key . ',';
        }
        $columns = substr($columns, 0, strlen($columns) - 1);

        $values = '';
        foreach ($fields as $key => $value) {
            $values .= ' ' . $value . ',';
        }
        $values = substr($values, 0, strlen($values) - 1);

        $sql = "insert into $this->table ($columns) values ($values);";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();
    }

    function getAll(): array {
        $stmt = $this->pdo->prepare('select * from ' . $this->table);
        $stmt->execute();
        $res = [];
        foreach ($stmt as $row) {
            $res[] = $row;
        }
        return $res;
    }

    function update(int $id, array $fields): void {
        $str = [];
        foreach ($fields as $column => $value)
        {
            $str[] = $column . ' = ' . $value . '';
        }
        $str = implode(',',$str);
        $sql = "update $this->table set
                    $str
                    where `id` = $id;
        ";
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute();
    }

    function delete(int $id): void {
        $stmt = $this->pdo->prepare("delete from $this->table where `id` = :id");
        $stmt->bindValue(':id', $id, PDO::PARAM_INT);
        $stmt->execute();
    }
}