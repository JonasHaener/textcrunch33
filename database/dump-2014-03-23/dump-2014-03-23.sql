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
  `notes` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`block_id`,`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocks`
--

LOCK TABLES `blocks` WRITE;
/*!40000 ALTER TABLE `blocks` DISABLE KEYS */;
INSERT INTO `blocks` VALUES (6,7,1,'2014-03-22 14:31:38',NULL),(7,7,1,'2014-03-22 14:32:38',NULL),(8,7,1,'2014-03-22 14:32:54',NULL),(9,7,1,'2014-03-22 14:47:31',NULL),(11,1,1,'2014-03-22 18:50:53',NULL),(12,1,1,'2014-03-22 18:51:32',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds text blocks that were deleted';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `blocks_deleted`
--

LOCK TABLES `blocks_deleted` WRITE;
/*!40000 ALTER TABLE `blocks_deleted` DISABLE KEYS */;
INSERT INTO `blocks_deleted` VALUES (1,2,1,1,'Jonas','JonasJonas','Jonas','Jonas','Jonas','Jonas',NULL,'Jonas','2014-03-12 12:25:31',NULL),(2,119,1,8,'sss','sss','sss','sss','ss','ss',NULL,'ss','2014-03-12 12:39:39',NULL),(3,3,1,11,'ss','','','','','',NULL,'','2014-03-12 12:43:25',NULL),(4,1,1,1,'Jonas','JonasJonas','Jonas','Jonas','Jonas','Jonas',NULL,'Jonas','2014-03-13 05:46:47',NULL),(5,160,3,2,'ss','','','','','',NULL,'','2014-03-21 18:12:08',NULL),(6,159,3,2,'ss','','','','','',NULL,'','2014-03-21 18:12:14',NULL),(7,165,3,8,'ss','','','','','',NULL,'','2014-03-21 19:21:24',NULL),(8,164,3,8,'ss','','','','','',NULL,'','2014-03-21 19:21:36',NULL),(9,162,3,8,'ss','','','','','',NULL,'','2014-03-21 19:22:21',NULL),(10,5,1,7,'sssssssssss','','','','','',NULL,'','2014-03-22 14:16:48',NULL),(11,1,1,8,'sssssssssss','','','','','',NULL,'','2014-03-22 14:17:22',NULL),(12,3,1,8,'sssssssssss','','','','','',NULL,'','2014-03-22 14:18:26',NULL),(13,2,1,8,'sssssssssss','','','','','',NULL,'','2014-03-22 14:19:59',NULL),(14,4,1,8,'sssssssssss','','','','','',NULL,'','2014-03-22 14:20:21',NULL),(15,10,1,2,'JOnas aher','JOnas aher','JOnas aher','JOnas aher','JOnas aher','JOnas aher',NULL,'JOnas aher','2014-03-22 19:40:23',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds categories to be assigned to textblocks\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'safety','2014-02-23 13:21:13',NULL),(2,'intro','2014-02-23 13:21:13',NULL),(3,'intendeduse','2014-02-23 13:21:13',NULL),(4,'warning','2014-02-23 13:21:13',NULL),(5,'use','2014-02-23 13:21:13',NULL),(6,'fcc','2014-02-23 13:21:13',NULL),(7,'doc','2014-02-23 13:21:13',NULL),(8,'cleaning','2014-02-23 13:21:13',NULL),(9,'techdata','2014-02-23 13:21:13',NULL),(10,'legal','2014-02-23 13:21:13',NULL),(11,'address','2014-02-23 13:21:13',NULL),(12,'support','2014-03-11 11:06:41',NULL);
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
INSERT INTO `lang_dutch` VALUES ('',6,'dutch','2014-03-22 14:31:38'),('',7,'dutch','2014-03-22 14:32:38'),('',8,'dutch','2014-03-22 14:32:54'),('',9,'dutch','2014-03-22 14:47:31'),('',11,'dutch','2014-03-22 18:50:53'),('',12,'dutch','2014-03-22 18:51:32');
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
INSERT INTO `lang_english` VALUES ('',6,'english','2014-03-22 14:31:38'),('',7,'english','2014-03-22 14:32:38'),('',8,'english','2014-03-22 14:32:54'),('',9,'english','2014-03-22 14:47:31'),('',11,'english','2014-03-22 18:50:53'),('',12,'english','2014-03-22 18:51:32');
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
INSERT INTO `lang_french` VALUES ('',6,'french','2014-03-22 14:31:38'),('',7,'french','2014-03-22 14:32:38'),('',8,'french','2014-03-22 14:32:54'),('',9,'french','2014-03-22 14:47:31'),('',11,'french','2014-03-22 18:50:53'),('',12,'french','2014-03-22 18:51:32');
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
INSERT INTO `lang_german` VALUES ('sssss dddddddddd',6,'german','2014-03-22 15:16:50'),('sssss',7,'german','2014-03-22 14:32:38'),('sssss',8,'german','2014-03-22 14:32:54'),('sssss',9,'german','2014-03-22 14:47:31'),('ssss',11,'german','2014-03-22 18:50:53'),('ssss',12,'german','2014-03-22 18:51:32');
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
INSERT INTO `lang_italian` VALUES ('',6,'italian','2014-03-22 14:31:38'),('',7,'italian','2014-03-22 14:32:38'),('',8,'italian','2014-03-22 14:32:54'),('',9,'italian','2014-03-22 14:47:31'),('',11,'italian','2014-03-22 18:50:53'),('',12,'italian','2014-03-22 18:51:32');
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
INSERT INTO `lang_japanese` VALUES ('',6,'japanese','2014-03-22 14:31:38'),('',7,'japanese','2014-03-22 14:32:38'),('',8,'japanese','2014-03-22 14:32:54'),('',9,'japanese','2014-03-22 14:47:31'),('',11,'japanese','2014-03-22 18:50:53'),('',12,'japanese','2014-03-22 18:51:32');
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
INSERT INTO `lang_polish` VALUES ('',6,'polish','2014-03-22 14:31:38'),('',7,'polish','2014-03-22 14:32:38'),('',8,'polish','2014-03-22 14:32:54'),('',9,'polish','2014-03-22 14:47:31'),('',11,'polish','2014-03-22 18:50:53'),('',12,'polish','2014-03-22 18:51:32');
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
INSERT INTO `lang_spanish` VALUES ('',6,'spanish','2014-03-22 14:31:38'),('',7,'spanish','2014-03-22 14:32:38'),('',8,'spanish','2014-03-22 14:32:54'),('',9,'spanish','2014-03-22 14:47:31'),('',11,'spanish','2014-03-22 18:50:53'),('',12,'spanish','2014-03-22 18:51:32');
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
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='saves user projects, block id collection\n';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `projects`
--

LOCK TABLES `projects` WRITE;
/*!40000 ALTER TABLE `projects` DISABLE KEYS */;
INSERT INTO `projects` VALUES (2,0,'_p_battery','1,2,3,4,5,6','2014-03-13 13:20:11',NULL),(3,0,'_p_battery','1,2,3,4,5,6','2014-03-13 13:20:11',NULL),(23,3,'jonas','1550','2014-03-22 07:50:59',NULL),(24,3,'judi','10223','2014-03-22 07:50:53',NULL),(25,3,'hans','124','2014-03-22 07:50:43',NULL),(26,1,'jonas.haener','','2014-03-22 08:09:55',NULL),(27,1,'Hello Jonas',NULL,'2014-03-22 09:55:46',NULL);
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
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tag_switch`
--

LOCK TABLES `tag_switch` WRITE;
/*!40000 ALTER TABLE `tag_switch` DISABLE KEYS */;
INSERT INTO `tag_switch` VALUES (5,6,26,'2014-03-22 15:16:50'),(5,7,21,'2014-03-22 14:32:38'),(5,8,22,'2014-03-22 14:32:54'),(5,9,23,'2014-03-22 14:47:31'),(1,11,30,'2014-03-22 18:50:53'),(1,12,31,'2014-03-22 18:51:32'),(8,12,32,'2014-03-22 18:51:32');
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
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds user created tags';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
INSERT INTO `tags` VALUES (1,1,'jonas','2014-03-22 14:13:54',NULL),(2,1,'fruit','2014-03-22 14:14:23',NULL),(3,1,'sun','2014-03-22 14:14:23',NULL),(4,1,'hannes','2014-03-22 14:16:06',NULL),(5,1,'ss','2014-03-22 14:31:38',NULL),(6,1,'test','2014-03-22 15:57:02',NULL),(7,1,'entry','2014-03-22 15:57:02',NULL),(8,1,'jonny','2014-03-22 18:51:32',NULL);
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
  `rights_name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='holds user data';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'jonas.haener','$2y$10$JmgE/lXzQraBB1OksZUI5ew1XRSugNwdlz.Y.FZVFGLU2ub/gJfci',0,'2014-03-02 08:59:34','2014-03-23 19:05:00',NULL,'administrator'),(2,'jenny.flex','jamesBond007',1,'2014-03-16 14:24:11',NULL,NULL,'publisher'),(3,'apple','$2y$10$gx5yeo8dDRfxxEXEHWxfZev.kXT2HndGfhNwCi9X2MH6/33rWeQgm',2,'2014-03-16 15:02:56','2014-03-16 23:06:05',NULL,'editor');
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

-- Dump completed on 2014-03-23 19:45:24
