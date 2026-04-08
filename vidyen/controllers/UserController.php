<?php

header("Content-Type: application/json");

require_once __DIR__ . '/../models/UserModel.php';

class UserController {

    private $userModel;

    public function __construct($db){
        $this->userModel = new UserModel($db);
    }

    public function getUsers(){
        $result = $this->userModel->getRegistrations();
        $users = $result->fetchAll(PDO::FETCH_ASSOC);

        echo json_encode([
            "status" => "success",
            "message" => "Users fetched successfully",
            "data" => $users
        ]);
    }

    public function register(){

        $data = json_decode(file_get_contents("php://input"), true);

        if(empty($data["full_name"]) || empty($data["email"])){

            echo json_encode([
                "status" => "error",
                "message" => "Full name and email are required"
            ]);
            return;
        }

    $this->userModel->createRegistration($data);

    echo json_encode([
        "status" => "success",
        "message" => "Registration successful"
    ]);

    }
}