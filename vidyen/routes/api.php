<?php

header("Content-Type: application/json");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST");

require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../controllers/UserController.php';

$database = new Database();
$db = $database->connect();

$userController = new UserController($db);

$action = $_GET['action'] ?? '';

switch($action){

    case "users":
        $userController->getUsers();
        break;

    case "register":
        $userController->register();
        break;

    default:
        echo json_encode([
            "status" => "error",
            "message" => "Invalid API"
        ]);
}
?>