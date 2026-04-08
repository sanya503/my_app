<?php

$conn = new PDO("mysql:host=localhost;dbname=vidyen", "root", "");

$data = json_decode(file_get_contents("php://input"));

$email = $data->email;
$password = $data->password;

$query = "SELECT * FROM users WHERE email=:email AND password=:password";

$stmt = $conn->prepare($query);

$stmt->bindParam(":email", $email);
$stmt->bindParam(":password", $password);

$stmt->execute();

if($stmt->rowCount() > 0){
    echo json_encode(["status"=>"success"]);
}else{
    echo json_encode(["status"=>"error"]);
}

?>