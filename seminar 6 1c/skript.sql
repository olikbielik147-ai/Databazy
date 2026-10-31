-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema northwind_dwh
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema northwind_dwh
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `northwind_dwh` DEFAULT CHARACTER SET utf8 ;
USE `northwind_dwh` ;

-- -----------------------------------------------------
-- Table `northwind_dwh`.`dim_customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind_dwh`.`dim_customer` (
  `customer_id` INT(11) NOT NULL,
  `customer_name` VARCHAR(50) NULL DEFAULT NULL,
  `contact_name` VARCHAR(50) NULL DEFAULT NULL,
  `city` VARCHAR(20) NULL DEFAULT NULL,
  `country` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind_dwh`.`dim_date`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind_dwh`.`dim_date` (
  `date_id` INT(11) NOT NULL,
  `full_date` DATE NULL DEFAULT NULL,
  `day` INT(11) NULL DEFAULT NULL,
  `month` INT(11) NULL DEFAULT NULL,
  `month_name` VARCHAR(15) NULL DEFAULT NULL,
  `year` INT(11) NULL DEFAULT NULL,
  `quarter` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`date_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind_dwh`.`dim_employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind_dwh`.`dim_employee` (
  `employee_id` INT(11) NOT NULL,
  `first_name` VARCHAR(15) NULL DEFAULT NULL,
  `last_name` VARCHAR(15) NULL DEFAULT NULL,
  `city` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`employee_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind_dwh`.`dim_product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind_dwh`.`dim_product` (
  `product_id` INT(11) NOT NULL,
  `product_name` VARCHAR(50) NULL DEFAULT NULL,
  `unit` VARCHAR(25) NULL DEFAULT NULL,
  `price` DECIMAL(10,2) NULL DEFAULT NULL,
  `category_name` VARCHAR(25) NULL DEFAULT NULL,
  `supplier_name` VARCHAR(50) NULL DEFAULT NULL,
  `supplier_country` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind_dwh`.`dim_shipper`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind_dwh`.`dim_shipper` (
  `shipper_id` INT(11) NOT NULL,
  `shipper_name` VARCHAR(25) NULL DEFAULT NULL,
  PRIMARY KEY (`shipper_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `northwind_dwh`.`fact_sales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `northwind_dwh`.`fact_sales` (
  `sales_id` INT(11) NOT NULL AUTO_INCREMENT,
  `order_id` INT(11) NULL DEFAULT NULL,
  `date_id` INT(11) NULL DEFAULT NULL,
  `customer_id` INT(11) NULL DEFAULT NULL,
  `employee_id` INT(11) NULL DEFAULT NULL,
  `shipper_id` INT(11) NULL DEFAULT NULL,
  `product_id` INT(11) NULL DEFAULT NULL,
  `quantity` INT(11) NULL DEFAULT NULL,
  `line_total` DECIMAL(12,2) NULL DEFAULT NULL,
  PRIMARY KEY (`sales_id`),
  INDEX `date_id` (`date_id` ASC) VISIBLE,
  INDEX `customer_id` (`customer_id` ASC) VISIBLE,
  INDEX `employee_id` (`employee_id` ASC) VISIBLE,
  INDEX `shipper_id` (`shipper_id` ASC) VISIBLE,
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `fact_sales_ibfk_1`
    FOREIGN KEY (`date_id`)
    REFERENCES `northwind_dwh`.`dim_date` (`date_id`),
  CONSTRAINT `fact_sales_ibfk_2`
    FOREIGN KEY (`customer_id`)
    REFERENCES `northwind_dwh`.`dim_customer` (`customer_id`),
  CONSTRAINT `fact_sales_ibfk_3`
    FOREIGN KEY (`employee_id`)
    REFERENCES `northwind_dwh`.`dim_employee` (`employee_id`),
  CONSTRAINT `fact_sales_ibfk_4`
    FOREIGN KEY (`shipper_id`)
    REFERENCES `northwind_dwh`.`dim_shipper` (`shipper_id`),
  CONSTRAINT `fact_sales_ibfk_5`
    FOREIGN KEY (`product_id`)
    REFERENCES `northwind_dwh`.`dim_product` (`product_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
