<?php

class UserModel {

    private $conn;
    private $table = "registration_details";

    public function __construct($db){
        $this->conn = $db;
    }

    // Get all registrations from the full details table
    public function getRegistrations(){

        $query = "SELECT * FROM " . $this->table;

        $stmt = $this->conn->prepare($query);
        $stmt->execute();

        return $stmt;
    }

    public function createRegistration($data){

        $query = "INSERT INTO " . $this->table . "
        (username,password,name_prefix,full_name,age,gender,delegate_type,designation,
        college_name,university_name,address,city,state,country,pincode,
        email,mobile,attend_workshops,attend_preconference,
        preconference1,preconference2,preconference3,preconference4,
        workshop,oral_presentation,posters,yenvision_talk)

        VALUES
        (:username,:password,:name_prefix,:full_name,:age,:gender,:delegate_type,:designation,
        :college_name,:university_name,:address,:city,:state,:country,:pincode,
        :email,:mobile,:attend_workshops,:attend_preconference,
        :preconference1,:preconference2,:preconference3,:preconference4,
        :workshop,:oral_presentation,:posters,:yenvision_talk)";

        $stmt = $this->conn->prepare($query);

        $stmt->bindValue(":username", $data["username"] ?? null);
        $stmt->bindValue(":password", $data["password"] ?? null);
        $stmt->bindValue(":name_prefix", $data["name_prefix"] ?? null);
        $stmt->bindValue(":full_name", $data["full_name"] ?? null);
        $stmt->bindValue(":age", $data["age"] ?? null);
        $stmt->bindValue(":gender", $data["gender"] ?? null);
        $stmt->bindValue(":delegate_type", $data["delegate_type"] ?? null);
        $stmt->bindValue(":designation", $data["designation"] ?? null);
        $stmt->bindValue(":college_name", $data["college_name"] ?? null);
        $stmt->bindValue(":university_name", $data["university_name"] ?? null);
        $stmt->bindValue(":address", $data["address"] ?? null);
        $stmt->bindValue(":city", $data["city"] ?? null);
        $stmt->bindValue(":state", $data["state"] ?? null);
        $stmt->bindValue(":country", $data["country"] ?? null);
        $stmt->bindValue(":pincode", $data["pincode"] ?? null);
        $stmt->bindValue(":email", $data["email"] ?? null);
        $stmt->bindValue(":mobile", $data["mobile"] ?? null);
        $stmt->bindValue(":attend_workshops", isset($data["attend_workshops"]) ? (int)$data["attend_workshops"] : 0, PDO::PARAM_INT);
        $stmt->bindValue(":attend_preconference", isset($data["attend_preconference"]) ? (int)$data["attend_preconference"] : 0, PDO::PARAM_INT);
        $stmt->bindValue(":preconference1", isset($data["preconference1"]) ? (int)$data["preconference1"] : 0, PDO::PARAM_INT);
        $stmt->bindValue(":preconference2", isset($data["preconference2"]) ? (int)$data["preconference2"] : 0, PDO::PARAM_INT);
        $stmt->bindValue(":preconference3", isset($data["preconference3"]) ? (int)$data["preconference3"] : 0, PDO::PARAM_INT);
        $stmt->bindValue(":preconference4", isset($data["preconference4"]) ? (int)$data["preconference4"] : 0, PDO::PARAM_INT);
        $stmt->bindValue(":workshop", isset($data["workshop"]) ? (int)$data["workshop"] : 0, PDO::PARAM_INT);
        $stmt->bindValue(":oral_presentation", isset($data["oral_presentation"]) ? (int)$data["oral_presentation"] : 0, PDO::PARAM_INT);
        $stmt->bindValue(":posters", isset($data["posters"]) ? (int)$data["posters"] : 0, PDO::PARAM_INT);
        $stmt->bindValue(":yenvision_talk", isset($data["yenvision_talk"]) ? (int)$data["yenvision_talk"] : 0, PDO::PARAM_INT);

        return $stmt->execute();
    }
}
?>