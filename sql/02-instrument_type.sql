/*
Description:
    Script to create `instrument_type` database in `financial` database.
    
History:

Date            Description
2022-09-05      Create `instrument_type` table

*/

USE `financial`;


CREATE TABLE IF NOT EXISTS `instrument_type` (
	`id`					INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` 			        VARCHAR(50) NOT NULL,
	`cre_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	`upd_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_u_idx` (`name`)
)
COLLATE='utf8mb4_unicode_ci'
;


-- Seed data
INSERT INTO instrument_type(name) VALUES 
    ('Stock')
    , ('REIT')
    , ('Business Trust')
    , ('ETF')
    , ('Structured Warrant')
    , ('Daily Leverage Certificate')
    , ('Leveraged & Inverse Product')
    , ('Company Warrant')
    , ('ADR');
