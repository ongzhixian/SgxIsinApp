/*
Description:
    Script to create `asset_class` table in `financial` database.
    
History:

Date            Description
2022-09-05      Create `asset_class` table

*/

USE `financial`;


CREATE TABLE IF NOT EXISTS `asset_class` (
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
INSERT INTO asset_class(id, name) VALUES
    (1, 'CASH'),
    (2, 'EQUITY'),
    (3, 'FIXED INCOME'),
    (4, 'FOREIGN CURRENCY'),
    (5, 'REAL ESTATE'),
    (6, 'COMMODITY'),
    (7, 'INDEX');
    

