--create table bom (
--	id bigint not null auto_increment,
--	create_date datetime default now() not null,
--	formula_id bigint,
--	order_id bigint,
--	product_id bigint,
--	primary key (id));
--
--create table bom_item (
--	calc_quantity float not null,
--	quantity float not null,
--	bom_id bigint not null,
--	material_id bigint not null,
--	primary key (bom_id, material_id));
--
--create table client (
--	id bigint not null auto_increment,
--	address varchar(200),
--	comment varchar(255),
--	contact varchar(30),
--	contract_no varchar(50) not null,
--	delivery_address varchar(200),
--	full_name varchar(100),
--	metadata varchar(500),
--	name varchar(50) not null,
--	phone varchar(30),
--	post_code varchar(6),
--	settlement_policy varchar(100),
--	type_id bigint,
--	primary key (id));
--
--create table client_type (
--	id bigint not null auto_increment,
--	name varchar(50) not null,
--	primary key (id));
--
--create table formula (
--	id bigint not null auto_increment,
--	change_log varchar(200),
--	comment varchar(255),
--	create_date datetime not null,
--	metadata varchar(500),
--	revision integer not null,
--	product_id bigint,
--	primary key (id));
--
--create table formula_item (
--	quantity float not null,
--	formula_id bigint not null,
--	material_id bigint not null,
--	primary key (formula_id, material_id));
--
--create table material (
--	id bigint not null auto_increment,
--	code varchar(20),
--	comment varchar(255),
--	metadata varchar(500),
--	name varchar(50) not null,
--	safe_quantity float not null,
-- 	spec varchar(20) null,
--  `category` TINYINT NOT NULL DEFAULT 0 COMMENT '0=物料;1=成品',
--	type_id bigint not null,
--	primary key (id));
--
--create table material_type (
--	id bigint not null auto_increment,
--	name varchar(50) not null,
--	primary key (id));
--
--create table `order` (
--	id bigint not null auto_increment,
--	actual_value float,
--	comment varchar(255),
--	delivery_date datetime not null,
--	metadata varchar(500),
--	no varchar(20) not null,
--	order_date datetime not null,
--	status tinyint default 0 not null,
--	tax bit not null,
--	value float not null,
--	client_id bigint not null,
--	primary key (id));
--
--create table order_item (
--	actual_quantity float,
--	price float not null,
--	quantity float not null,
--	`order_id` bigint not null,
--	product_id bigint not null,
--	primary key (`order_id`, product_id));
--
--create table produce_condition (
--	input_temperature integer not null,
--	main_miller_rpm integer not null,
--	mesh integer not null,
--	mix_time integer not null,
--	output_temperature integer not null,
--	screw_rpm integer not null,
--	second_miller_rpm integer not null,
--	formula_id bigint not null,
--	primary key (formula_id));
--
--create table product (
--	id bigint not null auto_increment,
--	base varchar(50),
--	code varchar(20) not null,
--	color varchar(20),
--	comment varchar(255),
--	metadata varchar(500),
--	primary key (id));
--
--
--alter table client add constraint UK_923db0lpkwf1yl7ff5hnfvt7w unique (contract_no);
--
--alter table formula add constraint uniq_formula_revision unique (product_id, revision);
--
--alter table material add constraint UK_dvc457p6ww41n1b9vs12e9f36 unique (code);
--
--alter table `order` add constraint UK_e8399sgf6y62t04adtfm5e2ia unique (no);
--
--alter table product add constraint UK_h3w5r1mx6d0e5c6um32dgyjej unique (code);
--
--alter table bom add constraint fk_bom_formula_id foreign key (formula_id) references formula (id);
--
--alter table bom add constraint FKpl04bpbc2t75bmdqmhuectmpr foreign key (order_id, product_id) references order_item (`order_id`, product_id);
--
--alter table bom_item add constraint fk_bom_item_bom foreign key (bom_id) references bom (id) ON DELETE CASCADE;
--
--alter table bom_item add constraint fk_bom_material foreign key (material_id) references material (id);
--
--alter table client add constraint fk_client_type foreign key (type_id) references client_type (id);
--
--alter table formula add constraint fk_formula_rev_product foreign key (product_id) references product (id);
--
--alter table formula_item add constraint fk_formula_item_formula foreign key (formula_id) references formula (id) ON DELETE CASCADE;
--
--alter table formula_item add constraint fk_formula_item_material foreign key (material_id) references material (id);
--
--alter table material add constraint fk_material_type foreign key (type_id) references material_type (id);
--
--alter table `order` add constraint fk_client_order foreign key (client_id) references client (id);
--
--alter table order_item add constraint fk_order_item_order foreign key (`order_id`) references `order` (id) ON DELETE CASCADE;
--
--alter table order_item add constraint fk_order_item_product foreign key (product_id) references product (id);
--
--alter table produce_condition add constraint fk_formula_produce_cond foreign key (formula_id) references formula (id) ON DELETE CASCADE;


