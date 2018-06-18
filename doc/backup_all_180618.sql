-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: 127.0.0.1    Database: hly
-- ------------------------------------------------------
-- Server version	8.0.11

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
-- Table structure for table `bom`
--

DROP TABLE IF EXISTS `bom`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bom` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `formula_id` bigint(20) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bom_formula_id` (`formula_id`),
  KEY `FKpl04bpbc2t75bmdqmhuectmpr` (`order_id`,`product_id`),
  CONSTRAINT `FKpl04bpbc2t75bmdqmhuectmpr` FOREIGN KEY (`order_id`, `product_id`) REFERENCES `order_item` (`order_id`, `product_id`),
  CONSTRAINT `fk_bom_formula_id` FOREIGN KEY (`formula_id`) REFERENCES `formula` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bom`
--

LOCK TABLES `bom` WRITE;
/*!40000 ALTER TABLE `bom` DISABLE KEYS */;
/*!40000 ALTER TABLE `bom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bom_item`
--

DROP TABLE IF EXISTS `bom_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bom_item` (
  `calc_quantity` float NOT NULL,
  `quantity` float NOT NULL,
  `bom_id` bigint(20) NOT NULL,
  `material_id` bigint(20) NOT NULL,
  PRIMARY KEY (`bom_id`,`material_id`),
  KEY `fk_bom_material` (`material_id`),
  CONSTRAINT `fk_bom_item_bom` FOREIGN KEY (`bom_id`) REFERENCES `bom` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_bom_material` FOREIGN KEY (`material_id`) REFERENCES `material` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bom_item`
--

LOCK TABLES `bom_item` WRITE;
/*!40000 ALTER TABLE `bom_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `bom_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `address` varchar(200) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `contact` varchar(30) DEFAULT NULL,
  `contract_no` varchar(50) NOT NULL,
  `delivery_address` varchar(200) DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `metadata` varchar(500) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(30) DEFAULT NULL,
  `post_code` varchar(6) DEFAULT NULL,
  `settlement_policy` varchar(100) DEFAULT NULL,
  `type_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_923db0lpkwf1yl7ff5hnfvt7w` (`contract_no`),
  KEY `fk_client_type` (`type_id`),
  CONSTRAINT `fk_client_type` FOREIGN KEY (`type_id`) REFERENCES `client_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'','','','c001','','测试客户',NULL,'测试','','','月结',1);
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client_type`
--

DROP TABLE IF EXISTS `client_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client_type`
--

LOCK TABLES `client_type` WRITE;
/*!40000 ALTER TABLE `client_type` DISABLE KEYS */;
INSERT INTO `client_type` VALUES (1,'五金'),(2,'铝材');
/*!40000 ALTER TABLE `client_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `debug`
--

DROP TABLE IF EXISTS `debug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `debug` (
  `proc_id` varchar(100) DEFAULT NULL,
  `debug_output` text,
  `line_id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`line_id`)
) ENGINE=InnoDB AUTO_INCREMENT=364 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `debug`
--

