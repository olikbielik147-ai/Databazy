
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema movielens_tags
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema movielens_tags
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `movielens_tags` DEFAULT CHARACTER SET utf8 ;
USE `movielens_tags` ;

-- -----------------------------------------------------
-- Table `movielens_tags`.`dim_genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movielens_tags`.`dim_genre` (
  `genre_id` INT(11) NOT NULL,
  `genre_name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `movielens_tags`.`dim_movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movielens_tags`.`dim_movies` (
  `movie_id` INT(11) NOT NULL,
  `movie_title` VARCHAR(255) NULL DEFAULT NULL,
  `release_year` CHAR(4) NULL DEFAULT NULL,
  PRIMARY KEY (`movie_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `movielens_tags`.`bridge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movielens_tags`.`bridge` (
  `bridge_id` INT(11) NOT NULL AUTO_INCREMENT,
  `movie_id` INT(11) NOT NULL,
  `genre_id` INT(11) NOT NULL,
  PRIMARY KEY (`bridge_id`),
  INDEX `fk_movie_genre_movie_idx` (`movie_id` ASC) VISIBLE,
  INDEX `fk_movie_genre_genre_idx` (`genre_id` ASC) VISIBLE,
  CONSTRAINT `fk_bridge_genre`
    FOREIGN KEY (`genre_id`)
    REFERENCES `movielens_tags`.`dim_genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_bridge_movie`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movielens_tags`.`dim_movies` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `movielens_tags`.`dim_date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movielens_tags`.`dim_date` (
  `dim_id` INT(11) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `day` INT(11) NULL DEFAULT NULL,
  `day_of_week` VARCHAR(15) NULL DEFAULT NULL,
  `week` INT(11) NULL DEFAULT NULL,
  `month` INT(11) NULL DEFAULT NULL,
  `month_name` VARCHAR(15) NULL DEFAULT NULL,
  `year` INT(11) NULL DEFAULT NULL,
  `quartal` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`dim_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `movielens_tags`.`dim_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movielens_tags`.`dim_time` (
  `time_id` INT(11) NOT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `hour` INT(11) NULL DEFAULT NULL,
  `minute` INT(11) NULL DEFAULT NULL,
  `second` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`time_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `movielens_tags`.`dim_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movielens_tags`.`dim_users` (
  `user_id` INT(11) NOT NULL,
  `gender` CHAR(1) NULL DEFAULT NULL,
  `age` INT(11) NULL DEFAULT NULL,
  `zip_code` VARCHAR(225) NULL DEFAULT NULL,
  `age_group_name` VARCHAR(45) NULL DEFAULT NULL,
  `occupation_name` VARCHAR(225) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `movielens_tags`.`tags`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `movielens_tags`.`tags` (
  `tag_id` INT(11) NOT NULL AUTO_INCREMENT,
  `date_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `movie_id` INT(11) NOT NULL,
  `time_id` INT(11) NOT NULL,
  `tag_name` VARCHAR(4000) NULL DEFAULT NULL,
  `tag_count` INT(11) NULL DEFAULT NULL,
  `tag_length` INT(11) NULL DEFAULT NULL,
  `word_count` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`tag_id`),
  INDEX `fk_tags_date_idx` (`date_id` ASC) VISIBLE,
  INDEX `fk_tags_user_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_tags_movie_idx` (`movie_id` ASC) VISIBLE,
  INDEX `fk_tags_time_idx` (`time_id` ASC) VISIBLE,
  CONSTRAINT `fk_tags_date`
    FOREIGN KEY (`date_id`)
    REFERENCES `movielens_tags`.`dim_date` (`dim_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tags_movie`
    FOREIGN KEY (`movie_id`)
    REFERENCES `movielens_tags`.`dim_movies` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tags_time`
    FOREIGN KEY (`time_id`)
    REFERENCES `movielens_tags`.`dim_time` (`time_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tags_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `movielens_tags`.`dim_users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
