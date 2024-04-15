CREATE DATABASE IF NOT EXISTS `app`;
USE `app`;

CREATE TABLE IF NOT EXISTS `SYONLINE` (
  `ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `IP` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `LOGINNAME` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `TYPE` varchar(1) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

INSERT INTO `SYONLINE` (`ID`, `CREATEDATETIME`, `IP`, `LOGINNAME`, `TYPE`) VALUES
	('0c69d762-af59-4f12-bd36-ea7b8af99e78', '2022-05-22 12:00:43', '127.0.0.1', 'admin', '1'),
	('48c530fa-0a73-4c1c-b0de-adec5c4a3447', '2023-05-16 19:49:12', '127.0.0.1', 'admin', '1');

CREATE TABLE IF NOT EXISTS `SYORGANIZATION` (
  `ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `ADDRESS` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `CODE` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `ICONCLS` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `NAME` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `SEQ` int DEFAULT NULL,
  `UPDATEDATETIME` datetime DEFAULT NULL,
  `SYORGANIZATION_ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `LEADER` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'responsible person',
  `PHONE` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'phone number',
  `EMAIL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'email',
  `STATUS` varchar(10) DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_acf7qlb04quthktalwx8c7q69` (`SYORGANIZATION_ID`) USING BTREE,
  CONSTRAINT `FK_acf7qlb04quthktalwx8c7q69` FOREIGN KEY (`SYORGANIZATION_ID`) REFERENCES `SYORGANIZATION` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

INSERT INTO `SYORGANIZATION` (`ID`, `ADDRESS`, `CODE`, `CREATEDATETIME`, `ICONCLS`, `NAME`, `SEQ`, `UPDATEDATETIME`, `SYORGANIZATION_ID`, `LEADER`, `PHONE`, `EMAIL`, `STATUS`) VALUES
	('0', NULL, NULL, '2016-11-28 10:34:54', 'ext-icon-bricks', 'HQ', 100, '2016-11-28 10:35:12', NULL, NULL, NULL, NULL, '0'),
	('5477d9a9-e41e-485f-bb08-697e8facef88', NULL, NULL, '2022-05-22 09:59:33', NULL, 'New York Branch', 1, '2023-05-16 19:52:10', '0', 'dd', '408-888-8888', 'ss@ada.com', '0'),
	('ce627e90-57d6-4ed4-a789-1f3dd467ae7d', NULL, NULL, '2022-05-24 23:54:10', NULL, 'Texas Branch', 2, '2022-05-24 23:56:21', '0', 'jack', NULL, NULL, '0');

CREATE TABLE IF NOT EXISTS `SYRESOURCETYPE` (
  `ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `DESCRIPTION` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `NAME` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `UPDATEDATETIME` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

INSERT INTO `SYRESOURCETYPE` (`ID`, `CREATEDATETIME`, `DESCRIPTION`, `NAME`, `UPDATEDATETIME`) VALUES
	('0', '2015-08-25 10:34:53', 'menu type will appear at system left menu', 'menu', '2015-08-25 10:34:53'),
	('1', '2015-08-25 10:34:53', 'function type will not appear at system left menu', 'function', '2015-08-25 10:34:53'),
	('3', '2022-05-15 10:27:08', NULL, 'category', '2022-05-15 10:27:18');

CREATE TABLE IF NOT EXISTS `SYRESOURCE` (
  `ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `DESCRIPTION` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `ICONCLS` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `NAME` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `SEQ` int DEFAULT NULL,
  `TARGET` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `UPDATEDATETIME` datetime DEFAULT NULL,
  `PATH` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `URL` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `PERMS` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `SYRESOURCE_ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `SYRESOURCETYPE_ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `STATUS` varchar(10) DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_n8kk2inhw4y4gax3nra2etfup` (`SYRESOURCE_ID`) USING BTREE,
  KEY `FK_93qfpiiuk3rwb32gc5mcmmlgh` (`SYRESOURCETYPE_ID`) USING BTREE,
  CONSTRAINT `FK_93qfpiiuk3rwb32gc5mcmmlgh` FOREIGN KEY (`SYRESOURCETYPE_ID`) REFERENCES `SYRESOURCETYPE` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_n8kk2inhw4y4gax3nra2etfup` FOREIGN KEY (`SYRESOURCE_ID`) REFERENCES `SYRESOURCE` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

INSERT INTO `SYRESOURCE` (`ID`, `CREATEDATETIME`, `DESCRIPTION`, `ICONCLS`, `NAME`, `SEQ`, `TARGET`, `UPDATEDATETIME`, `PATH`, `URL`, `PERMS`, `SYRESOURCE_ID`, `SYRESOURCETYPE_ID`, `STATUS`) VALUES
	('xtgl', '2015-08-25 10:34:53', 'management system resources, roles, organizations, users', 'system', 'system management', 1, '', '2023-05-16 20:03:02', '/system', NULL, NULL, NULL, '3', '0'),
	('xtjk', '2015-08-25 10:34:53', 'monitor system running info', 'monitor', 'system monitor', 2, '', '2022-06-10 00:48:47', '/system/log', '', '', NULL, '0', '0'),
	('27fda67f-61d1-4fe6-8eea-d796a848ab67', '2022-05-28 12:54:39', NULL, 'edit', 'param setting', 6, '', '2022-05-28 12:54:39', 'config', 'system/config/index', 'system:config:list', 'xtgl', '3', '0'),
	('jggl', '2015-08-25 10:34:53', 'management system user organization', 'tree', 'organization management', 4, '', '2022-05-25 00:40:04', 'dept', 'system/dept/index', 'system:dept:list', 'xtgl', '0', '0'),
	('jsgl', '2015-08-25 10:34:53', 'management system user role', 'peoples', 'role management', 2, '', '2015-08-25 10:34:53', 'role', 'system/role/index', 'system:role:list', 'xtgl', '0', '0'),
	('ffb8cf26-1049-43ee-9dd5-16e5742ce9d5', '2022-05-28 12:50:37', NULL, 'dict', 'dictionary management', 5, '', '2022-05-28 12:50:37', 'dict', 'system/dict/index', 'system:dict:list', 'xtgl', '3', '0'),
	('online', '2015-08-25 10:34:53', 'monitor user login, logout', 'ext-icon-chart_line', 'login history', 1, '', '2022-06-10 00:53:22', 'logininfor', 'monitor/logininfor/index', 'monitor:logininfor:list', 'xtjk', '0', '0'),
	('yhgl', '2015-08-25 10:34:53', 'management system user', 'user', 'user management', 1, '', '2023-05-16 20:08:40', 'user', 'system/user/index', 'system:user:list', 'xtgl', '0', '0'),
	('zygl', '2015-08-25 10:34:53', 'management system resource', 'tree-table', 'resource management', 3, '', '2022-05-25 00:48:32', 'menu', 'system/menu/index', 'system:menu:list', 'xtgl', '0', '0'),
	('jgbj', '2015-08-25 10:34:53', 'edit organization', 'ext-icon-bullet_wrench', 'edit organization', 2, '', '2022-05-25 00:39:56', NULL, '/base/syorganization!update', 'system:dept:edit', 'jggl', '1', '0'),
	('jgck', '2015-08-25 10:34:53', 'view organization', 'ext-icon-bullet_wrench', 'view organization', 4, '', '2015-08-25 10:34:53', NULL, '/base/syorganization!getById', 'system:dept:query', 'jggl', '1', '0'),
	('jglb', '2015-08-25 10:34:53', 'lookup organization table', 'ext-icon-bullet_wrench', 'organization table', 0, '', '2016-11-28 14:09:52', NULL, '/base/syorganization!treeGrid', 'system:dept:list', 'jggl', '1', '0'),
	('jgsc', '2015-08-25 10:34:53', 'delete organization', 'ext-icon-bullet_wrench', 'delete organization', 3, '', '2015-08-25 10:34:53', NULL, '/base/syorganization!delete', 'system:dept:remove', 'jggl', '1', '0'),
	('jgsq', '2015-08-25 10:34:53', 'organization anthorize', 'ext-icon-bullet_wrench', 'organization anthorize', 5, '', '2015-08-25 10:34:53', NULL, '/base/syorganization!grant', NULL, 'jggl', '1', '0'),
	('jgtj', '2015-08-25 10:34:53', 'add organization', 'ext-icon-bullet_wrench', 'add organization', 1, '', '2015-08-25 10:34:53', NULL, '/base/syorganization!save', 'system:dept:add', 'jggl', '1', '0'),
	('jsbj', '2015-08-25 10:34:53', 'edit role', 'ext-icon-bullet_wrench', 'edit role', 2, '', '2015-08-25 10:34:53', NULL, '/base/syrole!update', 'system:role:edit', 'jsgl', '1', '0'),
	('jsck', '2015-08-25 10:34:53', 'view role', 'ext-icon-bullet_wrench', 'view role', 4, '', '2015-08-25 10:34:53', NULL, '/base/syrole!getById', 'system:role:query', 'jsgl', '1', '0'),
	('jslb', '2015-08-25 10:34:53', 'lookup role table', 'ext-icon-bullet_wrench', 'role table', 0, '', '2015-08-25 10:34:53', NULL, '/base/syrole!grid', 'system:role:list', 'jsgl', '1', '0'),
	('jssc', '2015-08-25 10:34:53', 'delete role', 'ext-icon-bullet_wrench', 'delete role', 3, '', '2015-08-25 10:34:53', NULL, '/base/syrole!delete', 'system:role:remove', 'jsgl', '1', '0'),
	('jssq', '2015-08-25 10:34:53', 'role anthorize', 'ext-icon-bullet_wrench', 'role anthorize', 5, '', '2015-08-25 10:34:53', NULL, '/base/syrole!grant', NULL, 'jsgl', '1', '0'),
	('jstj', '2015-08-25 10:34:53', 'add role', 'ext-icon-bullet_wrench', 'add role', 1, '', '2015-08-25 10:34:53', NULL, '/base/syrole!save', 'system:role:add', 'jsgl', '1', '0'),
	('yhbj', '2015-08-25 10:34:53', 'edit user', 'ext-icon-bullet_wrench', 'edit user', 2, '', '2015-08-25 10:34:53', NULL, '/base/syuser!update', 'system:user:edit', 'yhgl', '1', '0'),
	('yhck', '2015-08-25 10:34:53', 'view user', 'ext-icon-bullet_wrench', 'view user', 4, '', '2015-08-25 10:34:53', NULL, '/base/syuser!getById', 'system:user:query', 'yhgl', '1', '0'),
	('yhjg', '2015-08-25 10:34:53', 'edit userorganization', 'ext-icon-bullet_wrench', 'userorganization', 6, '', '2015-08-25 10:34:53', NULL, '/base/syuser!grantOrganization', 'system:dept:edit', 'yhgl', '1', '0'),
	('yhjs', '2015-08-25 10:34:53', 'edit userrole', 'ext-icon-bullet_wrench', 'userrole', 5, '', '2015-08-25 10:34:53', NULL, '/base/syuser!grantRole', 'system:role:edit', 'yhgl', '1', '0'),
	('yhlb', '2015-08-25 10:34:53', 'lookup user table', 'ext-icon-bullet_wrench', 'user table', 0, '', '2015-08-25 10:34:53', NULL, '/base/syuser!grid', 'system:user:list', 'yhgl', '1', '0'),
	('yhsc', '2015-08-25 10:34:53', 'delete user', 'ext-icon-bullet_wrench', 'delete user', 3, '', '2015-08-25 10:34:53', NULL, '/base/syuser!delete', 'system:user:remove', 'yhgl', '1', '0'),
	('yhtj', '2015-08-25 10:34:53', 'add user', 'ext-icon-bullet_wrench', 'add user', 1, '', '2015-08-25 10:34:53', NULL, '/base/syuser!save', 'system:user:add', 'yhgl', '1', '0'),
	('zybj', '2015-08-25 10:34:53', 'edit resource', 'ext-icon-bullet_wrench', 'edit resource', 2, '', '2015-08-25 10:34:53', NULL, '/base/syresource!update', 'system:menu:edit', 'zygl', '1', '0'),
	('zyck', '2015-08-25 10:34:53', 'view resource', 'ext-icon-bullet_wrench', 'view resource', 4, '', '2015-08-25 10:34:53', NULL, '/base/syresource!getById', 'system:menu:query', 'zygl', '1', '0'),
	('zylb', '2015-08-25 10:34:53', 'lookup resource', 'ext-icon-bullet_wrench', 'resource table', 0, '', '2015-08-25 10:34:53', NULL, '/base/syresource!treeGrid', 'system:menu:query', 'zygl', '1', '0'),
	('zysc', '2015-08-25 10:34:53', 'delete resource', 'ext-icon-bullet_wrench', 'delete resource', 3, '', '2015-08-25 10:34:53', NULL, '/base/syresource!delete', 'system:menu:remove', 'zygl', '1', '0'),
	('zytj', '2015-08-25 10:34:53', 'add resource', 'ext-icon-bullet_wrench', 'add resource', 1, '', '2015-08-25 10:34:53', NULL, '/base/syresource!save', 'system:menu:add', 'zygl', '1', '0'),
	('4621e9f8-e7c6-4c2b-8172-3d8c8ea75371', '2022-05-28 12:55:24', NULL, NULL, 'param add', 2, NULL, '2022-05-28 12:55:24', NULL, NULL, 'system:config:add', '27fda67f-61d1-4fe6-8eea-d796a848ab67', '1', '0'),
	('726c7c1e-06f8-4c3e-b9e1-95778a430c07', '2022-05-28 12:51:16', NULL, NULL, 'dictionary lookup ', 1, NULL, '2022-05-28 12:51:16', NULL, NULL, 'system:dict:query', 'ffb8cf26-1049-43ee-9dd5-16e5742ce9d5', '1', '0'),
	('b95cae69-6389-4ebc-b613-bee7aac5f730', '2022-05-28 12:52:26', NULL, NULL, 'dictionary modify', 3, NULL, '2022-05-28 12:52:26', NULL, NULL, 'system:dict:edit', 'ffb8cf26-1049-43ee-9dd5-16e5742ce9d5', '1', '0'),
	('cc7ff599-a588-40b3-951d-ce9dd2490482', '2022-05-28 12:53:26', NULL, NULL, 'dictionary export', 5, NULL, '2022-05-28 12:53:26', NULL, NULL, 'system:dict:export', 'ffb8cf26-1049-43ee-9dd5-16e5742ce9d5', '1', '0'),
	('cssc', '2022-05-28 12:56:23', NULL, NULL, 'param delete ', 4, NULL, '2022-05-28 12:56:23', NULL, NULL, 'system:config:remove', '27fda67f-61d1-4fe6-8eea-d796a848ab67', '1', '0'),
	('d60df8ae-86ee-4879-b9b9-2fe79f146d31', '2022-05-28 12:55:02', NULL, NULL, 'param lookup ', 1, NULL, '2022-05-28 12:55:02', NULL, NULL, 'system:config:query', '27fda67f-61d1-4fe6-8eea-d796a848ab67', '1', '0'),
	('dd41b52b-272c-49ac-b045-b05392890a8d', '2022-05-28 12:56:49', NULL, NULL, 'param export', 5, NULL, '2022-05-28 12:56:49', NULL, NULL, 'system:config:export', '27fda67f-61d1-4fe6-8eea-d796a848ab67', '1', '0'),
	('edc3358e-b9c5-462f-8a70-7b1c7d7f2c26', '2022-05-28 12:51:53', NULL, NULL, 'dictionary add', 2, NULL, '2022-05-28 12:51:53', NULL, NULL, 'system:dict:add', 'ffb8cf26-1049-43ee-9dd5-16e5742ce9d5', '1', '0'),
	('onlineGrid', '2015-08-25 10:34:53', 'user login, logout history table', 'ext-icon-bullet_wrench', 'user login history table', 1, '', '2022-05-28 13:16:37', NULL, '/base/syonline!grid', 'monitor:logininfor:list', 'online', '1', '0'),
	('zdsc', '2022-05-28 12:52:58', NULL, NULL, 'dictionary delete ', 4, NULL, '2022-05-28 12:52:58', NULL, NULL, 'system:dict:remove', 'ffb8cf26-1049-43ee-9dd5-16e5742ce9d5', '1', '0'),
	('37ac3cd3-560b-49b3-ae86-96d1963e9db6', '2022-05-28 12:55:59', NULL, NULL, 'param modify', 3, NULL, '2022-05-28 12:55:59', NULL, NULL, 'system:config:edit', '27fda67f-61d1-4fe6-8eea-d796a848ab67', '1', '0');

CREATE TABLE IF NOT EXISTS `SYORGANIZATION_SYRESOURCE` (
  `SYRESOURCE_ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `SYORGANIZATION_ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  PRIMARY KEY (`SYORGANIZATION_ID`,`SYRESOURCE_ID`) USING BTREE,
  KEY `FK_acpjp8a7fjo0cnn02eb0ia6uf` (`SYORGANIZATION_ID`) USING BTREE,
  KEY `FK_m4mfglk7odi78d8pk9pif44vc` (`SYRESOURCE_ID`) USING BTREE,
  CONSTRAINT `FK_acpjp8a7fjo0cnn02eb0ia6uf` FOREIGN KEY (`SYORGANIZATION_ID`) REFERENCES `SYORGANIZATION` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_m4mfglk7odi78d8pk9pif44vc` FOREIGN KEY (`SYRESOURCE_ID`) REFERENCES `SYRESOURCE` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

CREATE TABLE IF NOT EXISTS `SYROLE` (
  `ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `DESCRIPTION` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `ICONCLS` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `NAME` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `SEQ` int DEFAULT NULL,
  `UPDATEDATETIME` datetime DEFAULT NULL,
  `ROLEKEY` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'role permission string',
  `DATASCOPE` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '1' COMMENT 'data range(1:all data permission 2:customized data permission 3:dept data permission 4:dept and below data permission)',
  `STATUS` varchar(10) DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

INSERT INTO `SYROLE` (`ID`, `CREATEDATETIME`, `DESCRIPTION`, `ICONCLS`, `NAME`, `SEQ`, `UPDATEDATETIME`, `ROLEKEY`, `DATASCOPE`, `STATUS`) VALUES
	('0', '2015-08-25 10:34:53', 'all system permission', NULL, 'superadmin', 0, '2022-06-10 00:27:23', 'superadmin', '1', '0'),
	('19f00d46-8f1b-45b5-b7b7-6197d7b8cb33', '2016-11-28 14:24:00', NULL, NULL, 'admin', 100, '2022-06-10 00:27:41', 'admin', '1', '0'),
	('f4e1b151-a171-4705-9154-503a046cb72a', '2022-05-29 13:29:38', NULL, NULL, 'read only user', 1, '2022-06-10 00:13:55', 'readonly', '2', '0');

CREATE TABLE IF NOT EXISTS `SYROLE_SYORGANIZATION` (
  `SYROLE_ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `SYORGANIZATION_ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  PRIMARY KEY (`SYORGANIZATION_ID`,`SYROLE_ID`) USING BTREE,
  KEY `FK_kkrartsovl2frhfvriqdi7jwl` (`SYORGANIZATION_ID`) USING BTREE,
  KEY `FK_r139h669pg4ts6mbvn3ip5472` (`SYROLE_ID`) USING BTREE,
  CONSTRAINT `SYROLE_SYORGANIZATION_ibfk_1` FOREIGN KEY (`SYORGANIZATION_ID`) REFERENCES `SYORGANIZATION` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `SYROLE_SYORGANIZATION_ibfk_2` FOREIGN KEY (`SYROLE_ID`) REFERENCES `SYROLE` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

INSERT INTO `SYROLE_SYORGANIZATION` (`SYROLE_ID`, `SYORGANIZATION_ID`) VALUES
	('f4e1b151-a171-4705-9154-503a046cb72a', '5477d9a9-e41e-485f-bb08-697e8facef88');

CREATE TABLE IF NOT EXISTS `SYROLE_SYRESOURCE` (
  `SYROLE_ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `SYRESOURCE_ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  PRIMARY KEY (`SYRESOURCE_ID`,`SYROLE_ID`) USING BTREE,
  KEY `FK_kkrartsovl2frhfvriqdi7jwl` (`SYRESOURCE_ID`) USING BTREE,
  KEY `FK_r139h669pg4ts6mbvn3ip5472` (`SYROLE_ID`) USING BTREE,
  CONSTRAINT `FK_kkrartsovl2frhfvriqdi7jwl` FOREIGN KEY (`SYRESOURCE_ID`) REFERENCES `SYRESOURCE` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_r139h669pg4ts6mbvn3ip5472` FOREIGN KEY (`SYROLE_ID`) REFERENCES `SYROLE` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

INSERT INTO `SYROLE_SYRESOURCE` (`SYROLE_ID`, `SYRESOURCE_ID`) VALUES
	('0', '27fda67f-61d1-4fe6-8eea-d796a848ab67'),
	('f4e1b151-a171-4705-9154-503a046cb72a', '27fda67f-61d1-4fe6-8eea-d796a848ab67'),
	('0', '37ac3cd3-560b-49b3-ae86-96d1963e9db6'),
	('0', '4621e9f8-e7c6-4c2b-8172-3d8c8ea75371'),
	('0', '726c7c1e-06f8-4c3e-b9e1-95778a430c07'),
	('f4e1b151-a171-4705-9154-503a046cb72a', '726c7c1e-06f8-4c3e-b9e1-95778a430c07'),
	('0', 'b95cae69-6389-4ebc-b613-bee7aac5f730'),
	('0', 'cc7ff599-a588-40b3-951d-ce9dd2490482'),
	('0', 'cssc'),
	('0', 'd60df8ae-86ee-4879-b9b9-2fe79f146d31'),
	('f4e1b151-a171-4705-9154-503a046cb72a', 'd60df8ae-86ee-4879-b9b9-2fe79f146d31'),
	('0', 'dd41b52b-272c-49ac-b045-b05392890a8d'),
	('0', 'edc3358e-b9c5-462f-8a70-7b1c7d7f2c26'),
	('0', 'ffb8cf26-1049-43ee-9dd5-16e5742ce9d5'),
	('f4e1b151-a171-4705-9154-503a046cb72a', 'ffb8cf26-1049-43ee-9dd5-16e5742ce9d5'),
	('0', 'jgbj'),
	('0', 'jgck'),
	('0', 'jggl'),
	('f4e1b151-a171-4705-9154-503a046cb72a', 'jggl'),
	('0', 'jglb'),
	('f4e1b151-a171-4705-9154-503a046cb72a', 'jglb'),
	('0', 'jgsc'),
	('0', 'jgsq'),
	('0', 'jgtj'),
	('0', 'jsbj'),
	('0', 'jsck'),
	('0', 'jsgl'),
	('f4e1b151-a171-4705-9154-503a046cb72a', 'jsgl'),
	('0', 'jslb'),
	('f4e1b151-a171-4705-9154-503a046cb72a', 'jslb'),
	('0', 'jssc'),
	('0', 'jssq'),
	('0', 'jstj'),
	('0', 'online'),
	('0', 'onlineGrid'),
	('0', 'xtgl'),
	('f4e1b151-a171-4705-9154-503a046cb72a', 'xtgl'),
	('0', 'xtjk'),
	('0', 'yhbj'),
	('0', 'yhck'),
	('0', 'yhgl'),
	('f4e1b151-a171-4705-9154-503a046cb72a', 'yhgl'),
	('0', 'yhjg'),
	('0', 'yhjs'),
	('0', 'yhlb'),
	('f4e1b151-a171-4705-9154-503a046cb72a', 'yhlb'),
	('0', 'yhsc'),
	('0', 'yhtj'),
	('0', 'zdsc'),
	('0', 'zybj'),
	('0', 'zyck'),
	('0', 'zygl'),
	('f4e1b151-a171-4705-9154-503a046cb72a', 'zygl'),
	('0', 'zylb'),
	('f4e1b151-a171-4705-9154-503a046cb72a', 'zylb'),
	('0', 'zysc'),
	('0', 'zytj');

CREATE TABLE IF NOT EXISTS `SYS_CONFIG` (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT 'param primary key',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT 'param name',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT 'param key name',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT 'param key value',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'N' COMMENT 'system built-in(Y N)',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT 'creator',
  `create_time` datetime DEFAULT NULL COMMENT 'time of creation',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT 'updator',
  `update_time` datetime DEFAULT NULL COMMENT 'time of updated',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT 'remark',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='param configuration table';

INSERT INTO `SYS_CONFIG` (`config_id`, `config_name`, `config_key`, `config_value`, `config_type`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
    (1, 'main frame page - default skin style name', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2022-05-14 14:04:21', '', NULL, 'skin-blue, skin-green, skin-purple, skin-red, skin-yellow'),
    (2, 'user management - account default password', 'sys.user.initPassword', '123456', 'Y', 'admin', '2022-05-14 14:04:21', '', NULL, 'default password 123456'),
    (3, 'main frame page - side bar theme', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2022-05-14 14:04:21', '', NULL, 'theme-dark, theme-light'),
    (4, 'account - captcha OnOff', 'sys.account.captchaOnOff', 'true', 'Y', 'admin', '2022-05-14 14:04:21', '', NULL, '(true on, false off)'),
    (5, 'account - activate user register', 'sys.account.registerUser', 'false', 'Y', 'admin', '2022-05-14 14:04:21', '', NULL, 'whether activate register user (true on, false off)');

CREATE TABLE IF NOT EXISTS `SYS_DICT_TYPE` (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT 'dictionary primary key',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT 'dictionary name',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT 'dictionary type',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE KEY `dict_type` (`dict_type`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='dictionary type table';

INSERT INTO `SYS_DICT_TYPE` (`dict_id`, `dict_name`, `dict_type`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
    (1, 'user gender', 'sys_user_sex', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'user gender table'),
    (2, 'menu status', 'sys_show_hide', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'menu status table'),
    (3, 'system onoff', 'sys_normal_disable', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'system onoff table'),
    (4, 'job status', 'sys_job_status', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'job status table'),
    (5, 'job group', 'sys_job_group', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'job group table'),
    (6, 'system yesno', 'sys_yes_no', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'system yesno table'),
    (7, 'notice type', 'sys_notice_type', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'notice type table'),
    (8, 'notice status', 'sys_notice_status', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'notice status table'),
    (9, 'opeartion type', 'sys_oper_type', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'opeartion type table'),
    (10, 'login status', 'sys_common_status', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'login status table'),
    (11, 'login log type', 'sys_login_type', '0', 'admin', '2022-06-10 00:28:26', 'admin', '2022-06-10 00:28:26', NULL);

CREATE TABLE IF NOT EXISTS `SYS_DICT_DATA` (
  `dict_code` bigint NOT NULL AUTO_INCREMENT,
  `dict_sort` int DEFAULT '0',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'N' ,
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '',
  `update_time` datetime DEFAULT NULL,
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`dict_code`) USING BTREE,
  KEY `dict_type` (`dict_type`) USING BTREE,
  CONSTRAINT `SYS_DICT_DATA_ibfk_1` FOREIGN KEY (`dict_type`) REFERENCES `SYS_DICT_TYPE` (`dict_type`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=DYNAMIC COMMENT='dictionary data table';

INSERT INTO `SYS_DICT_DATA` (`dict_code`, `dict_sort`, `dict_label`, `dict_value`, `dict_type`, `css_class`, `list_class`, `is_default`, `status`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
    (1, 1, 'male', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'gender male'),
    (2, 2, 'female', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'gender female'),
    (3, 3, 'unknown', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'gender unknown'),
    (4, 1, 'show', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'show menu'),
    (5, 2, 'hide', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'hide menu'),
    (6, 1, 'enable', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'enabled'),
    (7, 2, 'disable', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'disabled'),
    (8, 1, 'enable', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'enabled'),
    (9, 2, 'disable', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'disabled'),
    (10, 1, 'default', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'default group'),
    (11, 2, 'system', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'system group'),
    (12, 1, 'yes', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'system default yes'),
    (13, 2, 'no', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'system default no'),
    (14, 1, 'notice', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'notice'),
    (15, 2, 'announcement', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'announcement'),
    (16, 1, 'enable', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'enabled'),
    (17, 2, 'disable', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2022-05-14 14:04:20', '', NULL, 'disabled'),
    (18, 1, 'add', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-05-14 14:04:21', '', NULL, 'add operation'),
    (19, 2, 'modify', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2022-05-14 14:04:21', '', NULL, 'modify operation'),
    (20, 3, 'delete ', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-05-14 14:04:21', '', NULL, 'delete operation'),
    (21, 4, 'authorize', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2022-05-14 14:04:21', '', NULL, ' authorize operation'),
    (22, 5, 'export', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-05-14 14:04:21', '', NULL, 'export operation'),
    (23, 6, 'import', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-05-14 14:04:21', '', NULL, 'import operation'),
    (24, 7, 'force logout', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-05-14 14:04:21', '', NULL, 'force logout operation'),
    (25, 8, 'generate code', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2022-05-14 14:04:21', '', NULL, 'generator operation'),
    (26, 9, 'empty data', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2022-05-14 14:04:21', '', NULL, 'empty operation'),
    (27, 1, 'success', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2022-05-14 14:04:21', '', NULL, 'enabled'),
    (28, 2, 'fail', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2022-05-14 14:04:21', '', NULL, 'disabled'),
    (100, 0, 'login', '1', 'sys_login_type', NULL, 'default', NULL, '0', 'admin', '2022-06-10 00:29:31', 'admin', '2022-06-10 00:29:58', NULL),
    (101, 1, 'logout', '0', 'sys_login_type', NULL, 'default', NULL, '0', 'admin', '2022-06-10 00:29:48', NULL, '2022-06-10 00:29:48', NULL);

CREATE TABLE IF NOT EXISTS `SYUSER` (
  `ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `AGE` int DEFAULT NULL,
  `CREATEDATETIME` datetime DEFAULT NULL,
  `LOGINNAME` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `NAME` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `PHOTO` varchar(200) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `PWD` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `SEX` varchar(1) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `UPDATEDATETIME` datetime DEFAULT NULL,
  `EMPLOYDATE` datetime DEFAULT NULL,
  `EMAIL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT 'user email',
  `PHONENUMBER` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT 'phone number',
  `STATUS` varchar(10) DEFAULT '0',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `UK_eiov1gsncrds3rean3dmu822p` (`LOGINNAME`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

INSERT INTO `SYUSER` (`ID`, `AGE`, `CREATEDATETIME`, `LOGINNAME`, `NAME`, `PHOTO`, `PWD`, `SEX`, `UPDATEDATETIME`, `EMPLOYDATE`, `EMAIL`, `PHONENUMBER`, `STATUS`) VALUES
	('0', 30, '2015-08-25 10:34:54', 'admin', 'admin', '', 'e10adc3949ba59abbe56e057f20f883e', '1', '2022-06-08 11:04:52', NULL, 'test@test.com', '408-111-2239', '0'),
	('0f21b40c-5323-46e5-9200-0364eab3481e', NULL, '2022-05-29 09:28:57', 'test', 'test', NULL, 'e10adc3949ba59abbe56e057f20f883e', '0', '2022-06-10 09:19:56', '2022-05-29 09:28:57', 'test@test.com', '408-333-9999', '0');

CREATE TABLE IF NOT EXISTS `SYUSER_SYORGANIZATION` (
  `SYUSER_ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `SYORGANIZATION_ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  PRIMARY KEY (`SYORGANIZATION_ID`,`SYUSER_ID`) USING BTREE,
  KEY `FK_14ewqc5wtscac0dd5rswrm5j2` (`SYORGANIZATION_ID`) USING BTREE,
  KEY `FK_63bdmtxwlk259id13rp4iryy` (`SYUSER_ID`) USING BTREE,
  CONSTRAINT `FK_14ewqc5wtscac0dd5rswrm5j2` FOREIGN KEY (`SYORGANIZATION_ID`) REFERENCES `SYORGANIZATION` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_63bdmtxwlk259id13rp4iryy` FOREIGN KEY (`SYUSER_ID`) REFERENCES `SYUSER` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

INSERT INTO `SYUSER_SYORGANIZATION` (`SYUSER_ID`, `SYORGANIZATION_ID`) VALUES
	('0', '0'),
	('0f21b40c-5323-46e5-9200-0364eab3481e', '5477d9a9-e41e-485f-bb08-697e8facef88');

CREATE TABLE IF NOT EXISTS `SYUSER_SYROLE` (
  `SYUSER_ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `SYROLE_ID` varchar(36) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  PRIMARY KEY (`SYROLE_ID`,`SYUSER_ID`) USING BTREE,
  KEY `FK_j7iwtgslc2esrjx0ptieleoko` (`SYROLE_ID`) USING BTREE,
  KEY `FK_1pi4p5h4y5ghbs5f4gdlgn620` (`SYUSER_ID`) USING BTREE,
  CONSTRAINT `FK_1pi4p5h4y5ghbs5f4gdlgn620` FOREIGN KEY (`SYUSER_ID`) REFERENCES `SYUSER` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `FK_j7iwtgslc2esrjx0ptieleoko` FOREIGN KEY (`SYROLE_ID`) REFERENCES `SYROLE` (`ID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=gbk ROW_FORMAT=DYNAMIC;

INSERT INTO `SYUSER_SYROLE` (`SYUSER_ID`, `SYROLE_ID`) VALUES
	('0', '0'),
	('0', '19f00d46-8f1b-45b5-b7b7-6197d7b8cb33'),
	('0', 'f4e1b151-a171-4705-9154-503a046cb72a');