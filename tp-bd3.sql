-- phpMyAdmin SQL Dump
-- version 3.4.5deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Apr 24, 2012 at 08:01 PM
-- Server version: 5.1.61
-- PHP Version: 5.3.6-13ubuntu3.6

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `tp-bd3`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerEmpleadosProfesionalesConAccesoATodasLasAreasDeSuNivel`()
BEGIN

(SELECT count(distinct t.n_area) cant_area, t.id_persona id_persona
		FROM `TieneAccesoA` t
		group by (t.id_persona)
		having count(*) = (select count(*) from `Area` a, `PersonalNoProfesional` p where p.id_persona = t.id_persona and a.nivel = p.nivel));

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerIngresosSospechosos`()
BEGIN

(select id_persona from (select i.id_persona, count(*) c
FROM  `IngresaAbandona` i
where fecha > DATE_SUB(NOW(), INTERVAL 1 MONTH)
and i.autorizado = false
group by (i.id_persona )
having (c >= 5)) x)

union

(select i.id_persona from `IngresaAbandona` i, `Area` a
where i.n_area = a.n_area
and a.nivel > ( select max(b.nivel) from `Area` b, `TieneAccesoA` t
				where t.n_area = b.n_area
				and t.id_persona = i.id_persona
			  )
);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Area`
--

CREATE TABLE IF NOT EXISTS `Area` (
  `n_area` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom_ar` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `nivel` int(10) unsigned NOT NULL,
  PRIMARY KEY (`n_area`),
  KEY `nivel` (`nivel`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=7 ;

--
-- Dumping data for table `Area`
--

INSERT INTO `Area` (`n_area`, `nom_ar`, `nivel`) VALUES
(1, 'Laboratorio Secreto', 8000),
(2, 'Laboratorio Libre Acceso', 2000),
(3, 'Laboratorio Nivel Medio', 4000),
(4, 'Lobby', 2000),
(5, 'Laboratorio para conquistar el mundo', 8000),
(6, 'Comedor', 4000);

-- --------------------------------------------------------

--
-- Table structure for table `Auditoria`
--

CREATE TABLE IF NOT EXISTS `Auditoria` (
  `id_aud` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `resultado` text COLLATE latin1_spanish_ci NOT NULL,
  `n_contrato` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_aud`),
  KEY `n_contrato` (`n_contrato`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=2 ;

--
-- Dumping data for table `Auditoria`
--

INSERT INTO `Auditoria` (`id_aud`, `fecha`, `resultado`, `n_contrato`) VALUES
(1, '2012-04-09', 'Auditoria ok', 1);

-- --------------------------------------------------------

--
-- Stand-in structure for view `EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA`
--
CREATE TABLE IF NOT EXISTS `EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA` (
`id_persona` int(10) unsigned
);
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

--
-- Dumping data for table `Evento`
--

INSERT INTO `Evento` (`n_area`, `nro_evento`, `fecha`, `descrp`) VALUES
(1, 1, '2012-04-02', 'Llegada de materiales al laboratorio'),
(2, 2, '2012-03-20', 'Llegada del Catering para la inauguracion'),
(2, 3, '2012-03-28', 'Fiesta de inauguracion del laboratorio');

-- --------------------------------------------------------

--
-- Table structure for table `IngresaAbandona`
--

CREATE TABLE IF NOT EXISTS `IngresaAbandona` (
  `id_persona` int(10) unsigned NOT NULL,
  `n_area` int(10) unsigned NOT NULL,
  `nro_registro` int(10) unsigned NOT NULL,
  `fecha` datetime NOT NULL,
  `autorizado` tinyint(1) NOT NULL,
  `accion` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_persona`,`n_area`,`nro_registro`),
  KEY `n_area` (`n_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `IngresaAbandona`
--

INSERT INTO `IngresaAbandona` (`id_persona`, `n_area`, `nro_registro`, `fecha`, `autorizado`, `accion`) VALUES
(1, 1, 0, '2012-04-11 00:00:00', 0, 0),
(1, 1, 1, '2012-04-10 00:00:00', 1, 0),
(1, 1, 2, '2012-04-10 03:00:00', 1, 1),
(1, 1, 3, '2012-04-11 00:00:00', 0, 0),
(1, 1, 4, '2012-04-12 00:00:00', 0, 0),
(1, 1, 5, '2012-04-13 00:00:00', 0, 0),
(1, 1, 6, '2012-04-14 00:00:00', 0, 0),
(1, 1, 7, '2012-04-15 00:00:00', 0, 0),
(3, 3, 9, '2012-04-19 00:00:00', 0, 0),
(3, 6, 10, '2012-04-19 00:00:00', 0, 0),
(4, 3, 8, '2012-04-12 00:00:00', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `NivelDeSeguridad`
--

CREATE TABLE IF NOT EXISTS `NivelDeSeguridad` (
  `nivel` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom_niv` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`nivel`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=9001 ;

--
-- Dumping data for table `NivelDeSeguridad`
--

INSERT INTO `NivelDeSeguridad` (`nivel`, `nom_niv`) VALUES
(2000, 'bajo'),
(4000, 'medio'),
(8000, 'alto');

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
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci AUTO_INCREMENT=11 ;

--
-- Dumping data for table `Personal`
--

INSERT INTO `Personal` (`id_persona`, `nombre`, `apellido`, `contrasenia`, `huella`, `funcion`) VALUES
(1, 'Jacinto', 'Lugones', 'jlugones', 'jacintolugones', 1),
(2, 'Carlos', 'Tevez', 'ctevez', 'carlostevez', 2),
(3, 'Gustavo ', 'Lopez', 'glopez', 'gustavolopez', 3),
(4, 'Gonzalo', 'Gonzalez', 'ggonzalez', 'gonzalogonzales', 1),
(5, 'Honorio', 'Urquiza', 'hurquiza', 'honoriourquiza', 2),
(6, 'Hernan', 'Diaz', 'hdiaz', 'hernandiaz', 3),
(7, 'Leonardo', 'Astrada', 'lastrada', 'leonardoastrada', 1),
(8, 'Ramiro', 'Rodriguez', 'rrodriguez', 'ramirorodriguez', 2),
(9, 'Andres', 'Nocioni', 'anocioni', 'andresnocioni', 2),
(10, 'orlando', 'lastrani', 'olastrani', 'orlandolastrani', 3);

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

--
-- Dumping data for table `PersonalJerarquico`
--

INSERT INTO `PersonalJerarquico` (`id_persona`, `fecha_ini`, `n_area`) VALUES
(1, '2012-04-22', 1),
(4, '2012-04-22', 2),
(7, '2012-04-22', 3);

-- --------------------------------------------------------

--
-- Table structure for table `PersonalNoProfesional`
--

CREATE TABLE IF NOT EXISTS `PersonalNoProfesional` (
  `id_persona` int(10) unsigned NOT NULL,
  `nivel` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_persona`),
  KEY `nivel` (`nivel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `PersonalNoProfesional`
--

INSERT INTO `PersonalNoProfesional` (`id_persona`, `nivel`) VALUES
(3, 2000),
(6, 4000),
(10, 8000);

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

--
-- Dumping data for table `PersonalProfesional`
--

INSERT INTO `PersonalProfesional` (`id_persona`, `especialidad`, `tipo`) VALUES
(2, 'Cientifico', 1),
(5, 'Bacteriologo', 1),
(8, 'Fisico Nuclear', 2),
(9, 'Analista', 2);

-- --------------------------------------------------------

--
-- Table structure for table `PersonalProfesionalContratado`
--

CREATE TABLE IF NOT EXISTS `PersonalProfesionalContratado` (
  `id_persona` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `PersonalProfesionalContratado`
--

INSERT INTO `PersonalProfesionalContratado` (`id_persona`) VALUES
(8),
(9);

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

--
-- Dumping data for table `PersonalProfesionalPlantaPermanente`
--

INSERT INTO `PersonalProfesionalPlantaPermanente` (`id_persona`, `n_area`) VALUES
(2, 1),
(5, 2);

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

--
-- Dumping data for table `TieneAccesoA`
--

INSERT INTO `TieneAccesoA` (`n_area`, `hora_des`, `hora_has`, `id_persona`) VALUES
(2, '00:00:00', '08:00:00', 3),
(5, '00:00:00', '08:00:00', 10),
(3, '08:00:00', '16:00:00', 6),
(4, '08:00:00', '16:00:00', 3),
(1, '16:00:00', '00:00:00', 10);

--
-- Triggers `TieneAccesoA`
--
DROP TRIGGER IF EXISTS `ins_TieneAccesoA`;
DELIMITER //
CREATE TRIGGER `ins_TieneAccesoA` BEFORE INSERT ON `TieneAccesoA`
 FOR EACH ROW BEGIN
	DECLARE	NIVELAREA int;
	DECLARE	NIVELPERSONAL int;

	SET NIVELAREA = (SELECT NIVEL FROM Area WHERE N_AREA = NEW.N_AREA);
	SET NIVELPERSONAL = (SELECT NIVEL FROM PersonalNoProfesional WHERE ID_PERSONA = NEW.ID_PERSONA);

	IF NIVELPERSONAL <> NIVELAREA THEN 
		CALL `NIVEL NO AUTORIZADO`;
	END IF;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `Trabajo`
--

CREATE TABLE IF NOT EXISTS `Trabajo` (
  `id_persona` int(10) unsigned NOT NULL,
  `n_area` int(10) unsigned NOT NULL,
  `fecha_des` date NOT NULL,
  `fecha_has` date NOT NULL,
  `tarea` varchar(200) COLLATE latin1_spanish_ci NOT NULL,
  `n_contrato` int(10) unsigned NOT NULL,
  PRIMARY KEY (`n_contrato`),
  KEY `n_contrato` (`n_contrato`),
  KEY `n_area` (`n_area`),
  KEY `Trabajo_fk_id_persona` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;

--
-- Dumping data for table `Trabajo`
--

INSERT INTO `Trabajo` (`id_persona`, `n_area`, `fecha_des`, `fecha_has`, `tarea`, `n_contrato`) VALUES
(8, 1, '2012-04-02', '2012-04-06', 'Investigacion', 1),
(9, 2, '2012-04-02', '2012-04-06', 'Desarrollo', 2);

--
-- Triggers `Trabajo`
--
DROP TRIGGER IF EXISTS `ins_fecha_correcta`;
DELIMITER //
CREATE TRIGGER `ins_fecha_correcta` BEFORE INSERT ON `Trabajo`
 FOR EACH ROW BEGIN
	IF NEW.FECHA_DES > NEW.FECHA_HAS THEN
		CALL `Fecha desde es mayor que fecha hasta`;
	END IF;
END
//
DELIMITER ;

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
-- Dumping data for table `Turno`
--

INSERT INTO `Turno` (`hora_des`, `hora_has`, `nom_tur`) VALUES
('00:00:00', '08:00:00', 'noche'),
('08:00:00', '16:00:00', 'mañana'),
('16:00:00', '00:00:00', 'tarde');

-- --------------------------------------------------------

--
-- Structure for view `EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA`
--
DROP TABLE IF EXISTS `EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA` AS select `p`.`id_persona` AS `id_persona` from `IngresaAbandona` `p` where ((`p`.`fecha` >= curdate()) and (`p`.`autorizado` = 0) and (not(exists(select `i`.`id_persona` from `IngresaAbandona` `i` where ((`i`.`id_persona` = `p`.`id_persona`) and (`p`.`fecha` > `i`.`fecha`) and (`p`.`n_area` = `i`.`n_area`) and (`i`.`autorizado` = 1))))));

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Area`
--
ALTER TABLE `Area`
  ADD CONSTRAINT `Area_fk_nivel` FOREIGN KEY (`nivel`) REFERENCES `NivelDeSeguridad` (`nivel`);

--
-- Constraints for table `Auditoria`
--
ALTER TABLE `Auditoria`
  ADD CONSTRAINT `Auditoria_fk_nro_contrato` FOREIGN KEY (`n_contrato`) REFERENCES `Trabajo` (`n_contrato`);

--
-- Constraints for table `Evento`
--
ALTER TABLE `Evento`
  ADD CONSTRAINT `Evento_fk_n_area` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`);

--
-- Constraints for table `IngresaAbandona`
--
ALTER TABLE `IngresaAbandona`
  ADD CONSTRAINT `IngresaAbandona_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `Personal` (`id_persona`),
  ADD CONSTRAINT `IngresaAbandona_fk_n_area` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`);

--
-- Constraints for table `PersonalJerarquico`
--
ALTER TABLE `PersonalJerarquico`
  ADD CONSTRAINT `PersonalJerarquico_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `Personal` (`id_persona`),
  ADD CONSTRAINT `PersonalJerarquico_fk_n_area` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`);

--
-- Constraints for table `PersonalNoProfesional`
--
ALTER TABLE `PersonalNoProfesional`
  ADD CONSTRAINT `PersonalNoProfesional_ibfk_2` FOREIGN KEY (`nivel`) REFERENCES `NivelDeSeguridad` (`nivel`),
  ADD CONSTRAINT `PersonalNoProfesional_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `Personal` (`id_persona`);

--
-- Constraints for table `PersonalProfesional`
--
ALTER TABLE `PersonalProfesional`
  ADD CONSTRAINT `PersonalProfesional_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `Personal` (`id_persona`);

--
-- Constraints for table `PersonalProfesionalContratado`
--
ALTER TABLE `PersonalProfesionalContratado`
  ADD CONSTRAINT `PersonalProfesionalContratado_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `PersonalProfesional` (`id_persona`);

--
-- Constraints for table `PersonalProfesionalPlantaPermanente`
--
ALTER TABLE `PersonalProfesionalPlantaPermanente`
  ADD CONSTRAINT `PersonalProfesionalPlantaPermanente_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `PersonalProfesional` (`id_persona`),
  ADD CONSTRAINT `PersonalProfesionalPlantaPermanente_fk_n_area` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`);

--
-- Constraints for table `TieneAccesoA`
--
ALTER TABLE `TieneAccesoA`
  ADD CONSTRAINT `TieneAccesoA_fk_n_area` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`),
  ADD CONSTRAINT `TieneAccesoA_fk_hora_des` FOREIGN KEY (`hora_des`) REFERENCES `Turno` (`hora_des`),
  ADD CONSTRAINT `TieneAccesoA_fk_hora_has` FOREIGN KEY (`hora_has`) REFERENCES `Turno` (`hora_has`),
  ADD CONSTRAINT `TieneAccesoA_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `PersonalNoProfesional` (`id_persona`);

--
-- Constraints for table `Trabajo`
--
ALTER TABLE `Trabajo`
  ADD CONSTRAINT `Trabajo_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `PersonalProfesionalContratado` (`id_persona`),
  ADD CONSTRAINT `Trabajo_fk_n_area` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
