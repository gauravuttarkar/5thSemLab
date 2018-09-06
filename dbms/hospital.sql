-- MySQL dump 10.13  Distrib 5.7.23, for Linux (x86_64)
--
-- Host: localhost    Database: hospital
-- ------------------------------------------------------
-- Server version	5.7.23-0ubuntu0.16.04.1

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
-- Table structure for table `appointment`
--

DROP TABLE IF EXISTS `appointment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `appointment` (
  `appointmentid` varchar(255) NOT NULL,
  `patient` varchar(255) DEFAULT NULL,
  `prepnurse` varchar(255) DEFAULT NULL,
  `physician` varchar(255) DEFAULT NULL,
  `start_dt_time` datetime DEFAULT NULL,
  `end_dt_time` datetime DEFAULT NULL,
  `examinationroom` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`appointmentid`),
  KEY `fk_patient` (`patient`),
  KEY `fk_physician` (`physician`),
  KEY `fk_prepnurse` (`prepnurse`),
  CONSTRAINT `fk_patient` FOREIGN KEY (`patient`) REFERENCES `patient` (`ssn`),
  CONSTRAINT `fk_physician` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`),
  CONSTRAINT `fk_prepnurse` FOREIGN KEY (`prepnurse`) REFERENCES `nurse` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `blockfloor` varchar(10) NOT NULL,
  `blockcode` varchar(10) NOT NULL,
  PRIMARY KEY (`blockfloor`,`blockcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block`
--

LOCK TABLES `block` WRITE;
/*!40000 ALTER TABLE `block` DISABLE KEYS */;
/*!40000 ALTER TABLE `block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `departmentid` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `head` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`departmentid`),
  KEY `fk_head` (`head`),
  CONSTRAINT `fk_head` FOREIGN KEY (`head`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES ('1','General Medicine','4'),('2','Surgery','7'),('3','Psychiatry','9');
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurse`
--

DROP TABLE IF EXISTS `nurse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nurse` (
  `employeeid` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `registered` tinyint(1) DEFAULT NULL,
  `ssn` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse`
--

LOCK TABLES `nurse` WRITE;
/*!40000 ALTER TABLE `nurse` DISABLE KEYS */;
INSERT INTO `nurse` VALUES ('101','Carla Espinosa','Head Nurse',1,'111111110'),('102','Laverna Roberts','Nurse',1,'222222220'),('103','Paul Flowers','Nurse',0,'333333330');
/*!40000 ALTER TABLE `nurse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `ssn` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `insuranceid` varchar(255) DEFAULT NULL,
  `pcp` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`ssn`),
  KEY `fk_pcp` (`pcp`),
  CONSTRAINT `fk_pcp` FOREIGN KEY (`pcp`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physician`
--

DROP TABLE IF EXISTS `physician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physician` (
  `employeeid` varchar(40) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `ssn` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physician`
--

LOCK TABLES `physician` WRITE;
/*!40000 ALTER TABLE `physician` DISABLE KEYS */;
INSERT INTO `physician` VALUES ('1','John Dorian','Staff Internist','111111111'),('2','Elliot Reid','Attending Physician','222222222'),('3','Christopher Turk','Surgical Attending Physician','333333333'),('4','Percival Cox','Senior Attending Physician','444444444'),('5','Bob Kelso','Head Chief Of Medicine','555555555'),('6','Tod Quinlan','Surgical Attending Physician','666666666'),('7','John Wen','Surgical Attending Physician','777777777'),('8','Keith Dudemeister','MD Resident','888888888'),('9','Molly Clock','Attending Psychiatrist','999999999');
/*!40000 ALTER TABLE `physician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `roomnumber` int(11) NOT NULL,
  `roomtype` varchar(255) DEFAULT NULL,
  `blockfloor` varchar(10) DEFAULT NULL,
  `blockcode` varchar(10) DEFAULT NULL,
  `unavailable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`roomnumber`),
  KEY `fk_block` (`blockfloor`,`blockcode`),
  CONSTRAINT `fk_block` FOREIGN KEY (`blockfloor`, `blockcode`) REFERENCES `block` (`blockfloor`, `blockcode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-08-31 10:49:08
