CREATE DATABASE  IF NOT EXISTS `textcrunch` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `textcrunch`;
-- MySQL dump 10.13  Distrib 5.6.13, for Win32 (x86)
--
-- Host: localhost    Database: textcrunch
-- ------------------------------------------------------
-- Server version	5.6.14

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
  `notes` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`block_id`,`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=151 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocks`
--

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
INSERT INTO `blocks` VALUES (4,8,1,'2014-03-12 12:31:44',NULL),(5,8,1,'2014-03-12 12:31:46',NULL),(6,8,1,'2014-03-12 12:31:47',NULL),(7,8,1,'2014-03-12 12:31:47',NULL),(8,8,1,'2014-03-12 12:31:47',NULL),(9,8,1,'2014-03-12 12:31:48',NULL),(10,8,1,'2014-03-12 12:31:48',NULL),(11,8,1,'2014-03-12 12:31:49',NULL),(12,8,1,'2014-03-12 12:31:49',NULL),(13,8,1,'2014-03-12 12:31:50',NULL),(14,8,1,'2014-03-12 12:31:50',NULL),(15,8,1,'2014-03-12 12:31:50',NULL),(16,8,1,'2014-03-12 12:31:50',NULL),(17,8,1,'2014-03-12 12:31:50',NULL),(18,8,1,'2014-03-12 12:31:51',NULL),(19,8,1,'2014-03-12 12:31:51',NULL),(20,8,1,'2014-03-12 12:31:51',NULL),(21,8,1,'2014-03-12 12:31:51',NULL),(22,8,1,'2014-03-12 12:31:51',NULL),(23,8,1,'2014-03-12 12:31:52',NULL),(24,8,1,'2014-03-12 12:31:52',NULL),(25,8,1,'2014-03-12 12:31:52',NULL),(26,8,1,'2014-03-12 12:31:52',NULL),(27,8,1,'2014-03-12 12:31:52',NULL),(28,8,1,'2014-03-12 12:31:52',NULL),(29,8,1,'2014-03-12 12:31:53',NULL),(30,8,1,'2014-03-12 12:31:53',NULL),(31,8,1,'2014-03-12 12:31:53',NULL),(32,8,1,'2014-03-12 12:31:53',NULL),(33,8,1,'2014-03-12 12:31:53',NULL),(34,8,1,'2014-03-12 12:31:53',NULL),(35,8,1,'2014-03-12 12:31:54',NULL),(36,8,1,'2014-03-12 12:31:54',NULL),(37,8,1,'2014-03-12 12:31:54',NULL),(38,8,1,'2014-03-12 12:31:54',NULL),(39,8,1,'2014-03-12 12:31:54',NULL),(40,8,1,'2014-03-12 12:31:54',NULL),(41,8,1,'2014-03-12 12:31:55',NULL),(42,8,1,'2014-03-12 12:31:55',NULL),(43,8,1,'2014-03-12 12:31:55',NULL),(44,8,1,'2014-03-12 12:31:55',NULL),(45,8,1,'2014-03-12 12:31:55',NULL),(46,8,1,'2014-03-12 12:31:55',NULL),(47,8,1,'2014-03-12 12:31:56',NULL),(48,8,1,'2014-03-12 12:31:56',NULL),(49,8,1,'2014-03-12 12:31:56',NULL),(50,8,1,'2014-03-12 12:31:56',NULL),(51,8,1,'2014-03-12 12:31:56',NULL),(52,8,1,'2014-03-12 12:31:56',NULL),(53,8,1,'2014-03-12 12:31:57',NULL),(54,8,1,'2014-03-12 12:31:57',NULL),(55,8,1,'2014-03-12 12:31:57',NULL),(56,8,1,'2014-03-12 12:31:57',NULL),(57,8,1,'2014-03-12 12:31:57',NULL),(58,8,1,'2014-03-12 12:31:57',NULL),(59,8,1,'2014-03-12 12:31:58',NULL),(60,8,1,'2014-03-12 12:31:58',NULL),(61,8,1,'2014-03-12 12:31:58',NULL),(62,8,1,'2014-03-12 12:31:59',NULL),(63,8,1,'2014-03-12 12:31:59',NULL),(64,8,1,'2014-03-12 12:31:59',NULL),(65,8,1,'2014-03-12 12:31:59',NULL),(66,8,1,'2014-03-12 12:31:59',NULL),(67,8,1,'2014-03-12 12:32:00',NULL),(68,8,1,'2014-03-12 12:32:00',NULL),(69,8,1,'2014-03-12 12:32:00',NULL),(70,8,1,'2014-03-12 12:32:01',NULL),(71,8,1,'2014-03-12 12:32:01',NULL),(72,8,1,'2014-03-12 12:32:01',NULL),(73,8,1,'2014-03-12 12:32:01',NULL),(74,8,1,'2014-03-12 12:32:01',NULL),(75,8,1,'2014-03-12 12:32:01',NULL),(76,8,1,'2014-03-12 12:32:02',NULL),(77,8,1,'2014-03-12 12:32:02',NULL),(78,8,1,'2014-03-12 12:32:02',NULL),(79,8,1,'2014-03-12 12:32:02',NULL),(80,8,1,'2014-03-12 12:32:03',NULL),(81,8,1,'2014-03-12 12:32:03',NULL),(82,8,1,'2014-03-12 12:32:03',NULL),(83,8,1,'2014-03-12 12:32:03',NULL),(84,8,1,'2014-03-12 12:32:03',NULL),(85,8,1,'2014-03-12 12:32:03',NULL),(86,8,1,'2014-03-12 12:32:04',NULL),(87,8,1,'2014-03-12 12:32:04',NULL),(88,8,1,'2014-03-12 12:32:04',NULL),(89,8,1,'2014-03-12 12:32:04',NULL),(90,8,1,'2014-03-12 12:32:04',NULL),(91,8,1,'2014-03-12 12:32:05',NULL),(92,8,1,'2014-03-12 12:32:05',NULL),(93,8,1,'2014-03-12 12:32:05',NULL),(94,8,1,'2014-03-12 12:32:05',NULL),(95,8,1,'2014-03-12 12:32:06',NULL),(96,8,1,'2014-03-12 12:32:06',NULL),(97,8,1,'2014-03-12 12:32:06',NULL),(98,8,1,'2014-03-12 12:32:07',NULL),(99,8,1,'2014-03-12 12:32:07',NULL),(100,8,1,'2014-03-12 12:32:07',NULL),(101,8,1,'2014-03-12 12:32:07',NULL),(102,8,1,'2014-03-12 12:32:07',NULL),(103,8,1,'2014-03-12 12:32:08',NULL),(104,8,1,'2014-03-12 12:32:08',NULL),(105,8,1,'2014-03-12 12:32:08',NULL),(106,8,1,'2014-03-12 12:32:08',NULL),(107,8,1,'2014-03-12 12:32:08',NULL),(108,8,1,'2014-03-12 12:32:09',NULL),(109,8,1,'2014-03-12 12:32:09',NULL),(110,8,1,'2014-03-12 12:32:09',NULL),(111,8,1,'2014-03-12 12:32:09',NULL),(112,8,1,'2014-03-12 12:32:10',NULL),(113,8,1,'2014-03-12 12:32:10',NULL),(114,8,1,'2014-03-12 12:32:10',NULL),(115,8,1,'2014-03-12 12:32:10',NULL),(116,8,1,'2014-03-12 12:32:10',NULL),(117,8,1,'2014-03-12 12:32:10',NULL),(118,8,1,'2014-03-12 12:32:11',NULL),(119,8,1,'2014-03-13 13:48:16',NULL),(120,8,1,'2014-03-13 13:48:17',NULL),(121,8,1,'2014-03-13 13:48:17',NULL),(122,8,1,'2014-03-13 13:48:17',NULL),(123,8,1,'2014-03-13 13:48:17',NULL),(124,8,1,'2014-03-13 13:48:18',NULL),(125,8,1,'2014-03-13 13:48:18',NULL),(126,8,1,'2014-03-13 13:48:18',NULL),(127,8,1,'2014-03-13 13:48:18',NULL),(128,8,1,'2014-03-13 13:48:18',NULL),(129,8,1,'2014-03-13 13:48:18',NULL),(130,8,1,'2014-03-13 13:48:19',NULL),(131,8,1,'2014-03-13 13:48:19',NULL),(132,8,1,'2014-03-13 13:48:19',NULL),(133,8,1,'2014-03-13 13:48:19',NULL),(134,8,1,'2014-03-13 13:48:19',NULL),(135,8,1,'2014-03-13 13:48:20',NULL),(136,8,1,'2014-03-13 13:48:20',NULL),(137,8,1,'2014-03-13 13:48:20',NULL),(138,8,1,'2014-03-13 13:48:20',NULL),(139,8,1,'2014-03-13 13:48:20',NULL),(140,8,1,'2014-03-13 13:48:21',NULL),(141,8,1,'2014-03-13 13:48:22',NULL),(142,8,1,'2014-03-13 13:48:22',NULL),(143,8,1,'2014-03-13 13:48:22',NULL),(144,8,1,'2014-03-13 13:48:22',NULL),(145,8,1,'2014-03-13 13:48:22',NULL),(146,8,1,'2014-03-13 13:48:22',NULL),(147,11,1,'2014-03-14 03:33:26',NULL),(148,6,1,'2014-03-14 05:46:30',NULL),(149,7,1,'2014-03-14 05:46:35',NULL),(150,1,1,'2014-03-14 06:27:44',NULL);
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
  `old_block_id` int(10) NOT NULL,
  `user_id` int(10) NOT NULL,
  `category_id` int(10) NOT NULL,
  `german` longtext COLLATE utf8_unicode_ci,
  `english` longtext COLLATE utf8_unicode_ci,
  `french` longtext COLLATE utf8_unicode_ci,
  `dutch` longtext COLLATE utf8_unicode_ci,
  `italian` longtext COLLATE utf8_unicode_ci,
  `polish` longtext COLLATE utf8_unicode_ci,
  `spanish` longtext COLLATE utf8_unicode_ci,
  `japanese` longtext COLLATE utf8_unicode_ci,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notes` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`del_block_id`),
  KEY `block_id` (`del_block_id`),
  KEY `user_id` (`user_id`),
  KEY `fk_blocks_deleted_categories1_idx` (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds text blocks that were deleted';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocks_deleted`
--

LOCK TABLES `blocks_deleted` WRITE;
/*!40000 ALTER TABLE `blocks_deleted` DISABLE KEYS */;
INSERT INTO `blocks_deleted` VALUES (1,2,1,1,'Jonas','JonasJonas','Jonas','Jonas','Jonas','Jonas',NULL,'Jonas','2014-03-12 12:25:31',NULL),(2,119,1,8,'sss','sss','sss','sss','ss','ss',NULL,'ss','2014-03-12 12:39:39',NULL),(3,3,1,11,'ss','','','','','',NULL,'','2014-03-12 12:43:25',NULL),(4,1,1,1,'Jonas','JonasJonas','Jonas','Jonas','Jonas','Jonas',NULL,'Jonas','2014-03-13 05:46:47',NULL);
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
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notes` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds categories to be assigned to textblocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'safety','2014-02-23 13:21:13',NULL),(2,'intro','2014-02-23 13:21:13',NULL),(3,'intendeduse','2014-02-23 13:21:13',NULL),(4,'warning','2014-02-23 13:21:13',NULL),(5,'use','2014-02-23 13:21:13',NULL),(6,'fcc','2014-02-23 13:21:13',NULL),(7,'doc','2014-02-23 13:21:13',NULL),(8,'cleaning','2014-02-23 13:21:13',NULL),(9,'techdata','2014-02-23 13:21:13',NULL),(10,'legal','2014-02-23 13:21:13',NULL),(11,'address','2014-02-23 13:21:13',NULL),(12,'support','2014-03-11 11:06:41',NULL),(14,'-Pick category-','2014-03-11 11:18:09',NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_dutch`
--

