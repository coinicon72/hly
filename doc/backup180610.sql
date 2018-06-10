CREATE DATABASE  IF NOT EXISTS `hly` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `hly`;
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
  `type_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_dvc457p6ww41n1b9vs12e9f36` (`code`),
  KEY `fk_material_type` (`type_id`),
  CONSTRAINT `fk_material_type` FOREIGN KEY (`type_id`) REFERENCES `material_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

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

-- Dump completed on 2018-06-10 22:31:58
