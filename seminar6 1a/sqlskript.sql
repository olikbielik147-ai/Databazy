-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema new_schema2
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`dim_genre`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dim_genre` (
  `genre_id` INT(11) NOT NULL,
  `genre_name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`dim_movies`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dim_movies` (
  `movie_id` INT(11) NOT NULL,
  `title_movie` VARCHAR(25) NULL DEFAULT NULL,
  `release_year` CHAR(4) NULL DEFAULT NULL,
  PRIMARY KEY (`movie_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`bridge`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`bridge` (
  `bridge_id` INT(11) NOT NULL AUTO_INCREMENT,
  `movie_id` INT(11) NOT NULL,
  `genre_id` INT(11) NOT NULL,
  PRIMARY KEY (`bridge_id`),
  INDEX `fk_dim_movies_has_dim_genre_dim_genre1_idx` (`genre_id` ASC) VISIBLE,
  INDEX `fk_dim_movies_has_dim_genre_dim_movies1_idx` (`movie_id` ASC) VISIBLE,
  CONSTRAINT `fk_dim_movies_has_dim_genre_dim_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `mydb`.`dim_genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dim_movies_has_dim_genre_dim_movies1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `mydb`.`dim_movies` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`dim_date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dim_date` (
  `dim_id` INT(11) NOT NULL,
  `rated_at` DATETIME NULL DEFAULT NULL,
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
-- Table `mydb`.`dim_time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dim_time` (
  `time_id` INT(11) NOT NULL,
  `rated_at` DATETIME NULL DEFAULT NULL,
  `hour` INT(11) NULL DEFAULT NULL,
  `minute` INT(11) NULL DEFAULT NULL,
  `second` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`time_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`dim_users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`dim_users` (
  `user_id` INT(11) NOT NULL,
  `gender` CHAR(1) NULL DEFAULT NULL,
  `dm_userscol` VARCHAR(45) NULL DEFAULT NULL,
  `age` INT(11) NULL DEFAULT NULL,
  `zip_code` VARCHAR(225) NULL DEFAULT NULL,
  `age_group_name` VARCHAR(45) NULL DEFAULT NULL,
  `occupation_name` VARCHAR(225) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `mydb`.`fact_rating`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`fact_rating` (
  `rating_id` INT(11) NOT NULL AUTO_INCREMENT,
  `rating` DECIMAL(3,1) NULL DEFAULT NULL,
  `date_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  `movie_id` INT(11) NOT NULL,
  `time_id` INT(11) NOT NULL,
  PRIMARY KEY (`rating_id`),
  INDEX `fk_fact_rating_dm_date1_idx` (`date_id` ASC) VISIBLE,
  INDEX `fk_fact_rating_dm_users1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_fact_rating_1_idx` (`movie_id` ASC) VISIBLE,
  INDEX `fk_fact_rating_dim_time1_idx` (`time_id` ASC) VISIBLE,
  CONSTRAINT `fk_fact_rating_1`
    FOREIGN KEY (`movie_id`)
    REFERENCES `mydb`.`dim_movies` (`movie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_rating_dim_time1`
    FOREIGN KEY (`time_id`)
    REFERENCES `mydb`.`dim_time` (`time_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_rating_dm_date1`
    FOREIGN KEY (`date_id`)
    REFERENCES `mydb`.`dim_date` (`dim_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fact_rating_dm_users1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mydb`.`dim_users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
