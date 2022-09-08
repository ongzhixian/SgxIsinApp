/*
Description:
    Script to create `exclusion` table in `financial` database.
	This is use to indicate why a specific record in a database should be exclude.
    
History:

Date            Description
2022-09-07      Create `06-exclusion` table


*/

USE `financial`;


CREATE TABLE IF NOT EXISTS `exclusion` (
	`id`					INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`rationale` 			VARCHAR(128) NOT NULL,
	`cre_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	`upd_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `rationale_u_idx` (`rationale`)
)
COLLATE='utf8mb4_unicode_ci'
;

INSERT INTO `exclusion` (id, rationale) VALUES
	(1, 'Missing data');