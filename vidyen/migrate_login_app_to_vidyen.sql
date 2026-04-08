-- Migration script to move existing Vidyen-related tables from login_app into the new vidyen database
-- Run this once from a MySQL client that has access to both databases.

CREATE DATABASE IF NOT EXISTS vidyen;
USE vidyen;

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE IF NOT EXISTS vidyen.users LIKE login_app.users;
INSERT IGNORE INTO vidyen.users SELECT * FROM login_app.users;

CREATE TABLE IF NOT EXISTS vidyen.abstracts LIKE login_app.abstracts;
INSERT IGNORE INTO vidyen.abstracts SELECT * FROM login_app.abstracts;

CREATE TABLE IF NOT EXISTS vidyen.authors LIKE login_app.authors;
INSERT IGNORE INTO vidyen.authors SELECT * FROM login_app.authors;

CREATE TABLE IF NOT EXISTS vidyen.registration_details LIKE login_app.registration_details;
INSERT IGNORE INTO vidyen.registration_details SELECT * FROM login_app.registration_details;

SET FOREIGN_KEY_CHECKS = 1;
