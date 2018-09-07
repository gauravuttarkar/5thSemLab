-- MySQL dump 10.13  Distrib 5.7.23, for Linux (x86_64)
--
-- Host: localhost    Database: lab1
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
  `examinationroom` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`appointmentid`),
  KEY `prepnurse` (`prepnurse`),
  KEY `physician` (`physician`),
  KEY `patient` (`patient`),
  CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`prepnurse`) REFERENCES `nurse` (`employeeid`),
  CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`),
  CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`patient`) REFERENCES `patient` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `appointment`
--

LOCK TABLES `appointment` WRITE;
/*!40000 ALTER TABLE `appointment` DISABLE KEYS */;
INSERT INTO `appointment` VALUES (13216584,100000001,101,1,'2008-04-24 10:00:00','2008-04-24 11:00:00','A'),(59871321,100000004,NULL,4,'2008-04-26 10:00:00','2008-04-26 11:00:00','C'),(69879231,100000003,103,2,'2008-04-26 11:00:00','2008-04-26 12:00:00','C'),(76983231,100000001,NULL,3,'2008-04-26 12:00:00','2008-04-26 13:00:00','C');
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
  `name` varchar(50) DEFAULT NULL,
  `head` int(11) DEFAULT NULL,
  PRIMARY KEY (`departmentid`),
  KEY `head` (`head`),
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`head`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department`
--

LOCK TABLES `department` WRITE;
/*!40000 ALTER TABLE `department` DISABLE KEYS */;
INSERT INTO `department` VALUES (1,'General Medicine',4),(2,'Surgery',7),(3,'Psychiatry',9);
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
  `name` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `registered` varchar(1) DEFAULT NULL,
  `ssn` int(11) NOT NULL,
  PRIMARY KEY (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nurse`
--

LOCK TABLES `nurse` WRITE;
/*!40000 ALTER TABLE `nurse` DISABLE KEYS */;
INSERT INTO `nurse` VALUES (101,'Carla Espinosa','Head Nurse','t',111111110),(102,'Laverne Roberts','Nurse','t',222222220),(103,'Paul Flowers','Nurse','f',333333330);
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
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(100) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `insuranceid` int(11) DEFAULT NULL,
  `pcp` int(11) DEFAULT NULL,
  PRIMARY KEY (`ssn`),
  KEY `pcp` (`pcp`),
  CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`pcp`) REFERENCES `physician` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (100000001,'John Smith','42 Foobar Lane','555-0256',68476213,1),(100000002,'Grace Ritchie','37 Snafu Drive','555-0512',36546321,2),(100000003,'Random J. Patient','101 Omgbbq Street','555-1204',65465421,2),(100000004,'Dennis Doe','1100 Foobaz Avenue','555-2048',68421879,3);
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
  `name` varchar(50) DEFAULT NULL,
  `position` varchar(50) DEFAULT NULL,
  `ssn` int(11) DEFAULT NULL,
  PRIMARY KEY (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physician`
--

LOCK TABLES `physician` WRITE;
/*!40000 ALTER TABLE `physician` DISABLE KEYS */;
INSERT INTO `physician` VALUES (1,'John Dorian','Staff Internist',111111111),(2,'Elliot Reid','Attending Physician',222222222),(3,'Cristopher Turk','Surgical Attending Physician',333333333),(4,'Percival Cox','Senior Attending Physician',444444444),(5,'Bob Kelso','Head Chief of Medicine',555555555),(6,'Todd Quinlan','Surgical Attending Physician',666666666),(7,'John Wen','Surgical Attending Physician',777777777),(8,'Keith Dudemeister','MD Resident',888888888),(9,'Molly Clock','Attending Psychiatrist',999999999);
/*!40000 ALTER TABLE `physician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `procedur`
--

DROP TABLE IF EXISTS `procedur`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `procedur` (
  `code` int(11) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `cost` int(11) DEFAULT NULL,
  PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `procedur`
--

LOCK TABLES `procedur` WRITE;
/*!40000 ALTER TABLE `procedur` DISABLE KEYS */;
INSERT INTO `procedur` VALUES (1,'Reverse Rhinopodoplasty',1500),(2,'Obtuse Pyloric Recombobulation',3750),(3,'Folded Demiophtalmectomy',4500),(4,'Complete Walletectomy',10000),(5,'Obfuscated Dermogastrotomy',4899);
/*!40000 ALTER TABLE `procedur` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `roomnumber` int(11) NOT NULL,
  `roomtype` varchar(20) DEFAULT NULL,
  `blockfloor` int(11) DEFAULT NULL,
  `blockcode` int(11) DEFAULT NULL,
  `unavailable` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`roomnumber`),
  KEY `blockfloor` (`blockfloor`),
  CONSTRAINT `room_ibfk_1` FOREIGN KEY (`blockfloor`) REFERENCES `block` (`block_floor`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (101,'Single',1,1,0),(102,'Single',2,1,0),(212,'Single',3,2,0);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trained`
--

DROP TABLE IF EXISTS `trained`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trained` (
  `physician` int(11) DEFAULT NULL,
  `treatment` int(11) DEFAULT NULL,
  `cretificationdate` datetime DEFAULT NULL,
  `certificationexpires` datetime DEFAULT NULL,
  KEY `physician` (`physician`),
  KEY `treatment` (`treatment`),
  CONSTRAINT `trained_ibfk_1` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`),
  CONSTRAINT `trained_ibfk_2` FOREIGN KEY (`treatment`) REFERENCES `procedur` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trained`
--

LOCK TABLES `trained` WRITE;
/*!40000 ALTER TABLE `trained` DISABLE KEYS */;
INSERT INTO `trained` VALUES (3,1,'2008-01-01 00:00:00','2008-12-31 00:00:00'),(3,2,'2008-01-01 00:00:00','2008-12-31 00:00:00'),(6,2,'2008-01-01 00:00:00','2008-12-31 00:00:00'),(6,5,'2007-01-01 00:00:00','2007-12-31 00:00:00'),(7,1,'2008-01-01 00:00:00','2008-12-31 00:00:00');
/*!40000 ALTER TABLE `trained` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `undergoes`
--

DROP TABLE IF EXISTS `undergoes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `undergoes` (
  `patient` int(11) DEFAULT NULL,
  `procedur` int(11) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  `physician` int(11) DEFAULT NULL,
  `assistingnurse` int(11) DEFAULT NULL,
  KEY `patient` (`patient`),
  KEY `procedur` (`procedur`),
  KEY `physician` (`physician`),
  KEY `assistingnurse` (`assistingnurse`),
  CONSTRAINT `undergoes_ibfk_1` FOREIGN KEY (`patient`) REFERENCES `patient` (`ssn`),
  CONSTRAINT `undergoes_ibfk_2` FOREIGN KEY (`procedur`) REFERENCES `procedur` (`code`),
  CONSTRAINT `undergoes_ibfk_3` FOREIGN KEY (`physician`) REFERENCES `physician` (`employeeid`),
  CONSTRAINT `undergoes_ibfk_4` FOREIGN KEY (`assistingnurse`) REFERENCES `nurse` (`employeeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `undergoes`
--

LOCK TABLES `undergoes` WRITE;
/*!40000 ALTER TABLE `undergoes` DISABLE KEYS */;
INSERT INTO `undergoes` VALUES (100000001,1,'2008-05-02 00:00:00',3,101),(100000001,2,'2008-05-10 00:00:00',7,101),(100000004,4,'2008-05-13 00:00:00',3,103);
/*!40000 ALTER TABLE `undergoes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-07 10:37:49
