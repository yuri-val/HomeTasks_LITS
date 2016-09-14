-- MySQL dump 10.13  Distrib 5.5.50, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: geometric_shape
-- ------------------------------------------------------
-- Server version	5.5.50-0ubuntu0.14.04.1

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
-- Table structure for table `figures`
--

DROP TABLE IF EXISTS `figures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `figures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `formulas`
--

DROP TABLE IF EXISTS `formulas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formulas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `figure_id` int(11) NOT NULL,
  `name` char(100) NOT NULL,
  `formula` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `squares_fk0` (`figure_id`),
  CONSTRAINT `squares_fk0` FOREIGN KEY (`figure_id`) REFERENCES `figures` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `parameter_sets`
--

DROP TABLE IF EXISTS `parameter_sets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parameter_sets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `formula_id` int(11) NOT NULL,
  `p1` float NOT NULL,
  `p2` float DEFAULT NULL,
  `p3` float DEFAULT NULL,
  `p4` float DEFAULT NULL,
  `p5` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `formulas_fk0` (`formula_id`),
  CONSTRAINT `formulas_fk0` FOREIGN KEY (`formula_id`) REFERENCES `formulas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `squares`
--

DROP TABLE IF EXISTS `squares`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `squares` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `figure_id` int(11) NOT NULL,
  `formula_id` int(11) NOT NULL,
  `parameter_set_id` int(11) NOT NULL,
  `square` float NOT NULL,
  PRIMARY KEY (`id`),
  KEY `squares_fk0` (`figure_id`),
  KEY `squares_fk2` (`parameter_set_id`),
  KEY `squares_fk1` (`formula_id`),
  CONSTRAINT `squares_fk1` FOREIGN KEY (`formula_id`) REFERENCES `formulas` (`id`),
  CONSTRAINT `squares_fk0` FOREIGN KEY (`figure_id`) REFERENCES `figures` (`id`),
  CONSTRAINT `squares_fk2` FOREIGN KEY (`parameter_set_id`) REFERENCES `parameter_sets` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `errors`
--

DROP TABLE IF EXISTS `errors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `errors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `figure_id` int(11) NOT NULL,
  `formula_id` int(11) NOT NULL,
  `parameter_set_id` int(11) NOT NULL,
  `err_code` int(11) NOT NULL,
  `err_msg` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `errors_fk0` (`figure_id`),
  KEY `errors_fk1` (`formula_id`),
  KEY `errors_fk2` (`parameter_set_id`),
  CONSTRAINT `errors_fk2` FOREIGN KEY (`parameter_set_id`) REFERENCES `parameter_sets` (`id`),
  CONSTRAINT `errors_fk0` FOREIGN KEY (`figure_id`) REFERENCES `figures` (`id`),
  CONSTRAINT `errors_fk1` FOREIGN KEY (`formula_id`) REFERENCES `formulas` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;


/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-13 22:37:35