--CREATE TABLE `purchasing_order` (
--  `id` int(11) NOT NULL AUTO_INCREMENT,
--  `no` varchar(50) NOT NULL COMMENT 'order no',
--  `date` timestamp NOT NULL,
--  `tax` tinyint(4) NOT NULL COMMENT '1 = tax inclusive; 0 = tax exclusive',
--  `vat` float unsigned NULL DEFAULT 0,
--  `supplier` varchar(100) NOT NULL,
--  `signer` int(11) NOT NULL,
--  `comment` varchar(200) DEFAULT NULL,
--  PRIMARY KEY (`id`),
--  UNIQUE KEY `no_UNIQUE` (`no`),
--  CONSTRAINT `fk_purchasing_order_signer` FOREIGN KEY (`signer`) REFERENCES `user` (`id`)
--);
--
--CREATE TABLE `purchasing_order_item` (
--  `purchasing_order_id` int(11) NOT NULL,
--  `material_id` bigint(20) NOT NULL,
--  `quantity` float unsigned NOT NULL,
--  `vip` float unsigned NOT NULL,
--  `vat` float unsigned NOT NULL DEFAULT 0,
--  `vep` float unsigned NOT NULL COMMENT 'vat excluded price. vep = vip / (1 + vat)',
--  PRIMARY KEY (`purchasing_order_id`,`material_id`),
--  KEY `fk_purchasing_order_material` (`material_id`),
--  CONSTRAINT `fk_purchasing_order_item_purchasing_order` FOREIGN KEY (`purchasing_order_id`) REFERENCES `purchasing_order` (`id`),
--  CONSTRAINT `fk_purchasing_order_material` FOREIGN KEY (`material_id`) REFERENCES `material` (`id`)
--) COMMENT='采购单条目';


--CREATE TABLE `repo` (
--  `id` int(11) NOT NULL AUTO_INCREMENT,
--  `name` varchar(50) NOT NULL,
--  `type` tinyint(4) NOT NULL COMMENT '0 = material, 1=product',
--  `comment` varchar(200) DEFAULT NULL,
--  PRIMARY KEY (`id`),
--  UNIQUE KEY `name` (`name`)
--) COMMENT='仓库';


