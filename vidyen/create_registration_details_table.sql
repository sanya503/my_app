-- SQL script to create the full registration details table for Vidyen
-- This table stores every field from the registration page in its own column.

CREATE DATABASE IF NOT EXISTS vidyen;
USE vidyen;

CREATE TABLE IF NOT EXISTS registration_details (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) DEFAULT NULL,
    password VARCHAR(255) DEFAULT NULL,
    name_prefix VARCHAR(50) DEFAULT NULL,
    full_name VARCHAR(150) NOT NULL,
    age SMALLINT DEFAULT NULL,
    gender VARCHAR(20) DEFAULT NULL,
    delegate_type VARCHAR(100) DEFAULT NULL,
    designation VARCHAR(150) DEFAULT NULL,
    college_name VARCHAR(255) DEFAULT NULL,
    university_name VARCHAR(255) DEFAULT NULL,
    address VARCHAR(255) DEFAULT NULL,
    city VARCHAR(100) DEFAULT NULL,
    state VARCHAR(100) DEFAULT NULL,
    country VARCHAR(100) DEFAULT NULL,
    pincode VARCHAR(20) DEFAULT NULL,
    email VARCHAR(150) NOT NULL,
    mobile VARCHAR(50) DEFAULT NULL,
    attend_workshops TINYINT(1) DEFAULT 0,
    attend_preconference TINYINT(1) DEFAULT 0,
    preconference1 TINYINT(1) DEFAULT 0,
    preconference2 TINYINT(1) DEFAULT 0,
    preconference3 TINYINT(1) DEFAULT 0,
    preconference4 TINYINT(1) DEFAULT 0,
    workshop TINYINT(1) DEFAULT 0,
    oral_presentation TINYINT(1) DEFAULT 0,
    posters TINYINT(1) DEFAULT 0,
    yenvision_talk TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
