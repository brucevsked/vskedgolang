CREATE USER 'starenglishbook'@'localhost' IDENTIFIED BY 'starenglishbook';

CREATE DATABASE `starenglishbook` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

grant all  on `starenglishbook`.* to 'starenglishbook'@'localhost' ;