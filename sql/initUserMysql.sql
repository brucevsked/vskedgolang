CREATE USER 'golangtest'@'localhost' IDENTIFIED BY 'golangtest';

CREATE DATABASE `golangtest` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

grant all  on `golangtest`.* to 'golangtest'@'localhost' ;