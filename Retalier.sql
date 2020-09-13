-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Office`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Office` (
  `OfficeID` INT NOT NULL AUTO_INCREMENT,
  `OfficeName` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(24) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Country` VARCHAR(15) NOT NULL,
  `State` VARCHAR(15) NOT NULL,
  `EmployeeID` INT NOT NULL,
  PRIMARY KEY (`OfficeID`),
  INDEX `fk_Office_Employee1_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_Office_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `mydb`.`Employee` (`EmployeeID`)
    ON DELETE CASCADE
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Employee` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `LastName` VARCHAR(20) NOT NULL,
  `FirstName` VARCHAR(10) NOT NULL,
  `Phone` VARCHAR(24) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Salary` INT NULL,
  `OfficeID` INT NOT NULL,
  `ReportsTo` INT NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  INDEX `fk_Employee_Office_idx` (`OfficeID` ASC) VISIBLE,
  INDEX `fk_Employee_Employee1_idx` (`ReportsTo` ASC) VISIBLE,
  CONSTRAINT `fk_Employee_Office`
    FOREIGN KEY (`OfficeID`)
    REFERENCES `mydb`.`Office` (`OfficeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_Employee1`
    FOREIGN KEY (`ReportsTo`)
    REFERENCES `mydb`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Customer` (
  `CustomerID` INT NOT NULL AUTO_INCREMENT,
  `LastName` VARCHAR(20) NOT NULL,
  `FirstName` VARCHAR(10) NOT NULL,
  `Phone` VARCHAR(24) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  `Points` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `fk_Customer_Employee1_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_Customer_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `mydb`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Shipper`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Shipper` (
  `ShipperID` INT NOT NULL AUTO_INCREMENT,
  `LastName` VARCHAR(20) NOT NULL,
  `FirstName` VARCHAR(10) NOT NULL,
  `Phone` VARCHAR(24) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ShipperID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Order_Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Order_Status` (
  `Order_status_ID` INT NOT NULL AUTO_INCREMENT,
  `Status_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Order_status_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment_method`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment_method` (
  `Payment_method_ID` INT NOT NULL AUTO_INCREMENT,
  `Payment_way` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Payment_method_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Invoices`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Invoices` (
  `InvoiceID` INT NOT NULL AUTO_INCREMENT,
  `Invoice_number` VARCHAR(45) NOT NULL,
  `invoice_date` DATETIME NOT NULL,
  PRIMARY KEY (`InvoiceID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Payment` (
  `PaymentID` INT NOT NULL AUTO_INCREMENT,
  `Payment_amount` DECIMAL(10,2) NOT NULL,
  `Payment_date` DATETIME NOT NULL,
  `Payment_method_ID` INT NOT NULL,
  `InvoiceID` INT NOT NULL,
  PRIMARY KEY (`PaymentID`),
  INDEX `fk_Payment_Payment_method1_idx` (`Payment_method_ID` ASC) VISIBLE,
  INDEX `fk_Payment_Invoices1_idx` (`InvoiceID` ASC) VISIBLE,
  CONSTRAINT `fk_Payment_Payment_method1`
    FOREIGN KEY (`Payment_method_ID`)
    REFERENCES `mydb`.`Payment_method` (`Payment_method_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Payment_Invoices1`
    FOREIGN KEY (`InvoiceID`)
    REFERENCES `mydb`.`Invoices` (`InvoiceID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders` (
  `OrderID` INT NOT NULL,
  `Shipped_date` DATETIME NOT NULL,
  `Order_date` DATETIME NOT NULL,
  `ShipperID` INT NOT NULL,
  `Order_status_ID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  `CustomerID` INT NOT NULL,
  `PaymentID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_Orders_Shipper1_idx` (`ShipperID` ASC) VISIBLE,
  INDEX `fk_Orders_Order_Status1_idx` (`Order_status_ID` ASC) VISIBLE,
  INDEX `fk_Orders_Employee1_idx` (`EmployeeID` ASC) VISIBLE,
  INDEX `fk_Orders_Customer1_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `fk_Orders_Payment1_idx` (`PaymentID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_Shipper1`
    FOREIGN KEY (`ShipperID`)
    REFERENCES `mydb`.`Shipper` (`ShipperID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Order_Status1`
    FOREIGN KEY (`Order_status_ID`)
    REFERENCES `mydb`.`Order_Status` (`Order_status_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `mydb`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Customer1`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `mydb`.`Customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_Payment1`
    FOREIGN KEY (`PaymentID`)
    REFERENCES `mydb`.`Payment` (`PaymentID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product` (
  `ProductID` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NOT NULL,
  `Description` TEXT(50) NULL,
  `Unit_price` DECIMAL(10,2) NOT NULL,
  `Quantiy_in_stock` INT NOT NULL,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Supplier` (
  `SupplierID` INT NOT NULL,
  `CompanyName` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(24) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NULL,
  PRIMARY KEY (`SupplierID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Orders_information`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Orders_information` (
  `OrderID` INT NOT NULL,
  `ProductID` INT NOT NULL,
  `Quantity` INT NOT NULL,
  `Purchased_price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`OrderID`, `ProductID`),
  INDEX `fk_Orders_has_Product_Product1_idx` (`ProductID` ASC) VISIBLE,
  INDEX `fk_Orders_has_Product_Orders1_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `fk_Orders_has_Product_Orders1`
    FOREIGN KEY (`OrderID`)
    REFERENCES `mydb`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Orders_has_Product_Product1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `mydb`.`Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Product_Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Product_Supplier` (
  `ProductID` INT NOT NULL,
  `SupplierID` INT NOT NULL,
  `Note` TEXT(50) NULL,
  PRIMARY KEY (`ProductID`, `SupplierID`),
  INDEX `fk_Product_has_Supplier_Supplier1_idx` (`SupplierID` ASC) VISIBLE,
  INDEX `fk_Product_has_Supplier_Product1_idx` (`ProductID` ASC) VISIBLE,
  CONSTRAINT `fk_Product_has_Supplier_Product1`
    FOREIGN KEY (`ProductID`)
    REFERENCES `mydb`.`Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Product_has_Supplier_Supplier1`
    FOREIGN KEY (`SupplierID`)
    REFERENCES `mydb`.`Supplier` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