LOCK TABLES `debug` WRITE;
/*!40000 ALTER TABLE `debug` DISABLE KEYS */;
INSERT INTO `debug` VALUES ('test2_BEFORE_INSERT','Debug Started :2018-06-02 08:42:24',150),('test2_BEFORE_INSERT',NULL,151),('test2_BEFORE_INSERT','parent_hs: 1-4',152),('test2_BEFORE_INSERT',NULL,153),('test2_BEFORE_INSERT','Debug Ended :2018-06-02 08:42:24',154),('test_BEFORE_INSERT','Debug Started :2018-06-02 08:51:45',155),('test_BEFORE_INSERT',NULL,156),('test_BEFORE_INSERT','Debug Ended :2018-06-02 08:51:45',157),('test_BEFORE_INSERT','Debug Started :2018-06-02 08:51:45',158),('test_BEFORE_INSERT',NULL,159),('test_BEFORE_INSERT','Debug Ended :2018-06-02 08:51:45',160),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',161),('organization_BEFORE_UPDATE',NULL,162),('organization_BEFORE_UPDATE','new.hs: 1',163),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',164),('organization_BEFORE_UPDATE',NULL,165),('organization_BEFORE_UPDATE','new.hs: 14',166),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',167),('organization_BEFORE_UPDATE',NULL,168),('organization_BEFORE_UPDATE','new.hs: 15',169),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',170),('organization_BEFORE_UPDATE','parent_hs: 1',171),('organization_BEFORE_UPDATE','new.hs: 1-2',172),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',173),('organization_BEFORE_UPDATE','parent_hs: 1',174),('organization_BEFORE_UPDATE','new.hs: 1-3',175),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',176),('organization_BEFORE_UPDATE','parent_hs: 1',177),('organization_BEFORE_UPDATE','new.hs: 1-4',178),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',179),('organization_BEFORE_UPDATE','parent_hs: 1',180),('organization_BEFORE_UPDATE','new.hs: 1-5',181),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',182),('organization_BEFORE_UPDATE','parent_hs: 1',183),('organization_BEFORE_UPDATE','new.hs: 1-6',184),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',185),('organization_BEFORE_UPDATE','parent_hs: 1',186),('organization_BEFORE_UPDATE','new.hs: 1-7',187),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',188),('organization_BEFORE_UPDATE','parent_hs: 1',189),('organization_BEFORE_UPDATE','new.hs: 1-8',190),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',191),('organization_BEFORE_UPDATE','parent_hs: 1',192),('organization_BEFORE_UPDATE','new.hs: 1-9',193),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',194),('organization_BEFORE_UPDATE','parent_hs: 1-2',195),('organization_BEFORE_UPDATE','new.hs: 1-2-10',196),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',197),('organization_BEFORE_UPDATE','parent_hs: 1-3',198),('organization_BEFORE_UPDATE','new.hs: 1-3-11',199),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',200),('organization_BEFORE_UPDATE','parent_hs: 1-3',201),('organization_BEFORE_UPDATE','new.hs: 1-3-12',202),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',203),('organization_BEFORE_UPDATE','parent_hs: 1-4',204),('organization_BEFORE_UPDATE','new.hs: 1-4-13',205),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',206),('organization_BEFORE_UPDATE','parent_hs: 1',207),('organization_BEFORE_UPDATE','new.hs: 1-2',208),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',209),('organization_BEFORE_UPDATE','parent_hs: 1',210),('organization_BEFORE_UPDATE','new.hs: 1-3',211),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',212),('organization_BEFORE_UPDATE','parent_hs: 1',213),('organization_BEFORE_UPDATE','new.hs: 1-4',214),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',215),('organization_BEFORE_UPDATE','parent_hs: 1',216),('organization_BEFORE_UPDATE','new.hs: 1-5',217),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',218),('organization_BEFORE_UPDATE','parent_hs: 1',219),('organization_BEFORE_UPDATE','new.hs: 1-6',220),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',221),('organization_BEFORE_UPDATE','parent_hs: 1',222),('organization_BEFORE_UPDATE','new.hs: 1-7',223),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',224),('organization_BEFORE_UPDATE','parent_hs: 1',225),('organization_BEFORE_UPDATE','new.hs: 1-8',226),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',227),('organization_BEFORE_UPDATE','parent_hs: 1',228),('organization_BEFORE_UPDATE','new.hs: 1-9',229),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',230),('organization_BEFORE_UPDATE','parent_hs: 1-2',231),('organization_BEFORE_UPDATE','new.hs: 1-2-10',232),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',233),('organization_BEFORE_UPDATE','parent_hs: 1-3',234),('organization_BEFORE_UPDATE','new.hs: 1-3-11',235),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',236),('organization_BEFORE_UPDATE','parent_hs: 1-3',237),('organization_BEFORE_UPDATE','new.hs: 1-3-12',238),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',239),('organization_BEFORE_UPDATE','parent_hs: 1-4',240),('organization_BEFORE_UPDATE','new.hs: 1-4-13',241),('organization_BEFORE_INSERT','Debug Started :2018-06-02 09:09:09',242),('organization_BEFORE_INSERT','auto_id: 1',243),('organization_BEFORE_INSERT','parent_hs: 1-4',244),('organization_BEFORE_INSERT','new.hs: 1-4-1',245),('organization_BEFORE_INSERT','Debug Ended :2018-06-02 09:09:09',246),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',247),('organization_BEFORE_UPDATE',NULL,248),('organization_BEFORE_UPDATE','new.hs: 1',249),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',250),('organization_BEFORE_UPDATE','parent_hs: 1',251),('organization_BEFORE_UPDATE','new.hs: 1-2',252),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',253),('organization_BEFORE_UPDATE','parent_hs: 1',254),('organization_BEFORE_UPDATE','new.hs: 1-3',255),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',256),('organization_BEFORE_UPDATE','parent_hs: 1',257),('organization_BEFORE_UPDATE','new.hs: 1-4',258),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',259),('organization_BEFORE_UPDATE','parent_hs: 1',260),('organization_BEFORE_UPDATE','new.hs: 1-5',261),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',262),('organization_BEFORE_UPDATE','parent_hs: 1',263),('organization_BEFORE_UPDATE','new.hs: 1-6',264),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',265),('organization_BEFORE_UPDATE','parent_hs: 1',266),('organization_BEFORE_UPDATE','new.hs: 1-7',267),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',268),('organization_BEFORE_UPDATE','parent_hs: 1',269),('organization_BEFORE_UPDATE','new.hs: 1-8',270),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',271),('organization_BEFORE_UPDATE','parent_hs: 1',272),('organization_BEFORE_UPDATE','new.hs: 1-9',273),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',274),('organization_BEFORE_UPDATE','parent_hs: 1-2',275),('organization_BEFORE_UPDATE','new.hs: 1-2-10',276),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',277),('organization_BEFORE_UPDATE','parent_hs: 1-3',278),('organization_BEFORE_UPDATE','new.hs: 1-3-11',279),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',280),('organization_BEFORE_UPDATE','parent_hs: 1-3',281),('organization_BEFORE_UPDATE','new.hs: 1-3-12',282),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',283),('organization_BEFORE_UPDATE','parent_hs: 1-4',284),('organization_BEFORE_UPDATE','new.hs: 1-4-13',285),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',286),('organization_BEFORE_UPDATE','parent_hs: 1-4',287),('organization_BEFORE_UPDATE','new.hs: 1-4-16',288),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',289),('organization_BEFORE_UPDATE','parent_hs: 1-5',290),('organization_BEFORE_UPDATE','new.hs: 1-5-17',291),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',292),('organization_BEFORE_UPDATE','parent_hs: 1-6',293),('organization_BEFORE_UPDATE','new.hs: 1-6-18',294),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',295),('organization_BEFORE_UPDATE','parent_hs: 1-7',296),('organization_BEFORE_UPDATE','new.hs: 1-7-19',297),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',298),('organization_BEFORE_UPDATE','parent_hs: 1-8',299),('organization_BEFORE_UPDATE','new.hs: 1-8-20',300),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',301),('organization_BEFORE_UPDATE','parent_hs: 1-9',302),('organization_BEFORE_UPDATE','new.hs: 1-9-21',303),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',304),('organization_BEFORE_UPDATE','parent_hs: 1-8',305),('organization_BEFORE_UPDATE','new.hs: 1-8-22',306),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',307),('organization_BEFORE_UPDATE','parent_hs: 1',308),('organization_BEFORE_UPDATE','new.hs: 1-2',309),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',310),('organization_BEFORE_UPDATE','parent_hs: 1',311),('organization_BEFORE_UPDATE','new.hs: 1-3',312),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',313),('organization_BEFORE_UPDATE','parent_hs: 1',314),('organization_BEFORE_UPDATE','new.hs: 1-4',315),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',316),('organization_BEFORE_UPDATE','parent_hs: 1',317),('organization_BEFORE_UPDATE','new.hs: 1-5',318),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',319),('organization_BEFORE_UPDATE','parent_hs: 1',320),('organization_BEFORE_UPDATE','new.hs: 1-6',321),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',322),('organization_BEFORE_UPDATE','parent_hs: 1',323),('organization_BEFORE_UPDATE','new.hs: 1-7',324),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',325),('organization_BEFORE_UPDATE','parent_hs: 1',326),('organization_BEFORE_UPDATE','new.hs: 1-8',327),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',328),('organization_BEFORE_UPDATE','parent_hs: 1',329),('organization_BEFORE_UPDATE','new.hs: 1-9',330),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',331),('organization_BEFORE_UPDATE','parent_hs: 1-2',332),('organization_BEFORE_UPDATE','new.hs: 1-2-10',333),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',334),('organization_BEFORE_UPDATE','parent_hs: 1-3',335),('organization_BEFORE_UPDATE','new.hs: 1-3-11',336),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',337),('organization_BEFORE_UPDATE','parent_hs: 1-3',338),('organization_BEFORE_UPDATE','new.hs: 1-3-12',339),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',340),('organization_BEFORE_UPDATE','parent_hs: 1-4',341),('organization_BEFORE_UPDATE','new.hs: 1-4-13',342),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',343),('organization_BEFORE_UPDATE','parent_hs: 1-4',344),('organization_BEFORE_UPDATE','new.hs: 1-4-16',345),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',346),('organization_BEFORE_UPDATE','parent_hs: 1-5',347),('organization_BEFORE_UPDATE','new.hs: 1-5-17',348),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',349),('organization_BEFORE_UPDATE','parent_hs: 1-6',350),('organization_BEFORE_UPDATE','new.hs: 1-6-18',351),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',352),('organization_BEFORE_UPDATE','parent_hs: 1-7',353),('organization_BEFORE_UPDATE','new.hs: 1-7-19',354),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',355),('organization_BEFORE_UPDATE','parent_hs: 1-8',356),('organization_BEFORE_UPDATE','new.hs: 1-8-20',357),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',358),('organization_BEFORE_UPDATE','parent_hs: 1-9',359),('organization_BEFORE_UPDATE','new.hs: 1-9-21',360),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',361),('organization_BEFORE_UPDATE','parent_hs: 1-8',362),('organization_BEFORE_UPDATE','new.hs: 1-8-22',363);
/*!40000 ALTER TABLE `debug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formula`
--

DROP TABLE IF EXISTS `formula`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formula` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `change_log` varchar(200) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `create_date` datetime NOT NULL,
  `metadata` varchar(500) DEFAULT NULL,
  `revision` int(11) NOT NULL,
  `product_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_formula_revision` (`product_id`,`revision`),
  CONSTRAINT `fk_formula_rev_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formula`
--

LOCK TABLES `formula` WRITE;
/*!40000 ALTER TABLE `formula` DISABLE KEYS */;
/*!40000 ALTER TABLE `formula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `formula_item`
--

DROP TABLE IF EXISTS `formula_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `formula_item` (
  `quantity` float NOT NULL,
  `formula_id` bigint(20) NOT NULL,
  `material_id` bigint(20) NOT NULL,
  PRIMARY KEY (`formula_id`,`material_id`),
  KEY `fk_formula_item_material` (`material_id`),
  CONSTRAINT `fk_formula_item_formula` FOREIGN KEY (`formula_id`) REFERENCES `formula` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_formula_item_material` FOREIGN KEY (`material_id`) REFERENCES `material` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `formula_item`
--

LOCK TABLES `formula_item` WRITE;
/*!40000 ALTER TABLE `formula_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `formula_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `comment` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='盘点';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material`
--

DROP TABLE IF EXISTS `material`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `material` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `code` varchar(20) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `metadata` varchar(500) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `safe_quantity` float NOT NULL,
  `spec` varchar(20) DEFAULT NULL,
  `category` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0=物料;1=成品',
  `type_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_dvc457p6ww41n1b9vs12e9f36` (`code`),
  KEY `fk_material_type` (`type_id`),
  CONSTRAINT `fk_material_type` FOREIGN KEY (`type_id`) REFERENCES `material_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES (1,'m-001','',NULL,'色粉2',200,'20kg/p',0,1),(2,'m-002','',NULL,'色粉3',200,'30kg/p',0,1),(3,'m-003','',NULL,'黏胶A',100,'10kg/p',0,2),(4,'m-004','',NULL,'胶B',400,'40kg/p',0,2);
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_type`
--

DROP TABLE IF EXISTS `material_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `material_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_type`
--

LOCK TABLES `material_type` WRITE;
/*!40000 ALTER TABLE `material_type` DISABLE KEYS */;
INSERT INTO `material_type` VALUES (1,'颜料'),(2,'固化剂'),(3,'测试');
/*!40000 ALTER TABLE `material_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `actual_value` float DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `delivery_date` datetime NOT NULL,
  `metadata` varchar(500) DEFAULT NULL,
  `no` varchar(20) NOT NULL,
  `order_date` datetime NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '0',
  `tax` bit(1) NOT NULL,
  `value` float NOT NULL,
  `client_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_e8399sgf6y62t04adtfm5e2ia` (`no`),
  KEY `fk_client_order` (`client_id`),
  CONSTRAINT `fk_client_order` FOREIGN KEY (`client_id`) REFERENCES `client` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,NULL,'测试','2018-05-30 19:00:00',NULL,'o-001','2018-05-26 19:00:00',0,'\0',1100,1),(2,NULL,'test','2018-05-30 19:00:00',NULL,'o-002','2018-05-26 19:00:00',0,'\0',14,1),(3,NULL,'test again','2018-05-29 19:00:00',NULL,'o-003','2018-05-25 19:00:00',0,'',30,1);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `order_item`
--

DROP TABLE IF EXISTS `order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `order_item` (
  `actual_quantity` float DEFAULT NULL,
  `price` float NOT NULL,
  `quantity` float NOT NULL,
  `order_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  PRIMARY KEY (`order_id`,`product_id`),
  KEY `fk_order_item_product` (`product_id`),
  CONSTRAINT `fk_order_item_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_order_item_product` FOREIGN KEY (`product_id`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (NULL,22,11,1,1),(NULL,40,20,1,2),(NULL,2,1,2,1),(NULL,4,3,2,2),(NULL,6,5,3,2);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `org`
--

DROP TABLE IF EXISTS `org`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `org` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `comment` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_org_org_dir` FOREIGN KEY (`id`) REFERENCES `organization` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `org`
--

LOCK TABLES `org` WRITE;
/*!40000 ALTER TABLE `org` DISABLE KEYS */;
INSERT INTO `org` VALUES (1,'华丽雅粉末科技有限公司',NULL),(2,'总经办',NULL),(3,'行政财务部',NULL),(4,'销售部',NULL),(5,'质量技术部',NULL),(6,'工艺技术部',NULL),(7,'产品技术部',NULL),(8,'生产制造部',NULL),(9,'供应链管理部',NULL);
/*!40000 ALTER TABLE `org` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `organization`
--

DROP TABLE IF EXISTS `organization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `organization` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent` int(11) DEFAULT NULL,
  `type` smallint(6) NOT NULL COMMENT '0 - org; 1 - person; 2 - repo',
  `hs` varchar(200) DEFAULT NULL,
  `info` json DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (1,NULL,0,'1',NULL),(2,1,0,'1-2',NULL),(3,1,0,'1-3',NULL),(4,1,0,'1-4',NULL),(5,1,0,'1-5',NULL),(6,1,0,'1-6',NULL),(7,1,0,'1-7',NULL),(8,1,0,'1-8',NULL),(9,1,0,'1-9',NULL),(10,2,1,'1-2-10',NULL),(11,3,1,'1-3-11',NULL),(12,3,1,'1-3-12',NULL),(13,4,1,'1-4-13',NULL),(16,4,1,'1-4-16',NULL),(17,5,1,'1-5-17',NULL),(18,6,1,'1-6-18','{\"pwd\": \"f6a0f9a82944f338abe0244a4add7d02\", \"name\": \"汤确军\", \"phone\": \"13928771916\", \"title\": \"经理\"}'),(19,7,1,'1-7-19','{\"pwd\": \"82b4af7b80b04248821a5d4325f5248d\", \"name\": \"黄应通\", \"phone\": \"13531347949\", \"title\": \"经理\"}'),(20,8,1,'1-8-20','{\"pwd\": \"8464e6f8f1d9ac9f6bed378b75e12e6c\", \"name\": \"陈锦海\", \"phone\": \"13536620289\", \"title\": \"厂长\"}'),(21,9,1,'1-9-21','{\"pwd\": \"391c3a0cc268dec6e1db3e31c591a67a\", \"name\": \"邱谷娣\", \"phone\": \"15917885784\", \"title\": \"文员\"}'),(22,8,1,'1-8-22','{\"pwd\": \"7db072ab3abd8686b7959c52ba127397\", \"name\": \"吴国才\", \"phone\": \"18873798055\", \"title\": \"挤出班长\"}');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`hly`@`%`*/ /*!50003 TRIGGER `organization_BEFORE_INSERT` BEFORE INSERT ON `organization` FOR EACH ROW BEGIN
	-- DECLARE auto_id INT;
    -- DECLARE parent_hs VARCHAR(200);
    -- declare proc_id varchar(100) default 'organization_BEFORE_INSERT';
    -- call debug_on(proc_id);
    
	-- SET auto_id=  (SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema = schema() AND table_name='organization');
	-- SET parent_hs = (SELECT hs FROM organization WHERE id=new.parent);
	-- SELECT AUTO_INCREMENT into @auto_id FROM information_schema.tables WHERE table_schema = schema() AND table_name='organization';
	select max(id) + 1 into @auto_id from organization;
    -- call debug_insert(proc_id, concat("auto_id: ", @auto_id));
    
	SELECT hs into @parent_hs FROM organization WHERE id = new.parent;
   	-- call debug_insert(proc_id, concat("parent_hs: ", @parent_hs));
 
    IF @parent_hs IS NULL THEN
		SET new.hs = concat("", @auto_id);
	ELSE
	    SET new.hs = CONCAT(@parent_hs, "-", @auto_id);
    END IF; 
   	-- call debug_insert(proc_id, concat("new.hs: ", new.hs));

    -- call debug_off(proc_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`hly`@`%`*/ /*!50003 TRIGGER `organization_BEFORE_UPDATE` BEFORE UPDATE ON `organization` FOR EACH ROW BEGIN
	declare parent_hs varchar(200);
    declare l_proc_id varchar(100) default 'organization_BEFORE_UPDATE';
    call debug_on(l_proc_id);

	set parent_hs = (select hs from organization where id = new.parent);
	call debug_insert(l_proc_id, concat("parent_hs: ", parent_hs));
    IF parent_hs IS NULL THEN
		SET new.hs = old.id;
	else
	    set new.hs = concat(parent_hs, "-", old.id);
	end if;

	call debug_insert(l_proc_id, concat("new.hs: ", new.hs));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `privilege`
--

DROP TABLE IF EXISTS `privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `privilege` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `privilege`
--

LOCK TABLES `privilege` WRITE;
/*!40000 ALTER TABLE `privilege` DISABLE KEYS */;
INSERT INTO `privilege` VALUES (1,'system:basic-data:read','基础数据管理',0,'如：客户类型、材料分类等'),(2,'system:user-management:read','用户管理',0,'包括：组织结构、用户、角色、权限管理'),(3,'sales:client:read','客户管理',0,NULL),(4,'sales:order:read','订单管理',0,NULL),(5,'production:material:read','物料数据',0,NULL),(6,'production:product:read','产品',0,NULL),(7,'production:bom:read','BOM单',0,NULL),(8,'production:formula:read','产品配方',0,NULL),(9,'repo:stock-in:read','入库单',0,NULL),(10,'repo:stock-out:read','出库单',0,NULL),(11,'repo:inventory:read','库存盘点',0,NULL),(12,'purchasing:plan:read','采购计划',0,NULL),(14,'system:basic-data','基础数据管理 (可写)',0,'如：客户类型、材料分类等'),(15,'system:user-management','用户管理 (可写)',0,'包括：组织结构、用户、角色、权限管理'),(16,'sales:client','客户管理 (可写)',0,NULL),(17,'sales:order','订单管理 (可写)',0,NULL),(18,'production:material','物料数据 (可写)',0,NULL),(19,'production:product','产品 (可写)',0,NULL),(20,'production:bom','BOM单 (可写)',0,NULL),(21,'production:formula','产品配方 (可写)',0,NULL),(22,'repo:stock-in','入库单 (可写)',0,NULL),(23,'repo:stock-out','出库单 (可写)',0,NULL),(24,'repo:inventory','库存盘点 (可写)',0,NULL),(25,'purchasing:plan','采购计划 (可写)',0,NULL);
/*!40000 ALTER TABLE `privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produce_condition`
--

DROP TABLE IF EXISTS `produce_condition`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `produce_condition` (
  `input_temperature` int(11) NOT NULL,
  `main_miller_rpm` int(11) NOT NULL,
  `mesh` int(11) NOT NULL,
  `mix_time` int(11) NOT NULL,
  `output_temperature` int(11) NOT NULL,
  `screw_rpm` int(11) NOT NULL,
  `second_miller_rpm` int(11) NOT NULL,
  `formula_id` bigint(20) NOT NULL,
  PRIMARY KEY (`formula_id`),
  CONSTRAINT `fk_formula_produce_cond` FOREIGN KEY (`formula_id`) REFERENCES `formula` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produce_condition`
--

LOCK TABLES `produce_condition` WRITE;
/*!40000 ALTER TABLE `produce_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `produce_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `base` varchar(50) DEFAULT NULL,
  `code` varchar(20) NOT NULL,
  `color` varchar(20) DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `metadata` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_h3w5r1mx6d0e5c6um32dgyjej` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'铝合金','p001','红','',NULL),(2,'塑料','p002','白','',NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchasing_order`
--

DROP TABLE IF EXISTS `purchasing_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchasing_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `no` varchar(50) NOT NULL COMMENT 'order no',
  `date` timestamp NOT NULL,
  `tax` tinyint(4) NOT NULL COMMENT '1 = tax inclusive; 0 = tax exclusive',
  `vat` float unsigned DEFAULT '0',
  `supplier` varchar(100) NOT NULL,
  `signer` int(11) NOT NULL,
  `comment` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `no_UNIQUE` (`no`),
  KEY `fk_purchasing_order_signer_idx` (`signer`),
  CONSTRAINT `fk_purchasing_order_signer` FOREIGN KEY (`signer`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchasing_order`
--

LOCK TABLES `purchasing_order` WRITE;
/*!40000 ALTER TABLE `purchasing_order` DISABLE KEYS */;
INSERT INTO `purchasing_order` VALUES (1,'p001','2018-06-14 23:34:56',1,0.03,'顺德广盛塑料胶袋厂',21,'test'),(2,'p-0002','2018-06-16 11:00:00',1,0.03,'飞的飞',21,NULL);
/*!40000 ALTER TABLE `purchasing_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchasing_order_item`
--

DROP TABLE IF EXISTS `purchasing_order_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchasing_order_item` (
  `purchasing_order_id` int(11) NOT NULL,
  `material_id` bigint(20) NOT NULL,
  `quantity` float unsigned NOT NULL,
  `vip` float unsigned NOT NULL,
  `vat` float unsigned NOT NULL DEFAULT '0',
  `vep` float unsigned NOT NULL COMMENT 'vat excluded price. price = vat_inclusive_price / (1 + vat)',
  PRIMARY KEY (`purchasing_order_id`,`material_id`),
  KEY `fk_purchasing_order_material` (`material_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='采购单条目';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchasing_order_item`
--

LOCK TABLES `purchasing_order_item` WRITE;
/*!40000 ALTER TABLE `purchasing_order_item` DISABLE KEYS */;
INSERT INTO `purchasing_order_item` VALUES (2,2,4.1,5.2,0.03,5.04854),(2,3,2.3,4.4,0.03,4.27184);
/*!40000 ALTER TABLE `purchasing_order_item` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`hly`@`%`*/ /*!50003 TRIGGER `purchasing_order_item_BEFORE_INSERT` BEFORE INSERT ON `purchasing_order_item` FOR EACH ROW BEGIN
  select vat into @v from purchasing_order o where o.id = new.purchasing_order_id; 
  set new.vat = @v;
  set new.vep = new.vip / (1 + new.vat);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`hly`@`%`*/ /*!50003 TRIGGER `purchasing_order_item_BEFORE_UPDATE` BEFORE UPDATE ON `purchasing_order_item` FOR EACH ROW BEGIN
  select vat into @v from purchasing_order o where o.id = new.purchasing_order_id; 
  set new.vat = @v;
	set new.vep = new.vip / (1 + new.vat);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `repo`
--

DROP TABLE IF EXISTS `repo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '0 = material, 1=product',
  `comment` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repo`
--

LOCK TABLES `repo` WRITE;
/*!40000 ALTER TABLE `repo` DISABLE KEYS */;
INSERT INTO `repo` VALUES (1,'鹤山材料仓',0,NULL),(2,'鹤山成品仓',1,NULL);
/*!40000 ALTER TABLE `repo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repo_changing`
--

DROP TABLE IF EXISTS `repo_changing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repo_changing` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `repo_id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '1 = stock-in, 入库\n-1 = stock-out, 出库\n0 = inventory, 盘点',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0 = init; 1 = submitted; 2 = executed; -1 = rejected',
  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `applying_date` timestamp NULL DEFAULT NULL,
  `applicant` int(11) NOT NULL,
  `reason_id` int(11) DEFAULT NULL COMMENT 'null = custom reason',
  `reason_detail` varchar(200) DEFAULT NULL,
  `purchasing_order_id` int(11) DEFAULT NULL,
  `order_id` bigint(20) DEFAULT NULL,
  `department` varchar(50) DEFAULT NULL,
  `vat` float unsigned DEFAULT '0' COMMENT '增值税税率，0即意味着不含税, 0.03 = 3%',
  `vat_inclusive_value` float unsigned DEFAULT NULL COMMENT '含增值税的金额',
  `value` float unsigned DEFAULT NULL COMMENT '不含增值税的总额。\nvalue = value_with_vat / 1 + vat',
  `keeper` int(11) DEFAULT NULL,
  `execute_date` timestamp NULL DEFAULT NULL,
  `comment` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_repo_changing_repo_idx` (`repo_id`),
  KEY `fk_repo_changing_order_idx` (`order_id`),
  KEY `fk_repo_changing_reason_idx` (`reason_id`),
  KEY `fk_repo_changing_user_idx` (`applicant`),
  KEY `fk_repo_changing_keeper_user_idx` (`keeper`),
  CONSTRAINT `fk_repo_changing_keeper_user` FOREIGN KEY (`keeper`) REFERENCES `user` (`id`),
  CONSTRAINT `fk_repo_changing_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_repo_changing_reason` FOREIGN KEY (`reason_id`) REFERENCES `repo_changing_reason` (`id`) ON DELETE SET NULL,
  CONSTRAINT `fk_repo_changing_repo` FOREIGN KEY (`repo_id`) REFERENCES `repo` (`id`),
  CONSTRAINT `fk_repo_changing_user` FOREIGN KEY (`applicant`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='库存变化';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repo_changing`
--

LOCK TABLES `repo_changing` WRITE;
/*!40000 ALTER TABLE `repo_changing` DISABLE KEYS */;
INSERT INTO `repo_changing` VALUES (1,1,1,0,'2018-05-26 18:48:58',NULL,10,2,NULL,NULL,NULL,'test',0,0,0,NULL,NULL,NULL),(2,1,1,0,'2018-05-26 19:01:27',NULL,10,1,NULL,NULL,NULL,'d',0,0,0,NULL,NULL,NULL),(3,2,1,2,'2018-05-26 19:06:48','2018-05-26 11:00:00',10,4,'t',NULL,NULL,'d',0,0,0,21,'2018-06-10 10:07:25',''),(4,1,1,0,'2018-06-09 16:05:06',NULL,10,3,'过期',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL),(5,1,1,0,'2018-06-09 16:29:34',NULL,10,3,'dk',NULL,NULL,NULL,0,0,0,NULL,NULL,NULL),(6,1,-1,1,'2018-06-09 16:44:36','2018-06-09 11:00:00',10,5,'生产',NULL,3,NULL,0,0,0,NULL,NULL,NULL),(7,2,-1,2,'2018-06-09 18:37:13','2018-06-09 11:00:00',10,6,'测试',NULL,NULL,NULL,0,0,0,21,'2018-06-10 10:08:28','');
/*!40000 ALTER TABLE `repo_changing` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`hly`@`%`*/ /*!50003 TRIGGER `repo_changing_BEFORE_INSERT` BEFORE INSERT ON `repo_changing` FOR EACH ROW BEGIN
	set new.value = new.vat_inclusive_value / (1 + new.vat);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`hly`@`%`*/ /*!50003 TRIGGER `repo_changing_BEFORE_UPDATE` BEFORE UPDATE ON `repo_changing` FOR EACH ROW BEGIN
	set new.value = new.vat_inclusive_value / (1 + new.vat);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `repo_changing_item`
--

DROP TABLE IF EXISTS `repo_changing_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repo_changing_item` (
  `repo_changing_id` int(10) unsigned NOT NULL,
  `material_id` bigint(20) NOT NULL,
  `quantity` float unsigned NOT NULL,
  `vat_inclusive_price` float unsigned NOT NULL,
  `price` float unsigned NOT NULL COMMENT 'vat excluded price. price = vat_inclusive_price / (1 + repo_changing.vat)',
  PRIMARY KEY (`repo_changing_id`,`material_id`),
  KEY `fk_repo_changing_material` (`material_id`),
  CONSTRAINT `fk_repo_changing_item_repo_changing` FOREIGN KEY (`repo_changing_id`) REFERENCES `repo_changing` (`id`),
  CONSTRAINT `fk_repo_changing_material` FOREIGN KEY (`material_id`) REFERENCES `material` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存变化条目';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repo_changing_item`
--

LOCK TABLES `repo_changing_item` WRITE;
/*!40000 ALTER TABLE `repo_changing_item` DISABLE KEYS */;
INSERT INTO `repo_changing_item` VALUES (2,3,1,0,2),(3,2,3,0,4),(5,3,1,0,2),(5,4,3,0,4),(6,3,3,0,0),(6,4,2,0,0),(7,2,3.4,0,4);
/*!40000 ALTER TABLE `repo_changing_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repo_changing_reason`
--

DROP TABLE IF EXISTS `repo_changing_reason`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repo_changing_reason` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `repo_id` int(11) NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '1 = stock-in; -1 = stock-out',
  `reason` varchar(50) NOT NULL,
  `order_related` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_repo_changing_repo_idx` (`repo_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repo_changing_reason`
--

LOCK TABLES `repo_changing_reason` WRITE;
/*!40000 ALTER TABLE `repo_changing_reason` DISABLE KEYS */;
INSERT INTO `repo_changing_reason` VALUES (1,0,1,'采购入库',0),(2,0,1,'盘盈',0),(3,0,1,'过期转入',0),(4,0,1,'其他仓库调入',0),(5,0,-1,'生产领用',1),(6,0,-1,'打板领用',0),(7,0,-1,'车间辅助生产领用',0),(8,0,-1,'盘亏',0),(9,0,-1,'过期转出',0);
/*!40000 ALTER TABLE `repo_changing_reason` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repo_history`
--

DROP TABLE IF EXISTS `repo_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repo_history` (
  `inventory_id` int(10) unsigned NOT NULL,
  `material_id` bigint(20) NOT NULL,
  `quantity` float NOT NULL,
  `price` float NOT NULL,
  PRIMARY KEY (`inventory_id`,`material_id`),
  KEY `fk_repo_history_material` (`material_id`),
  CONSTRAINT `fk_repo_history_inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`),
  CONSTRAINT `fk_repo_history_material` FOREIGN KEY (`material_id`) REFERENCES `material` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存历史';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repo_history`
--

LOCK TABLES `repo_history` WRITE;
/*!40000 ALTER TABLE `repo_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `repo_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `repo_item`
--

DROP TABLE IF EXISTS `repo_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `repo_item` (
  `repo_id` int(11) NOT NULL,
  `material_id` bigint(20) NOT NULL,
  `quantity` float unsigned NOT NULL,
  `price` float unsigned NOT NULL,
  PRIMARY KEY (`repo_id`,`material_id`),
  KEY `fk_repo_item_material` (`material_id`),
  CONSTRAINT `fk_repo_item_material` FOREIGN KEY (`material_id`) REFERENCES `material` (`id`),
  CONSTRAINT `fk_repo_item_repo` FOREIGN KEY (`repo_id`) REFERENCES `repo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='库存详情';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `repo_item`
--

LOCK TABLES `repo_item` WRITE;
/*!40000 ALTER TABLE `repo_item` DISABLE KEYS */;
INSERT INTO `repo_item` VALUES (1,2,10,3),(2,2,1.4,4);
/*!40000 ALTER TABLE `repo_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `disabled` tinyint(4) NOT NULL DEFAULT '0',
  `comment` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code_UNIQUE` (`code`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'admin','系统管理员',0,NULL),(2,'general-manager','总经理',0,NULL),(3,'repo-keeper','仓库管理员',0,NULL),(8,'product-manager','产品经理',0,NULL),(9,'sales-manager','销售经理',0,NULL),(10,'producing-manager','生产主管',0,NULL),(11,'process-manager','工艺经理',0,NULL),(12,'financial-manager','财务主管',0,''),(13,'employee','员工',0,'公司员工'),(14,'supplying-manager','供应链主管',0,NULL);
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role_privilege`
--

DROP TABLE IF EXISTS `role_privilege`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role_privilege` (
  `role_id` int(11) NOT NULL,
  `privilege_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`privilege_id`),
  KEY `fk_role_privilege_privilege` (`privilege_id`),
  CONSTRAINT `fk_role_privilege_privilege` FOREIGN KEY (`privilege_id`) REFERENCES `privilege` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_role_privilege_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role_privilege`
--

LOCK TABLES `role_privilege` WRITE;
/*!40000 ALTER TABLE `role_privilege` DISABLE KEYS */;
INSERT INTO `role_privilege` VALUES (1,1),(10,1),(13,1),(1,2),(2,3),(9,3),(2,4),(9,4),(10,5),(13,5),(14,5),(8,6),(10,6),(13,6),(10,7),(10,8),(3,9),(13,9),(3,10),(13,10),(3,11),(1,14),(14,14),(1,15),(9,16),(9,17),(8,19),(13,22),(13,23),(3,24),(14,25);
/*!40000 ALTER TABLE `role_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test`
--

DROP TABLE IF EXISTS `test`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'a'),(2,'b');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `test2`
--

DROP TABLE IF EXISTS `test2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `test2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent` int(11) DEFAULT NULL,
  `type` smallint(6) NOT NULL COMMENT '0 - org; 1 - person; 2 - repo',
  `hs` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `test2`
--

LOCK TABLES `test2` WRITE;
/*!40000 ALTER TABLE `test2` DISABLE KEYS */;
INSERT INTO `test2` VALUES (1,NULL,0,NULL),(2,NULL,0,NULL);
/*!40000 ALTER TABLE `test2` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`hly`@`%`*/ /*!50003 TRIGGER `test2_BEFORE_INSERT` BEFORE INSERT ON `test2` FOR EACH ROW BEGIN
    declare proc_id varchar(100) default 'test2_BEFORE_INSERT';
    call debug_on(proc_id);
    
	SELECT AUTO_INCREMENT into @auto_id FROM information_schema.tables WHERE table_schema = schema() AND table_name='test2';
	call debug_insert(proc_id, concat("auto_id: ", @auto_id));
    
	SELECT hs into @parent_hs FROM organization WHERE id = new.parent;
   	call debug_insert(proc_id, concat("parent_hs: ", @parent_hs));
 
    IF @parent_hs IS NULL THEN
		SET new.hs = concat("", @auto_id);
	ELSE
	    SET new.hs = CONCAT(@parent_hs, "-", @auto_id);
    END IF; 
   	call debug_insert(proc_id, concat("new.hs: ", new.hs));

    call debug_off(proc_id);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `gender` tinyint(4) DEFAULT NULL COMMENT '0 - female; 1 = male',
  `phone` varchar(20) NOT NULL,
  `password` varchar(40) NOT NULL COMMENT 'md5 hashed',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT '0/null: not disabled; others = disabled',
  `comment` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `phone_UNIQUE` (`phone`),
  CONSTRAINT `fk_user_org` FOREIGN KEY (`id`) REFERENCES `organization` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (10,'李立新',NULL,'13926053858','701b3815ba65412590ac77ef2978ff8c',0,NULL),(11,'范玲艳',NULL,'18988524905','d824f69ef4b8bb4e70f3d303f403f3b2',0,NULL),(12,'文海燕',NULL,'13630401067','9ce1a633deb4db6abf97c29ca76f99e8',0,NULL),(13,'陈慧',NULL,'13928550268','8464e6f8f1d9ac9f6bed378b75e12e6c',0,NULL),(16,'曹杰峰',NULL,'13928600337','1a7c29d399c29e4202dc76204c2a8ec3',0,NULL),(17,'刘伟纯',NULL,'13660989300','f0122e8f067f03ad2c8cc946d2bf7199',0,NULL),(18,'汤确军',NULL,'13928771916','f6a0f9a82944f338abe0244a4add7d02',0,NULL),(19,'黄应通',NULL,'13531347949','82b4af7b80b04248821a5d4325f5248d',0,NULL),(20,'陈锦海',NULL,'13536620289','8464e6f8f1d9ac9f6bed378b75e12e6c',0,NULL),(21,'邱谷娣',NULL,'15917885784','391c3a0cc268dec6e1db3e31c591a67a',0,NULL),(22,'吴国才',NULL,'18873798055','7db072ab3abd8686b7959c52ba127397',0,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_role`
--

DROP TABLE IF EXISTS `user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_role` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`user_id`),
  KEY `fk_user_role_role_idx` (`role_id`),
  KEY `fk_user_role_user_idx` (`user_id`),
  CONSTRAINT `fk_user_role_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_user_role_user` FOREIGN KEY (`user_id`) REFERENCES `organization` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (10,1),(10,2),(21,3),(19,8),(18,10),(20,10),(18,11),(10,13),(20,13),(22,13),(21,14);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'hly'
--
/*!50003 DROP PROCEDURE IF EXISTS `apply_stock_in_changing` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`hly`@`%` PROCEDURE `apply_stock_in_changing`(cid int, executor int, cmt varchar(200))
BEGIN
     DECLARE EXIT HANDLER FOR SQLEXCEPTION 
         BEGIN
             ROLLBACK;
            resignal;
         END;
     START TRANSACTION;
         insert into repo_item (repo_id, material_id, quantity, price) 
         select * from (
             select c.repo_id, ci.material_id mid, 
             ci.quantity nq, ci.price np 
             from repo_changing_item ci join repo_changing c on ci.repo_changing_id = c.id where c.type = 1 and c.status=1 and ci.repo_changing_id = cid) si
         ON DUPLICATE KEY UPDATE price = round((np * nq + repo_item.quantity * price) / (repo_item.quantity + nq), 2), quantity = round(repo_item.quantity + nq, 3)
         ;
         update repo_changing set status=2, execute_date=now(), keeper=executor, comment=cmt where id=cid;
     COMMIT;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `apply_stock_out_changing` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`hly`@`%` PROCEDURE `apply_stock_out_changing`(cid int, executor INT, cmt varchar(200))
BEGIN
	declare res, count, err int default 0;
	DECLARE done int DEFAULT FALSE;

	declare c cursor for select fulfilled, count(*) from (
select ci.material_id,
	ifnull(repo_item.quantity, 0) quantity,
	ci.quantity require_quantity,
    ifnull(repo_item.quantity >= ci.quantity, 0) fulfilled
from repo_changing_item ci
	join repo_changing c on ci.repo_changing_id = c.id
	left join repo_item on repo_item.repo_id = c.repo_id and repo_item.material_id = ci.material_id
where c.type=-1 and c.status=1
and ci.repo_changing_id = cid
) t group by fulfilled -- where fulfilled is false
;

	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
            resignal;
        END;

	open c;
  read_loop: LOOP
    FETCH c INTO res, count;

    IF done THEN
      LEAVE read_loop;
    END IF;

    if res = 1 and count = 0 then
		set err = 1;
        LEAVE read_loop;
	elseif res = 0 and count > 0 then
		set err = 2;
        LEAVE read_loop;
	end if;

  END LOOP;

  CLOSE c;

  if err = 1 then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid changing id';
  elseif err = 2 then
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'cannot fulfill all item(s)';
	end if;

    -- do it
    START TRANSACTION;

	update repo_item r, repo_changing c, repo_changing_item ci
	set r.quantity = r.quantity - ci.quantity, ci.price = r.price, c.execute_date = now(), c.status = 2, c.keeper = executor, c.comment = cmt
	where r.repo_id = c.repo_id and ci.repo_changing_id = c.id and ci.material_id = r.material_id and c.type=-1 and c.status=1 and c.id = cid;

    COMMIT;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `debug_insert` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`hly`@`%` PROCEDURE `debug_insert`(in p_proc_id varchar(100),in p_debug_info text)
begin
  insert into debug (proc_id,debug_output)
  values (p_proc_id,p_debug_info);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `debug_off` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`hly`@`%` PROCEDURE `debug_off`(in p_proc_id varchar(100))
begin
  call debug_insert(p_proc_id,concat('Debug Ended :',now()));
  -- select debug_output from debug where proc_id = p_proc_id order by line_id;
  -- delete from debug where proc_id = p_proc_id;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `debug_on` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`hly`@`%` PROCEDURE `debug_on`(in p_proc_id varchar(100))
begin
  call debug_insert(p_proc_id,concat('Debug Started :',now()));
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `preview_stock_in_changing` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`hly`@`%` PROCEDURE `preview_stock_in_changing`(cid int)
BEGIN

select *,
	current_quantity * current_price as ct,
	round(in_quantity * in_price, 2) as nt,
	round(current_quantity + in_quantity, 3) as new_quantity,
	round((current_quantity * current_price + in_quantity * in_price) / (current_quantity + in_quantity), 2) as new_price
from (
select c.repo_id, ci.material_id,
ifnull(repo_item.quantity, 0) current_quantity, ifnull(repo_item.price, 0) current_price,
ci.quantity in_quantity, ci.price in_price
from repo_changing_item ci
	join repo_changing c on ci.repo_changing_id = c.id
    left join repo_item on repo_item.repo_id = c.repo_id and repo_item.material_id = ci.material_id
where c.type=1 and c.status=1 and ci.repo_changing_id = cid
) tmp;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `preview_stock_out_changing` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`hly`@`%` PROCEDURE `preview_stock_out_changing`(cid int)
BEGIN

select c.repo_id, ci.material_id,
	ifnull(repo_item.quantity, 0) quantity,
	ci.quantity require_quantity,
    ifnull(repo_item.quantity >= ci.quantity, 0) fulfilled
from repo_changing_item ci
	join repo_changing c on ci.repo_changing_id = c.id
	left join repo_item on repo_item.repo_id = c.repo_id and repo_item.material_id = ci.material_id
where c.type=-1 and c.status=1
and ci.repo_changing_id = cid
;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `rebuild_hs` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`hly`@`%` PROCEDURE `rebuild_hs`()
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        ROLLBACK;
 		SELECT -1;
	END;
    
    
	START TRANSACTION;

	-- UPDATE organization SET hs = null;

	UPDATE organization SET hs=id WHERE parent IS NULL;
	
	label:LOOP 
		UPDATE organization c, organization p SET c.hs = CONCAT(p.hs, "-", c.id)  WHERE c.parent=p.id AND p.hs IS NOT NULL;-- AND c.hs IS NULL;

		SELECT ROW_COUNT() INTO @r;
		IF @r =0 THEN
			 LEAVE label;
		END IF;
	END LOOP;

	COMMIT;
    
    select 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_node_parent` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`hly`@`%` PROCEDURE `update_node_parent`(IN `idx` INT,IN `parentx` INT)
main: BEGIN
	DECLARE oldHs VARCHAR(200);
    DECLARE newHs VARCHAR(200);
        
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
	BEGIN
		ROLLBACK;
		SELECT 0;
	END;
    
   
    SELECT parent INTO @cur_parent FROM organization WHERE id=idx ;
    IF @cur_parent = parentx THEN
		SELECT 1;
		LEAVE main;
    END IF;
    
    SELECT is_child(idx,parentx) INTO @is_child;
    IF @is_child > 0 THEN
      SELECT 0;
      LEAVE main;
	END IF;
    
    IF parentx = idx THEN
		SELECT 0;
        LEAVE main;
	END IF;
    
    
	SET @oldHs = (SELECT o.hs FROM organization o WHERE o.id=idx);
	SET @newHs = CONCAT((SELECT o.hs FROM organization o WHERE o.id=parentx),"-",idx);
	
	START TRANSACTION;

	UPDATE organization o SET o.parent=parentx ,hs=@newHs WHERE o.id=idx;

	
	SET @oldHs=CONCAT(@oldHs,"-");

	UPDATE organization SET hs=CONCAT(@newHs, SUBSTRING(hs, LENGTH(@oldHs))) WHERE LOCATE(@oldHs, hs) = 1;
	
	COMMIT;
	
	SELECT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-18 22:07:14
