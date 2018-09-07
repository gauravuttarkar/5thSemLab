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
  `appointmentid` int(11) NOT NULL,
  `patient` int(11) DEFAULT NULL,
  `prepnurse` int(11) DEFAULT NULL,
  `physician` int(11) DEFAULT NULL,
  `start_dt_time` datetime DEFAULT NULL,
  `end_dt_time` datetime DEFAULT NULL,
  `examinationroom` varchar(2) DEFAULT NULL,
  PRIMARY KEY (`appointmentid`),
  KEY `fk_pat` (`patient`),
  KEY `prepnurse` (`prepnurse`),
  KEY `physician` (`physician`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`prepnurse`) REFERENCES `nurse` (`employeeid`),
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`),
  CONSTRAINT `fk_pat` FOREIGN KEY (`patient`) REFERENCES `patient` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (13216584,10000001,101,1,'2008-04-24 10:00:00','2008-04-24 11:00:00','A'),(59871321,10000004,NULL,4,'2008-04-26 10:00:00','2008-04-26 11:00:00','C'),(69879231,10000003,103,2,'2008-04-26 11:00:00','2008-04-26 12:00:00','C'),(76983231,10000001,NULL,3,'2008-04-26 12:00:00','2008-04-26 13:00:00','C');
/*!40000 ALTER TABLE `appointment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `block`
--

DROP TABLE IF EXISTS `block`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `block` (
  `block_floor` int(11) NOT NULL,
  `block_code` int(11) NOT NULL,
  PRIMARY KEY (`block_floor`,`block_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `block`
--

LOCK TABLES `block` WRITE;
/*!40000 ALTER TABLE `block` DISABLE KEYS */;
INSERT INTO `block` VALUES (1,1),(1,2),(2,1),(2,2),(3,1),(3,2);
/*!40000 ALTER TABLE `block` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department`
--

DROP TABLE IF EXISTS `department`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `department` (
  `departmentid` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `head` int(11) DEFAULT NULL,
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
INSERT INTO `department` VALUES (1,'General Medicine',4),(2,'surgery',7),(3,'psychiatry',9);
/*!40000 ALTER TABLE `department` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nurse`
--

DROP TABLE IF EXISTS `nurse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nurse` (
  `employeeid` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `registered` tinyint(1) DEFAULT NULL,
  `ssn` int(11) DEFAULT NULL,
  PRIMARY KEY (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse`
--

LOCK TABLES `nurse` WRITE;
/*!40000 ALTER TABLE `nurse` DISABLE KEYS */;
INSERT INTO `nurse` VALUES (101,'Carla Espinoza','Head nurse',1,1111111110),(102,'Laverne Roberts','Nurse',1,222222220),(103,'Paul Flowers','Nurse',0,333333330);
/*!40000 ALTER TABLE `nurse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `ssn` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `insuranceid` int(11) DEFAULT NULL,
  `pcp` int(11) DEFAULT NULL,
  PRIMARY KEY (`ssn`),
  KEY `fk_ssn` (`pcp`),
  CONSTRAINT `fk_ssn` FOREIGN KEY (`pcp`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (10000001,'John smith','42 Foobar Lane',5550256,68476213,1),(10000002,'Grace ritchie','37 snafu drive',5550512,36546321,2),(10000003,'Random J Patient','101 Omgbbq street',5551204,65465421,2),(10000004,'Dennis joe','1100 foobaz avenue',5552048,68421879,3);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physician`
--

DROP TABLE IF EXISTS `physician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physician` (
  `employeeid` int(11) NOT NULL,
  `name` varchar(200) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `ssn` int(10) DEFAULT NULL,
  PRIMARY KEY (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physician`
--

LOCK TABLES `physician` WRITE;
/*!40000 ALTER TABLE `physician` DISABLE KEYS */;
INSERT INTO `physician` VALUES (1,'John Dorian','staff internist',111111111),(2,'Elliot Reid','Attending physician',222222222),(3,'Christopher turk','surgical attending physician',333333333),(4,'Percival Cox','senior attending physician',444444444),(5,'Bob Kelso','head chief medicine',555555555),(6,'Todd Quinlan','surgical attending physician',666666666),(7,'John Wen','surgical attending physician',777777777),(8,'Keith Dudemeister','MD Resident',888888888),(9,'Molly Clock','attending psychiatrist',999999999);
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
  `roomtype` varchar(100) DEFAULT NULL,
  `block_floor` int(11) DEFAULT NULL,
  `block_code` int(11) DEFAULT NULL,
  `unavailable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`roomnumber`),
  KEY `block_floor` (`block_floor`,`block_code`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`block_floor`, `block_code`) REFERENCES `block` (`block_floor`, `block_code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (101,'single',1,1,0),(102,'single',2,1,0),(212,'single',3,2,0);
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

-- Dump completed on 2018-08-31 10:47:38
