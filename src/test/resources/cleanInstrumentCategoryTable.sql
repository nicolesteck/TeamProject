-- MySQL Script generated by MySQL Workbench
-- Thu Feb 22 12:08:31 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE = '' TRADITIONAL, ALLOW_INVALID_DATES'';

-- -----------------------------------------------------
-- Schema test_concertPlanner
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `test_concertPlanner`;

-- -----------------------------------------------------
-- Schema test_concertPlanner
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `test_concertPlanner`
  DEFAULT CHARACTER SET latin1;
USE `test_concertPlanner`;

-- -----------------------------------------------------
-- Table `test_concertPlanner`.`Nationality`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test_concertPlanner`.`Nationality`;

CREATE TABLE IF NOT EXISTS `test_concertPlanner`.`Nationality` (
  `Id`          INT(11)      NOT NULL AUTO_INCREMENT,
  `nationality` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `test_concertPlanner`.`Composer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test_concertPlanner`.`Composer`;

CREATE TABLE IF NOT EXISTS `test_concertPlanner`.`Composer` (
  `Id`             INT(11)      NOT NULL AUTO_INCREMENT,
  `first_name`     VARCHAR(100) NOT NULL,
  `last_name`      VARCHAR(100) NOT NULL,
  `birth_year`     INT(11)      NULL     DEFAULT NULL,
  `death_year`     INT(11)      NULL     DEFAULT NULL,
  `Nationality_Id` INT(11)      NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `Composer_Nationality` (`Nationality_Id` ASC),
  CONSTRAINT `Composer_Nationality`
  FOREIGN KEY (`Nationality_Id`)
  REFERENCES `test_concertPlanner`.`Nationality` (`Id`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `test_concertPlanner`.`Composition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test_concertPlanner`.`Composition`;

CREATE TABLE IF NOT EXISTS `test_concertPlanner`.`Composition` (
  `Id`                INT(11)      NOT NULL AUTO_INCREMENT,
  `title`             VARCHAR(100) NOT NULL,
  `arranger`          VARCHAR(100) NULL     DEFAULT NULL,
  `duration`          INT(11)      NOT NULL,
  `year`              INT(11)      NOT NULL,
  `clocks_commission` TINYINT(1)   NULL     DEFAULT NULL,
  `number_of_players` INT(11)      NOT NULL,
  `notes`             VARCHAR(300) NOT NULL,
  `Composer_Id`       INT(11)      NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `Composition_Composer` (`Composer_Id` ASC),
  CONSTRAINT `Composition_Composer`
  FOREIGN KEY (`Composer_Id`)
  REFERENCES `test_concertPlanner`.`Composer` (`Id`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `test_concertPlanner`.`Instrument_Category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test_concertPlanner`.InstrumentCategory;

CREATE TABLE IF NOT EXISTS `test_concertPlanner`.`Instrument_Category` (
  `Id`       INT(11)      NOT NULL AUTO_INCREMENT,
  `category` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`Id`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `test_concertPlanner`.`Instrument`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test_concertPlanner`.`Instrument`;

CREATE TABLE IF NOT EXISTS `test_concertPlanner`.`Instrument` (
  `Id`                     INT(11)      NOT NULL AUTO_INCREMENT,
  `name`                   VARCHAR(100) NOT NULL,
  `Instrument_Category_Id` INT(11)      NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `Instrument_Instrument_Category` (`Instrument_Category_Id` ASC),
  CONSTRAINT `Instrument_Instrument_Category`
  FOREIGN KEY (`Instrument_Category_Id`)
  REFERENCES `test_concertPlanner`.InstrumentCategory (`Id`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `test_concertPlanner`.`Composition_Instrument`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test_concertPlanner`.`Composition_Instrument`;

CREATE TABLE IF NOT EXISTS `test_concertPlanner`.`Composition_Instrument` (
  `Id`             INT(11) NOT NULL AUTO_INCREMENT,
  `qty`            INT(11) NOT NULL,
  `player`         INT(11) NOT NULL,
  `Instrument_Id`  INT(11) NOT NULL,
  `Composition_Id` INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `Composition_Instrument_Composition` (`Composition_Id` ASC),
  INDEX `Composition_Instrument_Instrument` (`Instrument_Id` ASC),
  CONSTRAINT `Composition_Instrument_Composition`
  FOREIGN KEY (`Composition_Id`)
  REFERENCES `test_concertPlanner`.`Composition` (`Id`),
  CONSTRAINT `Composition_Instrument_Instrument`
  FOREIGN KEY (`Instrument_Id`)
  REFERENCES `test_concertPlanner`.`Instrument` (`Id`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `test_concertPlanner`.`Musician`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test_concertPlanner`.`Musician`;

CREATE TABLE IF NOT EXISTS `test_concertPlanner`.`Musician` (
  `Id`           INT(11)     NOT NULL AUTO_INCREMENT,
  `first_name`   VARCHAR(50) NOT NULL,
  `last_name`    VARCHAR(50) NOT NULL,
  `phone_number` VARCHAR(20) NULL     DEFAULT NULL,
  PRIMARY KEY (`Id`)
)
  ENGINE = InnoDB
  AUTO_INCREMENT = 3
  DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `test_concertPlanner`.`Program`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test_concertPlanner`.`Program`;

CREATE TABLE IF NOT EXISTS `test_concertPlanner`.`Program` (
  `Id`       INT(11)      NOT NULL AUTO_INCREMENT,
  `date`     DATE         NOT NULL,
  `title`    VARCHAR(100) NOT NULL,
  `location` VARCHAR(100) NOT NULL,
  `address`  VARCHAR(100) NOT NULL,
  `city`     VARCHAR(100) NOT NULL,
  `state`    VARCHAR(2)   NOT NULL,
  PRIMARY KEY (`Id`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;

-- -----------------------------------------------------
-- Table `test_concertPlanner`.`Composition_Program`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `test_concertPlanner`.`Composition_Program`;

CREATE TABLE IF NOT EXISTS `test_concertPlanner`.`Composition_Program` (
  `Id`             INT(11) NOT NULL AUTO_INCREMENT,
  `player`         INT(11) NOT NULL,
  `Composition_Id` INT(11) NOT NULL,
  `Musician_Id`    INT(11) NOT NULL,
  `Program_Id`     INT(11) NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `Composition_Program_Composition` (`Composition_Id` ASC),
  INDEX `Composition_Program_Musician` (`Musician_Id` ASC),
  INDEX `Composition_Program_Program` (`Program_Id` ASC),
  CONSTRAINT `Composition_Program_Composition`
  FOREIGN KEY (`Composition_Id`)
  REFERENCES `test_concertPlanner`.`Composition` (`Id`),
  CONSTRAINT `Composition_Program_Musician`
  FOREIGN KEY (`Musician_Id`)
  REFERENCES `test_concertPlanner`.`Musician` (`Id`),
  CONSTRAINT `Composition_Program_Program`
  FOREIGN KEY (`Program_Id`)
  REFERENCES `test_concertPlanner`.`Program` (`Id`)
)
  ENGINE = InnoDB
  DEFAULT CHARACTER SET = latin1;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
