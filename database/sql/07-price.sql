/*
Description:
    Script to create `exclusion` table in `financial` database.
    This is use to indicate why a specific record in a database should be exclude.
    
History:

Date            Description
2022-09-07      Create `06-exclusion` table


*/

USE `financial`;


CREATE TABLE IF NOT EXISTS `price` (
    `id`					INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `trade_date` 			DATETIME NOT NULL,
    `market_identifier_id` 	VARCHAR(8) NOT NULL,
    `code` 			        VARCHAR(10) NOT NULL,
    `open`					DECIMAL(15,6) NULL,
    `high`					DECIMAL(15,6) NULL,
    `low`					DECIMAL(15,6) NULL,
    `close`					DECIMAL(15,6) NULL,
    `adjusted_close`        DECIMAL(15,6) NULL,
    `volume`                INT UNSIGNED NULL,
    `cre_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    `upd_dt` 				DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (`id`),
    UNIQUE INDEX `rationale_u_idx` (`rationale`)
)
COLLATE='utf8mb4_unicode_ci'
;

