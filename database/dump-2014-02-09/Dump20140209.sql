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
-- Table structure for table `blocks`
--

DROP TABLE IF EXISTS `blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocks` (
  `block_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `created` datetime DEFAULT NULL,
  `notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`block_id`,`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocks`
--

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
INSERT INTO `blocks` VALUES (1,1,1,NULL,NULL),(2,2,1,NULL,NULL),(3,4,1,NULL,NULL),(4,4,1,NULL,NULL),(5,2,1,NULL,NULL),(6,1,1,NULL,NULL),(7,1,1,NULL,NULL);
/*!40000 ALTER TABLE `blocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `blocks_deleted`
--

DROP TABLE IF EXISTS `blocks_deleted`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `blocks_deleted` (
  `del_block_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `category_id` int(10) NOT NULL,
  `german` longtext,
  `english` longtext,
  `french` longtext,
  `dutch` longtext,
  `italian` longtext,
  `polish` longtext,
  `spanish` longtext,
  `japanese` longtext,
  `placeholder1` longtext,
  `placeholder2` longtext,
  `placeholder3` longtext,
  `created` timestamp NULL DEFAULT NULL,
  `notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`del_block_id`,`user_id`),
  KEY `block_id` (`del_block_id`),
  KEY `user_id` (`user_id`),
  KEY `fk_blocks_deleted_categories1_idx` (`category_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='holds text blocks that were deleted';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocks_deleted`
--

LOCK TABLES `blocks_deleted` WRITE;
/*!40000 ALTER TABLE `blocks_deleted` DISABLE KEYS */;
/*!40000 ALTER TABLE `blocks_deleted` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categories` (
  `category_id` int(10) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1 COMMENT='holds categories to be assigned to textblocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'safety',NULL,NULL),(2,'cleaning',NULL,NULL),(3,'introduction',NULL,NULL),(4,'legal',NULL,NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_dutch`
--

DROP TABLE IF EXISTS `lang_dutch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_dutch` (
  `content` longtext,
  `block_id` int(10) NOT NULL,
  `category_id` int(10) NOT NULL,
  `dutch_id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(45) DEFAULT 'dutch',
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `dutch_id_UNIQUE` (`dutch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_dutch`
--

LOCK TABLES `lang_dutch` WRITE;
/*!40000 ALTER TABLE `lang_dutch` DISABLE KEYS */;
INSERT INTO `lang_dutch` VALUES ('',1,1,1,'dutch'),('',2,2,2,'dutch'),('',3,4,3,'dutch'),('',4,4,4,'dutch'),('',5,2,5,'dutch'),('',6,1,6,'dutch'),('ss',7,1,7,'dutch');
/*!40000 ALTER TABLE `lang_dutch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_english`
--

DROP TABLE IF EXISTS `lang_english`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_english` (
  `content` longtext,
  `block_id` int(10) NOT NULL,
  `category_id` int(10) NOT NULL,
  `english_id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(45) DEFAULT 'english',
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `english_id_UNIQUE` (`english_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_english`
--

LOCK TABLES `lang_english` WRITE;
/*!40000 ALTER TABLE `lang_english` DISABLE KEYS */;
INSERT INTO `lang_english` VALUES ('',1,1,1,'english'),('',2,2,2,'english'),('',3,4,3,'english'),('',4,4,4,'english'),('',5,2,5,'english'),('',6,1,6,'english'),('ss',7,1,7,'english');
/*!40000 ALTER TABLE `lang_english` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_french`
--

DROP TABLE IF EXISTS `lang_french`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_french` (
  `content` longtext,
  `block_id` int(10) NOT NULL,
  `category_id` int(10) NOT NULL,
  `french_id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(45) DEFAULT 'french',
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `french_id_UNIQUE` (`french_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_french`
--

LOCK TABLES `lang_french` WRITE;
/*!40000 ALTER TABLE `lang_french` DISABLE KEYS */;
INSERT INTO `lang_french` VALUES ('',1,1,1,'french'),('',2,2,2,'french'),('',3,4,3,'french'),('',4,4,4,'french'),('',5,2,5,'french'),('',6,1,6,'french'),('ss',7,1,7,'french');
/*!40000 ALTER TABLE `lang_french` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_german`
--

DROP TABLE IF EXISTS `lang_german`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_german` (
  `content` longtext,
  `block_id` int(10) NOT NULL,
  `category_id` int(10) NOT NULL,
  `german_id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(45) DEFAULT 'german',
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `german_id_UNIQUE` (`german_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_german`
--

LOCK TABLES `lang_german` WRITE;
/*!40000 ALTER TABLE `lang_german` DISABLE KEYS */;
INSERT INTO `lang_german` VALUES ('ss',1,1,1,'german'),('ss',2,2,2,'german'),('ss',3,4,3,'german'),('ss',4,4,4,'german'),('ss',5,2,5,'german'),('ss',6,1,6,'german'),('ss',7,1,7,'german');
/*!40000 ALTER TABLE `lang_german` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_italian`
--

DROP TABLE IF EXISTS `lang_italian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_italian` (
  `content` longtext,
  `block_id` int(10) NOT NULL,
  `category_id` int(10) NOT NULL,
  `italian_id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(45) DEFAULT 'italian',
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `italian_id_UNIQUE` (`italian_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_italian`
--

LOCK TABLES `lang_italian` WRITE;
/*!40000 ALTER TABLE `lang_italian` DISABLE KEYS */;
INSERT INTO `lang_italian` VALUES ('',1,1,1,'italian'),('',2,2,2,'italian'),('',3,4,3,'italian'),('',4,4,4,'italian'),('',5,2,5,'italian'),('',6,1,6,'italian'),('ss',7,1,7,'italian');
/*!40000 ALTER TABLE `lang_italian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_japanese`
--

DROP TABLE IF EXISTS `lang_japanese`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_japanese` (
  `content` longtext,
  `block_id` int(10) NOT NULL,
  `category_id` int(10) NOT NULL,
  `japanese_id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(45) DEFAULT 'japanese',
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `japanese_id_UNIQUE` (`japanese_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_japanese`
--

LOCK TABLES `lang_japanese` WRITE;
/*!40000 ALTER TABLE `lang_japanese` DISABLE KEYS */;
INSERT INTO `lang_japanese` VALUES ('',1,1,1,'japanese'),('',2,2,2,'japanese'),('',3,4,3,'japanese'),('',4,4,4,'japanese'),('',5,2,5,'japanese'),('',6,1,6,'japanese'),('ss',7,1,7,'japanese');
/*!40000 ALTER TABLE `lang_japanese` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_polish`
--

DROP TABLE IF EXISTS `lang_polish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_polish` (
  `content` longtext,
  `block_id` int(10) NOT NULL,
  `category_id` int(10) NOT NULL,
  `polish_id` int(11) NOT NULL AUTO_INCREMENT,
  `lang` varchar(45) DEFAULT 'polish',
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `polish_id_UNIQUE` (`polish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_polish`
--

LOCK TABLES `lang_polish` WRITE;
/*!40000 ALTER TABLE `lang_polish` DISABLE KEYS */;
INSERT INTO `lang_polish` VALUES ('',1,1,1,'polish'),('',2,2,2,'polish'),('',3,4,3,'polish'),('',4,4,4,'polish'),('',5,2,5,'polish'),('',6,1,6,'polish'),('ss',7,1,7,'polish');
/*!40000 ALTER TABLE `lang_polish` ENABLE KEYS */;
UNLOCK TABLES;

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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_spanish`
--

LOCK TABLES `lang_spanish` WRITE;
/*!40000 ALTER TABLE `lang_spanish` DISABLE KEYS */;
INSERT INTO `lang_spanish` VALUES ('',1,1,1,'spanish'),('',2,2,2,'spanish'),('',3,4,3,'spanish'),('',4,4,4,'spanish'),('',5,2,5,'spanish'),('',6,1,6,'spanish'),('ss',7,1,7,'spanish');
/*!40000 ALTER TABLE `lang_spanish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `projects`
--

DROP TABLE IF EXISTS `projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `projects` (
  `project_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `project_name` varchar(100) DEFAULT NULL,
  `collection` varchar(500) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`project_id`,`user_id`),
  KEY `project_idx` (`project_id`),
  KEY `user_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=latin1 COMMENT='saves user projects, block id collection\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (97,1,'JOnas','',NULL,NULL),(98,1,'JOnAS','',NULL,NULL),(99,1,'jONAS','',NULL,NULL),(106,1,'Jonas','',NULL,NULL),(107,1,'Jonas','',NULL,NULL),(108,1,'Jonas','',NULL,NULL),(109,1,'Jonas','',NULL,NULL),(113,1,'Joans1','1,3',NULL,NULL),(116,1,'Jonas','1,2,3,7',NULL,NULL);
/*!40000 ALTER TABLE `projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tag_switch`
--

DROP TABLE IF EXISTS `tag_switch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tag_switch` (
  `tag_id` int(10) NOT NULL,
  `block_id` int(10) NOT NULL,
  `switch_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`block_id`,`tag_id`),
  UNIQUE KEY `switch_id_UNIQUE` (`switch_id`),
  KEY `blocks_idx` (`block_id`),
  KEY `tag_idx` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_switch`
--

LOCK TABLES `tag_switch` WRITE;
/*!40000 ALTER TABLE `tag_switch` DISABLE KEYS */;
INSERT INTO `tag_switch` VALUES (1,1,1),(1,2,2),(1,3,3),(2,4,4),(2,5,5),(2,6,6),(1,7,7);
/*!40000 ALTER TABLE `tag_switch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `tag_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_id` int(10) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `tag_idx` (`tag_id`),
  KEY `fk_tags_users1_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='holds user created tags';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,1,'usb',NULL,NULL),(2,1,'legal',NULL,NULL);
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `rights` int(10) NOT NULL,
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT NULL,
  `notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='holds user data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2014-02-09 20:41:04
