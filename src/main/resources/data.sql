-- 2018-5-26

--insert into repo_changing_reason (type, reason) values (1, '采购入库');
--insert into repo_changing_reason (type, reason) values (1, '盘盈');
--insert into repo_changing_reason (type, reason) values (1, '过期转入');
--insert into repo_changing_reason (type, reason) values (1, '其他仓库调入');
--
--insert into repo_changing_reason (type, reason, contract_related) values (-1, '生产领用', 1);
--insert into repo_changing_reason (type, reason) values (-1, '打板领用');
--insert into repo_changing_reason (type, reason) values (-1, '车间辅助生产领用');
--insert into repo_changing_reason (type, reason) values (-1, '盘亏');
--insert into repo_changing_reason (type, reason) values (-1, '过期转出');

--insert into role (code, name) values ('admin', '系统管理员'),
--('repo-keeper', '仓库管理员'),
--('sales-manager', '销售经理'),
--('process-manager', '工艺经理'),
--('product-manager', '产品经理'),
--('producing-manager', '生产主管'),
--;
--
--
--insert into privilege (code, name, comment) values ('system:basic-data', '基础数据管理', '如：客户类型、材料分类等');
--insert into privilege (code, name, comment) values ('system:user-management', '用户管理', '包括：组织结构、用户、角色、权限管理');
--insert into privilege (code, name, comment) values ('sales:client', '客户管理', null);
--insert into privilege (code, name, comment) values ('sales:order', '订单管理', null);
--insert into privilege (code, name, comment) values ('production:material', '物料数据', null);
--insert into privilege (code, name, comment) values ('production:product', '产品', null);
--insert into privilege (code, name, comment) values ('production:bom', 'BOM单', null);
--insert into privilege (code, name, comment) values ('production:formula', '产品配方', null);
--insert into privilege (code, name, comment) values ('repo:stock-in', '入库单', null);
--insert into privilege (code, name, comment) values ('repo:stock-out', '出库单', null);
--insert into privilege (code, name, comment) values ('repo:inventory', '库存盘点', null);
--insert into privilege (code, name, comment) values ('purchasing:plan', '采购计划', null);
--
--
--insert into organization (type) values (0);
--insert into organization (id, parent, type) values (2, 1, 0);
--insert into organization (id, parent, type) values (3, 1, 0);
--insert into organization (id, parent, type) values (4, 1, 0);
--insert into organization (id, parent, type) values (5, 1, 0);
--insert into organization (id, parent, type) values (6, 1, 0);
--insert into organization (id, parent, type) values (7, 1, 0);
--insert into organization (id, parent, type) values (8, 1, 0);
--insert into organization (id, parent, type) values (9, 1, 0);
--
--insert into org (id, name) values (1, '华丽雅粉末科技有限公司');
--insert into org (id, name) values (2, '总经办');
--insert into org (id, name) values (3, '行政财务部');
--insert into org (id, name) values (4, '销售部');
--insert into org (id, name) values (5, '质量技术部');
--insert into org (id, name) values (6, '工艺技术部');
--insert into org (id, name) values (7, '产品技术部');
--insert into org (id, name) values (8, '生产制造部');
--insert into org (id, name) values (9, '供应链管理部');
--
--
--insert into organization (id, parent, type) values (10, 2, 1);
--insert into `user` (id, name, phone, password) values (10, '李立新', '13926053858', md5('li.123'));
--
--insert into organization (id, parent, type) values (11, 3, 1);
--insert into `user` (id, name, phone, password) values (11, '范玲艳', '18988524905', md5('fan.123'));
--
--insert into organization (id, parent, type) values (12, 3, 1);
--insert into `user` (id, name, phone, password) values (12, '文海燕', '13630401067', md5('wen.123'));
--
--insert into organization (parent, type) values (4, 1);
--insert into `user` (id, name, phone, password) values (13, '陈慧', '13928550268', md5('chen.123'));
--
--insert into organization (parent, type) values (4, 1);
--insert into `user` (id, name, phone, password) select max(id), '曹杰峰', '13928600337', md5('cao.123') from organization;
--
--insert into organization (parent, type) values (5, 1);
--insert into `user` (id, name, phone, password) select max(id), '刘伟纯', '13660989300', md5('liu.123') from organization;
--
--insert into organization (parent, type, info) values (6, 1, concat('{"name":"汤确军", "phone":"13928771916", "pwd":"', md5('tang.123'), '", "title":"经理"}'));
--
--insert into organization (parent, type, info) values (7, 1, concat('{"name":"黄应通", "phone":"13531347949", "pwd":"', md5('huang.123'), '", "title":"经理"}'));
--
--insert into organization (parent, type, info) values (8, 1, concat('{"name":"陈锦海", "phone":"13536620289", "pwd":"', md5('chen.123'), '", "title":"厂长"}'));
--
--insert into organization (parent, type, info) values (9, 1, concat('{"name":"邱谷娣", "phone":"15917885784", "pwd":"', md5('qiu.123'), '", "title":"文员"}'));


--
select 1;