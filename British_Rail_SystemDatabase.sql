/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.5.27-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: rb341_test_1
-- ------------------------------------------------------
-- Server version	10.5.27-MariaDB

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
-- Table structure for table `carriage`
--

DROP TABLE IF EXISTS `carriage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carriage` (
  `train_id` varchar(20) NOT NULL,
  `letter` char(1) NOT NULL,
  PRIMARY KEY (`train_id`,`letter`),
  CONSTRAINT `carriage_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `train` (`unit_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carriage`
--

LOCK TABLES `carriage` WRITE;
/*!40000 ALTER TABLE `carriage` DISABLE KEYS */;
/*!40000 ALTER TABLE `carriage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carriage_feature`
--

DROP TABLE IF EXISTS `carriage_feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carriage_feature` (
  `train_id` varchar(20) NOT NULL,
  `letter` char(20) NOT NULL,
  `feature_id` int(11) NOT NULL,
  PRIMARY KEY (`train_id`,`letter`,`feature_id`),
  KEY `feature_id` (`feature_id`),
  CONSTRAINT `carriage_feature_ibfk_1` FOREIGN KEY (`train_id`, `letter`) REFERENCES `carriage` (`train_id`, `letter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `carriage_feature_ibfk_2` FOREIGN KEY (`feature_id`) REFERENCES `feature` (`feature_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carriage_feature`
--

LOCK TABLES `carriage_feature` WRITE;
/*!40000 ALTER TABLE `carriage_feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `carriage_feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feature`
--

DROP TABLE IF EXISTS `feature`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `feature` (
  `feature_id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`feature_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feature`
--

LOCK TABLES `feature` WRITE;
/*!40000 ALTER TABLE `feature` DISABLE KEYS */;
/*!40000 ALTER TABLE `feature` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `schedule`
--

DROP TABLE IF EXISTS `schedule`;
/*!50001 DROP VIEW IF EXISTS `schedule`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `schedule` AS SELECT
 1 AS `location_name`,
  1 AS `headcode`,
  1 AS `valid_from_date`,
  1 AS `valid_to_date`,
  1 AS `departure_time`,
  1 AS `arrival_time`,
  1 AS `platform`,
  1 AS `origin_name`,
  1 AS `destination_name` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service` (
  `headcode` varchar(10) NOT NULL,
  `valid_from_date` date NOT NULL,
  `valid_to_date` date NOT NULL,
  `origin` varchar(255) NOT NULL,
  `destination` varchar(255) NOT NULL,
  `train_id` varchar(20) NOT NULL,
  PRIMARY KEY (`headcode`),
  KEY `origin` (`origin`),
  KEY `destination` (`destination`),
  KEY `train_id` (`train_id`),
  CONSTRAINT `service_ibfk_1` FOREIGN KEY (`origin`) REFERENCES `location` (`name`) ON UPDATE CASCADE,
  CONSTRAINT `service_ibfk_2` FOREIGN KEY (`destination`) REFERENCES `location` (`name`) ON UPDATE CASCADE,
  CONSTRAINT `service_ibfk_3` FOREIGN KEY (`train_id`) REFERENCES `train` (`unit_id`) ON UPDATE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`valid_from_date` <= `valid_to_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_location`
--

DROP TABLE IF EXISTS `service_location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `service_location` (
  `headcode` varchar(10) NOT NULL,
  `location_name` varchar(255) NOT NULL,
  `sequence_number` int(11) NOT NULL,
  `departure_time` time NOT NULL,
  `arrival_time` time DEFAULT NULL,
  `platform` varchar(10) DEFAULT NULL,
  `stops` tinyint(1) NOT NULL,
  PRIMARY KEY (`headcode`,`location_name`),
  UNIQUE KEY `headcode` (`headcode`,`sequence_number`),
  KEY `location_name` (`location_name`),
  CONSTRAINT `service_location_ibfk_1` FOREIGN KEY (`headcode`) REFERENCES `service` (`headcode`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `service_location_ibfk_2` FOREIGN KEY (`location_name`) REFERENCES `location` (`name`) ON UPDATE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`stops` = 0 and `arrival_time` is null or `stops` = 1 and `arrival_time` is not null)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_location`
--

LOCK TABLES `service_location` WRITE;
/*!40000 ALTER TABLE `service_location` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `station` (
  `name` varchar(255) NOT NULL,
  `station_code` char(2) NOT NULL,
  PRIMARY KEY (`name`),
  UNIQUE KEY `station_code` (`station_code`),
  CONSTRAINT `station_ibfk_1` FOREIGN KEY (`name`) REFERENCES `location` (`name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `train` (
  `unit_id` varchar(20) NOT NULL,
  PRIMARY KEY (`unit_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'rb341_test_1'
--

--
-- Final view structure for view `schedule`
--

/*!50001 DROP VIEW IF EXISTS `schedule`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`rb341`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `schedule` AS select `location`.`name` AS `location_name`,`service`.`headcode` AS `headcode`,`service`.`valid_from_date` AS `valid_from_date`,`service`.`valid_to_date` AS `valid_to_date`,`service_location`.`departure_time` AS `departure_time`,`service_location`.`arrival_time` AS `arrival_time`,`service_location`.`platform` AS `platform`,`origin_location`.`name` AS `origin_name`,`destination_location`.`name` AS `destination_name` from ((((`location` join `service_location` on(`location`.`name` = `service_location`.`location_name`)) join `service` on(`service_location`.`headcode` = `service`.`headcode`)) join `location` `origin_location` on(`service`.`origin` = `origin_location`.`name`)) join `location` `destination_location` on(`service`.`destination` = `destination_location`.`name`)) where `location`.`name` = `service`.`origin` or `location`.`name` = `service`.`destination` */;
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

-- Dump completed on 2025-03-21 19:28:43
