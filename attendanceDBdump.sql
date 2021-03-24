-- MySQL dump 10.16  Distrib 10.1.47-MariaDB, for debian-linux-gnueabihf (armv7l)
--
-- Host: localhost    Database: attendance
-- ------------------------------------------------------
-- Server version	10.1.47-MariaDB-0+deb9u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `attendancelog`
--

DROP TABLE IF EXISTS `attendancelog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `attendancelog` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `studentID` int(10) unsigned NOT NULL,
  `checkinTime` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `attendanceLog_FK` (`studentID`),
  CONSTRAINT `attendanceLog_FK` FOREIGN KEY (`studentID`) REFERENCES `students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendancelog`
--

LOCK TABLES `attendancelog` WRITE;
/*!40000 ALTER TABLE `attendancelog` DISABLE KEYS */;
INSERT INTO `attendancelog` VALUES (12,2,'0000-00-00 00:00:00'),(13,2,'2021-03-18 02:36:03'),(14,2,'2021-03-20 14:56:16'),(15,1,'2021-03-20 14:56:39'),(16,1,'2021-03-20 19:21:51'),(17,2,'2021-03-20 19:21:51'),(18,1,'2021-03-20 19:21:51'),(19,2,'2021-03-20 19:21:51'),(20,1,'2021-03-20 19:56:21'),(21,2,'2021-03-20 19:56:26'),(22,1,'2021-03-20 19:56:33'),(23,1,'2021-03-20 19:57:08'),(24,2,'2021-03-20 19:57:14'),(25,2,'2021-03-20 19:57:25'),(26,1,'2021-03-20 19:57:37'),(27,2,'2021-03-20 20:03:02'),(28,2,'2021-03-20 20:28:37'),(29,2,'2020-10-21 11:53:11'),(30,1,'2020-10-21 11:53:54'),(31,2,'2021-03-24 12:00:21'),(32,1,'2021-03-24 12:00:42'),(33,2,'2021-03-24 12:03:12'),(34,1,'2021-03-24 12:03:23');
/*!40000 ALTER TABLE `attendancelog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rfidID` varchar(255) NOT NULL DEFAULT '',
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'454204699053','someone'),(2,'932361450349','darkness my old friend                          ');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-24 12:06:39
