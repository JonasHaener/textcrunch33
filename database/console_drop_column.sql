


ALTER TABLE `textcrunch`.`lang_japanese` 
DROP COLUMN `japanese_id`,
DROP COLUMN `category_id`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`block_id`),
DROP INDEX `japanese_id_UNIQUE` ;

ALTER TABLE `textcrunch`.`lang_polish` 
DROP COLUMN `polish_id`,
DROP COLUMN `category_id`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`block_id`),
DROP INDEX `polish_id_UNIQUE` ;

ALTER TABLE `textcrunch`.`lang_spanish` 
DROP COLUMN `spanish_id`,
DROP COLUMN `category_id`,
DROP PRIMARY KEY,
ADD PRIMARY KEY (`block_id`),
DROP INDEX `spanish_id_UNIQUE` ;

