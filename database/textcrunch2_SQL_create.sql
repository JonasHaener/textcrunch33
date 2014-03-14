SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `textcrunch` DEFAULT CHARACTER SET latin1 ;
USE `textcrunch` ;

-- -----------------------------------------------------
-- Table `textcrunch`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`categories` (
  `category_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `notes` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
COMMENT = 'holds categories to be assigned to textblocks\n';


-- -----------------------------------------------------
-- Table `textcrunch`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`users` (
  `user_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NULL DEFAULT NULL,
  `rights` INT(10) UNSIGNED NOT NULL,
  `created` TIMESTAMP NULL DEFAULT NULL,
  `last_login` DATETIME NULL DEFAULT NULL,
  `notes` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `user_id_UNIQUE` (`user_id` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC))
ENGINE = InnoDB
COMMENT = 'holds user data';


-- -----------------------------------------------------
-- Table `textcrunch`.`blocks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`blocks` (
  `block_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` INT(10) UNSIGNED NOT NULL,
  `user_id` INT(10) UNSIGNED NOT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `notes` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`block_id`, `category_id`, `user_id`),
  INDEX `category_idx` (`category_id` ASC),
  INDEX `user_idx` (`user_id` ASC),
  CONSTRAINT `fk_categories`
    FOREIGN KEY (`category_id`)
    REFERENCES `textcrunch`.`categories` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `textcrunch`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'text block navigator';


-- -----------------------------------------------------
-- Table `textcrunch`.`blocks_deleted`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`blocks_deleted` (
  `block_id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(10) NOT NULL,
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
  `placeholder3` LONGTEXT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `notes` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`block_id`, `user_id`),
  INDEX `block_id` (`block_id` ASC),
  INDEX `user_id` (`user_id` ASC),
  CONSTRAINT `user_id`
    FOREIGN KEY (`user_id`)
    REFERENCES `textcrunch`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'holds text blocks that were deleted';


-- -----------------------------------------------------
-- Table `textcrunch`.`lang_german`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_german` (
  `blocks_block_id` INT(10) UNSIGNED NOT NULL,
  `blocks_category_id` INT(10) UNSIGNED NOT NULL,
  `blocks_user_id` INT(10) UNSIGNED NOT NULL,
  `content` LONGTEXT NULL,
  PRIMARY KEY (`blocks_block_id`, `blocks_category_id`, `blocks_user_id`),
  INDEX `fk_lang_german_blocks_idx` (`blocks_block_id` ASC, `blocks_category_id` ASC, `blocks_user_id` ASC),
  CONSTRAINT `fk_lang_german_blocks`
    FOREIGN KEY (`blocks_block_id` , `blocks_category_id` , `blocks_user_id`)
    REFERENCES `textcrunch`.`blocks` (`block_id` , `category_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';


