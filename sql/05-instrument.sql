/*
Description:
    Script to create `instrument` table in `financial` database.
    
History:

Date            Description
2022-09-07      Create `instrument` table

*/

USE `financial`;


CREATE TABLE IF NOT EXISTS `instrument` (
	`id`					INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`name` 			        VARCHAR(50) NOT NULL,
	`cre_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	`upd_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_u_idx` (`name`)
)
COLLATE='utf8mb4_unicode_ci'
;

