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
-- Dumping data for table `bom`
--

LOCK TABLES `bom` WRITE;
/*!40000 ALTER TABLE `bom` DISABLE KEYS */;
/*!40000 ALTER TABLE `bom` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `bom_item`
--

LOCK TABLES `bom_item` WRITE;
/*!40000 ALTER TABLE `bom_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `bom_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'','','','c001','','测试客户',NULL,'测试','','','月结',1);
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `client_type`
--

LOCK TABLES `client_type` WRITE;
/*!40000 ALTER TABLE `client_type` DISABLE KEYS */;
INSERT INTO `client_type` VALUES (1,'五金'),(2,'铝材');
/*!40000 ALTER TABLE `client_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `debug`
--

LOCK TABLES `debug` WRITE;
/*!40000 ALTER TABLE `debug` DISABLE KEYS */;
INSERT INTO `debug` VALUES ('test2_BEFORE_INSERT','Debug Started :2018-06-02 08:42:24',150),('test2_BEFORE_INSERT',NULL,151),('test2_BEFORE_INSERT','parent_hs: 1-4',152),('test2_BEFORE_INSERT',NULL,153),('test2_BEFORE_INSERT','Debug Ended :2018-06-02 08:42:24',154),('test_BEFORE_INSERT','Debug Started :2018-06-02 08:51:45',155),('test_BEFORE_INSERT',NULL,156),('test_BEFORE_INSERT','Debug Ended :2018-06-02 08:51:45',157),('test_BEFORE_INSERT','Debug Started :2018-06-02 08:51:45',158),('test_BEFORE_INSERT',NULL,159),('test_BEFORE_INSERT','Debug Ended :2018-06-02 08:51:45',160),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',161),('organization_BEFORE_UPDATE',NULL,162),('organization_BEFORE_UPDATE','new.hs: 1',163),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',164),('organization_BEFORE_UPDATE',NULL,165),('organization_BEFORE_UPDATE','new.hs: 14',166),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',167),('organization_BEFORE_UPDATE',NULL,168),('organization_BEFORE_UPDATE','new.hs: 15',169),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',170),('organization_BEFORE_UPDATE','parent_hs: 1',171),('organization_BEFORE_UPDATE','new.hs: 1-2',172),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',173),('organization_BEFORE_UPDATE','parent_hs: 1',174),('organization_BEFORE_UPDATE','new.hs: 1-3',175),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',176),('organization_BEFORE_UPDATE','parent_hs: 1',177),('organization_BEFORE_UPDATE','new.hs: 1-4',178),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',179),('organization_BEFORE_UPDATE','parent_hs: 1',180),('organization_BEFORE_UPDATE','new.hs: 1-5',181),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',182),('organization_BEFORE_UPDATE','parent_hs: 1',183),('organization_BEFORE_UPDATE','new.hs: 1-6',184),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',185),('organization_BEFORE_UPDATE','parent_hs: 1',186),('organization_BEFORE_UPDATE','new.hs: 1-7',187),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',188),('organization_BEFORE_UPDATE','parent_hs: 1',189),('organization_BEFORE_UPDATE','new.hs: 1-8',190),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',191),('organization_BEFORE_UPDATE','parent_hs: 1',192),('organization_BEFORE_UPDATE','new.hs: 1-9',193),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',194),('organization_BEFORE_UPDATE','parent_hs: 1-2',195),('organization_BEFORE_UPDATE','new.hs: 1-2-10',196),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',197),('organization_BEFORE_UPDATE','parent_hs: 1-3',198),('organization_BEFORE_UPDATE','new.hs: 1-3-11',199),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',200),('organization_BEFORE_UPDATE','parent_hs: 1-3',201),('organization_BEFORE_UPDATE','new.hs: 1-3-12',202),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',203),('organization_BEFORE_UPDATE','parent_hs: 1-4',204),('organization_BEFORE_UPDATE','new.hs: 1-4-13',205),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',206),('organization_BEFORE_UPDATE','parent_hs: 1',207),('organization_BEFORE_UPDATE','new.hs: 1-2',208),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',209),('organization_BEFORE_UPDATE','parent_hs: 1',210),('organization_BEFORE_UPDATE','new.hs: 1-3',211),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',212),('organization_BEFORE_UPDATE','parent_hs: 1',213),('organization_BEFORE_UPDATE','new.hs: 1-4',214),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',215),('organization_BEFORE_UPDATE','parent_hs: 1',216),('organization_BEFORE_UPDATE','new.hs: 1-5',217),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',218),('organization_BEFORE_UPDATE','parent_hs: 1',219),('organization_BEFORE_UPDATE','new.hs: 1-6',220),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',221),('organization_BEFORE_UPDATE','parent_hs: 1',222),('organization_BEFORE_UPDATE','new.hs: 1-7',223),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',224),('organization_BEFORE_UPDATE','parent_hs: 1',225),('organization_BEFORE_UPDATE','new.hs: 1-8',226),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',227),('organization_BEFORE_UPDATE','parent_hs: 1',228),('organization_BEFORE_UPDATE','new.hs: 1-9',229),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',230),('organization_BEFORE_UPDATE','parent_hs: 1-2',231),('organization_BEFORE_UPDATE','new.hs: 1-2-10',232),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',233),('organization_BEFORE_UPDATE','parent_hs: 1-3',234),('organization_BEFORE_UPDATE','new.hs: 1-3-11',235),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',236),('organization_BEFORE_UPDATE','parent_hs: 1-3',237),('organization_BEFORE_UPDATE','new.hs: 1-3-12',238),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:03:43',239),('organization_BEFORE_UPDATE','parent_hs: 1-4',240),('organization_BEFORE_UPDATE','new.hs: 1-4-13',241),('organization_BEFORE_INSERT','Debug Started :2018-06-02 09:09:09',242),('organization_BEFORE_INSERT','auto_id: 1',243),('organization_BEFORE_INSERT','parent_hs: 1-4',244),('organization_BEFORE_INSERT','new.hs: 1-4-1',245),('organization_BEFORE_INSERT','Debug Ended :2018-06-02 09:09:09',246),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',247),('organization_BEFORE_UPDATE',NULL,248),('organization_BEFORE_UPDATE','new.hs: 1',249),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',250),('organization_BEFORE_UPDATE','parent_hs: 1',251),('organization_BEFORE_UPDATE','new.hs: 1-2',252),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',253),('organization_BEFORE_UPDATE','parent_hs: 1',254),('organization_BEFORE_UPDATE','new.hs: 1-3',255),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',256),('organization_BEFORE_UPDATE','parent_hs: 1',257),('organization_BEFORE_UPDATE','new.hs: 1-4',258),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',259),('organization_BEFORE_UPDATE','parent_hs: 1',260),('organization_BEFORE_UPDATE','new.hs: 1-5',261),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',262),('organization_BEFORE_UPDATE','parent_hs: 1',263),('organization_BEFORE_UPDATE','new.hs: 1-6',264),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',265),('organization_BEFORE_UPDATE','parent_hs: 1',266),('organization_BEFORE_UPDATE','new.hs: 1-7',267),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',268),('organization_BEFORE_UPDATE','parent_hs: 1',269),('organization_BEFORE_UPDATE','new.hs: 1-8',270),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',271),('organization_BEFORE_UPDATE','parent_hs: 1',272),('organization_BEFORE_UPDATE','new.hs: 1-9',273),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',274),('organization_BEFORE_UPDATE','parent_hs: 1-2',275),('organization_BEFORE_UPDATE','new.hs: 1-2-10',276),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',277),('organization_BEFORE_UPDATE','parent_hs: 1-3',278),('organization_BEFORE_UPDATE','new.hs: 1-3-11',279),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',280),('organization_BEFORE_UPDATE','parent_hs: 1-3',281),('organization_BEFORE_UPDATE','new.hs: 1-3-12',282),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',283),('organization_BEFORE_UPDATE','parent_hs: 1-4',284),('organization_BEFORE_UPDATE','new.hs: 1-4-13',285),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',286),('organization_BEFORE_UPDATE','parent_hs: 1-4',287),('organization_BEFORE_UPDATE','new.hs: 1-4-16',288),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',289),('organization_BEFORE_UPDATE','parent_hs: 1-5',290),('organization_BEFORE_UPDATE','new.hs: 1-5-17',291),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',292),('organization_BEFORE_UPDATE','parent_hs: 1-6',293),('organization_BEFORE_UPDATE','new.hs: 1-6-18',294),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',295),('organization_BEFORE_UPDATE','parent_hs: 1-7',296),('organization_BEFORE_UPDATE','new.hs: 1-7-19',297),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',298),('organization_BEFORE_UPDATE','parent_hs: 1-8',299),('organization_BEFORE_UPDATE','new.hs: 1-8-20',300),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',301),('organization_BEFORE_UPDATE','parent_hs: 1-9',302),('organization_BEFORE_UPDATE','new.hs: 1-9-21',303),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',304),('organization_BEFORE_UPDATE','parent_hs: 1-8',305),('organization_BEFORE_UPDATE','new.hs: 1-8-22',306),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',307),('organization_BEFORE_UPDATE','parent_hs: 1',308),('organization_BEFORE_UPDATE','new.hs: 1-2',309),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',310),('organization_BEFORE_UPDATE','parent_hs: 1',311),('organization_BEFORE_UPDATE','new.hs: 1-3',312),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',313),('organization_BEFORE_UPDATE','parent_hs: 1',314),('organization_BEFORE_UPDATE','new.hs: 1-4',315),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',316),('organization_BEFORE_UPDATE','parent_hs: 1',317),('organization_BEFORE_UPDATE','new.hs: 1-5',318),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',319),('organization_BEFORE_UPDATE','parent_hs: 1',320),('organization_BEFORE_UPDATE','new.hs: 1-6',321),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',322),('organization_BEFORE_UPDATE','parent_hs: 1',323),('organization_BEFORE_UPDATE','new.hs: 1-7',324),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',325),('organization_BEFORE_UPDATE','parent_hs: 1',326),('organization_BEFORE_UPDATE','new.hs: 1-8',327),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',328),('organization_BEFORE_UPDATE','parent_hs: 1',329),('organization_BEFORE_UPDATE','new.hs: 1-9',330),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',331),('organization_BEFORE_UPDATE','parent_hs: 1-2',332),('organization_BEFORE_UPDATE','new.hs: 1-2-10',333),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',334),('organization_BEFORE_UPDATE','parent_hs: 1-3',335),('organization_BEFORE_UPDATE','new.hs: 1-3-11',336),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',337),('organization_BEFORE_UPDATE','parent_hs: 1-3',338),('organization_BEFORE_UPDATE','new.hs: 1-3-12',339),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',340),('organization_BEFORE_UPDATE','parent_hs: 1-4',341),('organization_BEFORE_UPDATE','new.hs: 1-4-13',342),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',343),('organization_BEFORE_UPDATE','parent_hs: 1-4',344),('organization_BEFORE_UPDATE','new.hs: 1-4-16',345),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',346),('organization_BEFORE_UPDATE','parent_hs: 1-5',347),('organization_BEFORE_UPDATE','new.hs: 1-5-17',348),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',349),('organization_BEFORE_UPDATE','parent_hs: 1-6',350),('organization_BEFORE_UPDATE','new.hs: 1-6-18',351),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',352),('organization_BEFORE_UPDATE','parent_hs: 1-7',353),('organization_BEFORE_UPDATE','new.hs: 1-7-19',354),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',355),('organization_BEFORE_UPDATE','parent_hs: 1-8',356),('organization_BEFORE_UPDATE','new.hs: 1-8-20',357),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',358),('organization_BEFORE_UPDATE','parent_hs: 1-9',359),('organization_BEFORE_UPDATE','new.hs: 1-9-21',360),('organization_BEFORE_UPDATE','Debug Started :2018-06-02 09:37:09',361),('organization_BEFORE_UPDATE','parent_hs: 1-8',362),('organization_BEFORE_UPDATE','new.hs: 1-8-22',363);
/*!40000 ALTER TABLE `debug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `formula`
--

LOCK TABLES `formula` WRITE;
/*!40000 ALTER TABLE `formula` DISABLE KEYS */;
/*!40000 ALTER TABLE `formula` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `formula_item`
--

LOCK TABLES `formula_item` WRITE;
/*!40000 ALTER TABLE `formula_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `formula_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `material`
--

LOCK TABLES `material` WRITE;
/*!40000 ALTER TABLE `material` DISABLE KEYS */;
INSERT INTO `material` VALUES (1,'m-001','',NULL,'色粉2',200,'20kg/p',1),(2,'m-002','',NULL,'色粉3',200,'30kg/p',1),(3,'m-003','',NULL,'黏胶A',100,'10kg/p',2),(4,'m-004','',NULL,'胶B',400,'40kg/p',2);
/*!40000 ALTER TABLE `material` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `material_type`
--

LOCK TABLES `material_type` WRITE;
/*!40000 ALTER TABLE `material_type` DISABLE KEYS */;
INSERT INTO `material_type` VALUES (1,'颜料'),(2,'固化剂'),(3,'测试');
/*!40000 ALTER TABLE `material_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `order`
--

LOCK TABLES `order` WRITE;
/*!40000 ALTER TABLE `order` DISABLE KEYS */;
INSERT INTO `order` VALUES (1,NULL,'测试','2018-05-30 19:00:00',NULL,'o-001','2018-05-26 19:00:00',0,'\0',1100,1),(2,NULL,'test','2018-05-30 19:00:00',NULL,'o-002','2018-05-26 19:00:00',0,'\0',14,1),(3,NULL,'test again','2018-05-29 19:00:00',NULL,'o-003','2018-05-25 19:00:00',0,'',30,1);
/*!40000 ALTER TABLE `order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `order_item`
--

LOCK TABLES `order_item` WRITE;
/*!40000 ALTER TABLE `order_item` DISABLE KEYS */;
INSERT INTO `order_item` VALUES (NULL,22,11,1,1),(NULL,40,20,1,2),(NULL,2,1,2,1),(NULL,4,3,2,2),(NULL,6,5,3,2);
/*!40000 ALTER TABLE `order_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `org`
--

LOCK TABLES `org` WRITE;
/*!40000 ALTER TABLE `org` DISABLE KEYS */;
INSERT INTO `org` VALUES (1,'华丽雅粉末科技有限公司',NULL),(2,'总经办',NULL),(3,'行政财务部',NULL),(4,'销售部',NULL),(5,'质量技术部',NULL),(6,'工艺技术部',NULL),(7,'产品技术部',NULL),(8,'生产制造部',NULL),(9,'供应链管理部',NULL);
/*!40000 ALTER TABLE `org` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `organization`
--

LOCK TABLES `organization` WRITE;
/*!40000 ALTER TABLE `organization` DISABLE KEYS */;
INSERT INTO `organization` VALUES (1,NULL,0,'1',NULL),(2,1,0,'1-2',NULL),(3,1,0,'1-3',NULL),(4,1,0,'1-4',NULL),(5,1,0,'1-5',NULL),(6,1,0,'1-6',NULL),(7,1,0,'1-7',NULL),(8,1,0,'1-8',NULL),(9,1,0,'1-9',NULL),(10,2,1,'1-2-10',NULL),(11,3,1,'1-3-11',NULL),(12,3,1,'1-3-12',NULL),(13,4,1,'1-4-13',NULL),(16,4,1,'1-4-16',NULL),(17,5,1,'1-5-17',NULL),(18,6,1,'1-6-18','{\"pwd\": \"f6a0f9a82944f338abe0244a4add7d02\", \"name\": \"汤确军\", \"phone\": \"13928771916\", \"title\": \"经理\"}'),(19,7,1,'1-7-19','{\"pwd\": \"82b4af7b80b04248821a5d4325f5248d\", \"name\": \"黄应通\", \"phone\": \"13531347949\", \"title\": \"经理\"}'),(20,8,1,'1-8-20','{\"pwd\": \"8464e6f8f1d9ac9f6bed378b75e12e6c\", \"name\": \"陈锦海\", \"phone\": \"13536620289\", \"title\": \"厂长\"}'),(21,9,1,'1-9-21','{\"pwd\": \"391c3a0cc268dec6e1db3e31c591a67a\", \"name\": \"邱谷娣\", \"phone\": \"15917885784\", \"title\": \"文员\"}'),(22,8,1,'1-8-22','{\"pwd\": \"7db072ab3abd8686b7959c52ba127397\", \"name\": \"吴国才\", \"phone\": \"18873798055\", \"title\": \"挤出班长\"}');
/*!40000 ALTER TABLE `organization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `privilege`
--

LOCK TABLES `privilege` WRITE;
/*!40000 ALTER TABLE `privilege` DISABLE KEYS */;
INSERT INTO `privilege` VALUES (1,'system:basic-data:read','基础数据管理',0,'如：客户类型、材料分类等'),(2,'system:user-management:read','用户管理',0,'包括：组织结构、用户、角色、权限管理'),(3,'sales:client:read','客户管理',0,NULL),(4,'sales:order:read','订单管理',0,NULL),(5,'production:material:read','物料数据',0,NULL),(6,'production:product:read','产品',0,NULL),(7,'production:bom:read','BOM单',0,NULL),(8,'production:formula:read','产品配方',0,NULL),(9,'repo:stock-in:read','入库单',0,NULL),(10,'repo:stock-out:read','出库单',0,NULL),(11,'repo:inventory:read','库存盘点',0,NULL),(12,'purchasing:plan:read','采购计划',0,NULL),(14,'system:basic-data','基础数据管理 (可写)',0,'如：客户类型、材料分类等'),(15,'system:user-management','用户管理 (可写)',0,'包括：组织结构、用户、角色、权限管理'),(16,'sales:client','客户管理 (可写)',0,NULL),(17,'sales:order','订单管理 (可写)',0,NULL),(18,'production:material','物料数据 (可写)',0,NULL),(19,'production:product','产品 (可写)',0,NULL),(20,'production:bom','BOM单 (可写)',0,NULL),(21,'production:formula','产品配方 (可写)',0,NULL),(22,'repo:stock-in','入库单 (可写)',0,NULL),(23,'repo:stock-out','出库单 (可写)',0,NULL),(24,'repo:inventory','库存盘点 (可写)',0,NULL),(25,'purchasing:plan','采购计划 (可写)',0,NULL);
/*!40000 ALTER TABLE `privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `produce_condition`
--

LOCK TABLES `produce_condition` WRITE;
/*!40000 ALTER TABLE `produce_condition` DISABLE KEYS */;
/*!40000 ALTER TABLE `produce_condition` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,'铝合金','p001','红','',NULL),(2,'塑料','p002','白','',NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `repo`
--

LOCK TABLES `repo` WRITE;
/*!40000 ALTER TABLE `repo` DISABLE KEYS */;
INSERT INTO `repo` VALUES (1,'鹤山材料仓',0,NULL),(2,'鹤山成品仓',1,NULL);
/*!40000 ALTER TABLE `repo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `repo_changing`
--

LOCK TABLES `repo_changing` WRITE;
/*!40000 ALTER TABLE `repo_changing` DISABLE KEYS */;
INSERT INTO `repo_changing` VALUES (1,1,1,0,'2018-05-26 18:48:58',NULL,10,2,NULL,NULL,'test',0,0,0,NULL,NULL,NULL),(2,1,1,0,'2018-05-26 19:01:27',NULL,10,1,NULL,NULL,'d',0,0,0,NULL,NULL,NULL),(3,2,1,2,'2018-05-26 19:06:48','2018-05-26 11:00:00',10,4,'t',NULL,'d',0,0,0,21,'2018-06-10 10:07:25',''),(4,1,1,0,'2018-06-09 16:05:06',NULL,10,3,'过期',NULL,NULL,0,0,0,NULL,NULL,NULL),(5,1,1,0,'2018-06-09 16:29:34',NULL,10,3,'dk',NULL,NULL,0,0,0,NULL,NULL,NULL),(6,1,-1,1,'2018-06-09 16:44:36','2018-06-09 11:00:00',10,5,'生产',3,NULL,0,0,0,NULL,NULL,NULL),(7,2,-1,2,'2018-06-09 18:37:13','2018-06-09 11:00:00',10,6,'测试',NULL,NULL,0,0,0,21,'2018-06-10 10:08:28','');
/*!40000 ALTER TABLE `repo_changing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `repo_changing_item`
--

LOCK TABLES `repo_changing_item` WRITE;
/*!40000 ALTER TABLE `repo_changing_item` DISABLE KEYS */;
INSERT INTO `repo_changing_item` VALUES (2,3,1,0,2),(3,2,3,0,4),(5,3,1,0,2),(5,4,3,0,4),(6,3,3,0,0),(6,4,2,0,0),(7,2,3.4,0,4);
/*!40000 ALTER TABLE `repo_changing_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `repo_changing_reason`
--

LOCK TABLES `repo_changing_reason` WRITE;
/*!40000 ALTER TABLE `repo_changing_reason` DISABLE KEYS */;
INSERT INTO `repo_changing_reason` VALUES (1,0,1,'采购入库',0),(2,0,1,'盘盈',0),(3,0,1,'过期转入',0),(4,0,1,'其他仓库调入',0),(5,0,-1,'生产领用',1),(6,0,-1,'打板领用',0),(7,0,-1,'车间辅助生产领用',0),(8,0,-1,'盘亏',0),(9,0,-1,'过期转出',0);
/*!40000 ALTER TABLE `repo_changing_reason` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `repo_history`
--

LOCK TABLES `repo_history` WRITE;
/*!40000 ALTER TABLE `repo_history` DISABLE KEYS */;
/*!40000 ALTER TABLE `repo_history` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `repo_item`
--

LOCK TABLES `repo_item` WRITE;
/*!40000 ALTER TABLE `repo_item` DISABLE KEYS */;
INSERT INTO `repo_item` VALUES (1,2,10,3),(2,2,1.4,4);
/*!40000 ALTER TABLE `repo_item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'admin','系统管理员',0,NULL),(2,'general-manager','总经理',0,NULL),(3,'repo-keeper','仓库管理员',0,NULL),(8,'product-manager','产品经理',0,NULL),(9,'sales-manager','销售经理',0,NULL),(10,'producing-manager','生产主管',0,NULL),(11,'process-manager','工艺经理',0,NULL),(12,'financial-manager','财务主管',0,''),(13,'employee','员工',0,'公司员工');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `role_privilege`
--

LOCK TABLES `role_privilege` WRITE;
/*!40000 ALTER TABLE `role_privilege` DISABLE KEYS */;
INSERT INTO `role_privilege` VALUES (1,1),(10,1),(13,1),(1,2),(2,3),(9,3),(2,4),(9,4),(10,5),(13,5),(8,6),(10,6),(13,6),(10,7),(10,8),(3,9),(13,9),(3,10),(13,10),(3,11),(1,14),(1,15),(9,16),(9,17),(8,19),(13,22),(13,23),(3,24);
/*!40000 ALTER TABLE `role_privilege` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `test`
--

LOCK TABLES `test` WRITE;
/*!40000 ALTER TABLE `test` DISABLE KEYS */;
INSERT INTO `test` VALUES (1,'a'),(2,'b');
/*!40000 ALTER TABLE `test` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `test2`
--

LOCK TABLES `test2` WRITE;
/*!40000 ALTER TABLE `test2` DISABLE KEYS */;
INSERT INTO `test2` VALUES (1,NULL,0,NULL),(2,NULL,0,NULL);
/*!40000 ALTER TABLE `test2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (10,'李立新',NULL,'13926053858','701b3815ba65412590ac77ef2978ff8c',0,NULL),(11,'范玲艳',NULL,'18988524905','d824f69ef4b8bb4e70f3d303f403f3b2',0,NULL),(12,'文海燕',NULL,'13630401067','9ce1a633deb4db6abf97c29ca76f99e8',0,NULL),(13,'陈慧',NULL,'13928550268','8464e6f8f1d9ac9f6bed378b75e12e6c',0,NULL),(16,'曹杰峰',NULL,'13928600337','1a7c29d399c29e4202dc76204c2a8ec3',0,NULL),(17,'刘伟纯',NULL,'13660989300','f0122e8f067f03ad2c8cc946d2bf7199',0,NULL),(18,'汤确军',NULL,'13928771916','f6a0f9a82944f338abe0244a4add7d02',0,NULL),(19,'黄应通',NULL,'13531347949','82b4af7b80b04248821a5d4325f5248d',0,NULL),(20,'陈锦海',NULL,'13536620289','8464e6f8f1d9ac9f6bed378b75e12e6c',0,NULL),(21,'邱谷娣',NULL,'15917885784','391c3a0cc268dec6e1db3e31c591a67a',0,NULL),(22,'吴国才',NULL,'18873798055','7db072ab3abd8686b7959c52ba127397',0,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `user_role`
--

LOCK TABLES `user_role` WRITE;
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` VALUES (10,1),(10,2),(21,3),(19,8),(18,10),(20,10),(18,11),(10,13),(20,13),(21,13),(22,13);
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;
UNLOCK TABLES;
