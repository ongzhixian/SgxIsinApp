/*
Description:
    Script to create `instrument` table in `financial` database.
    
History:

Date            Description
2022-09-07      Create `instrument` table

INSERT INTO `instrument` (market_identifier_id, code, name, counter, isin) VALUES (?, ?, ?, ?, ?)
sgx_isin_layout = r"(?P<name>.{50})(?P<status>.{10})(?P<isin>.{20})(?P<code>.{10})(?P<counter>.+)"

*/

USE `financial`;


CREATE TABLE IF NOT EXISTS `instrument` (
	`id`					INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`market_identifier_id` 	VARCHAR(8) NOT NULL,
	`code` 			        VARCHAR(10) NOT NULL,
	`name` 			        VARCHAR(50) NOT NULL,
	`counter` 			    VARCHAR(30) NULL,
	`isin` 			        VARCHAR(20) NULL,
	`exclusion_id`			INT UNSIGNED NULL,
	`cre_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	`upd_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_u_idx` (`market_identifier_id`, `code`)
)
COLLATE='utf8mb4_unicode_ci'
;

