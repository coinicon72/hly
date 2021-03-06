-- 2018-5-26


----
--alter table `repo` rename to `repo_item`;
--
--
----
--CREATE TABLE `repo` (
--  `id` int(11) NOT NULL AUTO_INCREMENT,
--  `name` varchar(50) NOT NULL,
--  `type` tinyint(4) NOT NULL COMMENT '0 = material, 1=product',
--  `comment` varchar(200) DEFAULT NULL,
--  PRIMARY KEY (`id`),
--  UNIQUE KEY `name` (`name`)
--) COMMENT='仓库';
--
--
----
--ALTER TABLE `repo_item`
--ADD COLUMN `repo_id` INT(11) NOT NULL FIRST,
--DROP PRIMARY KEY,
--ADD PRIMARY KEY (`repo_id`, `material_id`),
--ADD INDEX `fk_repo_item_repo` (`repo_id` ASC);
--
--ALTER TABLE `repo_item`
--ADD CONSTRAINT `fk_repo_item_repo`
--  FOREIGN KEY (`repo_id`)
--  REFERENCES `repo` (`id`)
--;
--
--
----
--CREATE TABLE `repo_changing_reason` (
--  `id` int(11) NOT NULL AUTO_INCREMENT,
--  `type` tinyint(4) NOT NULL COMMENT '1 = stock-in; -1 = stock-out',
--  `reason` varchar(50) NOT NULL,
--  `order_related` tinyint(4) NOT NULL DEFAULT 0,
--  PRIMARY KEY (`id`)
--);
--
--
----
--ALTER TABLE `repo_changing`
--ADD COLUMN `repo_id` INT NOT NULL AFTER `id`,
--ADD COLUMN `order_id` BIGINT NULL AFTER `application`,
--ADD COLUMN `reason_id` INT NULL COMMENT 'null = custom reason' AFTER `applicant`,
--CHANGE COLUMN `application` `reason_detail` VARCHAR(200) NULL DEFAULT NULL ,
--CHANGE COLUMN `apply_date` `applying_date` TIMESTAMP NULL DEFAULT NULL,
--ADD COLUMN `vat` FLOAT UNSIGNED NULL DEFAULT 0 COMMENT '增值税税率，0即意味着不含税, 0.03 = 3%' AFTER `department`,
--ADD COLUMN `vat_inclusive_value` FLOAT UNSIGNED NULL COMMENT '含增值税的金额' AFTER `vat`,
--CHANGE COLUMN `amount` `value` FLOAT UNSIGNED NULL DEFAULT NULL COMMENT '不含增值税的总额。\nvalue = value_with_vat / 1 + vat' ,
--ADD INDEX `fk_repo_changing_repo_idx` (`repo_id` ASC),
--ADD INDEX `fk_repo_changing_order_idx` (`order_id` ASC),
--ADD INDEX `fk_repo_changing_reason_idx` (`reason_id` ASC);
--
--ALTER TABLE `repo_changing`
--ADD CONSTRAINT `fk_repo_changing_repo`
--  FOREIGN KEY (`repo_id`)
--  REFERENCES `repo` (`id`),
--ADD CONSTRAINT `fk_repo_changing_order`
--  FOREIGN KEY (`order_id`)
--  REFERENCES `order` (`id`),
--ADD CONSTRAINT `fk_repo_changing_reason`
--  FOREIGN KEY (`reason_id`)
--  REFERENCES `repo_changing_reason` (`id`)
--  ON DELETE SET NULL
--;
--
--
----
--ALTER TABLE `repo_changing_item`
--CHANGE COLUMN `price` `price` FLOAT UNSIGNED NOT NULL COMMENT 'vat excluded price. price = vat_inclusive_price / (1 + repo_changing.vat)' ,
--ADD COLUMN `vat_inclusive_price` FLOAT UNSIGNED NOT NULL AFTER `quantity`;


--DROP TRIGGER IF EXISTS `repo_changing_BEFORE_INSERT`;
--
--DELIMITER $$
--CREATE TRIGGER `repo_changing_BEFORE_INSERT` BEFORE INSERT ON `repo_changing` FOR EACH ROW
--BEGIN
--	set new.value = new.vat_inclusive_value / (1 + new.vat);
--END$$
--DELIMITER ;
--
--DROP TRIGGER IF EXISTS `repo_changing_BEFORE_UPDATE`;
--
--DELIMITER $$
--CREATE TRIGGER `repo_changing_BEFORE_UPDATE` BEFORE UPDATE ON `repo_changing` FOR EACH ROW
--BEGIN
--	set new.value = new.vat_inclusive_value / (1 + new.vat);
--END$$
--DELIMITER ;



--ALTER TABLE `repo_changing`
--CHANGE COLUMN `applicant` `applicant` INT NOT NULL ,
--CHANGE COLUMN `keeper` `keeper` INT NULL DEFAULT NULL ,
--ADD INDEX `fk_repo_changing_user_idx` (`applicant` ASC),
--ADD INDEX `fk_repo_changing_keeper_user_idx` (`keeper` ASC);
--ALTER TABLE `repo_changing`
--ADD CONSTRAINT `fk_repo_changing_user`
--  FOREIGN KEY (`applicant`)
--  REFERENCES `user` (`id`)
--  ON DELETE RESTRICT,
--ADD CONSTRAINT `fk_repo_changing_keeper_user`
--  FOREIGN KEY (`keeper`)
--  REFERENCES `user` (`id`)
--  ON DELETE RESTRICT
-- ;



--ALTER TABLE `hly`.`material`
--ADD COLUMN `category` TINYINT(4) NOT NULL DEFAULT '0' COMMENT '0=物料;1=成品' ;


select 1;