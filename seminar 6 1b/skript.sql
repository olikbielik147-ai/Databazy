-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema chinook_dwh
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema chinook_dwh
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `chinook_dwh` DEFAULT CHARACTER SET utf8 ;
USE `chinook_dwh` ;

-- -----------------------------------------------------
-- Table `chinook_dwh`.`dim_customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chinook_dwh`.`dim_customer` (
  `customer_id` INT(11) NOT NULL,
  `first_name` VARCHAR(40) NULL DEFAULT NULL,
  `last_name` VARCHAR(20) NULL DEFAULT NULL,
  `company` VARCHAR(80) NULL DEFAULT NULL,
  `city` VARCHAR(40) NULL DEFAULT NULL,
  `state` VARCHAR(40) NULL DEFAULT NULL,
  `country` VARCHAR(40) NULL DEFAULT NULL,
  `support_rep_name` VARCHAR(60) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `chinook_dwh`.`dim_date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chinook_dwh`.`dim_date` (
  `date_id` INT(11) NOT NULL,
  `full_date` DATE NULL DEFAULT NULL,
  `day` INT(11) NULL DEFAULT NULL,
  `day_of_week` VARCHAR(15) NULL DEFAULT NULL,
  `month` INT(11) NULL DEFAULT NULL,
  `month_name` VARCHAR(15) NULL DEFAULT NULL,
  `year` INT(11) NULL DEFAULT NULL,
  `quarter` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`date_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `chinook_dwh`.`dim_track`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chinook_dwh`.`dim_track` (
  `track_id` INT(11) NOT NULL,
  `track_name` VARCHAR(200) NULL DEFAULT NULL,
  `composer` VARCHAR(220) NULL DEFAULT NULL,
  `album_title` VARCHAR(160) NULL DEFAULT NULL,
  `artist_name` VARCHAR(120) NULL DEFAULT NULL,
  `genre_name` VARCHAR(120) NULL DEFAULT NULL,
  `media_type_name` VARCHAR(120) NULL DEFAULT NULL,
  `milliseconds` INT(11) NULL DEFAULT NULL,
  `bytes` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`track_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `chinook_dwh`.`fact_sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `chinook_dwh`.`fact_sales` (
  `sales_id` INT(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` INT(11) NULL DEFAULT NULL,
  `date_id` INT(11) NULL DEFAULT NULL,
  `customer_id` INT(11) NULL DEFAULT NULL,
  `track_id` INT(11) NULL DEFAULT NULL,
  `quantity` INT(11) NULL DEFAULT NULL,
  `unit_price` DECIMAL(10,2) NULL DEFAULT NULL,
  `line_total` DECIMAL(10,2) NULL DEFAULT NULL,
  PRIMARY KEY (`sales_id`),
  INDEX `date_id` (`date_id` ASC) VISIBLE,
  INDEX `customer_id` (`customer_id` ASC) VISIBLE,
  INDEX `track_id` (`track_id` ASC) VISIBLE,
  CONSTRAINT `fact_sales_ibfk_1`
    FOREIGN KEY (`date_id`)
    REFERENCES `chinook_dwh`.`dim_date` (`date_id`),
  CONSTRAINT `fact_sales_ibfk_2`
    FOREIGN KEY (`customer_id`)
    REFERENCES `chinook_dwh`.`dim_customer` (`customer_id`),
  CONSTRAINT `fact_sales_ibfk_3`
    FOREIGN KEY (`track_id`)
    REFERENCES `chinook_dwh`.`dim_track` (`track_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
