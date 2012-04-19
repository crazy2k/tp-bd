-- phpMyAdmin SQL Dump
-- version 3.4.5deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 19, 2012 at 08:35 AM
-- Server version: 5.1.61
-- PHP Version: 5.3.6-13ubuntu3.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tp-bd`
--

-- --------------------------------------------------------

--
-- Table structure for table `Area`
--

CREATE TABLE IF NOT EXISTS `Area` (
  `n_area` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom_ar` varchar(100) CHARACTER SET latin1 NOT NULL,
  `nivel` int(10) unsigned NOT NULL,
  PRIMARY KEY (`n_area`),
  KEY `nivel` (`nivel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `Auditoria`
--

CREATE TABLE IF NOT EXISTS `Auditoria` (
  `id_aud` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `resultado` text COLLATE latin1_spanish_ci NOT NULL,
  `id_persona` int(10) unsigned NOT NULL,
  `n_area` int(10) unsigned NOT NULL,
  `n_contrato` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_aud`),
  KEY `n_contrato` (`n_contrato`),
  KEY `n_area` (`n_area`),
  KEY `id_persona` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `CapacitadoPara`
--

CREATE TABLE IF NOT EXISTS `CapacitadoPara` (
  `nivel` int(10) unsigned NOT NULL,
  `id_persona` int(10) unsigned NOT NULL,
  PRIMARY KEY (`nivel`,`id_persona`),
  KEY `id_persona` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ContratadoPara`
--

CREATE TABLE IF NOT EXISTS `ContratadoPara` (
  `id_persona` int(10) unsigned NOT NULL,
  `n_area` int(10) unsigned NOT NULL,
  `fecha_des` date NOT NULL,
  `fecha_has` date NOT NULL,
  `tarea` varchar(200) CHARACTER SET latin1 NOT NULL,
  `n_contrato` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_persona`,`n_area`,`n_contrato`),
  KEY `n_contrato` (`n_contrato`),
  KEY `n_area` (`n_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Evento`
--

CREATE TABLE IF NOT EXISTS `Evento` (
  `n_area` int(10) unsigned NOT NULL,
  `nro_evento` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `descrp` varchar(300) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`n_area`,`nro_evento`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `IngresaAbandona`
--

CREATE TABLE IF NOT EXISTS `IngresaAbandona` (
  `id_persona` int(10) unsigned NOT NULL,
  `n_area` int(10) unsigned NOT NULL,
  `nro_registro` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `autorizado` tinyint(1) NOT NULL,
  `accion` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_persona`,`n_area`,`nro_registro`),
  KEY `n_area` (`n_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `NivelDeSeguridad`
--

CREATE TABLE IF NOT EXISTS `NivelDeSeguridad` (
  `nivel` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom_niv` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`nivel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `Personal`
--

CREATE TABLE IF NOT EXISTS `Personal` (
  `id_persona` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  `apellido` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  `contrasenia` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `huella` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `funcion` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `PersonalJerarquico`
--

CREATE TABLE IF NOT EXISTS `PersonalJerarquico` (
  `id_persona` int(10) unsigned NOT NULL,
  `fecha_ini` date NOT NULL,
  `n_area` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_persona`),
  KEY `n_area` (`n_area`),
  KEY `n_area_2` (`n_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `PersonalNoProfesional`
--

CREATE TABLE IF NOT EXISTS `PersonalNoProfesional` (
  `id_persona` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `PersonalProfesional`
--

CREATE TABLE IF NOT EXISTS `PersonalProfesional` (
  `id_persona` int(10) unsigned NOT NULL,
  `especialidad` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `tipo` int(11) NOT NULL,
  PRIMARY KEY (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `PersonalProfesionalContratado`
--

CREATE TABLE IF NOT EXISTS `PersonalProfesionalContratado` (
  `id_persona` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `PersonalProfesionalPlantaPermanente`
--

CREATE TABLE IF NOT EXISTS `PersonalProfesionalPlantaPermanente` (
  `id_persona` int(10) unsigned NOT NULL,
  `n_area` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_persona`),
  KEY `n_area` (`n_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `TieneAccesoA`
--

CREATE TABLE IF NOT EXISTS `TieneAccesoA` (
  `n_area` int(10) unsigned NOT NULL,
  `hora_des` time NOT NULL,
  `hora_has` time NOT NULL,
  `id_persona` int(10) unsigned NOT NULL,
  PRIMARY KEY (`n_area`,`hora_des`,`hora_has`,`id_persona`),
  KEY `hora_des` (`hora_des`),
  KEY `hora_has` (`hora_has`),
  KEY `id_persona` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `Turno`
--

CREATE TABLE IF NOT EXISTS `Turno` (
  `hora_des` time NOT NULL,
  `hora_has` time NOT NULL,
  `nom_tur` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`hora_des`,`hora_has`),
  KEY `hora_has` (`hora_has`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Area`
--
ALTER TABLE `Area`
  ADD CONSTRAINT `Area_ibfk_1` FOREIGN KEY (`nivel`) REFERENCES `NivelDeSeguridad` (`nivel`);

--
-- Constraints for table `Auditoria`
--
ALTER TABLE `Auditoria`
  ADD CONSTRAINT `Auditoria_ibfk_8` FOREIGN KEY (`n_contrato`) REFERENCES `ContratadoPara` (`n_contrato`),
  ADD CONSTRAINT `Auditoria_ibfk_6` FOREIGN KEY (`id_persona`) REFERENCES `PersonalProfesionalContratado` (`id_persona`),
  ADD CONSTRAINT `Auditoria_ibfk_7` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`);

--
-- Constraints for table `CapacitadoPara`
--
ALTER TABLE `CapacitadoPara`
  ADD CONSTRAINT `CapacitadoPara_ibfk_2` FOREIGN KEY (`id_persona`) REFERENCES `PersonalNoProfesional` (`id_persona`),
  ADD CONSTRAINT `CapacitadoPara_ibfk_1` FOREIGN KEY (`nivel`) REFERENCES `NivelDeSeguridad` (`nivel`);

--
-- Constraints for table `ContratadoPara`
--
ALTER TABLE `ContratadoPara`
  ADD CONSTRAINT `ContratadoPara_ibfk_4` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`),
  ADD CONSTRAINT `ContratadoPara_ibfk_3` FOREIGN KEY (`id_persona`) REFERENCES `PersonalProfesionalContratado` (`id_persona`);

--
-- Constraints for table `Evento`
--
ALTER TABLE `Evento`
  ADD CONSTRAINT `Evento_ibfk_1` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`);

--
-- Constraints for table `IngresaAbandona`
--
ALTER TABLE `IngresaAbandona`
  ADD CONSTRAINT `IngresaAbandona_ibfk_2` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`),
  ADD CONSTRAINT `IngresaAbandona_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `Personal` (`id_persona`);

--
-- Constraints for table `PersonalJerarquico`
--
ALTER TABLE `PersonalJerarquico`
  ADD CONSTRAINT `PersonalJerarquico_ibfk_2` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`),
  ADD CONSTRAINT `PersonalJerarquico_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `Personal` (`id_persona`);

--
-- Constraints for table `PersonalNoProfesional`
--
ALTER TABLE `PersonalNoProfesional`
  ADD CONSTRAINT `PersonalNoProfesional_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `Personal` (`id_persona`);

--
-- Constraints for table `PersonalProfesional`
--
ALTER TABLE `PersonalProfesional`
  ADD CONSTRAINT `PersonalProfesional_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `Personal` (`id_persona`);

--
-- Constraints for table `PersonalProfesionalContratado`
--
ALTER TABLE `PersonalProfesionalContratado`
  ADD CONSTRAINT `PersonalProfesionalContratado_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `PersonalProfesional` (`id_persona`);

--
-- Constraints for table `PersonalProfesionalPlantaPermanente`
--
ALTER TABLE `PersonalProfesionalPlantaPermanente`
  ADD CONSTRAINT `PersonalProfesionalPlantaPermanente_ibfk_4` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`),
  ADD CONSTRAINT `PersonalProfesionalPlantaPermanente_ibfk_3` FOREIGN KEY (`id_persona`) REFERENCES `PersonalProfesional` (`id_persona`);

--
-- Constraints for table `TieneAccesoA`
--
ALTER TABLE `TieneAccesoA`
  ADD CONSTRAINT `TieneAccesoA_ibfk_6` FOREIGN KEY (`id_persona`) REFERENCES `PersonalNoProfesional` (`id_persona`),
  ADD CONSTRAINT `TieneAccesoA_ibfk_3` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`),
  ADD CONSTRAINT `TieneAccesoA_ibfk_4` FOREIGN KEY (`hora_des`) REFERENCES `Turno` (`hora_des`),
  ADD CONSTRAINT `TieneAccesoA_ibfk_5` FOREIGN KEY (`hora_has`) REFERENCES `Turno` (`hora_has`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