DROP TABLE IF EXISTS `lang_dutch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_dutch` (
  `content` longtext COLLATE utf8_unicode_ci,
  `block_id` int(11) NOT NULL,
  `lang` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'dutch',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_dutch`
--

LOCK TABLES `lang_dutch` WRITE;
/*!40000 ALTER TABLE `lang_dutch` DISABLE KEYS */;
INSERT INTO `lang_dutch` VALUES ('sss',4,'dutch','2014-03-12 12:31:44'),('sss',5,'dutch','2014-03-12 12:31:46'),('sss',6,'dutch','2014-03-12 12:31:47'),('sss',7,'dutch','2014-03-12 12:31:47'),('sss',8,'dutch','2014-03-12 12:31:47'),('sss',9,'dutch','2014-03-12 12:31:48'),('sss',10,'dutch','2014-03-12 12:31:48'),('sss',11,'dutch','2014-03-12 12:31:49'),('sss',12,'dutch','2014-03-12 12:31:49'),('sss',13,'dutch','2014-03-12 12:31:50'),('sss',14,'dutch','2014-03-12 12:31:50'),('sss',15,'dutch','2014-03-12 12:31:50'),('sss',16,'dutch','2014-03-12 12:31:50'),('sss',17,'dutch','2014-03-12 12:31:50'),('sss',18,'dutch','2014-03-12 12:31:51'),('sss',19,'dutch','2014-03-12 12:31:51'),('sss',20,'dutch','2014-03-12 12:31:51'),('sss',21,'dutch','2014-03-12 12:31:51'),('sss',22,'dutch','2014-03-12 12:31:51'),('sss',23,'dutch','2014-03-12 12:31:52'),('sss',24,'dutch','2014-03-12 12:31:52'),('sss',25,'dutch','2014-03-12 12:31:52'),('sss',26,'dutch','2014-03-12 12:31:52'),('sss',27,'dutch','2014-03-12 12:31:52'),('sss',28,'dutch','2014-03-12 12:31:52'),('sss',29,'dutch','2014-03-12 12:31:53'),('sss',30,'dutch','2014-03-12 12:31:53'),('sss',31,'dutch','2014-03-12 12:31:53'),('sss',32,'dutch','2014-03-12 12:31:53'),('sss',33,'dutch','2014-03-12 12:31:53'),('sss',34,'dutch','2014-03-12 12:31:53'),('sss',35,'dutch','2014-03-12 12:31:54'),('sss',36,'dutch','2014-03-12 12:31:54'),('sss',37,'dutch','2014-03-12 12:31:54'),('sss',38,'dutch','2014-03-12 12:31:54'),('sss',39,'dutch','2014-03-12 12:31:54'),('sss',40,'dutch','2014-03-12 12:31:54'),('sss',41,'dutch','2014-03-12 12:31:55'),('sss',42,'dutch','2014-03-12 12:31:55'),('sss',43,'dutch','2014-03-12 12:31:55'),('sss',44,'dutch','2014-03-12 12:31:55'),('sss',45,'dutch','2014-03-12 12:31:55'),('sss',46,'dutch','2014-03-12 12:31:55'),('sss',47,'dutch','2014-03-12 12:31:56'),('sss',48,'dutch','2014-03-12 12:31:56'),('sss',49,'dutch','2014-03-12 12:31:56'),('sss',50,'dutch','2014-03-12 12:31:56'),('sss',51,'dutch','2014-03-12 12:31:56'),('sss',52,'dutch','2014-03-12 12:31:56'),('sss',53,'dutch','2014-03-12 12:31:57'),('sss',54,'dutch','2014-03-12 12:31:57'),('sss',55,'dutch','2014-03-12 12:31:57'),('sss',56,'dutch','2014-03-12 12:31:57'),('sss',57,'dutch','2014-03-12 12:31:57'),('sss',58,'dutch','2014-03-12 12:31:57'),('sss',59,'dutch','2014-03-12 12:31:58'),('sss',60,'dutch','2014-03-12 12:31:58'),('sss',61,'dutch','2014-03-12 12:31:58'),('sss',62,'dutch','2014-03-12 12:31:59'),('sss',63,'dutch','2014-03-12 12:31:59'),('sss',64,'dutch','2014-03-12 12:31:59'),('sss',65,'dutch','2014-03-12 12:31:59'),('sss',66,'dutch','2014-03-12 12:31:59'),('sss',67,'dutch','2014-03-12 12:32:00'),('sss',68,'dutch','2014-03-12 12:32:00'),('sss',69,'dutch','2014-03-12 12:32:00'),('sss',70,'dutch','2014-03-12 12:32:01'),('sss',71,'dutch','2014-03-12 12:32:01'),('sss',72,'dutch','2014-03-12 12:32:01'),('sss',73,'dutch','2014-03-12 12:32:01'),('sss',74,'dutch','2014-03-12 12:32:01'),('sss',75,'dutch','2014-03-12 12:32:01'),('sss',76,'dutch','2014-03-12 12:32:02'),('sss',77,'dutch','2014-03-12 12:32:02'),('sss',78,'dutch','2014-03-12 12:32:02'),('sss',79,'dutch','2014-03-12 12:32:02'),('sss',80,'dutch','2014-03-12 12:32:03'),('sss',81,'dutch','2014-03-12 12:32:03'),('sss',82,'dutch','2014-03-12 12:32:03'),('sss',83,'dutch','2014-03-12 12:32:03'),('sss',84,'dutch','2014-03-12 12:32:03'),('sss',85,'dutch','2014-03-12 12:32:03'),('sss',86,'dutch','2014-03-12 12:32:04'),('sss',87,'dutch','2014-03-12 12:32:04'),('sss',88,'dutch','2014-03-12 12:32:04'),('sss',89,'dutch','2014-03-12 12:32:04'),('sss',90,'dutch','2014-03-12 12:32:04'),('sss',91,'dutch','2014-03-12 12:32:05'),('sss',92,'dutch','2014-03-12 12:32:05'),('sss',93,'dutch','2014-03-12 12:32:05'),('sss',94,'dutch','2014-03-12 12:32:05'),('sss',95,'dutch','2014-03-12 12:32:06'),('sss',96,'dutch','2014-03-12 12:32:06'),('sss',97,'dutch','2014-03-12 12:32:06'),('sss',98,'dutch','2014-03-12 12:32:07'),('sss',99,'dutch','2014-03-12 12:32:07'),('sss',100,'dutch','2014-03-12 12:32:07'),('sss',101,'dutch','2014-03-12 12:32:07'),('sss',102,'dutch','2014-03-12 12:32:07'),('sss',103,'dutch','2014-03-12 12:32:08'),('sss',104,'dutch','2014-03-12 12:32:08'),('sss',105,'dutch','2014-03-12 12:32:08'),('sss',106,'dutch','2014-03-12 12:32:08'),('sss',107,'dutch','2014-03-12 12:32:08'),('sss',108,'dutch','2014-03-12 12:32:09'),('sss',109,'dutch','2014-03-12 12:32:09'),('sss',110,'dutch','2014-03-12 12:32:09'),('sss',111,'dutch','2014-03-12 12:32:09'),('sss',112,'dutch','2014-03-12 12:32:10'),('sss',113,'dutch','2014-03-12 12:32:10'),('sss',114,'dutch','2014-03-12 12:32:10'),('sss',115,'dutch','2014-03-12 12:32:10'),('sss',116,'dutch','2014-03-12 12:32:10'),('sss',117,'dutch','2014-03-12 12:32:10'),('sss',118,'dutch','2014-03-12 12:32:11'),('',119,'dutch','2014-03-13 13:48:16'),('',120,'dutch','2014-03-13 13:48:17'),('',121,'dutch','2014-03-13 13:48:17'),('',122,'dutch','2014-03-13 13:48:17'),('',123,'dutch','2014-03-13 13:48:17'),('',124,'dutch','2014-03-13 13:48:18'),('',125,'dutch','2014-03-13 13:48:18'),('',126,'dutch','2014-03-13 13:48:18'),('',127,'dutch','2014-03-13 13:48:18'),('',128,'dutch','2014-03-13 13:48:18'),('',129,'dutch','2014-03-13 13:48:18'),('',130,'dutch','2014-03-13 13:48:19'),('',131,'dutch','2014-03-13 13:48:19'),('',132,'dutch','2014-03-13 13:48:19'),('',133,'dutch','2014-03-13 13:48:19'),('',134,'dutch','2014-03-13 13:48:19'),('',135,'dutch','2014-03-13 13:48:20'),('',136,'dutch','2014-03-13 13:48:20'),('',137,'dutch','2014-03-13 13:48:20'),('',138,'dutch','2014-03-13 13:48:20'),('',139,'dutch','2014-03-13 13:48:20'),('',140,'dutch','2014-03-13 13:48:21'),('',141,'dutch','2014-03-13 13:48:22'),('',142,'dutch','2014-03-13 13:48:22'),('',143,'dutch','2014-03-13 13:48:22'),('',144,'dutch','2014-03-13 13:48:22'),('',145,'dutch','2014-03-13 13:48:22'),('',146,'dutch','2014-03-13 13:48:22'),('',147,'dutch','2014-03-14 03:33:26'),('',148,'dutch','2014-03-14 05:46:30'),('',149,'dutch','2014-03-14 05:46:35'),('',150,'dutch','2014-03-14 06:27:44');
/*!40000 ALTER TABLE `lang_dutch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_english`
--

DROP TABLE IF EXISTS `lang_english`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_english` (
  `content` longtext COLLATE utf8_unicode_ci,
  `block_id` int(10) NOT NULL,
  `lang` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'english',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_english`
--

LOCK TABLES `lang_english` WRITE;
/*!40000 ALTER TABLE `lang_english` DISABLE KEYS */;
INSERT INTO `lang_english` VALUES ('sss',4,'english','2014-03-12 12:31:44'),('sss',5,'english','2014-03-12 12:31:46'),('sss',6,'english','2014-03-12 12:31:47'),('sss',7,'english','2014-03-12 12:31:47'),('sss',8,'english','2014-03-12 12:31:47'),('sss',9,'english','2014-03-12 12:31:48'),('sss',10,'english','2014-03-12 12:31:48'),('sss',11,'english','2014-03-12 12:31:49'),('sss',12,'english','2014-03-12 12:31:49'),('sss',13,'english','2014-03-12 12:31:50'),('sss',14,'english','2014-03-12 12:31:50'),('sss',15,'english','2014-03-12 12:31:50'),('sss',16,'english','2014-03-12 12:31:50'),('sss',17,'english','2014-03-12 12:31:50'),('sss',18,'english','2014-03-12 12:31:51'),('sss',19,'english','2014-03-12 12:31:51'),('sss',20,'english','2014-03-12 12:31:51'),('sss',21,'english','2014-03-12 12:31:51'),('sss',22,'english','2014-03-12 12:31:51'),('sss',23,'english','2014-03-12 12:31:52'),('sss',24,'english','2014-03-12 12:31:52'),('sss',25,'english','2014-03-12 12:31:52'),('sss',26,'english','2014-03-12 12:31:52'),('sss',27,'english','2014-03-12 12:31:52'),('sss',28,'english','2014-03-12 12:31:52'),('sss',29,'english','2014-03-12 12:31:53'),('sss',30,'english','2014-03-12 12:31:53'),('sss',31,'english','2014-03-12 12:31:53'),('sss',32,'english','2014-03-12 12:31:53'),('sss',33,'english','2014-03-12 12:31:53'),('sss',34,'english','2014-03-12 12:31:53'),('sss',35,'english','2014-03-12 12:31:54'),('sss',36,'english','2014-03-12 12:31:54'),('sss',37,'english','2014-03-12 12:31:54'),('sss',38,'english','2014-03-12 12:31:54'),('sss',39,'english','2014-03-12 12:31:54'),('sss',40,'english','2014-03-12 12:31:54'),('sss',41,'english','2014-03-12 12:31:55'),('sss',42,'english','2014-03-12 12:31:55'),('sss',43,'english','2014-03-12 12:31:55'),('sss',44,'english','2014-03-12 12:31:55'),('sss',45,'english','2014-03-12 12:31:55'),('sss',46,'english','2014-03-12 12:31:55'),('sss',47,'english','2014-03-12 12:31:56'),('sss',48,'english','2014-03-12 12:31:56'),('sss',49,'english','2014-03-12 12:31:56'),('sss',50,'english','2014-03-12 12:31:56'),('sss',51,'english','2014-03-12 12:31:56'),('sss',52,'english','2014-03-12 12:31:56'),('sss',53,'english','2014-03-12 12:31:57'),('sss',54,'english','2014-03-12 12:31:57'),('sss',55,'english','2014-03-12 12:31:57'),('sss',56,'english','2014-03-12 12:31:57'),('sss',57,'english','2014-03-12 12:31:57'),('sss',58,'english','2014-03-12 12:31:57'),('sss',59,'english','2014-03-12 12:31:58'),('sss',60,'english','2014-03-12 12:31:58'),('sss',61,'english','2014-03-12 12:31:58'),('sss',62,'english','2014-03-12 12:31:59'),('sss',63,'english','2014-03-12 12:31:59'),('sss',64,'english','2014-03-12 12:31:59'),('sss',65,'english','2014-03-12 12:31:59'),('sss',66,'english','2014-03-12 12:31:59'),('sss',67,'english','2014-03-12 12:32:00'),('sss',68,'english','2014-03-12 12:32:00'),('sss',69,'english','2014-03-12 12:32:00'),('sss',70,'english','2014-03-12 12:32:01'),('sss',71,'english','2014-03-12 12:32:01'),('sss',72,'english','2014-03-12 12:32:01'),('sss',73,'english','2014-03-12 12:32:01'),('sss',74,'english','2014-03-12 12:32:01'),('sss',75,'english','2014-03-12 12:32:01'),('sss',76,'english','2014-03-12 12:32:02'),('sss',77,'english','2014-03-12 12:32:02'),('sss',78,'english','2014-03-12 12:32:02'),('sss',79,'english','2014-03-12 12:32:02'),('sss',80,'english','2014-03-12 12:32:03'),('sss',81,'english','2014-03-12 12:32:03'),('sss',82,'english','2014-03-12 12:32:03'),('sss',83,'english','2014-03-12 12:32:03'),('sss',84,'english','2014-03-12 12:32:03'),('sss',85,'english','2014-03-12 12:32:03'),('sss',86,'english','2014-03-12 12:32:04'),('sss',87,'english','2014-03-12 12:32:04'),('sss',88,'english','2014-03-12 12:32:04'),('sss',89,'english','2014-03-12 12:32:04'),('sss',90,'english','2014-03-12 12:32:04'),('sss',91,'english','2014-03-12 12:32:05'),('sss',92,'english','2014-03-12 12:32:05'),('sss',93,'english','2014-03-12 12:32:05'),('sss',94,'english','2014-03-12 12:32:05'),('sss',95,'english','2014-03-12 12:32:06'),('sss',96,'english','2014-03-12 12:32:06'),('sss',97,'english','2014-03-12 12:32:06'),('sss',98,'english','2014-03-12 12:32:07'),('sss',99,'english','2014-03-12 12:32:07'),('sss',100,'english','2014-03-12 12:32:07'),('sss',101,'english','2014-03-12 12:32:07'),('sss',102,'english','2014-03-12 12:32:07'),('sss',103,'english','2014-03-12 12:32:08'),('sss',104,'english','2014-03-12 12:32:08'),('sss',105,'english','2014-03-12 12:32:08'),('sss',106,'english','2014-03-12 12:32:08'),('sss',107,'english','2014-03-12 12:32:08'),('sss',108,'english','2014-03-12 12:32:09'),('sss',109,'english','2014-03-12 12:32:09'),('sss',110,'english','2014-03-12 12:32:09'),('sss',111,'english','2014-03-12 12:32:09'),('sss',112,'english','2014-03-12 12:32:10'),('sss',113,'english','2014-03-12 12:32:10'),('sss',114,'english','2014-03-12 12:32:10'),('sss',115,'english','2014-03-12 12:32:10'),('sss',116,'english','2014-03-12 12:32:10'),('sss',117,'english','2014-03-12 12:32:10'),('sss',118,'english','2014-03-12 12:32:11'),('',119,'english','2014-03-13 13:48:16'),('',120,'english','2014-03-13 13:48:17'),('',121,'english','2014-03-13 13:48:17'),('',122,'english','2014-03-13 13:48:17'),('',123,'english','2014-03-13 13:48:17'),('',124,'english','2014-03-13 13:48:18'),('',125,'english','2014-03-13 13:48:18'),('',126,'english','2014-03-13 13:48:18'),('',127,'english','2014-03-13 13:48:18'),('',128,'english','2014-03-13 13:48:18'),('',129,'english','2014-03-13 13:48:18'),('',130,'english','2014-03-13 13:48:19'),('',131,'english','2014-03-13 13:48:19'),('',132,'english','2014-03-13 13:48:19'),('',133,'english','2014-03-13 13:48:19'),('',134,'english','2014-03-13 13:48:19'),('',135,'english','2014-03-13 13:48:20'),('',136,'english','2014-03-13 13:48:20'),('',137,'english','2014-03-13 13:48:20'),('',138,'english','2014-03-13 13:48:20'),('',139,'english','2014-03-13 13:48:20'),('',140,'english','2014-03-13 13:48:21'),('',141,'english','2014-03-13 13:48:22'),('',142,'english','2014-03-13 13:48:22'),('',143,'english','2014-03-13 13:48:22'),('',144,'english','2014-03-13 13:48:22'),('',145,'english','2014-03-13 13:48:22'),('',146,'english','2014-03-13 13:48:22'),('',147,'english','2014-03-14 03:33:26'),('',148,'english','2014-03-14 05:46:30'),('',149,'english','2014-03-14 05:46:35'),('',150,'english','2014-03-14 06:27:44');
/*!40000 ALTER TABLE `lang_english` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_french`
--

DROP TABLE IF EXISTS `lang_french`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_french` (
  `content` longtext COLLATE utf8_unicode_ci,
  `block_id` int(10) NOT NULL,
  `lang` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'french',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_french`
--

LOCK TABLES `lang_french` WRITE;
/*!40000 ALTER TABLE `lang_french` DISABLE KEYS */;
INSERT INTO `lang_french` VALUES ('sss',4,'french','2014-03-12 12:31:44'),('sss',5,'french','2014-03-12 12:31:46'),('sss',6,'french','2014-03-12 12:31:47'),('sss',7,'french','2014-03-12 12:31:47'),('sss',8,'french','2014-03-12 12:31:47'),('sss',9,'french','2014-03-12 12:31:48'),('sss',10,'french','2014-03-12 12:31:48'),('sss',11,'french','2014-03-12 12:31:49'),('sss',12,'french','2014-03-12 12:31:49'),('sss',13,'french','2014-03-12 12:31:50'),('sss',14,'french','2014-03-12 12:31:50'),('sss',15,'french','2014-03-12 12:31:50'),('sss',16,'french','2014-03-12 12:31:50'),('sss',17,'french','2014-03-12 12:31:50'),('sss',18,'french','2014-03-12 12:31:51'),('sss',19,'french','2014-03-12 12:31:51'),('sss',20,'french','2014-03-12 12:31:51'),('sss',21,'french','2014-03-12 12:31:51'),('sss',22,'french','2014-03-12 12:31:51'),('sss',23,'french','2014-03-12 12:31:52'),('sss',24,'french','2014-03-12 12:31:52'),('sss',25,'french','2014-03-12 12:31:52'),('sss',26,'french','2014-03-12 12:31:52'),('sss',27,'french','2014-03-12 12:31:52'),('sss',28,'french','2014-03-12 12:31:52'),('sss',29,'french','2014-03-12 12:31:53'),('sss',30,'french','2014-03-12 12:31:53'),('sss',31,'french','2014-03-12 12:31:53'),('sss',32,'french','2014-03-12 12:31:53'),('sss',33,'french','2014-03-12 12:31:53'),('sss',34,'french','2014-03-12 12:31:53'),('sss',35,'french','2014-03-12 12:31:54'),('sss',36,'french','2014-03-12 12:31:54'),('sss',37,'french','2014-03-12 12:31:54'),('sss',38,'french','2014-03-12 12:31:54'),('sss',39,'french','2014-03-12 12:31:54'),('sss',40,'french','2014-03-12 12:31:54'),('sss',41,'french','2014-03-12 12:31:55'),('sss',42,'french','2014-03-12 12:31:55'),('sss',43,'french','2014-03-12 12:31:55'),('sss',44,'french','2014-03-12 12:31:55'),('sss',45,'french','2014-03-12 12:31:55'),('sss',46,'french','2014-03-12 12:31:55'),('sss',47,'french','2014-03-12 12:31:56'),('sss',48,'french','2014-03-12 12:31:56'),('sss',49,'french','2014-03-12 12:31:56'),('sss',50,'french','2014-03-12 12:31:56'),('sss',51,'french','2014-03-12 12:31:56'),('sss',52,'french','2014-03-12 12:31:56'),('sss',53,'french','2014-03-12 12:31:57'),('sss',54,'french','2014-03-12 12:31:57'),('sss',55,'french','2014-03-12 12:31:57'),('sss',56,'french','2014-03-12 12:31:57'),('sss',57,'french','2014-03-12 12:31:57'),('sss',58,'french','2014-03-12 12:31:57'),('sss',59,'french','2014-03-12 12:31:58'),('sss',60,'french','2014-03-12 12:31:58'),('sss',61,'french','2014-03-12 12:31:58'),('sss',62,'french','2014-03-12 12:31:59'),('sss',63,'french','2014-03-12 12:31:59'),('sss',64,'french','2014-03-12 12:31:59'),('sss',65,'french','2014-03-12 12:31:59'),('sss',66,'french','2014-03-12 12:31:59'),('sss',67,'french','2014-03-12 12:32:00'),('sss',68,'french','2014-03-12 12:32:00'),('sss',69,'french','2014-03-12 12:32:00'),('sss',70,'french','2014-03-12 12:32:01'),('sss',71,'french','2014-03-12 12:32:01'),('sss',72,'french','2014-03-12 12:32:01'),('sss',73,'french','2014-03-12 12:32:01'),('sss',74,'french','2014-03-12 12:32:01'),('sss',75,'french','2014-03-12 12:32:01'),('sss',76,'french','2014-03-12 12:32:02'),('sss',77,'french','2014-03-12 12:32:02'),('sss',78,'french','2014-03-12 12:32:02'),('sss',79,'french','2014-03-12 12:32:02'),('sss',80,'french','2014-03-12 12:32:03'),('sss',81,'french','2014-03-12 12:32:03'),('sss',82,'french','2014-03-12 12:32:03'),('sss',83,'french','2014-03-12 12:32:03'),('sss',84,'french','2014-03-12 12:32:03'),('sss',85,'french','2014-03-12 12:32:03'),('sss',86,'french','2014-03-12 12:32:04'),('sss',87,'french','2014-03-12 12:32:04'),('sss',88,'french','2014-03-12 12:32:04'),('sss',89,'french','2014-03-12 12:32:04'),('sss',90,'french','2014-03-12 12:32:04'),('sss',91,'french','2014-03-12 12:32:05'),('sss',92,'french','2014-03-12 12:32:05'),('sss',93,'french','2014-03-12 12:32:05'),('sss',94,'french','2014-03-12 12:32:05'),('sss',95,'french','2014-03-12 12:32:06'),('sss',96,'french','2014-03-12 12:32:06'),('sss',97,'french','2014-03-12 12:32:06'),('sss',98,'french','2014-03-12 12:32:07'),('sss',99,'french','2014-03-12 12:32:07'),('sss',100,'french','2014-03-12 12:32:07'),('sss',101,'french','2014-03-12 12:32:07'),('sss',102,'french','2014-03-12 12:32:07'),('sss',103,'french','2014-03-12 12:32:08'),('sss',104,'french','2014-03-12 12:32:08'),('sss',105,'french','2014-03-12 12:32:08'),('sss',106,'french','2014-03-12 12:32:08'),('sss',107,'french','2014-03-12 12:32:08'),('sss',108,'french','2014-03-12 12:32:09'),('sss',109,'french','2014-03-12 12:32:09'),('sss',110,'french','2014-03-12 12:32:09'),('sss',111,'french','2014-03-12 12:32:09'),('sss',112,'french','2014-03-12 12:32:10'),('sss',113,'french','2014-03-12 12:32:10'),('sss',114,'french','2014-03-12 12:32:10'),('sss',115,'french','2014-03-12 12:32:10'),('sss',116,'french','2014-03-12 12:32:10'),('sss',117,'french','2014-03-12 12:32:10'),('sss',118,'french','2014-03-12 12:32:11'),('',119,'french','2014-03-13 13:48:16'),('',120,'french','2014-03-13 13:48:17'),('',121,'french','2014-03-13 13:48:17'),('',122,'french','2014-03-13 13:48:17'),('',123,'french','2014-03-13 13:48:17'),('',124,'french','2014-03-13 13:48:18'),('',125,'french','2014-03-13 13:48:18'),('',126,'french','2014-03-13 13:48:18'),('',127,'french','2014-03-13 13:48:18'),('',128,'french','2014-03-13 13:48:18'),('',129,'french','2014-03-13 13:48:18'),('',130,'french','2014-03-13 13:48:19'),('',131,'french','2014-03-13 13:48:19'),('',132,'french','2014-03-13 13:48:19'),('',133,'french','2014-03-13 13:48:19'),('',134,'french','2014-03-13 13:48:19'),('',135,'french','2014-03-13 13:48:20'),('',136,'french','2014-03-13 13:48:20'),('',137,'french','2014-03-13 13:48:20'),('',138,'french','2014-03-13 13:48:20'),('',139,'french','2014-03-13 13:48:20'),('',140,'french','2014-03-13 13:48:21'),('',141,'french','2014-03-13 13:48:22'),('',142,'french','2014-03-13 13:48:22'),('',143,'french','2014-03-13 13:48:22'),('',144,'french','2014-03-13 13:48:22'),('',145,'french','2014-03-13 13:48:22'),('',146,'french','2014-03-13 13:48:22'),('',147,'french','2014-03-14 03:33:26'),('',148,'french','2014-03-14 05:46:30'),('',149,'french','2014-03-14 05:46:35'),('',150,'french','2014-03-14 06:27:44');
/*!40000 ALTER TABLE `lang_french` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_german`
--

DROP TABLE IF EXISTS `lang_german`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_german` (
  `content` longtext COLLATE utf8_unicode_ci,
  `block_id` int(10) NOT NULL,
  `lang` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'german',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_german`
--

LOCK TABLES `lang_german` WRITE;
/*!40000 ALTER TABLE `lang_german` DISABLE KEYS */;
INSERT INTO `lang_german` VALUES ('sss',4,'german','2014-03-12 12:31:44'),('sss',5,'german','2014-03-12 12:31:46'),('sss',6,'german','2014-03-12 12:31:47'),('sss',7,'german','2014-03-12 12:31:47'),('sss',8,'german','2014-03-12 12:31:47'),('sss',9,'german','2014-03-12 12:31:48'),('sss',10,'german','2014-03-12 12:31:48'),('sss',11,'german','2014-03-12 12:31:49'),('sss',12,'german','2014-03-12 12:31:49'),('sss',13,'german','2014-03-12 12:31:50'),('sss',14,'german','2014-03-12 12:31:50'),('sss',15,'german','2014-03-12 12:31:50'),('sss',16,'german','2014-03-12 12:31:50'),('sss',17,'german','2014-03-12 12:31:50'),('sss',18,'german','2014-03-12 12:31:51'),('sss',19,'german','2014-03-12 12:31:51'),('sss',20,'german','2014-03-12 12:31:51'),('sss',21,'german','2014-03-12 12:31:51'),('sss',22,'german','2014-03-12 12:31:51'),('sss',23,'german','2014-03-12 12:31:52'),('sss',24,'german','2014-03-12 12:31:52'),('sss',25,'german','2014-03-12 12:31:52'),('sss',26,'german','2014-03-12 12:31:52'),('sss',27,'german','2014-03-12 12:31:52'),('sss',28,'german','2014-03-12 12:31:52'),('sss',29,'german','2014-03-12 12:31:53'),('sss',30,'german','2014-03-12 12:31:53'),('sss',31,'german','2014-03-12 12:31:53'),('sss',32,'german','2014-03-12 12:31:53'),('sss',33,'german','2014-03-12 12:31:53'),('sss',34,'german','2014-03-12 12:31:53'),('sss',35,'german','2014-03-12 12:31:54'),('sss',36,'german','2014-03-12 12:31:54'),('sss',37,'german','2014-03-12 12:31:54'),('sss',38,'german','2014-03-12 12:31:54'),('sss',39,'german','2014-03-12 12:31:54'),('sss',40,'german','2014-03-12 12:31:54'),('sss',41,'german','2014-03-12 12:31:55'),('sss',42,'german','2014-03-12 12:31:55'),('sss',43,'german','2014-03-12 12:31:55'),('sss',44,'german','2014-03-12 12:31:55'),('sss',45,'german','2014-03-12 12:31:55'),('sss',46,'german','2014-03-12 12:31:55'),('sss',47,'german','2014-03-12 12:31:56'),('sss',48,'german','2014-03-12 12:31:56'),('sss',49,'german','2014-03-12 12:31:56'),('sss',50,'german','2014-03-12 12:31:56'),('sss',51,'german','2014-03-12 12:31:56'),('sss',52,'german','2014-03-12 12:31:56'),('sss',53,'german','2014-03-12 12:31:57'),('sss',54,'german','2014-03-12 12:31:57'),('sss',55,'german','2014-03-12 12:31:57'),('sss',56,'german','2014-03-12 12:31:57'),('sss',57,'german','2014-03-12 12:31:57'),('sss',58,'german','2014-03-12 12:31:57'),('sss',59,'german','2014-03-12 12:31:58'),('sss',60,'german','2014-03-12 12:31:58'),('sss',61,'german','2014-03-12 12:31:58'),('sss',62,'german','2014-03-12 12:31:59'),('sss',63,'german','2014-03-12 12:31:59'),('sss',64,'german','2014-03-12 12:31:59'),('sss',65,'german','2014-03-12 12:31:59'),('sss',66,'german','2014-03-12 12:31:59'),('sss',67,'german','2014-03-12 12:32:00'),('sss',68,'german','2014-03-12 12:32:00'),('sss',69,'german','2014-03-12 12:32:00'),('sss',70,'german','2014-03-12 12:32:01'),('sss',71,'german','2014-03-12 12:32:01'),('sss',72,'german','2014-03-12 12:32:01'),('sss',73,'german','2014-03-12 12:32:01'),('sss',74,'german','2014-03-12 12:32:01'),('sss',75,'german','2014-03-12 12:32:01'),('sss',76,'german','2014-03-12 12:32:02'),('sss',77,'german','2014-03-12 12:32:02'),('sss',78,'german','2014-03-12 12:32:02'),('sss',79,'german','2014-03-12 12:32:02'),('sss',80,'german','2014-03-12 12:32:03'),('sss',81,'german','2014-03-12 12:32:03'),('sss',82,'german','2014-03-12 12:32:03'),('sss',83,'german','2014-03-12 12:32:03'),('sss',84,'german','2014-03-12 12:32:03'),('sss',85,'german','2014-03-12 12:32:03'),('sss',86,'german','2014-03-12 12:32:04'),('sss',87,'german','2014-03-12 12:32:04'),('sss',88,'german','2014-03-12 12:32:04'),('sss',89,'german','2014-03-12 12:32:04'),('sss',90,'german','2014-03-12 12:32:04'),('sss',91,'german','2014-03-12 12:32:05'),('sss',92,'german','2014-03-12 12:32:05'),('sss',93,'german','2014-03-12 12:32:05'),('sss',94,'german','2014-03-12 12:32:05'),('sss',95,'german','2014-03-12 12:32:06'),('sss',96,'german','2014-03-12 12:32:06'),('sss',97,'german','2014-03-12 12:32:06'),('sss',98,'german','2014-03-12 12:32:07'),('sss',99,'german','2014-03-12 12:32:07'),('sss',100,'german','2014-03-12 12:32:07'),('sss',101,'german','2014-03-12 12:32:07'),('sss',102,'german','2014-03-12 12:32:07'),('sss',103,'german','2014-03-12 12:32:08'),('sss',104,'german','2014-03-12 12:32:08'),('sss',105,'german','2014-03-12 12:32:08'),('sss',106,'german','2014-03-12 12:32:08'),('sss',107,'german','2014-03-12 12:32:08'),('sss',108,'german','2014-03-12 12:32:09'),('sss',109,'german','2014-03-12 12:32:09'),('sss',110,'german','2014-03-12 12:32:09'),('sss',111,'german','2014-03-12 12:32:09'),('sss',112,'german','2014-03-12 12:32:10'),('sss',113,'german','2014-03-12 12:32:10'),('sss',114,'german','2014-03-12 12:32:10'),('sss',115,'german','2014-03-12 12:32:10'),('sss',116,'german','2014-03-12 12:32:10'),('sss',117,'german','2014-03-12 12:32:10'),('sss',118,'german','2014-03-12 12:32:11'),('ssss',119,'german','2014-03-13 13:48:16'),('ssss',120,'german','2014-03-13 13:48:17'),('ssss',121,'german','2014-03-13 13:48:17'),('ssss',122,'german','2014-03-13 13:48:17'),('ssss',123,'german','2014-03-13 13:48:17'),('ssss',124,'german','2014-03-13 13:48:18'),('ssss',125,'german','2014-03-13 13:48:18'),('ssss',126,'german','2014-03-13 13:48:18'),('ssss',127,'german','2014-03-13 13:48:18'),('ssss',128,'german','2014-03-13 13:48:18'),('ssss',129,'german','2014-03-13 13:48:18'),('ssss',130,'german','2014-03-13 13:48:19'),('ssss',131,'german','2014-03-13 13:48:19'),('ssss',132,'german','2014-03-13 13:48:19'),('ssss',133,'german','2014-03-13 13:48:19'),('ssss',134,'german','2014-03-13 13:48:19'),('ssss',135,'german','2014-03-13 13:48:20'),('ssss',136,'german','2014-03-13 13:48:20'),('ssss',137,'german','2014-03-13 13:48:20'),('ssss',138,'german','2014-03-13 13:48:20'),('ssss',139,'german','2014-03-13 13:48:20'),('ssss',140,'german','2014-03-13 13:48:21'),('ssss',141,'german','2014-03-13 13:48:22'),('ssss',142,'german','2014-03-13 13:48:22'),('ssss',143,'german','2014-03-13 13:48:22'),('ssss',144,'german','2014-03-13 13:48:22'),('ssss',145,'german','2014-03-13 13:48:22'),('ssss',146,'german','2014-03-13 13:48:22'),('ss',147,'german','2014-03-14 03:33:26'),('ssss',148,'german','2014-03-14 05:46:30'),('ssss',149,'german','2014-03-14 05:46:35'),('ssss',150,'german','2014-03-14 06:27:44');
/*!40000 ALTER TABLE `lang_german` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_italian`
--

DROP TABLE IF EXISTS `lang_italian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_italian` (
  `content` longtext COLLATE utf8_unicode_ci,
  `block_id` int(10) NOT NULL,
  `lang` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'italian',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_italian`
--

LOCK TABLES `lang_italian` WRITE;
/*!40000 ALTER TABLE `lang_italian` DISABLE KEYS */;
INSERT INTO `lang_italian` VALUES ('ss',4,'italian','2014-03-12 12:31:44'),('ss',5,'italian','2014-03-12 12:31:46'),('ss',6,'italian','2014-03-12 12:31:47'),('ss',7,'italian','2014-03-12 12:31:47'),('ss',8,'italian','2014-03-12 12:31:47'),('ss',9,'italian','2014-03-12 12:31:48'),('ss',10,'italian','2014-03-12 12:31:48'),('ss',11,'italian','2014-03-12 12:31:49'),('ss',12,'italian','2014-03-12 12:31:49'),('ss',13,'italian','2014-03-12 12:31:50'),('ss',14,'italian','2014-03-12 12:31:50'),('ss',15,'italian','2014-03-12 12:31:50'),('ss',16,'italian','2014-03-12 12:31:50'),('ss',17,'italian','2014-03-12 12:31:50'),('ss',18,'italian','2014-03-12 12:31:51'),('ss',19,'italian','2014-03-12 12:31:51'),('ss',20,'italian','2014-03-12 12:31:51'),('ss',21,'italian','2014-03-12 12:31:51'),('ss',22,'italian','2014-03-12 12:31:51'),('ss',23,'italian','2014-03-12 12:31:52'),('ss',24,'italian','2014-03-12 12:31:52'),('ss',25,'italian','2014-03-12 12:31:52'),('ss',26,'italian','2014-03-12 12:31:52'),('ss',27,'italian','2014-03-12 12:31:52'),('ss',28,'italian','2014-03-12 12:31:52'),('ss',29,'italian','2014-03-12 12:31:53'),('ss',30,'italian','2014-03-12 12:31:53'),('ss',31,'italian','2014-03-12 12:31:53'),('ss',32,'italian','2014-03-12 12:31:53'),('ss',33,'italian','2014-03-12 12:31:53'),('ss',34,'italian','2014-03-12 12:31:53'),('ss',35,'italian','2014-03-12 12:31:54'),('ss',36,'italian','2014-03-12 12:31:54'),('ss',37,'italian','2014-03-12 12:31:54'),('ss',38,'italian','2014-03-12 12:31:54'),('ss',39,'italian','2014-03-12 12:31:54'),('ss',40,'italian','2014-03-12 12:31:54'),('ss',41,'italian','2014-03-12 12:31:55'),('ss',42,'italian','2014-03-12 12:31:55'),('ss',43,'italian','2014-03-12 12:31:55'),('ss',44,'italian','2014-03-12 12:31:55'),('ss',45,'italian','2014-03-12 12:31:55'),('ss',46,'italian','2014-03-12 12:31:55'),('ss',47,'italian','2014-03-12 12:31:56'),('ss',48,'italian','2014-03-12 12:31:56'),('ss',49,'italian','2014-03-12 12:31:56'),('ss',50,'italian','2014-03-12 12:31:56'),('ss',51,'italian','2014-03-12 12:31:56'),('ss',52,'italian','2014-03-12 12:31:56'),('ss',53,'italian','2014-03-12 12:31:57'),('ss',54,'italian','2014-03-12 12:31:57'),('ss',55,'italian','2014-03-12 12:31:57'),('ss',56,'italian','2014-03-12 12:31:57'),('ss',57,'italian','2014-03-12 12:31:57'),('ss',58,'italian','2014-03-12 12:31:57'),('ss',59,'italian','2014-03-12 12:31:58'),('ss',60,'italian','2014-03-12 12:31:58'),('ss',61,'italian','2014-03-12 12:31:58'),('ss',62,'italian','2014-03-12 12:31:59'),('ss',63,'italian','2014-03-12 12:31:59'),('ss',64,'italian','2014-03-12 12:31:59'),('ss',65,'italian','2014-03-12 12:31:59'),('ss',66,'italian','2014-03-12 12:31:59'),('ss',67,'italian','2014-03-12 12:32:00'),('ss',68,'italian','2014-03-12 12:32:00'),('ss',69,'italian','2014-03-12 12:32:00'),('ss',70,'italian','2014-03-12 12:32:01'),('ss',71,'italian','2014-03-12 12:32:01'),('ss',72,'italian','2014-03-12 12:32:01'),('ss',73,'italian','2014-03-12 12:32:01'),('ss',74,'italian','2014-03-12 12:32:01'),('ss',75,'italian','2014-03-12 12:32:01'),('ss',76,'italian','2014-03-12 12:32:02'),('ss',77,'italian','2014-03-12 12:32:02'),('ss',78,'italian','2014-03-12 12:32:02'),('ss',79,'italian','2014-03-12 12:32:02'),('ss',80,'italian','2014-03-12 12:32:03'),('ss',81,'italian','2014-03-12 12:32:03'),('ss',82,'italian','2014-03-12 12:32:03'),('ss',83,'italian','2014-03-12 12:32:03'),('ss',84,'italian','2014-03-12 12:32:03'),('ss',85,'italian','2014-03-12 12:32:03'),('ss',86,'italian','2014-03-12 12:32:04'),('ss',87,'italian','2014-03-12 12:32:04'),('ss',88,'italian','2014-03-12 12:32:04'),('ss',89,'italian','2014-03-12 12:32:04'),('ss',90,'italian','2014-03-12 12:32:04'),('ss',91,'italian','2014-03-12 12:32:05'),('ss',92,'italian','2014-03-12 12:32:05'),('ss',93,'italian','2014-03-12 12:32:05'),('ss',94,'italian','2014-03-12 12:32:05'),('ss',95,'italian','2014-03-12 12:32:06'),('ss',96,'italian','2014-03-12 12:32:06'),('ss',97,'italian','2014-03-12 12:32:06'),('ss',98,'italian','2014-03-12 12:32:07'),('ss',99,'italian','2014-03-12 12:32:07'),('ss',100,'italian','2014-03-12 12:32:07'),('ss',101,'italian','2014-03-12 12:32:07'),('ss',102,'italian','2014-03-12 12:32:07'),('ss',103,'italian','2014-03-12 12:32:08'),('ss',104,'italian','2014-03-12 12:32:08'),('ss',105,'italian','2014-03-12 12:32:08'),('ss',106,'italian','2014-03-12 12:32:08'),('ss',107,'italian','2014-03-12 12:32:08'),('ss',108,'italian','2014-03-12 12:32:09'),('ss',109,'italian','2014-03-12 12:32:09'),('ss',110,'italian','2014-03-12 12:32:09'),('ss',111,'italian','2014-03-12 12:32:09'),('ss',112,'italian','2014-03-12 12:32:10'),('ss',113,'italian','2014-03-12 12:32:10'),('ss',114,'italian','2014-03-12 12:32:10'),('ss',115,'italian','2014-03-12 12:32:10'),('ss',116,'italian','2014-03-12 12:32:10'),('ss',117,'italian','2014-03-12 12:32:11'),('ss',118,'italian','2014-03-12 12:32:11'),('',119,'italian','2014-03-13 13:48:16'),('',120,'italian','2014-03-13 13:48:17'),('',121,'italian','2014-03-13 13:48:17'),('',122,'italian','2014-03-13 13:48:17'),('',123,'italian','2014-03-13 13:48:17'),('',124,'italian','2014-03-13 13:48:18'),('',125,'italian','2014-03-13 13:48:18'),('',126,'italian','2014-03-13 13:48:18'),('',127,'italian','2014-03-13 13:48:18'),('',128,'italian','2014-03-13 13:48:18'),('',129,'italian','2014-03-13 13:48:18'),('',130,'italian','2014-03-13 13:48:19'),('',131,'italian','2014-03-13 13:48:19'),('',132,'italian','2014-03-13 13:48:19'),('',133,'italian','2014-03-13 13:48:19'),('',134,'italian','2014-03-13 13:48:19'),('',135,'italian','2014-03-13 13:48:20'),('',136,'italian','2014-03-13 13:48:20'),('',137,'italian','2014-03-13 13:48:20'),('',138,'italian','2014-03-13 13:48:20'),('',139,'italian','2014-03-13 13:48:20'),('',140,'italian','2014-03-13 13:48:21'),('',141,'italian','2014-03-13 13:48:22'),('',142,'italian','2014-03-13 13:48:22'),('',143,'italian','2014-03-13 13:48:22'),('',144,'italian','2014-03-13 13:48:22'),('',145,'italian','2014-03-13 13:48:22'),('',146,'italian','2014-03-13 13:48:22'),('',147,'italian','2014-03-14 03:33:26'),('',148,'italian','2014-03-14 05:46:30'),('',149,'italian','2014-03-14 05:46:35'),('',150,'italian','2014-03-14 06:27:44');
/*!40000 ALTER TABLE `lang_italian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_japanese`
--

DROP TABLE IF EXISTS `lang_japanese`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_japanese` (
  `content` longtext COLLATE utf8_unicode_ci,
  `block_id` int(10) NOT NULL,
  `lang` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'japanese',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_japanese`
--

LOCK TABLES `lang_japanese` WRITE;
/*!40000 ALTER TABLE `lang_japanese` DISABLE KEYS */;
INSERT INTO `lang_japanese` VALUES ('ss',4,'japanese','2014-03-12 12:31:44'),('ss',5,'japanese','2014-03-12 12:31:46'),('ss',6,'japanese','2014-03-12 12:31:47'),('ss',7,'japanese','2014-03-12 12:31:47'),('ss',8,'japanese','2014-03-12 12:31:47'),('ss',9,'japanese','2014-03-12 12:31:48'),('ss',10,'japanese','2014-03-12 12:31:48'),('ss',11,'japanese','2014-03-12 12:31:49'),('ss',12,'japanese','2014-03-12 12:31:49'),('ss',13,'japanese','2014-03-12 12:31:50'),('ss',14,'japanese','2014-03-12 12:31:50'),('ss',15,'japanese','2014-03-12 12:31:50'),('ss',16,'japanese','2014-03-12 12:31:50'),('ss',17,'japanese','2014-03-12 12:31:50'),('ss',18,'japanese','2014-03-12 12:31:51'),('ss',19,'japanese','2014-03-12 12:31:51'),('ss',20,'japanese','2014-03-12 12:31:51'),('ss',21,'japanese','2014-03-12 12:31:51'),('ss',22,'japanese','2014-03-12 12:31:51'),('ss',23,'japanese','2014-03-12 12:31:52'),('ss',24,'japanese','2014-03-12 12:31:52'),('ss',25,'japanese','2014-03-12 12:31:52'),('ss',26,'japanese','2014-03-12 12:31:52'),('ss',27,'japanese','2014-03-12 12:31:52'),('ss',28,'japanese','2014-03-12 12:31:52'),('ss',29,'japanese','2014-03-12 12:31:53'),('ss',30,'japanese','2014-03-12 12:31:53'),('ss',31,'japanese','2014-03-12 12:31:53'),('ss',32,'japanese','2014-03-12 12:31:53'),('ss',33,'japanese','2014-03-12 12:31:53'),('ss',34,'japanese','2014-03-12 12:31:53'),('ss',35,'japanese','2014-03-12 12:31:54'),('ss',36,'japanese','2014-03-12 12:31:54'),('ss',37,'japanese','2014-03-12 12:31:54'),('ss',38,'japanese','2014-03-12 12:31:54'),('ss',39,'japanese','2014-03-12 12:31:54'),('ss',40,'japanese','2014-03-12 12:31:54'),('ss',41,'japanese','2014-03-12 12:31:55'),('ss',42,'japanese','2014-03-12 12:31:55'),('ss',43,'japanese','2014-03-12 12:31:55'),('ss',44,'japanese','2014-03-12 12:31:55'),('ss',45,'japanese','2014-03-12 12:31:55'),('ss',46,'japanese','2014-03-12 12:31:55'),('ss',47,'japanese','2014-03-12 12:31:56'),('ss',48,'japanese','2014-03-12 12:31:56'),('ss',49,'japanese','2014-03-12 12:31:56'),('ss',50,'japanese','2014-03-12 12:31:56'),('ss',51,'japanese','2014-03-12 12:31:56'),('ss',52,'japanese','2014-03-12 12:31:56'),('ss',53,'japanese','2014-03-12 12:31:57'),('ss',54,'japanese','2014-03-12 12:31:57'),('ss',55,'japanese','2014-03-12 12:31:57'),('ss',56,'japanese','2014-03-12 12:31:57'),('ss',57,'japanese','2014-03-12 12:31:57'),('ss',58,'japanese','2014-03-12 12:31:57'),('ss',59,'japanese','2014-03-12 12:31:58'),('ss',60,'japanese','2014-03-12 12:31:58'),('ss',61,'japanese','2014-03-12 12:31:58'),('ss',62,'japanese','2014-03-12 12:31:59'),('ss',63,'japanese','2014-03-12 12:31:59'),('ss',64,'japanese','2014-03-12 12:31:59'),('ss',65,'japanese','2014-03-12 12:31:59'),('ss',66,'japanese','2014-03-12 12:31:59'),('ss',67,'japanese','2014-03-12 12:32:00'),('ss',68,'japanese','2014-03-12 12:32:00'),('ss',69,'japanese','2014-03-12 12:32:00'),('ss',70,'japanese','2014-03-12 12:32:01'),('ss',71,'japanese','2014-03-12 12:32:01'),('ss',72,'japanese','2014-03-12 12:32:01'),('ss',73,'japanese','2014-03-12 12:32:01'),('ss',74,'japanese','2014-03-12 12:32:01'),('ss',75,'japanese','2014-03-12 12:32:01'),('ss',76,'japanese','2014-03-12 12:32:02'),('ss',77,'japanese','2014-03-12 12:32:02'),('ss',78,'japanese','2014-03-12 12:32:02'),('ss',79,'japanese','2014-03-12 12:32:02'),('ss',80,'japanese','2014-03-12 12:32:03'),('ss',81,'japanese','2014-03-12 12:32:03'),('ss',82,'japanese','2014-03-12 12:32:03'),('ss',83,'japanese','2014-03-12 12:32:03'),('ss',84,'japanese','2014-03-12 12:32:03'),('ss',85,'japanese','2014-03-12 12:32:03'),('ss',86,'japanese','2014-03-12 12:32:04'),('ss',87,'japanese','2014-03-12 12:32:04'),('ss',88,'japanese','2014-03-12 12:32:04'),('ss',89,'japanese','2014-03-12 12:32:04'),('ss',90,'japanese','2014-03-12 12:32:04'),('ss',91,'japanese','2014-03-12 12:32:05'),('ss',92,'japanese','2014-03-12 12:32:05'),('ss',93,'japanese','2014-03-12 12:32:05'),('ss',94,'japanese','2014-03-12 12:32:05'),('ss',95,'japanese','2014-03-12 12:32:06'),('ss',96,'japanese','2014-03-12 12:32:06'),('ss',97,'japanese','2014-03-12 12:32:06'),('ss',98,'japanese','2014-03-12 12:32:07'),('ss',99,'japanese','2014-03-12 12:32:07'),('ss',100,'japanese','2014-03-12 12:32:07'),('ss',101,'japanese','2014-03-12 12:32:07'),('ss',102,'japanese','2014-03-12 12:32:07'),('ss',103,'japanese','2014-03-12 12:32:08'),('ss',104,'japanese','2014-03-12 12:32:08'),('ss',105,'japanese','2014-03-12 12:32:08'),('ss',106,'japanese','2014-03-12 12:32:08'),('ss',107,'japanese','2014-03-12 12:32:08'),('ss',108,'japanese','2014-03-12 12:32:09'),('ss',109,'japanese','2014-03-12 12:32:09'),('ss',110,'japanese','2014-03-12 12:32:09'),('ss',111,'japanese','2014-03-12 12:32:09'),('ss',112,'japanese','2014-03-12 12:32:10'),('ss',113,'japanese','2014-03-12 12:32:10'),('ss',114,'japanese','2014-03-12 12:32:10'),('ss',115,'japanese','2014-03-12 12:32:10'),('ss',116,'japanese','2014-03-12 12:32:10'),('ss',117,'japanese','2014-03-12 12:32:11'),('ss',118,'japanese','2014-03-12 12:32:11'),('',119,'japanese','2014-03-13 13:48:16'),('',120,'japanese','2014-03-13 13:48:17'),('',121,'japanese','2014-03-13 13:48:17'),('',122,'japanese','2014-03-13 13:48:17'),('',123,'japanese','2014-03-13 13:48:17'),('',124,'japanese','2014-03-13 13:48:18'),('',125,'japanese','2014-03-13 13:48:18'),('',126,'japanese','2014-03-13 13:48:18'),('',127,'japanese','2014-03-13 13:48:18'),('',128,'japanese','2014-03-13 13:48:18'),('',129,'japanese','2014-03-13 13:48:18'),('',130,'japanese','2014-03-13 13:48:19'),('',131,'japanese','2014-03-13 13:48:19'),('',132,'japanese','2014-03-13 13:48:19'),('',133,'japanese','2014-03-13 13:48:19'),('',134,'japanese','2014-03-13 13:48:19'),('',135,'japanese','2014-03-13 13:48:20'),('',136,'japanese','2014-03-13 13:48:20'),('',137,'japanese','2014-03-13 13:48:20'),('',138,'japanese','2014-03-13 13:48:20'),('',139,'japanese','2014-03-13 13:48:20'),('',140,'japanese','2014-03-13 13:48:21'),('',141,'japanese','2014-03-13 13:48:22'),('',142,'japanese','2014-03-13 13:48:22'),('',143,'japanese','2014-03-13 13:48:22'),('',144,'japanese','2014-03-13 13:48:22'),('',145,'japanese','2014-03-13 13:48:22'),('',146,'japanese','2014-03-13 13:48:22'),('',147,'japanese','2014-03-14 03:33:26'),('',148,'japanese','2014-03-14 05:46:30'),('',149,'japanese','2014-03-14 05:46:35'),('',150,'japanese','2014-03-14 06:27:44');
/*!40000 ALTER TABLE `lang_japanese` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_polish`
--

DROP TABLE IF EXISTS `lang_polish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_polish` (
  `content` longtext COLLATE utf8_unicode_ci,
  `block_id` int(10) NOT NULL,
  `lang` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'polish',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_polish`
--

LOCK TABLES `lang_polish` WRITE;
/*!40000 ALTER TABLE `lang_polish` DISABLE KEYS */;
INSERT INTO `lang_polish` VALUES ('ss',4,'polish','2014-03-12 12:31:44'),('ss',5,'polish','2014-03-12 12:31:46'),('ss',6,'polish','2014-03-12 12:31:47'),('ss',7,'polish','2014-03-12 12:31:47'),('ss',8,'polish','2014-03-12 12:31:47'),('ss',9,'polish','2014-03-12 12:31:48'),('ss',10,'polish','2014-03-12 12:31:48'),('ss',11,'polish','2014-03-12 12:31:49'),('ss',12,'polish','2014-03-12 12:31:49'),('ss',13,'polish','2014-03-12 12:31:50'),('ss',14,'polish','2014-03-12 12:31:50'),('ss',15,'polish','2014-03-12 12:31:50'),('ss',16,'polish','2014-03-12 12:31:50'),('ss',17,'polish','2014-03-12 12:31:50'),('ss',18,'polish','2014-03-12 12:31:51'),('ss',19,'polish','2014-03-12 12:31:51'),('ss',20,'polish','2014-03-12 12:31:51'),('ss',21,'polish','2014-03-12 12:31:51'),('ss',22,'polish','2014-03-12 12:31:51'),('ss',23,'polish','2014-03-12 12:31:52'),('ss',24,'polish','2014-03-12 12:31:52'),('ss',25,'polish','2014-03-12 12:31:52'),('ss',26,'polish','2014-03-12 12:31:52'),('ss',27,'polish','2014-03-12 12:31:52'),('ss',28,'polish','2014-03-12 12:31:52'),('ss',29,'polish','2014-03-12 12:31:53'),('ss',30,'polish','2014-03-12 12:31:53'),('ss',31,'polish','2014-03-12 12:31:53'),('ss',32,'polish','2014-03-12 12:31:53'),('ss',33,'polish','2014-03-12 12:31:53'),('ss',34,'polish','2014-03-12 12:31:53'),('ss',35,'polish','2014-03-12 12:31:54'),('ss',36,'polish','2014-03-12 12:31:54'),('ss',37,'polish','2014-03-12 12:31:54'),('ss',38,'polish','2014-03-12 12:31:54'),('ss',39,'polish','2014-03-12 12:31:54'),('ss',40,'polish','2014-03-12 12:31:54'),('ss',41,'polish','2014-03-12 12:31:55'),('ss',42,'polish','2014-03-12 12:31:55'),('ss',43,'polish','2014-03-12 12:31:55'),('ss',44,'polish','2014-03-12 12:31:55'),('ss',45,'polish','2014-03-12 12:31:55'),('ss',46,'polish','2014-03-12 12:31:55'),('ss',47,'polish','2014-03-12 12:31:56'),('ss',48,'polish','2014-03-12 12:31:56'),('ss',49,'polish','2014-03-12 12:31:56'),('ss',50,'polish','2014-03-12 12:31:56'),('ss',51,'polish','2014-03-12 12:31:56'),('ss',52,'polish','2014-03-12 12:31:56'),('ss',53,'polish','2014-03-12 12:31:57'),('ss',54,'polish','2014-03-12 12:31:57'),('ss',55,'polish','2014-03-12 12:31:57'),('ss',56,'polish','2014-03-12 12:31:57'),('ss',57,'polish','2014-03-12 12:31:57'),('ss',58,'polish','2014-03-12 12:31:57'),('ss',59,'polish','2014-03-12 12:31:58'),('ss',60,'polish','2014-03-12 12:31:58'),('ss',61,'polish','2014-03-12 12:31:58'),('ss',62,'polish','2014-03-12 12:31:59'),('ss',63,'polish','2014-03-12 12:31:59'),('ss',64,'polish','2014-03-12 12:31:59'),('ss',65,'polish','2014-03-12 12:31:59'),('ss',66,'polish','2014-03-12 12:31:59'),('ss',67,'polish','2014-03-12 12:32:00'),('ss',68,'polish','2014-03-12 12:32:00'),('ss',69,'polish','2014-03-12 12:32:00'),('ss',70,'polish','2014-03-12 12:32:01'),('ss',71,'polish','2014-03-12 12:32:01'),('ss',72,'polish','2014-03-12 12:32:01'),('ss',73,'polish','2014-03-12 12:32:01'),('ss',74,'polish','2014-03-12 12:32:01'),('ss',75,'polish','2014-03-12 12:32:01'),('ss',76,'polish','2014-03-12 12:32:02'),('ss',77,'polish','2014-03-12 12:32:02'),('ss',78,'polish','2014-03-12 12:32:02'),('ss',79,'polish','2014-03-12 12:32:02'),('ss',80,'polish','2014-03-12 12:32:03'),('ss',81,'polish','2014-03-12 12:32:03'),('ss',82,'polish','2014-03-12 12:32:03'),('ss',83,'polish','2014-03-12 12:32:03'),('ss',84,'polish','2014-03-12 12:32:03'),('ss',85,'polish','2014-03-12 12:32:03'),('ss',86,'polish','2014-03-12 12:32:04'),('ss',87,'polish','2014-03-12 12:32:04'),('ss',88,'polish','2014-03-12 12:32:04'),('ss',89,'polish','2014-03-12 12:32:04'),('ss',90,'polish','2014-03-12 12:32:04'),('ss',91,'polish','2014-03-12 12:32:05'),('ss',92,'polish','2014-03-12 12:32:05'),('ss',93,'polish','2014-03-12 12:32:05'),('ss',94,'polish','2014-03-12 12:32:05'),('ss',95,'polish','2014-03-12 12:32:06'),('ss',96,'polish','2014-03-12 12:32:06'),('ss',97,'polish','2014-03-12 12:32:06'),('ss',98,'polish','2014-03-12 12:32:07'),('ss',99,'polish','2014-03-12 12:32:07'),('ss',100,'polish','2014-03-12 12:32:07'),('ss',101,'polish','2014-03-12 12:32:07'),('ss',102,'polish','2014-03-12 12:32:07'),('ss',103,'polish','2014-03-12 12:32:08'),('ss',104,'polish','2014-03-12 12:32:08'),('ss',105,'polish','2014-03-12 12:32:08'),('ss',106,'polish','2014-03-12 12:32:08'),('ss',107,'polish','2014-03-12 12:32:08'),('ss',108,'polish','2014-03-12 12:32:09'),('ss',109,'polish','2014-03-12 12:32:09'),('ss',110,'polish','2014-03-12 12:32:09'),('ss',111,'polish','2014-03-12 12:32:09'),('ss',112,'polish','2014-03-12 12:32:10'),('ss',113,'polish','2014-03-12 12:32:10'),('ss',114,'polish','2014-03-12 12:32:10'),('ss',115,'polish','2014-03-12 12:32:10'),('ss',116,'polish','2014-03-12 12:32:10'),('ss',117,'polish','2014-03-12 12:32:11'),('ss',118,'polish','2014-03-12 12:32:11'),('',119,'polish','2014-03-13 13:48:16'),('',120,'polish','2014-03-13 13:48:17'),('',121,'polish','2014-03-13 13:48:17'),('',122,'polish','2014-03-13 13:48:17'),('',123,'polish','2014-03-13 13:48:17'),('',124,'polish','2014-03-13 13:48:18'),('',125,'polish','2014-03-13 13:48:18'),('',126,'polish','2014-03-13 13:48:18'),('',127,'polish','2014-03-13 13:48:18'),('',128,'polish','2014-03-13 13:48:18'),('',129,'polish','2014-03-13 13:48:18'),('',130,'polish','2014-03-13 13:48:19'),('',131,'polish','2014-03-13 13:48:19'),('',132,'polish','2014-03-13 13:48:19'),('',133,'polish','2014-03-13 13:48:19'),('',134,'polish','2014-03-13 13:48:19'),('',135,'polish','2014-03-13 13:48:20'),('',136,'polish','2014-03-13 13:48:20'),('',137,'polish','2014-03-13 13:48:20'),('',138,'polish','2014-03-13 13:48:20'),('',139,'polish','2014-03-13 13:48:20'),('',140,'polish','2014-03-13 13:48:21'),('',141,'polish','2014-03-13 13:48:22'),('',142,'polish','2014-03-13 13:48:22'),('',143,'polish','2014-03-13 13:48:22'),('',144,'polish','2014-03-13 13:48:22'),('',145,'polish','2014-03-13 13:48:22'),('',146,'polish','2014-03-13 13:48:22'),('',147,'polish','2014-03-14 03:33:26'),('',148,'polish','2014-03-14 05:46:30'),('',149,'polish','2014-03-14 05:46:35'),('',150,'polish','2014-03-14 06:27:44');
/*!40000 ALTER TABLE `lang_polish` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lang_spanish`
--

DROP TABLE IF EXISTS `lang_spanish`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lang_spanish` (
  `content` longtext COLLATE utf8_unicode_ci,
  `block_id` int(10) NOT NULL,
  `lang` varchar(45) COLLATE utf8_unicode_ci DEFAULT 'spanish',
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`block_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds german text blocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lang_spanish`
--

LOCK TABLES `lang_spanish` WRITE;
/*!40000 ALTER TABLE `lang_spanish` DISABLE KEYS */;
INSERT INTO `lang_spanish` VALUES ('ss',4,'spanish','2014-03-12 12:31:44'),('ss',5,'spanish','2014-03-12 12:31:46'),('ss',6,'spanish','2014-03-12 12:31:47'),('ss',7,'spanish','2014-03-12 12:31:47'),('ss',8,'spanish','2014-03-12 12:31:47'),('ss',9,'spanish','2014-03-12 12:31:48'),('ss',10,'spanish','2014-03-12 12:31:48'),('ss',11,'spanish','2014-03-12 12:31:49'),('ss',12,'spanish','2014-03-12 12:31:49'),('ss',13,'spanish','2014-03-12 12:31:50'),('ss',14,'spanish','2014-03-12 12:31:50'),('ss',15,'spanish','2014-03-12 12:31:50'),('ss',16,'spanish','2014-03-12 12:31:50'),('ss',17,'spanish','2014-03-12 12:31:50'),('ss',18,'spanish','2014-03-12 12:31:51'),('ss',19,'spanish','2014-03-12 12:31:51'),('ss',20,'spanish','2014-03-12 12:31:51'),('ss',21,'spanish','2014-03-12 12:31:51'),('ss',22,'spanish','2014-03-12 12:31:51'),('ss',23,'spanish','2014-03-12 12:31:52'),('ss',24,'spanish','2014-03-12 12:31:52'),('ss',25,'spanish','2014-03-12 12:31:52'),('ss',26,'spanish','2014-03-12 12:31:52'),('ss',27,'spanish','2014-03-12 12:31:52'),('ss',28,'spanish','2014-03-12 12:31:52'),('ss',29,'spanish','2014-03-12 12:31:53'),('ss',30,'spanish','2014-03-12 12:31:53'),('ss',31,'spanish','2014-03-12 12:31:53'),('ss',32,'spanish','2014-03-12 12:31:53'),('ss',33,'spanish','2014-03-12 12:31:53'),('ss',34,'spanish','2014-03-12 12:31:53'),('ss',35,'spanish','2014-03-12 12:31:54'),('ss',36,'spanish','2014-03-12 12:31:54'),('ss',37,'spanish','2014-03-12 12:31:54'),('ss',38,'spanish','2014-03-12 12:31:54'),('ss',39,'spanish','2014-03-12 12:31:54'),('ss',40,'spanish','2014-03-12 12:31:54'),('ss',41,'spanish','2014-03-12 12:31:55'),('ss',42,'spanish','2014-03-12 12:31:55'),('ss',43,'spanish','2014-03-12 12:31:55'),('ss',44,'spanish','2014-03-12 12:31:55'),('ss',45,'spanish','2014-03-12 12:31:55'),('ss',46,'spanish','2014-03-12 12:31:55'),('ss',47,'spanish','2014-03-12 12:31:56'),('ss',48,'spanish','2014-03-12 12:31:56'),('ss',49,'spanish','2014-03-12 12:31:56'),('ss',50,'spanish','2014-03-12 12:31:56'),('ss',51,'spanish','2014-03-12 12:31:56'),('ss',52,'spanish','2014-03-12 12:31:56'),('ss',53,'spanish','2014-03-12 12:31:57'),('ss',54,'spanish','2014-03-12 12:31:57'),('ss',55,'spanish','2014-03-12 12:31:57'),('ss',56,'spanish','2014-03-12 12:31:57'),('ss',57,'spanish','2014-03-12 12:31:57'),('ss',58,'spanish','2014-03-12 12:31:57'),('ss',59,'spanish','2014-03-12 12:31:58'),('ss',60,'spanish','2014-03-12 12:31:58'),('ss',61,'spanish','2014-03-12 12:31:58'),('ss',62,'spanish','2014-03-12 12:31:59'),('ss',63,'spanish','2014-03-12 12:31:59'),('ss',64,'spanish','2014-03-12 12:31:59'),('ss',65,'spanish','2014-03-12 12:31:59'),('ss',66,'spanish','2014-03-12 12:31:59'),('ss',67,'spanish','2014-03-12 12:32:00'),('ss',68,'spanish','2014-03-12 12:32:00'),('ss',69,'spanish','2014-03-12 12:32:00'),('ss',70,'spanish','2014-03-12 12:32:01'),('ss',71,'spanish','2014-03-12 12:32:01'),('ss',72,'spanish','2014-03-12 12:32:01'),('ss',73,'spanish','2014-03-12 12:32:01'),('ss',74,'spanish','2014-03-12 12:32:01'),('ss',75,'spanish','2014-03-12 12:32:01'),('ss',76,'spanish','2014-03-12 12:32:02'),('ss',77,'spanish','2014-03-12 12:32:02'),('ss',78,'spanish','2014-03-12 12:32:02'),('ss',79,'spanish','2014-03-12 12:32:02'),('ss',80,'spanish','2014-03-12 12:32:03'),('ss',81,'spanish','2014-03-12 12:32:03'),('ss',82,'spanish','2014-03-12 12:32:03'),('ss',83,'spanish','2014-03-12 12:32:03'),('ss',84,'spanish','2014-03-12 12:32:03'),('ss',85,'spanish','2014-03-12 12:32:03'),('ss',86,'spanish','2014-03-12 12:32:04'),('ss',87,'spanish','2014-03-12 12:32:04'),('ss',88,'spanish','2014-03-12 12:32:04'),('ss',89,'spanish','2014-03-12 12:32:04'),('ss',90,'spanish','2014-03-12 12:32:04'),('ss',91,'spanish','2014-03-12 12:32:05'),('ss',92,'spanish','2014-03-12 12:32:05'),('ss',93,'spanish','2014-03-12 12:32:05'),('ss',94,'spanish','2014-03-12 12:32:05'),('ss',95,'spanish','2014-03-12 12:32:06'),('ss',96,'spanish','2014-03-12 12:32:06'),('ss',97,'spanish','2014-03-12 12:32:06'),('ss',98,'spanish','2014-03-12 12:32:07'),('ss',99,'spanish','2014-03-12 12:32:07'),('ss',100,'spanish','2014-03-12 12:32:07'),('ss',101,'spanish','2014-03-12 12:32:07'),('ss',102,'spanish','2014-03-12 12:32:07'),('ss',103,'spanish','2014-03-12 12:32:08'),('ss',104,'spanish','2014-03-12 12:32:08'),('ss',105,'spanish','2014-03-12 12:32:08'),('ss',106,'spanish','2014-03-12 12:32:08'),('ss',107,'spanish','2014-03-12 12:32:08'),('ss',108,'spanish','2014-03-12 12:32:09'),('ss',109,'spanish','2014-03-12 12:32:09'),('ss',110,'spanish','2014-03-12 12:32:09'),('ss',111,'spanish','2014-03-12 12:32:09'),('ss',112,'spanish','2014-03-12 12:32:10'),('ss',113,'spanish','2014-03-12 12:32:10'),('ss',114,'spanish','2014-03-12 12:32:10'),('ss',115,'spanish','2014-03-12 12:32:10'),('ss',116,'spanish','2014-03-12 12:32:10'),('ss',117,'spanish','2014-03-12 12:32:11'),('ss',118,'spanish','2014-03-12 12:32:11'),('',119,'spanish','2014-03-13 13:48:16'),('',120,'spanish','2014-03-13 13:48:17'),('',121,'spanish','2014-03-13 13:48:17'),('',122,'spanish','2014-03-13 13:48:17'),('',123,'spanish','2014-03-13 13:48:17'),('',124,'spanish','2014-03-13 13:48:18'),('',125,'spanish','2014-03-13 13:48:18'),('',126,'spanish','2014-03-13 13:48:18'),('',127,'spanish','2014-03-13 13:48:18'),('',128,'spanish','2014-03-13 13:48:18'),('',129,'spanish','2014-03-13 13:48:18'),('',130,'spanish','2014-03-13 13:48:19'),('',131,'spanish','2014-03-13 13:48:19'),('',132,'spanish','2014-03-13 13:48:19'),('',133,'spanish','2014-03-13 13:48:19'),('',134,'spanish','2014-03-13 13:48:19'),('',135,'spanish','2014-03-13 13:48:20'),('',136,'spanish','2014-03-13 13:48:20'),('',137,'spanish','2014-03-13 13:48:20'),('',138,'spanish','2014-03-13 13:48:20'),('',139,'spanish','2014-03-13 13:48:20'),('',140,'spanish','2014-03-13 13:48:21'),('',141,'spanish','2014-03-13 13:48:22'),('',142,'spanish','2014-03-13 13:48:22'),('',143,'spanish','2014-03-13 13:48:22'),('',144,'spanish','2014-03-13 13:48:22'),('',145,'spanish','2014-03-13 13:48:22'),('',146,'spanish','2014-03-13 13:48:22'),('',147,'spanish','2014-03-14 03:33:26'),('',148,'spanish','2014-03-14 05:46:30'),('',149,'spanish','2014-03-14 05:46:35'),('',150,'spanish','2014-03-14 06:27:44');
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
  `project_name` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `collection` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notes` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`project_id`,`user_id`),
  KEY `project_idx` (`project_id`),
  KEY `user_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='saves user projects, block id collection\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (2,0,'_p_battery','1,2,3,4,5,6','2014-03-13 13:20:11',NULL),(3,0,'_p_battery','1,2,3,4,5,6','2014-03-13 13:20:11',NULL),(14,1,'jonas','','2014-03-13 13:17:22',NULL),(15,1,'jonas','119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146','2014-03-13 13:49:42',NULL),(17,1,'jonas33','','2014-03-13 14:02:40',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_switch`
--

LOCK TABLES `tag_switch` WRITE;
/*!40000 ALTER TABLE `tag_switch` DISABLE KEYS */;
INSERT INTO `tag_switch` VALUES (3,4,5,'2014-03-12 12:31:44'),(3,5,6,'2014-03-12 12:31:46'),(3,6,7,'2014-03-12 12:31:47'),(3,7,8,'2014-03-12 12:31:47'),(3,8,9,'2014-03-12 12:31:47'),(3,9,10,'2014-03-12 12:31:48'),(3,10,11,'2014-03-12 12:31:48'),(3,11,12,'2014-03-12 12:31:49'),(3,12,13,'2014-03-12 12:31:49'),(3,13,14,'2014-03-12 12:31:50'),(3,14,15,'2014-03-12 12:31:50'),(3,15,16,'2014-03-12 12:31:50'),(3,16,17,'2014-03-12 12:31:50'),(3,17,18,'2014-03-12 12:31:50'),(3,18,19,'2014-03-12 12:31:51'),(3,19,20,'2014-03-12 12:31:51'),(3,20,21,'2014-03-12 12:31:51'),(3,21,22,'2014-03-12 12:31:51'),(3,22,23,'2014-03-12 12:31:51'),(3,23,24,'2014-03-12 12:31:52'),(3,24,25,'2014-03-12 12:31:52'),(3,25,26,'2014-03-12 12:31:52'),(3,26,27,'2014-03-12 12:31:52'),(3,27,28,'2014-03-12 12:31:52'),(3,28,29,'2014-03-12 12:31:52'),(3,29,30,'2014-03-12 12:31:53'),(3,30,31,'2014-03-12 12:31:53'),(3,31,32,'2014-03-12 12:31:53'),(3,32,33,'2014-03-12 12:31:53'),(3,33,34,'2014-03-12 12:31:53'),(3,34,35,'2014-03-12 12:31:53'),(3,35,36,'2014-03-12 12:31:54'),(3,36,37,'2014-03-12 12:31:54'),(3,37,38,'2014-03-12 12:31:54'),(3,38,39,'2014-03-12 12:31:54'),(3,39,40,'2014-03-12 12:31:54'),(3,40,41,'2014-03-12 12:31:54'),(3,41,42,'2014-03-12 12:31:55'),(3,42,43,'2014-03-12 12:31:55'),(3,43,44,'2014-03-12 12:31:55'),(3,44,45,'2014-03-12 12:31:55'),(3,45,46,'2014-03-12 12:31:55'),(3,46,47,'2014-03-12 12:31:55'),(3,47,48,'2014-03-12 12:31:56'),(3,48,49,'2014-03-12 12:31:56'),(3,49,50,'2014-03-12 12:31:56'),(3,50,51,'2014-03-12 12:31:56'),(3,51,52,'2014-03-12 12:31:56'),(3,52,53,'2014-03-12 12:31:56'),(3,53,54,'2014-03-12 12:31:57'),(3,54,55,'2014-03-12 12:31:57'),(3,55,56,'2014-03-12 12:31:57'),(3,56,57,'2014-03-12 12:31:57'),(3,57,58,'2014-03-12 12:31:57'),(3,58,59,'2014-03-12 12:31:57'),(3,59,60,'2014-03-12 12:31:58'),(3,60,61,'2014-03-12 12:31:58'),(3,61,62,'2014-03-12 12:31:58'),(3,62,63,'2014-03-12 12:31:59'),(3,63,64,'2014-03-12 12:31:59'),(3,64,65,'2014-03-12 12:31:59'),(3,65,66,'2014-03-12 12:31:59'),(3,66,67,'2014-03-12 12:31:59'),(3,67,68,'2014-03-12 12:32:00'),(3,68,69,'2014-03-12 12:32:00'),(3,69,70,'2014-03-12 12:32:00'),(3,70,71,'2014-03-12 12:32:01'),(3,71,72,'2014-03-12 12:32:01'),(3,72,73,'2014-03-12 12:32:01'),(3,73,74,'2014-03-12 12:32:01'),(3,74,75,'2014-03-12 12:32:01'),(3,75,76,'2014-03-12 12:32:01'),(3,76,77,'2014-03-12 12:32:02'),(3,77,78,'2014-03-12 12:32:02'),(3,78,79,'2014-03-12 12:32:02'),(3,79,80,'2014-03-12 12:32:02'),(3,80,81,'2014-03-12 12:32:03'),(3,81,82,'2014-03-12 12:32:03'),(3,82,83,'2014-03-12 12:32:03'),(3,83,84,'2014-03-12 12:32:03'),(3,84,85,'2014-03-12 12:32:03'),(3,85,86,'2014-03-12 12:32:03'),(3,86,87,'2014-03-12 12:32:04'),(3,87,88,'2014-03-12 12:32:04'),(3,88,89,'2014-03-12 12:32:04'),(3,89,90,'2014-03-12 12:32:04'),(3,90,91,'2014-03-12 12:32:04'),(3,91,92,'2014-03-12 12:32:05'),(3,92,93,'2014-03-12 12:32:05'),(3,93,94,'2014-03-12 12:32:05'),(3,94,95,'2014-03-12 12:32:05'),(3,95,96,'2014-03-12 12:32:06'),(3,96,97,'2014-03-12 12:32:06'),(3,97,98,'2014-03-12 12:32:06'),(3,98,99,'2014-03-12 12:32:07'),(3,99,100,'2014-03-12 12:32:07'),(3,100,101,'2014-03-12 12:32:07'),(3,101,102,'2014-03-12 12:32:07'),(3,102,103,'2014-03-12 12:32:07'),(3,103,104,'2014-03-12 12:32:08'),(3,104,105,'2014-03-12 12:32:08'),(3,105,106,'2014-03-12 12:32:08'),(3,106,107,'2014-03-12 12:32:08'),(3,107,108,'2014-03-12 12:32:08'),(3,108,109,'2014-03-12 12:32:09'),(3,109,110,'2014-03-12 12:32:09'),(3,110,111,'2014-03-12 12:32:09'),(3,111,112,'2014-03-12 12:32:09'),(3,112,113,'2014-03-12 12:32:10'),(3,113,114,'2014-03-12 12:32:10'),(3,114,115,'2014-03-12 12:32:10'),(3,115,116,'2014-03-12 12:32:10'),(3,116,117,'2014-03-12 12:32:10'),(3,117,118,'2014-03-12 12:32:11'),(3,118,119,'2014-03-12 12:32:11'),(4,119,120,'2014-03-13 13:48:16'),(4,120,121,'2014-03-13 13:48:17'),(4,121,122,'2014-03-13 13:48:17'),(4,122,123,'2014-03-13 13:48:17'),(4,123,124,'2014-03-13 13:48:17'),(4,124,125,'2014-03-13 13:48:18'),(4,125,126,'2014-03-13 13:48:18'),(4,126,127,'2014-03-13 13:48:18'),(4,127,128,'2014-03-13 13:48:18'),(4,128,129,'2014-03-13 13:48:18'),(4,129,130,'2014-03-13 13:48:18'),(4,130,131,'2014-03-13 13:48:19'),(4,131,132,'2014-03-13 13:48:19'),(4,132,133,'2014-03-13 13:48:19'),(4,133,134,'2014-03-13 13:48:19'),(4,134,135,'2014-03-13 13:48:19'),(4,135,136,'2014-03-13 13:48:20'),(4,136,137,'2014-03-13 13:48:20'),(4,137,138,'2014-03-13 13:48:20'),(4,138,139,'2014-03-13 13:48:20'),(4,139,140,'2014-03-13 13:48:20'),(4,140,141,'2014-03-13 13:48:21'),(4,141,142,'2014-03-13 13:48:22'),(4,142,143,'2014-03-13 13:48:22'),(4,143,144,'2014-03-13 13:48:22'),(4,144,145,'2014-03-13 13:48:22'),(4,145,146,'2014-03-13 13:48:22'),(4,146,147,'2014-03-13 13:48:22'),(5,147,148,'2014-03-14 03:33:26'),(6,148,149,'2014-03-14 05:46:30'),(6,149,150,'2014-03-14 05:46:35'),(4,150,151,'2014-03-14 06:27:44');
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
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `notes` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`tag_id`),
  KEY `tag_idx` (`tag_id`),
  KEY `fk_tags_users1_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds user created tags';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,1,'jonas','2014-03-12 11:48:09',NULL),(2,1,'s','2014-03-12 11:59:05',NULL),(3,1,'html','2014-03-12 12:31:44',NULL),(4,1,'ss','2014-03-13 13:48:16',NULL),(5,1,'address','2014-03-14 03:33:26',NULL),(6,1,'fcc','2014-03-14 05:46:30',NULL);
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
  `username` varchar(45) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rights` int(10) NOT NULL,
  `created` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `last_login` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `notes` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds user data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jonas.haener','$2y$10$JmgE/lXzQraBB1OksZUI5ew1XRSugNwdlz.Y.FZVFGLU2ub/gJfci',0,'2014-03-02 08:59:34','2014-03-14 14:35:15',NULL);
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

-- Dump completed on 2014-03-14 14:48:24
