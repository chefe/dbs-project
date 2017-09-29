-- MySQL Script generated by MySQL Workbench
-- Fri 29 Sep 2017 07:56:58 PM CEST
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `Adresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Adresse` (
  `Id` INT NOT NULL,
  `Strasse` VARCHAR(100) NULL,
  `PLZ` INT NULL,
  `Ort` VARCHAR(100) NULL,
  `Land` VARCHAR(100) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Person`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Person` (
  `Id` INT NOT NULL,
  `PersonArt` VARCHAR(45) NULL,
  `Name` VARCHAR(200) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Firma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Firma` (
  `Id` INT NOT NULL,
  `AnzahlMA` VARCHAR(45) NULL,
  `PersonId` VARCHAR(45) NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fkPerson`
    FOREIGN KEY ()
    REFERENCES `Person` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Buero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Buero` (
  `Id` INT NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Arbeitsplatz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Arbeitsplatz` (
  `Id` INT NOT NULL,
  `BueroId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fkBuero`
    FOREIGN KEY ()
    REFERENCES `Buero` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mitarbeiter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Mitarbeiter` (
  `Id` INT NOT NULL,
  `PersonId` INT NULL,
  `ArbeitsplatzId` INT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fkPerson`
    FOREIGN KEY ()
    REFERENCES `Person` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkArbeitsplatz`
    FOREIGN KEY ()
    REFERENCES `Arbeitsplatz` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Ansprechpartner`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Ansprechpartner` (
  `Id` INT NOT NULL,
  `Vorname` VARCHAR(100) NULL,
  `Name` VARCHAR(100) NULL,
  `Email` VARCHAR(250) NULL,
  `PersonId` INT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fkPerson`
    FOREIGN KEY ()
    REFERENCES `Person` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Kunde`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Kunde` (
  `Id` INT NOT NULL,
  `AnsprechpartnerId` INT NULL,
  `FirmaId` INT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fkAnsprechpartner`
    FOREIGN KEY ()
    REFERENCES `Ansprechpartner` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkFirma`
    FOREIGN KEY ()
    REFERENCES `Firma` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projekt`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projekt` (
  `Id` INT NOT NULL,
  `BestellerKundeId` INT NULL,
  `LeiterMitarbeiterId` INT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fkKunde`
    FOREIGN KEY ()
    REFERENCES `Kunde` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkMitarbeiter`
    FOREIGN KEY ()
    REFERENCES `Mitarbeiter` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Aktionaer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Aktionaer` (
  `Id` INT NOT NULL,
  `AnzahlAktien` INT NULL,
  `MitarbeiterId` INT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fkMitarbeiter`
    FOREIGN KEY ()
    REFERENCES `Mitarbeiter` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Dokument`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Dokument` (
  `Id` INT NOT NULL,
  `ProjektId` INT NULL,
  PRIMARY KEY (`Id`),
  CONSTRAINT `fkProjekt`
    FOREIGN KEY ()
    REFERENCES `Projekt` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `PersonAdresse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PersonAdresse` (
  `PersonId` INT NOT NULL,
  `AdresseId` INT NOT NULL,
  PRIMARY KEY (`PersonId`, `AdresseId`),
  CONSTRAINT `fkPerson`
    FOREIGN KEY ()
    REFERENCES `Person` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkAdresse`
    FOREIGN KEY ()
    REFERENCES `Adresse` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Rolle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Rolle` (
  `RolleId` INT NOT NULL,
  `Name` VARCHAR(100) NULL,
  `Stundensatz` DOUBLE NULL,
  PRIMARY KEY (`RolleId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Anstellung`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Anstellung` (
  `MitarbeiterId` INT NOT NULL,
  `FirmaId` INT NOT NULL,
  PRIMARY KEY (`MitarbeiterId`, `FirmaId`),
  CONSTRAINT `fkMitarbeiter`
    FOREIGN KEY ()
    REFERENCES `Mitarbeiter` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkFirma`
    FOREIGN KEY ()
    REFERENCES `Firma` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Autorschaft`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Autorschaft` (
  `MitarbeiterId` INT NOT NULL,
  `DokumentId` INT NOT NULL,
  PRIMARY KEY (`MitarbeiterId`, `DokumentId`),
  CONSTRAINT `fkMitarbeiter`
    FOREIGN KEY ()
    REFERENCES `Mitarbeiter` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkDokument`
    FOREIGN KEY ()
    REFERENCES `Dokument` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Projektmitarbeit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Projektmitarbeit` (
  `MitarbeiterId` INT NOT NULL,
  `RolleId` INT NULL,
  `ProjektId` INT NULL,
  PRIMARY KEY (`MitarbeiterId`),
  CONSTRAINT `fkMitarbeiter`
    FOREIGN KEY ()
    REFERENCES `Mitarbeiter` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkProjekt`
    FOREIGN KEY ()
    REFERENCES `Projekt` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fkRolle`
    FOREIGN KEY ()
    REFERENCES `Rolle` ()
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
