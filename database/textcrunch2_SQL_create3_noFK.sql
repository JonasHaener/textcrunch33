SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

SHOW WARNINGS;
CREATE SCHEMA IF NOT EXISTS `textcrunch` DEFAULT CHARACTER SET latin1 ;
SHOW WARNINGS;
USE `textcrunch` ;

-- -----------------------------------------------------
-- Table `textcrunch`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`categories` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`categories` (
  `category_id` INT(10) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `created` TIMESTAMP NULL,
  `notes` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
COMMENT = 'holds categories to be assigned to textblocks\n';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`users` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`users` (
  `user_id` INT(10) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `rights` INT(10) NOT NULL,
  `created` TIMESTAMP NOT NULL,
  `last_login` TIMESTAMP NULL,
  `notes` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
COMMENT = 'holds user data';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`blocks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`blocks` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`blocks` (
  `block_id` INT(10) NOT NULL AUTO_INCREMENT,
  `category_id` INT(10) NOT NULL,
  `user_id` INT(10) NOT NULL,
  `created` TIMESTAMP NULL,
  `notes` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`block_id`, `category_id`),
  INDEX `category_idx` (`category_id` ASC),
  INDEX `user_idx` (`user_id` ASC))
ENGINE = InnoDB
COMMENT = 'text block navigator';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`blocks_deleted`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`blocks_deleted` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`blocks_deleted` (
  `del_block_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(10) NOT NULL,
  `category_id` INT(10) NOT NULL,
  `german` LONGTEXT NULL DEFAULT NULL,
  `english` LONGTEXT NULL DEFAULT NULL,
  `french` LONGTEXT NULL DEFAULT NULL,
  `dutch` LONGTEXT NULL DEFAULT NULL,
  `italian` LONGTEXT NULL DEFAULT NULL,
  `polish` LONGTEXT NULL DEFAULT NULL,
  `spanish` LONGTEXT NULL DEFAULT NULL,
  `japanese` LONGTEXT NULL DEFAULT NULL,
  `placeholder1` LONGTEXT NULL DEFAULT NULL,
  `placeholder2` LONGTEXT NULL DEFAULT NULL,
  `placeholder3` LONGTEXT NULL DEFAULT NULL,
  `created` TIMESTAMP NULL,
  `notes` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`del_block_id`, `user_id`),
  INDEX `block_id` (`del_block_id` ASC),
  INDEX `user_id` (`user_id` ASC),
  INDEX `fk_blocks_deleted_categories1_idx` (`category_id` ASC))
ENGINE = InnoDB
COMMENT = 'holds text blocks that were deleted';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`lang_german`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`lang_german` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_german` (
  `content` LONGTEXT NULL DEFAULT NULL,
  `block_id` INT(10) NOT NULL,
  `category_id` INT(10) NOT NULL,
  PRIMARY KEY (`block_id`, `category_id`))
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`projects`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`projects` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`projects` (
  `project_id` INT(10) NOT NULL AUTO_INCREMENT,
  `user_id` INT(10) NOT NULL,
  `project_name` VARCHAR(100) NULL DEFAULT NULL,
  `collection` VARCHAR(500) NULL DEFAULT NULL,
  `created` TIMESTAMP NULL,
  `notes` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`project_id`, `user_id`),
  INDEX `project_idx` (`project_id` ASC),
  INDEX `user_idx` (`user_id` ASC))
ENGINE = InnoDB
COMMENT = 'saves user projects, block id collection\n';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`tags` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`tags` (
  `tag_id` INT(10) NOT NULL AUTO_INCREMENT,
  `user_id` INT(10) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `created` TIMESTAMP NULL,
  `notes` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`tag_id`),
  INDEX `tag_idx` (`tag_id` ASC),
  INDEX `fk_tags_users1_idx` (`user_id` ASC))
ENGINE = InnoDB
COMMENT = 'holds user created tags';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`tag_switch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`tag_switch` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`tag_switch` (
  `tag_id` INT(10) NOT NULL,
  `block_id` INT(10) NOT NULL,
  PRIMARY KEY (`block_id`, `tag_id`),
  INDEX `blocks_idx` (`block_id` ASC),
  INDEX `tag_idx` (`tag_id` ASC))
ENGINE = InnoDB;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`lang_english`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`lang_english` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_english` (
  `content` LONGTEXT NULL DEFAULT NULL,
  `block_id` INT(10) NOT NULL,
  `category_id` INT(10) NOT NULL,
  PRIMARY KEY (`block_id`, `category_id`))
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`lang_french`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`lang_french` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_french` (
  `content` LONGTEXT NULL DEFAULT NULL,
  `block_id` INT(10) NOT NULL,
  `category_id` INT(10) NOT NULL,
  PRIMARY KEY (`block_id`, `category_id`))
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`lang_dutch`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`lang_dutch` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_dutch` (
  `content` LONGTEXT NULL DEFAULT NULL,
  `block_id` INT(10) NOT NULL,
  `category_id` INT(10) NOT NULL,
  PRIMARY KEY (`block_id`, `category_id`))
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`lang_italian`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`lang_italian` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_italian` (
  `content` LONGTEXT NULL DEFAULT NULL,
  `block_id` INT(10) NOT NULL,
  `category_id` INT(10) NOT NULL,
  PRIMARY KEY (`block_id`, `category_id`))
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`lang_polish`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`lang_polish` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_polish` (
  `content` LONGTEXT NULL DEFAULT NULL,
  `block_id` INT(10) NOT NULL,
  `category_id` INT(10) NOT NULL,
  PRIMARY KEY (`block_id`, `category_id`))
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`lang_spanish`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`lang_spanish` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_spanish` (
  `content` LONGTEXT NULL DEFAULT NULL,
  `blocks_block_id` INT(10) NOT NULL,
  `blocks_category_id` INT(10) NOT NULL,
  PRIMARY KEY (`blocks_block_id`, `blocks_category_id`))
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `textcrunch`.`lang_japanese`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `textcrunch`.`lang_japanese` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_japanese` (
  `content` LONGTEXT NULL DEFAULT NULL,
  `block_id` INT(10) NOT NULL,
  `category_id` INT(10) NOT NULL,
  PRIMARY KEY (`block_id`, `category_id`))
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
