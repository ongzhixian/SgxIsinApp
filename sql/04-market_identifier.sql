/*
Description:
    Script to create `instrument` table in `financial` database.
    
History:

Date            Description
2022-09-07      Create `instrument` table

*/

USE `financial`;


CREATE TABLE IF NOT EXISTS `market_identifier` (
	`id`					INT UNSIGNED NOT NULL AUTO_INCREMENT,
	`code` 			        VARCHAR(8) NOT NULL,
	`alias`					VARCHAR(8) NULL,
	`ric_suffix`			VARCHAR(8) NULL,
	`is_iso`				TINYINT(1) NOT NULL,
	`cre_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	`upd_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `name_u_idx` (`name`)
)
COLLATE='utf8mb4_unicode_ci'
;

-- Seed data
INSERT INTO market_identifier(code, alias, ric_suffix, is_iso) VALUES
    ('XSES', 'SGX', 	'SI', 1),
	('XASX', 'ASX', 	'AX', 1),
	('XSFE', 'SFE', 	NULL, 1),
    ('AORA', 'OANDA', 	NULL, 0);