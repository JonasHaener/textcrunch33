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
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`block_id`,`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocks`
--

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
INSERT INTO `blocks` VALUES (1,1,1,'2014-02-23 07:01:37',NULL),(2,1,1,'2014-02-23 07:01:37',NULL),(3,1,1,'2014-02-23 07:01:37',NULL),(4,2,1,'2014-02-23 07:01:37',NULL),(5,1,1,'2014-02-23 07:01:37',NULL),(6,1,1,'2014-02-23 07:08:46',NULL),(7,1,1,'2014-02-23 07:15:22',NULL),(8,2,1,'2014-02-23 08:13:45',NULL),(9,1,1,'2014-02-23 08:24:28',NULL),(10,1,1,'2014-02-23 08:35:31',NULL),(13,1,1,'2014-02-23 10:55:52',NULL),(14,1,1,'2014-02-23 10:55:54',NULL),(15,2,1,'2014-02-23 10:56:04',NULL),(16,2,1,'2014-02-23 10:56:05',NULL),(17,4,1,'2014-02-23 11:21:48',NULL),(18,4,1,'2014-02-23 11:21:49',NULL),(19,4,1,'2014-02-23 11:22:53',NULL),(21,8,1,'2014-02-23 14:01:04',NULL),(22,5,1,'2014-02-23 14:02:56',NULL),(23,11,1,'2014-02-23 14:04:03',NULL),(24,5,1,'2014-02-23 14:04:43',NULL);
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1 COMMENT='holds categories to be assigned to textblocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'safety','2014-02-23 13:21:13',NULL),(2,'intro','2014-02-23 13:21:13',NULL),(3,'intendeduse','2014-02-23 13:21:13',NULL),(4,'warning','2014-02-23 13:21:13',NULL),(5,'use','2014-02-23 13:21:13',NULL),(6,'fcc','2014-02-23 13:21:13',NULL),(7,'doc','2014-02-23 13:21:13',NULL),(8,'cleaning','2014-02-23 13:21:13',NULL),(9,'techdata','2014-02-23 13:21:13',NULL),(10,'legal','2014-02-23 13:21:13',NULL),(11,'address','2014-02-23 13:21:13',NULL);
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `dutch_id_UNIQUE` (`dutch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_dutch`
--

LOCK TABLES `lang_dutch` WRITE;
/*!40000 ALTER TABLE `lang_dutch` DISABLE KEYS */;
INSERT INTO `lang_dutch` VALUES ('',1,1,1,'dutch','2014-02-23 07:03:29'),('',2,1,2,'dutch','2014-02-23 07:03:29'),('',3,2,3,'dutch','2014-02-23 07:03:29'),('',4,2,4,'dutch','2014-02-23 07:03:29'),('',5,1,5,'dutch','2014-02-23 07:03:29'),('',6,1,6,'dutch','2014-02-23 07:08:46'),('',7,1,7,'dutch','2014-02-23 07:15:22'),('',8,2,8,'dutch','2014-02-23 08:13:45'),('',9,1,9,'dutch','2014-02-23 08:24:28'),('',10,1,10,'dutch','2014-02-23 08:35:31'),('',13,1,13,'dutch','2014-02-23 10:55:52'),('',14,1,14,'dutch','2014-02-23 10:55:54'),('',15,2,15,'dutch','2014-02-23 10:56:04'),('',16,2,16,'dutch','2014-02-23 10:56:05'),('',17,4,17,'dutch','2014-02-23 11:21:48'),('',18,4,18,'dutch','2014-02-23 11:21:49'),('',19,4,19,'dutch','2014-02-23 11:22:53'),('',21,8,21,'dutch','2014-02-23 14:01:04'),('',22,5,22,'dutch','2014-02-23 14:05:44'),('',23,11,23,'dutch','2014-02-23 14:04:03'),('',24,5,24,'dutch','2014-02-23 14:04:43');
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `english_id_UNIQUE` (`english_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_english`
--

LOCK TABLES `lang_english` WRITE;
/*!40000 ALTER TABLE `lang_english` DISABLE KEYS */;
INSERT INTO `lang_english` VALUES ('@safety',1,1,1,'english','2014-02-23 07:03:53'),('@safety',2,1,2,'english','2014-02-23 07:03:53'),('@cleaning',3,2,3,'english','2014-02-23 07:03:53'),('@cleaning',4,2,4,'english','2014-02-23 07:03:53'),('',5,1,5,'english','2014-02-23 07:03:53'),('',6,1,6,'english','2014-02-23 07:08:46'),('',7,1,7,'english','2014-02-23 07:15:22'),('',8,2,8,'english','2014-02-23 08:13:45'),('',9,1,9,'english','2014-02-23 08:24:28'),('',10,1,10,'english','2014-02-23 08:35:31'),('',13,1,13,'english','2014-02-23 10:55:52'),('',14,1,14,'english','2014-02-23 10:55:54'),('',15,2,15,'english','2014-02-23 10:56:04'),('',16,2,16,'english','2014-02-23 10:56:05'),('',17,4,17,'english','2014-02-23 11:21:48'),('',18,4,18,'english','2014-02-23 11:21:49'),('',19,4,19,'english','2014-02-23 11:22:53'),('',21,8,21,'english','2014-02-23 14:01:04'),('',22,5,22,'english','2014-02-23 14:05:44'),('',23,11,23,'english','2014-02-23 14:04:03'),('',24,5,24,'english','2014-02-23 14:04:43');
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `french_id_UNIQUE` (`french_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_french`
--

LOCK TABLES `lang_french` WRITE;
/*!40000 ALTER TABLE `lang_french` DISABLE KEYS */;
INSERT INTO `lang_french` VALUES ('',1,1,1,'french','2014-02-23 07:04:10'),('',2,1,2,'french','2014-02-23 07:04:10'),('',3,2,3,'french','2014-02-23 07:04:10'),('',4,2,4,'french','2014-02-23 07:04:10'),('',5,1,5,'french','2014-02-23 07:04:10'),('',6,1,6,'french','2014-02-23 07:08:46'),('',7,1,7,'french','2014-02-23 07:15:22'),('',8,2,8,'french','2014-02-23 08:13:45'),('',9,1,9,'french','2014-02-23 08:24:28'),('',10,1,10,'french','2014-02-23 08:35:31'),('',13,1,13,'french','2014-02-23 10:55:52'),('',14,1,14,'french','2014-02-23 10:55:54'),('',15,2,15,'french','2014-02-23 10:56:04'),('',16,2,16,'french','2014-02-23 10:56:05'),('',17,4,17,'french','2014-02-23 11:21:48'),('',18,4,18,'french','2014-02-23 11:21:49'),('',19,4,19,'french','2014-02-23 11:22:53'),('',21,8,21,'french','2014-02-23 14:01:04'),('',22,5,22,'french','2014-02-23 14:05:44'),('',23,11,23,'french','2014-02-23 14:04:03'),('',24,5,24,'french','2014-02-23 14:04:43');
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `german_id_UNIQUE` (`german_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_german`
--

LOCK TABLES `lang_german` WRITE;
/*!40000 ALTER TABLE `lang_german` DISABLE KEYS */;
INSERT INTO `lang_german` VALUES ('@safety@safety@ssssafety@safetywss    Jonas changed  1 AGAIN @safety',1,1,1,'german','2014-02-23 10:01:15'),('@safety',2,1,2,'german','2014-02-23 07:04:28'),('@cleaning@cleaning@cleaning',3,1,3,'german','2014-02-23 07:04:28'),('@cleaning @cleaning@cleaning@cleaning @cleaning @cleaning@cleaning@cleaning',4,2,4,'german','2014-02-23 07:04:28'),('22',5,1,5,'german','2014-02-23 07:04:28'),('ssss',6,1,6,'german','2014-02-23 07:08:46'),('ss',7,1,7,'german','2014-02-23 07:15:22'),('sss',8,2,8,'german','2014-02-23 08:13:45'),('ssss',9,1,9,'german','2014-02-23 08:24:28'),('www WWWW',10,1,10,'german','2014-02-23 12:29:05'),('@safety',13,1,13,'german','2014-02-23 10:55:52'),('@safety',14,1,14,'german','2014-02-23 10:55:54'),('@cleaning',15,2,15,'german','2014-02-23 10:56:04'),('@cleaning',16,2,16,'german','2014-02-23 10:56:05'),('@cleaning',17,4,17,'german','2014-02-23 11:21:48'),('@cleaning',18,4,18,'german','2014-02-23 11:21:49'),('@legal  #1 #2',19,4,19,'german','2014-02-23 11:22:53'),('ssss',21,8,21,'german','2014-02-23 14:01:04'),('My home address is so and so...<>>',22,5,22,'german','2014-02-23 14:02:56'),('My home address is so and so...<>>',23,11,23,'german','2014-02-23 14:04:03'),('My home address is so and so...<>>',24,5,24,'german','2014-02-23 14:04:43');
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `italian_id_UNIQUE` (`italian_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_italian`
--

LOCK TABLES `lang_italian` WRITE;
/*!40000 ALTER TABLE `lang_italian` DISABLE KEYS */;
INSERT INTO `lang_italian` VALUES ('',1,1,1,'italian','2014-02-23 07:04:42'),('',2,1,2,'italian','2014-02-23 07:04:42'),('',3,2,3,'italian','2014-02-23 07:04:42'),('',4,2,4,'italian','2014-02-23 07:04:42'),('',5,1,5,'italian','2014-02-23 07:04:42'),('',6,1,6,'italian','2014-02-23 07:08:46'),('',7,1,7,'italian','2014-02-23 07:15:22'),('',8,2,8,'italian','2014-02-23 08:13:45'),('',9,1,9,'italian','2014-02-23 08:24:28'),('',10,1,10,'italian','2014-02-23 08:35:31'),('',13,1,13,'italian','2014-02-23 10:55:52'),('',14,1,14,'italian','2014-02-23 10:55:54'),('',15,2,15,'italian','2014-02-23 10:56:04'),('',16,2,16,'italian','2014-02-23 10:56:05'),('',17,4,17,'italian','2014-02-23 11:21:48'),('',18,4,18,'italian','2014-02-23 11:21:49'),('',19,4,19,'italian','2014-02-23 11:22:53'),('',21,8,21,'italian','2014-02-23 14:01:04'),('',22,5,22,'italian','2014-02-23 14:05:44'),('',23,11,23,'italian','2014-02-23 14:04:03'),('',24,5,24,'italian','2014-02-23 14:04:43');
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `japanese_id_UNIQUE` (`japanese_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_japanese`
--

LOCK TABLES `lang_japanese` WRITE;
/*!40000 ALTER TABLE `lang_japanese` DISABLE KEYS */;
INSERT INTO `lang_japanese` VALUES ('',1,1,1,'japanese','2014-02-23 07:05:01'),('',2,1,2,'japanese','2014-02-23 07:05:01'),('',3,2,3,'japanese','2014-02-23 07:05:01'),('',4,2,4,'japanese','2014-02-23 07:05:01'),('',5,1,5,'japanese','2014-02-23 07:05:01'),('',6,1,6,'japanese','2014-02-23 07:08:46'),('',7,1,7,'japanese','2014-02-23 07:15:22'),('',8,2,8,'japanese','2014-02-23 08:13:45'),('',9,1,9,'japanese','2014-02-23 08:24:28'),('',10,1,10,'japanese','2014-02-23 08:35:31'),('',13,1,13,'japanese','2014-02-23 10:55:52'),('',14,1,14,'japanese','2014-02-23 10:55:54'),('',15,2,15,'japanese','2014-02-23 10:56:04'),('',16,2,16,'japanese','2014-02-23 10:56:05'),('',17,4,17,'japanese','2014-02-23 11:21:48'),('',18,4,18,'japanese','2014-02-23 11:21:49'),('',19,4,19,'japanese','2014-02-23 11:22:53'),('',21,8,21,'japanese','2014-02-23 14:01:04'),('',22,5,22,'japanese','2014-02-23 14:05:44'),('',23,11,23,'japanese','2014-02-23 14:04:03'),('',24,5,24,'japanese','2014-02-23 14:04:43');
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `polish_id_UNIQUE` (`polish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_polish`
--

LOCK TABLES `lang_polish` WRITE;
/*!40000 ALTER TABLE `lang_polish` DISABLE KEYS */;
INSERT INTO `lang_polish` VALUES ('',1,1,1,'polish','2014-02-23 07:05:14'),('',2,1,2,'polish','2014-02-23 07:05:14'),('',3,2,3,'polish','2014-02-23 07:05:14'),('',4,2,4,'polish','2014-02-23 07:05:14'),('',5,1,5,'polish','2014-02-23 07:05:14'),('',6,1,6,'polish','2014-02-23 07:08:46'),('',7,1,7,'polish','2014-02-23 07:15:22'),('',8,2,8,'polish','2014-02-23 08:13:45'),('',9,1,9,'polish','2014-02-23 08:24:28'),('',10,1,10,'polish','2014-02-23 08:35:31'),('',13,1,13,'polish','2014-02-23 10:55:52'),('',14,1,14,'polish','2014-02-23 10:55:54'),('',15,2,15,'polish','2014-02-23 10:56:04'),('',16,2,16,'polish','2014-02-23 10:56:05'),('',17,4,17,'polish','2014-02-23 11:21:48'),('',18,4,18,'polish','2014-02-23 11:21:49'),('',19,4,19,'polish','2014-02-23 11:22:53'),('',21,8,21,'polish','2014-02-23 14:01:04'),('',22,5,22,'polish','2014-02-23 14:05:44'),('',23,11,23,'polish','2014-02-23 14:04:03'),('',24,5,24,'polish','2014-02-23 14:04:43');
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`,`category_id`),
  UNIQUE KEY `spanish_id_UNIQUE` (`spanish_id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1 COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_spanish`
--

LOCK TABLES `lang_spanish` WRITE;
/*!40000 ALTER TABLE `lang_spanish` DISABLE KEYS */;
INSERT INTO `lang_spanish` VALUES ('',1,1,1,'spanish','2014-02-23 07:05:32'),('',2,1,2,'spanish','2014-02-23 07:05:32'),('',3,2,3,'spanish','2014-02-23 07:05:32'),('',4,2,4,'spanish','2014-02-23 07:05:32'),('',5,1,5,'spanish','2014-02-23 07:05:32'),('',6,1,6,'spanish','2014-02-23 07:08:46'),('',7,1,7,'spanish','2014-02-23 07:15:22'),('',8,2,8,'spanish','2014-02-23 08:13:45'),('',9,1,9,'spanish','2014-02-23 08:24:28'),('',10,1,10,'spanish','2014-02-23 08:35:31'),('',13,1,13,'spanish','2014-02-23 10:55:52'),('',14,1,14,'spanish','2014-02-23 10:55:54'),('',15,2,15,'spanish','2014-02-23 10:56:04'),('',16,2,16,'spanish','2014-02-23 10:56:05'),('',17,4,17,'spanish','2014-02-23 11:21:48'),('',18,4,18,'spanish','2014-02-23 11:21:49'),('',19,4,19,'spanish','2014-02-23 11:22:53'),('',21,8,21,'spanish','2014-02-23 14:01:04'),('',22,5,22,'spanish','2014-02-23 14:05:44'),('',23,11,23,'spanish','2014-02-23 14:04:03'),('',24,5,24,'spanish','2014-02-23 14:04:43');
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`project_id`,`user_id`),
  KEY `project_idx` (`project_id`),
  KEY `user_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 COMMENT='saves user projects, block id collection\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (3,1,'jonas','1,2,3','2014-02-23 10:49:57',NULL),(4,1,'jonasss','21,22,24','2014-02-23 14:11:36',NULL);
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`,`tag_id`),
  UNIQUE KEY `switch_id_UNIQUE` (`switch_id`),
  KEY `blocks_idx` (`block_id`),
  KEY `tag_idx` (`tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_switch`
--

LOCK TABLES `tag_switch` WRITE;
/*!40000 ALTER TABLE `tag_switch` DISABLE KEYS */;
INSERT INTO `tag_switch` VALUES (1,1,43,'2014-02-23 10:01:15'),(1,2,2,'2014-02-23 07:06:31'),(1,3,10,'2014-02-23 07:06:31'),(1,4,37,'2014-02-23 09:08:17'),(1,5,36,'2014-02-23 09:07:09'),(2,6,26,'2014-02-23 07:08:46'),(3,7,27,'2014-02-23 07:15:22'),(4,8,30,'2014-02-23 08:28:09'),(4,9,29,'2014-02-23 08:24:28'),(5,10,53,'2014-02-23 12:29:05'),(1,11,42,'2014-02-23 10:00:53'),(1,12,44,'2014-02-23 10:05:18'),(6,13,45,'2014-02-23 10:55:52'),(6,14,46,'2014-02-23 10:55:54'),(6,15,47,'2014-02-23 10:56:04'),(6,16,48,'2014-02-23 10:56:05'),(6,17,49,'2014-02-23 11:21:48'),(6,18,50,'2014-02-23 11:21:49'),(1,19,51,'2014-02-23 11:22:53'),(2,19,52,'2014-02-23 11:22:53'),(6,20,56,'2014-02-23 13:57:20'),(1,21,57,'2014-02-23 14:01:04'),(1,22,63,'2014-02-23 14:05:44'),(1,23,61,'2014-02-23 14:04:03'),(1,24,62,'2014-02-23 14:04:43');
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notes` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `tag_idx` (`tag_id`),
  KEY `fk_tags_users1_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1 COMMENT='holds user created tags';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,1,'1',NULL,NULL),(2,1,'2','2014-02-23 07:08:46',NULL),(3,1,'s','2014-02-23 07:15:22',NULL),(4,1,'jonas','2014-02-23 08:13:45',NULL),(5,1,'rt','2014-02-23 08:35:31',NULL),(6,1,'baum','2014-02-23 10:55:52',NULL);
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
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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

-- Dump completed on 2014-02-23 22:20:27
