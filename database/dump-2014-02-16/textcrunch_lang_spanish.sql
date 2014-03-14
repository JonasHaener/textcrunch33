CREATE DATABASE  IF NOT EXISTS `textcrunch` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `textcrunch`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: textcrunch
-- ------------------------------------------------------
-- Server version	5.6.14-log

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
-- Table structure for table `lang_spanish`
--

DROP TABLE IF EXISTS `lang_spanish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_spanish` (
  `content` longtext,
  `block_id` int(10) NOT NULL,
  `category_id` int(10) NOT NULL,
  `spanish_id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(45) DEFAULT 'spanish',
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `spanish_id_UNIQUE` (`spanish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_spanish`
--

LOCK TABLES `lang_spanish` WRITE;
/*!40000 ALTER TABLE `lang_spanish` DISABLE KEYS */;
INSERT INTO `lang_spanish` VALUES ('',1,2,1,'spanish'),('',2,1,2,'spanish'),('',3,4,3,'spanish'),('',4,1,4,'spanish'),('',5,4,5,'spanish'),('',6,4,6,'spanish'),('',8,1,8,'spanish'),('',9,1,9,'spanish'),('',11,1,11,'spanish'),('',12,1,12,'spanish'),('',13,1,13,'spanish'),('',14,1,14,'spanish'),('',15,1,15,'spanish'),('',16,1,16,'spanish'),('',17,1,17,'spanish'),('',18,1,18,'spanish');
/*!40000 ALTER TABLE `lang_spanish` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-02-16 12:57:26
