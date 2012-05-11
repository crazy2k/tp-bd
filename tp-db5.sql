-- MySQL dump 10.13  Distrib 5.5.22, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: tp_db
-- ------------------------------------------------------
-- Server version	5.5.22-0ubuntu1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Area`
--

DROP TABLE IF EXISTS `Area`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Area` (
  `n_area` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom_ar` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `nivel` int(10) unsigned NOT NULL,
  PRIMARY KEY (`n_area`),
  KEY `nivel` (`nivel`),
  CONSTRAINT `Area_fk_nivel` FOREIGN KEY (`nivel`) REFERENCES `NivelDeSeguridad` (`nivel`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Area`
--

LOCK TABLES `Area` WRITE;
/*!40000 ALTER TABLE `Area` DISABLE KEYS */;
INSERT INTO `Area` VALUES (1,'Laboratorio Secreto',8000),(2,'Laboratorio Libre Acceso',2000),(3,'Laboratorio Nivel Medio',4000),(4,'Lobby',2000),(5,'Laboratorio para conquistar el mundo',8000),(6,'Comedor',4000),(7,'Laboratorio Nivel maximo',8000);
/*!40000 ALTER TABLE `Area` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Auditoria`
--

DROP TABLE IF EXISTS `Auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Auditoria` (
  `id_aud` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `resultado` text COLLATE latin1_spanish_ci NOT NULL,
  `n_contrato` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_aud`),
  KEY `n_contrato` (`n_contrato`),
  CONSTRAINT `Auditoria_fk_nro_contrato` FOREIGN KEY (`n_contrato`) REFERENCES `Trabajo` (`n_contrato`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Auditoria`
--

LOCK TABLES `Auditoria` WRITE;
/*!40000 ALTER TABLE `Auditoria` DISABLE KEYS */;
INSERT INTO `Auditoria` VALUES (1,'2012-04-09','Auditoria ok',1),(2,'2012-06-06','Auditoria_not_ok',2),(3,'2012-06-06','Auditoria_not_ok',2);
/*!40000 ALTER TABLE `Auditoria` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ins_Auditoria` BEFORE INSERT ON `Auditoria`
 FOR EACH ROW BEGIN
	DECLARE	FECHA_INICIO_TRABAJO date;

	SET FECHA_INICIO_TRABAJO = (SELECT fecha_des FROM Trabajo WHERE Trabajo.n_contrato = NEW.n_contrato);

	IF NEW.fecha < FECHA_INICIO_TRABAJO THEN 
		SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'La fecha de la auditoria no puede ser anterior a la fecha de inicio del trabajo que audita';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA`
--

DROP TABLE IF EXISTS `EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA`;
/*!50001 DROP VIEW IF EXISTS `EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA` (
  `id_persona` int(10) unsigned,
  `n_area` int(10) unsigned
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `Evento`
--

DROP TABLE IF EXISTS `Evento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Evento` (
  `n_area` int(10) unsigned NOT NULL,
  `nro_evento` int(10) unsigned NOT NULL,
  `fecha` date NOT NULL,
  `descrp` varchar(300) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`n_area`,`nro_evento`),
  CONSTRAINT `Evento_fk_n_area` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Evento`
--

LOCK TABLES `Evento` WRITE;
/*!40000 ALTER TABLE `Evento` DISABLE KEYS */;
INSERT INTO `Evento` VALUES (1,1,'2012-04-02','Llegada de materiales al laboratorio'),(2,2,'2012-03-20','Llegada del Catering para la inauguracion'),(2,3,'2012-03-28','Fiesta de inauguracion del laboratorio');
/*!40000 ALTER TABLE `Evento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IngresaAbandona`
--

DROP TABLE IF EXISTS `IngresaAbandona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IngresaAbandona` (
  `id_persona` int(10) unsigned NOT NULL,
  `n_area` int(10) unsigned NOT NULL,
  `nro_registro` int(10) unsigned NOT NULL,
  `fecha` datetime NOT NULL,
  `autorizado` tinyint(1) NOT NULL,
  `accion` tinyint(1) NOT NULL,
  PRIMARY KEY (`id_persona`,`n_area`,`nro_registro`),
  KEY `n_area` (`n_area`),
  CONSTRAINT `IngresaAbandona_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `Personal` (`id_persona`),
  CONSTRAINT `IngresaAbandona_fk_n_area` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IngresaAbandona`
--

LOCK TABLES `IngresaAbandona` WRITE;
/*!40000 ALTER TABLE `IngresaAbandona` DISABLE KEYS */;
INSERT INTO `IngresaAbandona` VALUES (1,1,2,'2012-04-10 03:00:00',1,1),(1,1,3,'2012-04-11 00:00:00',0,0),(1,1,4,'2012-04-12 00:00:00',0,0),(1,1,5,'2012-04-13 00:00:00',0,0),(1,1,7,'2012-04-15 00:00:00',0,0),(3,3,9,'2012-04-25 23:59:59',0,0),(3,6,10,'2012-04-19 00:00:00',0,0),(4,3,8,'2012-04-12 00:00:00',0,0);
/*!40000 ALTER TABLE `IngresaAbandona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NivelDeSeguridad`
--

DROP TABLE IF EXISTS `NivelDeSeguridad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NivelDeSeguridad` (
  `nivel` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nom_niv` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`nivel`)
) ENGINE=InnoDB AUTO_INCREMENT=8001 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NivelDeSeguridad`
--

LOCK TABLES `NivelDeSeguridad` WRITE;
/*!40000 ALTER TABLE `NivelDeSeguridad` DISABLE KEYS */;
INSERT INTO `NivelDeSeguridad` VALUES (2000,'bajo'),(4000,'medio'),(8000,'alto');
/*!40000 ALTER TABLE `NivelDeSeguridad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Personal`
--

DROP TABLE IF EXISTS `Personal`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Personal` (
  `id_persona` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  `apellido` varchar(100) COLLATE latin1_spanish_ci DEFAULT NULL,
  `contrasenia` varchar(20) COLLATE latin1_spanish_ci DEFAULT NULL,
  `huella` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  `funcion` varchar(200) COLLATE latin1_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id_persona`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Personal`
--

LOCK TABLES `Personal` WRITE;
/*!40000 ALTER TABLE `Personal` DISABLE KEYS */;
INSERT INTO `Personal` VALUES (1,'Jacinto','Lugones','jlugones','jacintolugones','Jerarquico'),(2,'Carlos','Tevez','ctevez','carlostevez','Profesional'),(3,'Gustavo ','Lopez','glopez','gustavolopez','NoProfesional'),(4,'Gonzalo','Gonzalez','ggonzalez','gonzalogonzales','Jerarquico'),(5,'Honorio','Urquiza','hurquiza','honoriourquiza','Profesional'),(6,'Hernan','Diaz','hdiaz','hernandiaz','NoProfesional'),(7,'Leonardo','Astrada','lastrada','leonardoastrada','Jerarquico'),(8,'Ramiro','Rodriguez','rrodriguez','ramirorodriguez','Profesional'),(9,'Andres','Nocioni','anocioni','andresnocioni','Profesional'),(10,'orlando','lastrani','olastrani','orlandolastrani','NoProfesional');
/*!40000 ALTER TABLE `Personal` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PersonalJerarquico`
--

DROP TABLE IF EXISTS `PersonalJerarquico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PersonalJerarquico` (
  `id_persona` int(10) unsigned NOT NULL,
  `fecha_ini` date NOT NULL,
  `n_area` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_persona`),
  KEY `n_area` (`n_area`),
  KEY `n_area_2` (`n_area`),
  CONSTRAINT `PersonalJerarquico_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `Personal` (`id_persona`),
  CONSTRAINT `PersonalJerarquico_fk_n_area` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PersonalJerarquico`
--

LOCK TABLES `PersonalJerarquico` WRITE;
/*!40000 ALTER TABLE `PersonalJerarquico` DISABLE KEYS */;
INSERT INTO `PersonalJerarquico` VALUES (1,'2012-04-22',1),(4,'2012-04-22',2),(7,'2012-04-22',3);
/*!40000 ALTER TABLE `PersonalJerarquico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PersonalNoProfesional`
--

DROP TABLE IF EXISTS `PersonalNoProfesional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PersonalNoProfesional` (
  `id_persona` int(10) unsigned NOT NULL,
  `nivel` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_persona`),
  KEY `nivel` (`nivel`),
  CONSTRAINT `PersonalNoProfesional_ibfk_1` FOREIGN KEY (`id_persona`) REFERENCES `Personal` (`id_persona`),
  CONSTRAINT `PersonalNoProfesional_ibfk_2` FOREIGN KEY (`nivel`) REFERENCES `NivelDeSeguridad` (`nivel`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PersonalNoProfesional`
--

LOCK TABLES `PersonalNoProfesional` WRITE;
/*!40000 ALTER TABLE `PersonalNoProfesional` DISABLE KEYS */;
INSERT INTO `PersonalNoProfesional` VALUES (3,2000),(6,4000),(10,8000);
/*!40000 ALTER TABLE `PersonalNoProfesional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PersonalProfesional`
--

DROP TABLE IF EXISTS `PersonalProfesional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PersonalProfesional` (
  `id_persona` int(10) unsigned NOT NULL,
  `especialidad` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  `tipo` varchar(200) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`id_persona`),
  CONSTRAINT `PersonalProfesional_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `Personal` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PersonalProfesional`
--

LOCK TABLES `PersonalProfesional` WRITE;
/*!40000 ALTER TABLE `PersonalProfesional` DISABLE KEYS */;
INSERT INTO `PersonalProfesional` VALUES (2,'Cientifico','PlantaPermanente'),(5,'Bacteriologo','PlantaPermanente'),(8,'Fisico Nuclear','Contratado'),(9,'Analista','Contratado');
/*!40000 ALTER TABLE `PersonalProfesional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PersonalProfesionalContratado`
--

DROP TABLE IF EXISTS `PersonalProfesionalContratado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PersonalProfesionalContratado` (
  `id_persona` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_persona`),
  CONSTRAINT `PersonalProfesionalContratado_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `PersonalProfesional` (`id_persona`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PersonalProfesionalContratado`
--

LOCK TABLES `PersonalProfesionalContratado` WRITE;
/*!40000 ALTER TABLE `PersonalProfesionalContratado` DISABLE KEYS */;
INSERT INTO `PersonalProfesionalContratado` VALUES (8),(9);
/*!40000 ALTER TABLE `PersonalProfesionalContratado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PersonalProfesionalPlantaPermanente`
--

DROP TABLE IF EXISTS `PersonalProfesionalPlantaPermanente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PersonalProfesionalPlantaPermanente` (
  `id_persona` int(10) unsigned NOT NULL,
  `n_area` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id_persona`),
  KEY `n_area` (`n_area`),
  CONSTRAINT `PersonalProfesionalPlantaPermanente_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `PersonalProfesional` (`id_persona`),
  CONSTRAINT `PersonalProfesionalPlantaPermanente_fk_n_area` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PersonalProfesionalPlantaPermanente`
--

LOCK TABLES `PersonalProfesionalPlantaPermanente` WRITE;
/*!40000 ALTER TABLE `PersonalProfesionalPlantaPermanente` DISABLE KEYS */;
INSERT INTO `PersonalProfesionalPlantaPermanente` VALUES (2,1),(5,2);
/*!40000 ALTER TABLE `PersonalProfesionalPlantaPermanente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TieneAccesoA`
--

DROP TABLE IF EXISTS `TieneAccesoA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TieneAccesoA` (
  `n_area` int(10) unsigned NOT NULL,
  `hora_des` time NOT NULL,
  `hora_has` time NOT NULL,
  `id_persona` int(10) unsigned NOT NULL,
  PRIMARY KEY (`n_area`,`hora_des`,`hora_has`,`id_persona`),
  KEY `hora_has` (`hora_has`),
  KEY `id_persona` (`id_persona`),
  KEY `hora_des` (`hora_des`,`hora_has`),
  CONSTRAINT `TieneAccesoA_fk_hora_des` FOREIGN KEY (`hora_des`, `hora_has`) REFERENCES `Turno` (`hora_des`, `hora_has`),
  CONSTRAINT `TieneAccesoA_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `PersonalNoProfesional` (`id_persona`),
  CONSTRAINT `TieneAccesoA_fk_n_area` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TieneAccesoA`
--

LOCK TABLES `TieneAccesoA` WRITE;
/*!40000 ALTER TABLE `TieneAccesoA` DISABLE KEYS */;
INSERT INTO `TieneAccesoA` VALUES (1,'16:00:00','00:00:00',10),(2,'00:00:00','08:00:00',3),(5,'00:00:00','08:00:00',10),(2,'08:00:00','16:00:00',3),(3,'08:00:00','16:00:00',6),(4,'08:00:00','16:00:00',3);
/*!40000 ALTER TABLE `TieneAccesoA` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ins_TieneAccesoA` BEFORE INSERT ON `TieneAccesoA`
 FOR EACH ROW BEGIN
	DECLARE	NIVELAREA int;
	DECLARE	NIVELPERSONAL int;

	SET NIVELAREA = (SELECT NIVEL FROM Area WHERE N_AREA = NEW.N_AREA);
	SET NIVELPERSONAL = (SELECT NIVEL FROM PersonalNoProfesional WHERE ID_PERSONA = NEW.ID_PERSONA);

	IF NIVELPERSONAL <> NIVELAREA THEN 
		SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Nivel no autorizado';
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Trabajo`
--

DROP TABLE IF EXISTS `Trabajo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Trabajo` (
  `id_persona` int(10) unsigned NOT NULL,
  `n_area` int(10) unsigned NOT NULL,
  `fecha_des` date NOT NULL,
  `fecha_has` date NOT NULL,
  `tarea` varchar(200) COLLATE latin1_spanish_ci NOT NULL,
  `n_contrato` int(10) unsigned NOT NULL,
  PRIMARY KEY (`n_contrato`),
  KEY `n_contrato` (`n_contrato`),
  KEY `n_area` (`n_area`),
  KEY `Trabajo_fk_id_persona` (`id_persona`),
  CONSTRAINT `Trabajo_fk_id_persona` FOREIGN KEY (`id_persona`) REFERENCES `PersonalProfesionalContratado` (`id_persona`),
  CONSTRAINT `Trabajo_fk_n_area` FOREIGN KEY (`n_area`) REFERENCES `Area` (`n_area`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Trabajo`
--

LOCK TABLES `Trabajo` WRITE;
/*!40000 ALTER TABLE `Trabajo` DISABLE KEYS */;
INSERT INTO `Trabajo` VALUES (8,1,'2012-04-02','2012-04-06','Investigacion',1),(9,2,'2012-04-02','2012-04-06','Desarrollo',2);
/*!40000 ALTER TABLE `Trabajo` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = '' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ins_fecha_correcta` BEFORE INSERT ON `Trabajo`
 FOR EACH ROW BEGIN
    IF NEW.FECHA_DES > NEW.FECHA_HAS THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Fecha desde es mayor que fecha hasta';
	END IF;
    
 END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `Turno`
--

DROP TABLE IF EXISTS `Turno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Turno` (
  `hora_des` time NOT NULL,
  `hora_has` time NOT NULL,
  `nom_tur` varchar(100) COLLATE latin1_spanish_ci NOT NULL,
  PRIMARY KEY (`hora_des`,`hora_has`),
  KEY `hora_has` (`hora_has`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_spanish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Turno`
--

LOCK TABLES `Turno` WRITE;
/*!40000 ALTER TABLE `Turno` DISABLE KEYS */;
INSERT INTO `Turno` VALUES ('00:00:00','08:00:00','noche'),('08:00:00','16:00:00','mañana'),('16:00:00','00:00:00','tarde');
/*!40000 ALTER TABLE `Turno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Final view structure for view `EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA`
--

/*!50001 DROP TABLE IF EXISTS `EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA`*/;
/*!50001 DROP VIEW IF EXISTS `EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `EMPLEADOS_INTENTO_ACCESO_AREA_RESTRINGIDA` AS select `p`.`id_persona` AS `id_persona`,`p`.`n_area` AS `n_area` from `IngresaAbandona` `p` where ((`p`.`fecha` >= curdate()) and (`p`.`autorizado` = 0) and (not(exists(select `i`.`id_persona` from `IngresaAbandona` `i` where ((`i`.`id_persona` = `p`.`id_persona`) and (`p`.`fecha` > `i`.`fecha`) and (`p`.`n_area` = `i`.`n_area`) and (`i`.`autorizado` = 1)))))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-05-11  7:57:13