--CREATE TABLE `repo_item` (
--  `repo_id` int NOT NULL,
--  `material_id` bigint(20) NOT NULL,
--  `quantity` float UNSIGNED NOT NULL,
--  `price` float UNSIGNED NOT NULL,
--  PRIMARY KEY (`repo_id`, `material_id`),
--  CONSTRAINT `fk_repo_item_repo` FOREIGN KEY (`repo_id`) REFERENCES `repo` (`id`)
--  CONSTRAINT `fk_repo_item_material` FOREIGN KEY (`material_id`) REFERENCES `material` (`id`)
--) COMMENT='库存';
--
--CREATE TABLE `inventory` (
--  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
--  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
--  `comment` varchar(200) DEFAULT NULL,
--  PRIMARY KEY (`id`)
--) COMMENT='盘点';
--
--CREATE TABLE `repo_history` (
--  `inventory_id` int(10) unsigned NOT NULL,
--  `material_id` bigint(20) NOT NULL,
--  `quantity` float NOT NULL,
--  `price` float NOT NULL,
--  PRIMARY KEY (`inventory_id`,`material_id`),
--  CONSTRAINT `fk_repo_history_inventory` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`id`),
--  CONSTRAINT `fk_repo_history_material` FOREIGN KEY (`material_id`) REFERENCES `material` (`id`)
--) COMMENT='库存历史';
--
--CREATE TABLE `repo_changing` (
--  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
--  `repo_id` INT NOT NULL,
--  `type` tinyint(4) NOT NULL default 0 COMMENT '1 = stock-in, 入库\n-1 = stock-out, 出库\n0 = inventory, 盘点',
--  `status` tinyint(4) NOT NULL default 0 COMMENT '0 = init; 1 = submitted; 2 = executed; -1 = rejected',
--  `create_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
--  `applying_date` timestamp NULL,
--  `applicant` INT NOT NULL,
--  `reason_id` INT NULL COMMENT 'null = custom reason',
--  `reason_detail` VARCHAR(200) NULL DEFAULT NULL ,
--  `department` varchar(50) null DEFAULT NULL,
--  `vat` FLOAT UNSIGNED NULL DEFAULT 0 COMMENT '增值税税率，0即意味着不含税, 0.03 = 3%',
--  `vat_ inclusive_value` FLOAT UNSIGNED NULL COMMENT '含增值税的金额',
--  `value` FLOAT UNSIGNED NULL DEFAULT NULL COMMENT '不含增值税的总额。value = value_with_vat / 1 + vat' ,
--  `keeper` INT NULL,
--  `execute_date` timestamp null,
--  `comment` varchar(200) default null,
--  PRIMARY KEY (`id`),
--  CONSTRAINT `fk_repo_changing_repo` FOREIGN KEY (`repo_id`) REFERENCES `repo` (`id`),
--  CONSTRAINT `fk_repo_changing_order` FOREIGN KEY (`order_id`) REFERENCES `order` (`id`),
--  CONSTRAINT `fk_repo_changing_reason` FOREIGN KEY (`reason_id`) REFERENCES `repo_changing_reason` (`id`) ON DELETE SET NULL,
--  CONSTRAINT `fk_repo_changing_user` FOREIGN KEY (`applicant`) REFERENCES `user` (`id`) ON DELETE RESTRICT,
--  CONSTRAINT `fk_repo_changing_keeper_user` FOREIGN KEY (`keeper`) REFERENCES `user` (`id`) ON DELETE RESTRICT
--) COMMENT='库存变化';
--
--CREATE TABLE `repo_changing_item` (
--  `repo_changing_id` int(10) unsigned NOT NULL,
--  `material_id` bigint(20) NOT NULL,
--  `quantity` float unsigned NOT NULL,
--  `price` float UNSIGNED NOT NULL COMMENT 'vat excluded price. price = vat_inclusive_price / (1 + repo_changing.vat)' ,
--  `vat_inclusive_price` FLOAT UNSIGNED NOT NULL,
--  PRIMARY KEY (`repo_changing_id`, `material_id`),
--  CONSTRAINT `fk_repo_changing_item_repo_changing` FOREIGN KEY (`repo_changing_id`) REFERENCES `repo_changing` (`id`),
--  CONSTRAINT `fk_repo_changing_material` FOREIGN KEY (`material_id`) REFERENCES `material` (`id`)
--) COMMENT='库存变化条目';



--DELIMITER $$
--CREATE PROCEDURE `preview_stock_in_changing`(cid int)
--BEGIN
--
--select *,
--	current_quantity * current_price as ct,
--	round(in_quantity * in_price, 2) as nt,
--	round(current_quantity + in_quantity, 3) as new_quantity,
--	round((current_quantity * current_price + in_quantity * in_price) / (current_quantity + in_quantity), 2) as new_price
--from (
--select c.repo_id, ci.material_id,
--ifnull(repo.quantity, 0) current_quantity, ifnull(repo_item.price, 0) current_price,
--ci.quantity in_quantity, ci.price in_price
--from repo_changing_item ci
--	join repo_changing c on ci.repo_changing_id = c.id
--    left join repo on repo_item.repo_id = c.repo_id and repo_item.material_id = ci.material_id
--where c.type=1 and c.status=1 and ci.repo_changing_id = cid
--) tmp;
--
--END$$
--DELIMITER ;


--DELIMITER $$
--CREATE PROCEDURE `preview_stock_out_changing`(cid int)
--BEGIN
--
--select c.repo_id, ci.material_id,
--	ifnull(repo_item.quantity, 0) quantity,
--	ci.quantity require_quantity,
--    ifnull(repo_item.quantity >= ci.quantity, 0) fulfilled
--from repo_changing_item ci
--	join repo_changing c on ci.repo_changing_id = c.id
--	left join repo_item on repo_item.repo_id = c.repo_id and repo_item.material_id = ci.material_id
--where c.type=-1 and c.status=1
--and ci.repo_changing_id = cid
--;
--
--END$$
--DELIMITER ;


-- DELIMITER $$
--CREATE PROCEDURE `apply_stock_in_changing`(cid int, executor int, cmt varchar(200))
--BEGIN
--
--     DECLARE EXIT HANDLER FOR SQLEXCEPTION
--         BEGIN
--             ROLLBACK;
--            resignal;
--         END;
--
--     START TRANSACTION;
--         insert into repo_item (repo_id, material_id, quantity, price)
--         select * from (
--             select c.repo_id, ci.material_id mid,
--             ci.quantity nq, ci.price np
--             from repo_changing_item ci join repo_changing c on ci.repo_changing_id = c.id where c.type = 1 and c.status=1 and ci.repo_changing_id = cid) si
--         ON DUPLICATE KEY UPDATE price = round((np * nq + repo_item.quantity * price) / (repo_item.quantity + nq), 2), quantity = round(repo_item.quantity + nq, 3)
--         ;

--         update repo_changing set status=2, execute_date=now(), keeper=executor, comment=cmt where id=cid;
--     COMMIT;
-- END$$
-- DELIMITER ;


--DELIMITER $$
--CREATE PROCEDURE `apply_stock_out_changing`(cid int, executor INT, cmt varchar(200))
--BEGIN
--	declare res, count, err int default 0;
--	DECLARE done int DEFAULT FALSE;
--
--	declare c cursor for select fulfilled, count(*) from (
--        select ci.material_id,
--            ifnull(repo_item.quantity, 0) quantity,
--            ci.quantity require_quantity,
--            ifnull(repo_item.quantity >= ci.quantity, 0) fulfilled
--        from repo_changing_item ci
--            join repo_changing c on ci.repo_changing_id = c.id
--            left join repo_item on repo_item.repo_id = c.repo_id and repo_item.material_id = ci.material_id
--        where c.type=-1 and c.status=1
--        and ci.repo_changing_id = cid
--        ) t group by fulfilled -- where fulfilled is false
--    ;
--
--	DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
--
--    DECLARE EXIT HANDLER FOR SQLEXCEPTION
--        BEGIN
--            ROLLBACK;
--            resignal;
--        END;
--
--	open c;
--  read_loop: LOOP
--    FETCH c INTO res, count;
--
--    IF done THEN
--      LEAVE read_loop;
--    END IF;
--
--    if res = 1 and count = 0 then
--		set err = 1;
--        LEAVE read_loop;
--	elseif res = 0 and count > 0 then
--		set err = 2;
--        LEAVE read_loop;
--	end if;
--
--  END LOOP;
--
--  CLOSE c;
--
--  if err = 1 then
--		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid changing id';
--  elseif err = 2 then
--		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'cannot fulfill all item(s)';
--	end if;
--
--    -- do it
--    START TRANSACTION;
--
--	update repo_item r, repo_changing c, repo_changing_item ci
--	set r.quantity = r.quantity - ci.quantity, ci.price = r.price, c.execute_date = now(), c.status = 2, c.keeper = executor, c.comment = cmt
--	where r.repo_id = c.repo_id and ci.repo_changing_id = c.id and ci.material_id = r.material_id and c.type=-1 and c.status=1 and c.id = cid;
--
--    COMMIT;
--
--END$$
--DELIMITER ;


--CREATE TABLE `repo_changing_reason` (
--  `id` int(11) NOT NULL AUTO_INCREMENT,
--  `type` tinyint(4) NOT NULL COMMENT '1 = stock-in; -1 = stock-out',
--  `reason` varchar(50) NOT NULL,
--  `order_related` tinyint(4) NOT NULL DEFAULT 0,
--  PRIMARY KEY (`id`)
--);


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


--CREATE TABLE `organization` (
--  `id` INT NOT NULL AUTO_INCREMENT,
--  `parent` INT NULL,
--  `type` SMALLINT NOT NULL COMMENT '0 - org; 1 - person; 2 - repo',
--  `hs` VARCHAR(200) NOT NULL,
--  PRIMARY KEY (`id`)
--);
--
--DROP TRIGGER IF EXISTS `organization_BEFORE_INSERT`;
--
--DELIMITER $$
--CREATE TRIGGER `organization_BEFORE_INSERT` BEFORE INSERT ON `organization` FOR EACH ROW
--BEGIN
--
--	DECLARE auto_id INT;
--    DECLARE parent_hs VARCHAR(200);
--
--	SET auto_id = (SELECT AUTO_INCREMENT FROM information_schema.tables WHERE table_schema = schema() AND table_name = 'organization');
--	SET parent_hs = (SELECT hs FROM organization WHERE id=new.parent);
--
--    IF parent_hs IS NULL THEN
--		SET new.hs = auto_id;
--	ELSE
--	  SET new.hs = CONCAT(parent_hs, "-", auto_id);
--    END IF;
--
--END$$
--DELIMITER ;
--
--
----
--DROP TRIGGER IF EXISTS `organization_BEFORE_UPDATE`;
--
--DELIMITER $$
--CREATE TRIGGER `organization_BEFORE_UPDATE` BEFORE UPDATE ON `organization` FOR EACH ROW
--BEGIN
--	declare parent_hs varchar(200);
--
--	set parent_hs = (select hs from organization where id = new.parent);
--
--    IF parent_hs IS NULL THEN
--		SET new.hs = old.id;
--	else
--	    set new.hs = concat(parent_hs, "-", old.id);
--	end if;
--END$$
--DELIMITER ;
--
--
----
--DROP procedure IF EXISTS `rebuild_hs`;
--
--DELIMITER $$
--CREATE PROCEDURE `rebuild_hs` ()
--BEGIN
--    DECLARE EXIT HANDLER FOR SQLEXCEPTION
--	BEGIN
--		ROLLBACK;
--		SELECT -1;
--	END;
--
--
--    START TRANSACTION;
--
-- 	-- UPDATE organization SET hs = null;
--
--	UPDATE organization SET hs=id WHERE parent IS NULL;
--
--	label:LOOP
--		UPDATE organization c, organization p SET c.hs=CONCAT(p.hs,"-", c.id) WHERE c.parent=p.id AND c.hs IS NULL AND p.hs IS NOT NULL;
--
--		SELECT ROW_COUNT() INTO @r;
--		IF @r =0 THEN
--			 LEAVE label;
--		END IF;
--	END LOOP;
--
--	COMMIT;
--
--	select 1;
--END$$
--DELIMITER ;
--
--
----
--DROP procedure IF EXISTS `update_node_parent`;
--
--DELIMITER $$
--CREATE PROCEDURE `update_node_parent` (IN `idx` INT,IN `parentx` INT)
--main: BEGIN
--	DECLARE oldHs VARCHAR(200);
--    DECLARE newHs VARCHAR(200);
--
--    DECLARE EXIT HANDLER FOR SQLEXCEPTION
--	BEGIN
--		ROLLBACK;
--		SELECT 0;
--	END;
--
--
--    SELECT parent INTO @cur_parent FROM organization WHERE id=idx;
--    IF @cur_parent = parentx THEN
--		SELECT 1;
--		LEAVE main;
--    END IF;
--
--    SELECT is_child(idx, parentx) INTO @is_child;
--    IF @is_child > 0 THEN
--      SELECT 0;
--      LEAVE main;
--	END IF;
--
--    IF parentx = idx THEN
--		SELECT 0;
--        LEAVE main;
--	END IF;
--
--
--	SET @oldHs = (SELECT o.hs FROM organization o WHERE o.id=idx);
--	SET @newHs = CONCAT((SELECT o.hs FROM organization o WHERE o.id=parentx), "-", idx);
--
--	START TRANSACTION;
--
--	UPDATE organization o SET o.parent=parentx, hs=@newHs WHERE o.id=idx;
--
--	SET @oldHs = CONCAT(@oldHs, "-");
--
--	UPDATE organization SET hs = CONCAT(@newHs, SUBSTRING(hs, LENGTH(@oldHs))) WHERE LOCATE(@oldHs, hs) = 1;
--
--	COMMIT;
--
--	SELECT 1;
--
--END$$
--DELIMITER ;
--
--
--CREATE TABLE `hly`.`user` (
--  `id` INT NOT NULL,
--  `name` VARCHAR(30) NOT NULL,
--  `gender` TINYINT NULL COMMENT '0 - female; 1 = male',
--  `phone` VARCHAR(20) NOT NULL,
--  `password` VARCHAR(40) NOT NULL COMMENT 'md5 hashed',
--  `disabled` TINYINT NOT NULL DEFAULT 0 COMMENT '0/null: not disabled; others = disabled',
--  `comment` VARCHAR(45) NULL,
--  PRIMARY KEY (`id`),
--  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC),
--  CONSTRAINT `fk_user_org`
--    FOREIGN KEY (`id`)
--    REFERENCES `hly`.`organization` (`id`)
--    ON DELETE CASCADE
--);
--
--
--CREATE TABLE `hly`.`role` (
--  `id` INT NOT NULL AUTO_INCREMENT,
--  `code` VARCHAR(50) NOT NULL,
--  `name` VARCHAR(50) NOT NULL,
--  `disabled` TINYINT NOT NULL DEFAULT 0,
--  `comment` VARCHAR(45) NULL,
--  PRIMARY KEY (`id`),
--  UNIQUE INDEX `role_code_UNIQUE` (`code` ASC),
--  UNIQUE INDEX `role_name_UNIQUE` (`name` ASC)
--);
--
--
--CREATE TABLE `user_role` (
--  `user_id` int(11) NOT NULL,
--  `role_id` int(11) NOT NULL,
--  PRIMARY KEY (`user_id`,`role_id`),
--  KEY `fk_user_role_role_idx` (`role_id`),
--  CONSTRAINT `fk_user_role_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
--  CONSTRAINT `fk_user_role_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
--);
--
--
--CREATE TABLE `hly`.`privilege` (
--  `id` INT NOT NULL AUTO_INCREMENT,
--  `code` VARCHAR(50) NOT NULL,
--  `name` VARCHAR(50) NOT NULL,
--  `disabled` TINYINT NOT NULL DEFAULT 0,
--  `comment` VARCHAR(100) NULL,
--  PRIMARY KEY (`id`),
--  UNIQUE INDEX `privilege_code_UNIQUE` (`code` ASC),
--  UNIQUE INDEX `privilege_name_UNIQUE` (`name` ASC)
--);


-- use mysql 8 COMMON TABLE EXPRESS (cte) support to generate HIERARCHY PATH STRING (hs) and more (like LEVEL),
-- without extra triggers and util store produces needed
--CREATE VIEW `v_organization` AS
--  with recursive `o` (`id`,`type`,`info`,`hs`,`parent`, `level`)
--  as (
--    select `id`, `type`, `info`, `concat(id)`, `parent`, 1 from `organization` where isnull(`parent`)
--    union
--    select `n`.`id`, `n`.`type`, `n`.`info`, concat(`o`.`hs`,'-',`n`.`id`), `n`.`parent`, o.level + 1 from (`organization` `n` join `o`) where (`n`.`parent` = `o`.`id`)
--  )
--select * from `o`;



select 1;