-- -----------------------------------------------------
-- Table `textcrunch`.`projects`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`projects` (
  `project_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT(10) NOT NULL,
  `project_name` VARCHAR(100) NULL DEFAULT NULL,
  `collection` VARCHAR(500) NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `notes` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`project_id`, `user_id`),
  INDEX `project_idx` (`project_id` ASC),
  INDEX `user_idx` (`user_id` ASC),
  CONSTRAINT `fk_projects_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `textcrunch`.`users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'saves user projects, block id collection\n';


-- -----------------------------------------------------
-- Table `textcrunch`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`tags` (
  `tag_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` INT(10) NOT NULL,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `created` DATETIME NULL DEFAULT NULL,
  `notes` VARCHAR(500) NULL DEFAULT NULL,
  PRIMARY KEY (`tag_id`, `user_id`),
  INDEX `tag_idx` (`tag_id` ASC),
  INDEX `user_idx` (`user_id` ASC),
  CONSTRAINT `user_id`
    FOREIGN KEY ()
    REFERENCES `textcrunch`.`users` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'holds user created tags';


-- -----------------------------------------------------
-- Table `textcrunch`.`tag_switch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`tag_switch` (
  `tags_tag_id` INT(10) UNSIGNED NOT NULL,
  `blocks_block_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`blocks_block_id`, `tags_tag_id`),
  INDEX `blocks_idx` (`blocks_block_id` ASC),
  INDEX `tag_idx` (`tags_tag_id` ASC),
  CONSTRAINT `fk_tags_has_blocks_tags1`
    FOREIGN KEY (`tags_tag_id`)
    REFERENCES `textcrunch`.`tags` (`tag_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tags_has_blocks_blocks1`
    FOREIGN KEY (`blocks_block_id`)
    REFERENCES `textcrunch`.`blocks` (`block_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `textcrunch`.`lang_english`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_english` (
  `blocks_block_id` INT(10) UNSIGNED NOT NULL,
  `blocks_category_id` INT(10) UNSIGNED NOT NULL,
  `blocks_user_id` INT(10) UNSIGNED NOT NULL,
  `content` LONGTEXT NULL,
  PRIMARY KEY (`blocks_block_id`, `blocks_category_id`, `blocks_user_id`),
  INDEX `fk_lang_english_blocks_idx` (`blocks_block_id` ASC, `blocks_category_id` ASC, `blocks_user_id` ASC),
  CONSTRAINT `fk_lang_english_blocks`
    FOREIGN KEY (`blocks_block_id` , `blocks_category_id` , `blocks_user_id`)
    REFERENCES `textcrunch`.`blocks` (`block_id` , `category_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';


-- -----------------------------------------------------
-- Table `textcrunch`.`lang_french`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_french` (
  `blocks_block_id` INT(10) UNSIGNED NOT NULL,
  `blocks_category_id` INT(10) UNSIGNED NOT NULL,
  `blocks_user_id` INT(10) UNSIGNED NOT NULL,
  `content` LONGTEXT NULL,
  PRIMARY KEY (`blocks_block_id`, `blocks_category_id`, `blocks_user_id`),
  INDEX `fk_lang_french_blocks_idx` (`blocks_block_id` ASC, `blocks_category_id` ASC, `blocks_user_id` ASC),
  CONSTRAINT `fk_lang_french_blocks`
    FOREIGN KEY (`blocks_block_id` , `blocks_category_id` , `blocks_user_id`)
    REFERENCES `textcrunch`.`blocks` (`block_id` , `category_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';


-- -----------------------------------------------------
-- Table `textcrunch`.`lang_dutch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_dutch` (
  `blocks_block_id` INT(10) UNSIGNED NOT NULL,
  `blocks_category_id` INT(10) UNSIGNED NOT NULL,
  `blocks_user_id` INT(10) UNSIGNED NOT NULL,
  `content` LONGTEXT NULL,
  PRIMARY KEY (`blocks_block_id`, `blocks_category_id`, `blocks_user_id`),
  INDEX `fk_lang_dutch_blocks_idx` (`blocks_block_id` ASC, `blocks_category_id` ASC, `blocks_user_id` ASC),
  CONSTRAINT `fk_lang_dutch_blocks`
    FOREIGN KEY (`blocks_block_id` , `blocks_category_id` , `blocks_user_id`)
    REFERENCES `textcrunch`.`blocks` (`block_id` , `category_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';


-- -----------------------------------------------------
-- Table `textcrunch`.`lang_italian`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_italian` (
  `blocks_block_id` INT(10) UNSIGNED NOT NULL,
  `blocks_category_id` INT(10) UNSIGNED NOT NULL,
  `blocks_user_id` INT(10) UNSIGNED NOT NULL,
  `content` LONGTEXT NULL,
  PRIMARY KEY (`blocks_block_id`, `blocks_category_id`, `blocks_user_id`),
  INDEX `fk_lang_italian_blocks_idx` (`blocks_block_id` ASC, `blocks_category_id` ASC, `blocks_user_id` ASC),
  CONSTRAINT `fk_lang_italian_blocks`
    FOREIGN KEY (`blocks_block_id` , `blocks_category_id` , `blocks_user_id`)
    REFERENCES `textcrunch`.`blocks` (`block_id` , `category_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';


-- -----------------------------------------------------
-- Table `textcrunch`.`lang_polish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_polish` (
  `blocks_block_id` INT(10) UNSIGNED NOT NULL,
  `blocks_category_id` INT(10) UNSIGNED NOT NULL,
  `blocks_user_id` INT(10) UNSIGNED NOT NULL,
  `content` LONGTEXT NULL,
  PRIMARY KEY (`blocks_block_id`, `blocks_category_id`, `blocks_user_id`),
  INDEX `fk_lang_polish_blocks_idx` (`blocks_block_id` ASC, `blocks_category_id` ASC, `blocks_user_id` ASC),
  CONSTRAINT `fk_lang_polish_blocks`
    FOREIGN KEY (`blocks_block_id` , `blocks_category_id` , `blocks_user_id`)
    REFERENCES `textcrunch`.`blocks` (`block_id` , `category_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';


-- -----------------------------------------------------
-- Table `textcrunch`.`lang_spanish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_spanish` (
  `blocks_block_id` INT(10) UNSIGNED NOT NULL,
  `blocks_category_id` INT(10) UNSIGNED NOT NULL,
  `blocks_user_id` INT(10) UNSIGNED NOT NULL,
  `content` LONGTEXT NULL,
  PRIMARY KEY (`blocks_block_id`, `blocks_category_id`, `blocks_user_id`),
  INDEX `fk_lang_spanish_blocks_idx` (`blocks_block_id` ASC, `blocks_category_id` ASC, `blocks_user_id` ASC),
  CONSTRAINT `fk_lang_spanish_blocks`
    FOREIGN KEY (`blocks_block_id` , `blocks_category_id` , `blocks_user_id`)
    REFERENCES `textcrunch`.`blocks` (`block_id` , `category_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';


-- -----------------------------------------------------
-- Table `textcrunch`.`lang_japanese`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `textcrunch`.`lang_japanese` (
  `blocks_block_id` INT(10) UNSIGNED NOT NULL,
  `blocks_category_id` INT(10) UNSIGNED NOT NULL,
  `blocks_user_id` INT(10) UNSIGNED NOT NULL,
  `content` LONGTEXT NULL,
  PRIMARY KEY (`blocks_block_id`, `blocks_category_id`, `blocks_user_id`),
  INDEX `fk_lang_japanese_blocks_idx` (`blocks_block_id` ASC, `blocks_category_id` ASC, `blocks_user_id` ASC),
  CONSTRAINT `fk_lang_japanese_blocks`
    FOREIGN KEY (`blocks_block_id` , `blocks_category_id` , `blocks_user_id`)
    REFERENCES `textcrunch`.`blocks` (`block_id` , `category_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'holds german text blocks\n';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
