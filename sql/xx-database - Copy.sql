/*
Description:
    A
    
History:

Date            Description
2022-09-05      a

*/

USE `financial`;

CREATE TABLE IF NOT EXISTS `country` (
	`id`					INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` 			        VARCHAR(60) NOT NULL,
	`code2` 				VARCHAR(2) NOT NULL,
	`code3` 				VARCHAR(3) NOT NULL,
	`m49` 					INT NOT NULL,
	`cre_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	`upd_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `code2_u_idx` (`code2`)
)
COLLATE='utf8mb4_unicode_ci'
;

CREATE TABLE IF NOT EXISTS `currency` (
	`id`					INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`country_name` 			VARCHAR(60) NOT NULL,
	`name`					VARCHAR(70) NOT NULL,
	`code` 					VARCHAR(3) NULL,
	`number` 				INT NULL,
	`minor_unit`			INT NULL,
	`cre_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	`upd_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `country_name_u_idx` (`country_name`, `code`)
)
COLLATE='utf8mb4_unicode_ci'
;


CREATE TABLE IF NOT EXISTS `market_identifier` (
	`id`					INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`country_name` 			VARCHAR(60) NOT NULL,
	`country_code2`			VARCHAR(2) NOT NULL,
	`code` 					VARCHAR(4) NOT NULL,
	`operating_mic`			VARCHAR(4) NOT NULL,
	`name` 					VARCHAR(110) NOT NULL,
	`short_name`			VARCHAR(60) NULL,
	`city`					VARCHAR(60) NULL,
	`url`					VARCHAR(128) NULL,
	`status`				VARCHAR(10) NULL,
	`comments`				VARCHAR(255) NULL,
	`cre_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	`upd_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `country_name_u_idx` (`country_name`, `code`)
)
COLLATE='utf8mb4_unicode_ci'
;


CREATE TABLE `instrument` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`username`      VARCHAR(50) NOT NULL,
	`password_hash` VARCHAR(50) NOT NULL,
	`password_salt` VARCHAR(50) NOT NULL,
	`create_dt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	`password_update_dt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	`last_login_dt` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `login_u_idx` (`username`)
)
COLLATE='utf8mb4_unicode_ci'
;


CREATE TABLE IF NOT EXISTS `portfolio` (
	`id`					INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` 			        VARCHAR(50) NOT NULL,
	`cre_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	`upd_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_u_idx` (`name`)
)
COLLATE='utf8mb4_unicode_ci'
;
