/*
 Navicat Premium Data Transfer

 Source Server         : 49.234.100.110_3306
 Source Server Type    : MySQL
 Source Server Version : 50737
 Source Host           : 49.234.100.110:3306
 Source Schema         : sademo

 Target Server Type    : MySQL
 Target Server Version : 50737
 File Encoding         : 65001

 Date: 22/05/2022 13:06:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sa_admin
-- ----------------------------
DROP TABLE IF EXISTS `sa_admin`;
CREATE TABLE `sa_admin`  (
  `id` mediumint(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分组id',
  `department_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门id',
  `jobs_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '岗位id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '帐号',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `pwd` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
  `sex` tinyint(1) NOT NULL DEFAULT 1 COMMENT '性别',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户标签',
  `face` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/static/admin/images/user.png' COMMENT '头像',
  `mood` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '每日心情',
  `email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `area` char(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区号',
  `mobile` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '简介',
  `count` smallint(6) NULL DEFAULT NULL COMMENT '登录次数',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户地址',
  `loginip` bigint(12) NULL DEFAULT NULL COMMENT '登录IP',
  `login_time` int(11) NULL DEFAULT NULL COMMENT '最后登录时间',
  `create_ip` bigint(12) NULL DEFAULT NULL COMMENT '注册IP',
  `status` int(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '用户状态',
  `banned` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封号原因',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '注册时间',
  `update_time` int(11) NOT NULL COMMENT '修改时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE,
  INDEX `pwd`(`pwd`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_admin
-- ----------------------------
INSERT INTO `sa_admin` VALUES (1, '1', '2', '3', 'admin', '权栈', '13682bec405cf4b9002e6e8306312ce6', 1, 'a:2:{i:3;s:15:\"隔壁帅小伙\";i:4;s:9:\"技术宅\";}', '/upload/avatar/f8e34ec67a2a0233_100x100.jpg', '海阔天空，有容乃大', 'admin@swiftadmin.net', '0310', '15188888888', '高级管理人员', 201, '河北省邯郸市', 1861775580, 1653193832, 3232254977, 1, NULL, 1596682835, 1653193832, NULL);
INSERT INTO `sa_admin` VALUES (2, '2', '4', '5,6', 'ceshi', '白眉大侠', '13682bec405cf4b9002e6e8306312ce6', 1, 'a:3:{i:0;s:6:\"呵呵\";i:1;s:5:\"Think\";i:2;s:12:\"铁血柔肠\";}', '/upload/avatar/a0b923820dcc509a_100x100.png', '吃我一招乾坤大挪移', 'baimei@your.com', '0310', '15188888888', '我原本以为吕布已经天下无敌了，没想到还有比吕布勇猛的，这谁的部将？', 41, '河北省邯郸市廉颇大道110号指挥中心', 2130706433, 1653189834, 3232254977, 1, '违规', 1609836672, 1653189834, NULL);

-- ----------------------------
-- Table structure for sa_admin_access
-- ----------------------------
DROP TABLE IF EXISTS `sa_admin_access`;
CREATE TABLE `sa_admin_access`  (
  `admin_id` mediumint(8) UNSIGNED NOT NULL COMMENT '用户ID',
  `group_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理员分组',
  `rules` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自定义权限',
  `cates` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目权限',
  PRIMARY KEY (`admin_id`) USING BTREE,
  INDEX `uid`(`admin_id`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '组规则表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_admin_access
-- ----------------------------
INSERT INTO `sa_admin_access` VALUES (1, '1', NULL, NULL);
INSERT INTO `sa_admin_access` VALUES (2, '2', '5,12,13,14,15,16,17,31,37,40,85,86,87,88,89,90,91,97,98,99,100,101,102,109,110,111,112,113,114,115,116,117,118,119,120,121', '');

-- ----------------------------
-- Table structure for sa_admin_group
-- ----------------------------
DROP TABLE IF EXISTS `sa_admin_group`;
CREATE TABLE `sa_admin_group`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL COMMENT '父组id',
  `jobid` int(11) NULL DEFAULT NULL COMMENT '体系id',
  `title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '分组名称',
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标识',
  `type` int(11) NULL DEFAULT NULL COMMENT '分组类型',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `rules` varchar(2048) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '规则字符串',
  `cates` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '栏目权限',
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户组表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_admin_group
-- ----------------------------
INSERT INTO `sa_admin_group` VALUES (1, 0, 1, '超级管理员', 'admin', 1, 1, '网站超级管理员组的', NULL, NULL, 'layui-bg-blue', 1607832158, NULL);
INSERT INTO `sa_admin_group` VALUES (2, 1, 2, '网站编辑', 'editor', 1, 1, '负责公司软文的编写', NULL, '3', 'layui-bg-cyan', 1607832158, NULL);

-- ----------------------------
-- Table structure for sa_admin_rules
-- ----------------------------
DROP TABLE IF EXISTS `sa_admin_rules`;
CREATE TABLE `sa_admin_rules`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '父栏目id',
  `title` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '菜单标题',
  `router` char(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由地址',
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '菜单，按钮，接口，系统',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `condition` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '正则表达式',
  `sort` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '排序',
  `icons` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `auth` tinyint(4) NULL DEFAULT 1 COMMENT '状态',
  `status` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'normal' COMMENT '状态码',
  `isSystem` tinyint(3) UNSIGNED NULL DEFAULT 0 COMMENT '系统级,只可手动操作',
  `update_time` int(11) NULL DEFAULT 0 COMMENT '添加时间',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `sort`(`sort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 328 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_admin_rules
-- ----------------------------
INSERT INTO `sa_admin_rules` VALUES (1, 0, 'Dashboard', '#', '#', 0, NULL, '', 0, 'layui-icon-home', 0, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (2, 1, '控制台', '/index/console', 'index:console', 0, NULL, '', 1, '', 0, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (3, 1, '分析页', '/index/analysis', 'index:analysis', 0, NULL, '', 2, '', 0, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (4, 1, '监控页', '/index/monitor', 'index:monitor', 0, NULL, '', 3, '', 0, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (31, 0, '系统管理', '#', '#', 0, NULL, '', 30, 'layui-icon-set-fill', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (32, 31, '基本设置', '/index/basecfg', 'index:basecfg', 0, NULL, '', 31, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (33, 32, '修改配置', '/index/baseset', 'index:baseset', 2, NULL, '', 32, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (34, 32, 'FTP接口', '/index/testftp', 'index:testftp', 2, NULL, '', 33, '', 0, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (35, 32, '邮件接口', '/index/testemail', 'index:testemail', 2, NULL, '', 34, '', 0, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (36, 32, '缓存接口', '/index/testcache', 'index:testcache', 2, NULL, '', 35, '', 0, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (37, 31, '用户管理', '/system.admin/index', 'system.admin:index', 0, NULL, '', 36, '', 1, 'normal', 0, 1639484140, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (38, 37, '查看', '/system.admin/index', 'system.admin:index', 1, NULL, '', 37, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (39, 37, '添加', '/system.admin/add', 'system.admin:add', 1, NULL, '', 38, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (40, 37, '编辑', '/system.admin/edit', 'system.admin:edit', 1, NULL, '', 39, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (41, 37, '删除', '/system.admin/del', 'system.admin:del', 1, NULL, '', 40, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (42, 37, '状态', '/system.admin/status', 'system.admin:status', 2, NULL, '', 41, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (43, 37, '编辑权限', '/system.admin/editrules', 'system.admin:editrules', 2, NULL, '', 42, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (44, 37, '编辑栏目', '/system.admin/editcates', 'system.admin:editcates', 2, NULL, '', 43, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (45, 37, '系统模板', '/system.admin/theme', 'system.admin:theme', 2, NULL, '', 44, '', 0, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (46, 37, '短消息', '/system.admin/message', 'system.admin:message', 2, NULL, '', 45, '', 0, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (47, 37, '个人中心', '/system.admin/center', 'system.admin:center', 2, NULL, '', 46, '', 0, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (48, 37, '修改资料', '/system.admin/modify', 'system.admin:modify', 2, NULL, '', 47, '', 0, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (49, 37, '修改密码', '/system.admin/pwd', 'system.admin:pwd', 2, NULL, '', 48, '', 0, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (50, 37, '系统语言', '/system.admin/language', 'system.admin:language', 2, NULL, '', 49, '', 0, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (51, 37, '清理缓存', '/system.admin/clear', 'system.admin:clear', 2, NULL, '', 50, '', 0, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (52, 37, '数据接口', '/system.admin/authorities', 'system.admin:authorities', 3, NULL, '', 51, '', 0, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (53, 31, '用户中心', '/system.admin/center', 'system.admin:center', 0, NULL, '', 52, '', 1, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (61, 53, '系统模板', '/system.admin/theme', 'system.admin:theme', 2, NULL, '', 60, '', 0, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (62, 53, '短消息', '/system.admin/message', 'system.admin:message', 2, NULL, '', 61, '', 0, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (64, 53, '修改资料', '/system.admin/modify', 'system.admin:modify', 2, NULL, '', 63, '', 0, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (65, 53, '修改密码', '/system.admin/pwd', 'system.admin:pwd', 2, NULL, '', 64, '', 0, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (66, 53, '系统语言', '/system.admin/language', 'system.admin:language', 2, NULL, '', 65, '', 0, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (67, 53, '清理缓存', '/system.admin/clear', 'system.admin:clear', 2, NULL, '', 66, '', 0, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (69, 31, '角色管理', '/system.admingroup/index', 'system.admingroup:index', 0, NULL, '', 68, '', 1, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (70, 69, '查看', '/system.admingroup/index', 'system.admingroup:index', 1, NULL, '', 69, '', 1, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (71, 69, '添加', '/system.admingroup/add', 'system.admingroup:add', 1, NULL, '', 70, '', 1, 'normal', 0, 1621989904, 1621989904, NULL);
INSERT INTO `sa_admin_rules` VALUES (72, 69, '编辑', '/system.admingroup/edit', 'system.admingroup:edit', 1, NULL, '', 71, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (73, 69, '删除', '/system.admingroup/del', 'system.admingroup:del', 1, NULL, '', 72, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (74, 69, '状态', '/system.admingroup/status', 'system.admingroup:status', 2, NULL, '', 73, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (75, 69, '编辑权限', '/system.admingroup/editrules', 'system.admingroup:editrules', 2, NULL, '', 74, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (76, 69, '编辑栏目', '/system.admingroup/editcates', 'system.admingroup:editcates', 2, NULL, '', 75, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (77, 31, '菜单管理', '/system.adminrules/index', 'system.adminrules:index', 0, NULL, '', 76, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (78, 77, '查询', '/system.adminrules/index', 'system.adminrules:index', 1, NULL, '', 77, NULL, 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (79, 77, '添加', '/system.adminrules/add', 'system.adminrules:add', 1, NULL, '', 78, NULL, 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (80, 77, '编辑', '/system.adminrules/edit', 'system.adminrules:edit', 1, NULL, '', 79, NULL, 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (81, 77, '删除', '/system.adminrules/del', 'system.adminrules:del', 1, NULL, '', 80, NULL, 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (82, 77, '状态', '/system.adminrules/status', 'system.adminrules:status', 2, NULL, '', 81, NULL, 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (83, 31, '操作日志', '/system.systemlog/index', 'system.systemlog:index', 0, NULL, '', 82, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (84, 83, '查询', '/system.systemlog/index', 'system.systemlog:index', 1, NULL, '', 83, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (146, 0, '高级管理', '#', '#', 0, NULL, '', 145, 'layui-icon-engine', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (147, 146, '公司管理', '/system.company/index', 'system.company:index', 0, NULL, '', 146, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (148, 147, '查看', '/system.company/index', 'system.company:index', 1, NULL, '', 147, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (149, 147, '添加', '/system.company/add', 'system.company:add', 1, NULL, '', 148, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (150, 147, '编辑', '/system.company/edit', 'system.company:edit', 1, NULL, '', 149, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (151, 147, '删除', '/system.company/del', 'system.company:del', 1, NULL, '', 150, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (152, 147, '状态', '/system.company/status', 'system.company:status', 2, NULL, '', 151, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (153, 146, '部门管理', '/system.department/index', 'system.department:index', 0, NULL, '', 152, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (154, 153, '查看', '/system.department/index', 'system.department:index', 1, NULL, '', 153, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (155, 153, '添加', '/system.department/add', 'system.department:add', 1, NULL, '', 154, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (156, 153, '编辑', '/system.department/edit', 'system.department:edit', 1, NULL, '', 155, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (157, 153, '删除', '/system.department/del', 'system.department:del', 1, NULL, '', 156, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (158, 153, '状态', '/system.department/status', 'system.department:status', 2, NULL, '', 157, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (159, 146, '岗位管理', '/system.jobs/index', 'system.jobs:index', 0, NULL, '', 158, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (160, 159, '查看', '/system.jobs/index', 'system.jobs:index', 1, NULL, '', 159, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (161, 159, '添加', '/system.jobs/add', 'system.jobs:add', 1, NULL, '', 160, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (162, 159, '编辑', '/system.jobs/edit', 'system.jobs:edit', 1, NULL, '', 161, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (163, 159, '删除', '/system.jobs/del', 'system.jobs:del', 1, NULL, '', 162, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (164, 159, '状态', '/system.jobs/status', 'system.jobs:status', 2, NULL, '', 163, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (165, 146, '字典设置', '/system.dictionary/index', 'system.dictionary:index', 0, NULL, '', 164, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (166, 165, '查看', '/system.dictionary/index', 'system.dictionary:index', 1, NULL, '', 165, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (167, 165, '添加', '/system.dictionary/add', 'system.dictionary:add', 1, NULL, '', 166, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (168, 165, '编辑', '/system.dictionary/edit', 'system.dictionary:edit', 1, NULL, '', 167, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (169, 165, '删除', '/system.dictionary/del', 'system.dictionary:del', 1, NULL, '', 168, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (170, 165, '状态', '/system.dictionary/status', 'system.dictionary:status', 2, NULL, '', 169, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (171, 146, '附件管理', '/system.attachment/index', 'system.attachment:index', 0, NULL, '', 170, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (172, 171, '查看', '/system.attachment/index', 'system.attachment:index', 1, NULL, '', 171, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (173, 171, '编辑', '/system.attachment/edit', 'system.attachment:edit', 1, NULL, '', 172, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (174, 171, '删除', '/system.attachment/del', 'system.attachment:del', 1, NULL, '', 173, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (175, 171, '附件上传', '/upload/upload', 'upload:upload', 2, NULL, '', 174, '', 0, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (182, 0, '插件应用', '#', '#', 0, NULL, '', 181, 'layui-icon-component', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (183, 182, '插件管理', '/system.plugin/index', 'system.plugin:index', 0, NULL, '', 182, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (184, 183, '查看', '/system.plugin/index', 'system.plugin:index', 1, NULL, '', 183, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (185, 183, '安装', '/system.plugin/install', 'system.plugin:install', 1, NULL, '', 184, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (186, 183, '卸载', '/system.plugin/uninstall', 'system.plugin:uninstall', 1, NULL, '', 185, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (187, 183, '配置', '/system.plugin/config', 'system.plugin:config', 1, NULL, '', 186, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (188, 183, '状态', '/system.plugin/status', 'system.plugin:status', 2, NULL, '', 187, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (189, 183, '升级', '/system.plugin/upgrade', 'system.plugin:upgrade', 2, NULL, '', 188, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (190, 183, '数据表', '/system.plugin/tables', 'system.plugin:tables', 2, NULL, '', 189, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (197, 182, '占位菜单', '#', '#', 0, NULL, '', 196, '', 1, 'hidden', 1, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (198, 197, '查看', '#', '#', 1, NULL, '', 197, '', 1, 'hidden', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (199, 197, '安装', '#', '#', 1, NULL, '', 198, '', 1, 'hidden', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (200, 197, '卸载', '#', '#', 1, NULL, '', 199, '', 1, 'hidden', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (201, 197, '预留1', '#', '#', 1, NULL, '', 200, '', 1, 'hidden', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (202, 197, '预留2', '#', '#', 2, NULL, '', 201, '', 1, 'hidden', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (203, 0, '会员管理', '#', '#', 0, NULL, '', 202, 'layui-icon-user', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (204, 203, '会员管理', '/system.user/index', 'system.user:index', 0, NULL, '', 203, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (205, 204, '查看', '/system.user/index', 'system.user:index', 1, NULL, '', 204, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (206, 204, '添加', '/system.user/add', 'system.user:add', 1, NULL, '', 205, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (207, 204, '编辑', '/system.user/edit', 'system.user:edit', 1, NULL, '', 206, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (208, 204, '删除', '/system.user/del', 'system.user:del', 1, NULL, '', 207, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (209, 204, '状态', '/system.user/status', 'system.user:status', 2, NULL, '', 208, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (210, 203, '评论管理', '/system.comment/index', 'system.comment:index', 0, NULL, '', 209, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (211, 210, '查看', '/system.comment/index', 'system.comment:index', 1, NULL, '', 210, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (212, 210, '回复', '/system.comment/view', 'system.comment:view', 1, NULL, '', 211, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (213, 210, '添加', '/system.comment/add', 'system.comment:add', 1, NULL, '', 212, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (214, 210, '编辑', '/system.comment/edit', 'system.comment:edit', 1, NULL, '', 213, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (215, 210, '删除', '/system.comment/del', 'system.comment:del', 1, NULL, '', 214, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (216, 210, '状态', '/system.comment/status', 'system.comment:status', 2, NULL, '', 215, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (217, 203, '留言板管理', '/system.guestbook/index', 'system.guestbook:index', 0, NULL, '', 216, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (218, 217, '查看', '/system.guestbook/index', 'system.guestbook:index', 1, NULL, '', 217, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (219, 217, '回复', '/system.guestbook/reply', 'system.guestbook:reply', 1, NULL, '', 218, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (220, 217, '删除', '/system.guestbook/del', 'system.guestbook:del', 1, NULL, '', 219, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (221, 217, '状态', '/system.guestbook/status', 'system.guestbook:status', 2, NULL, '', 220, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (222, 203, '会员组管理', '/system.usergroup/index', 'system.usergroup:index', 0, NULL, '', 221, '', 1, 'normal', 0, 1621989910, 1621989910, NULL);
INSERT INTO `sa_admin_rules` VALUES (223, 222, '查看', '/system.usergroup/index', 'system.usergroup:index', 1, NULL, '', 222, '', 1, 'normal', 0, 1621989911, 1621989911, NULL);
INSERT INTO `sa_admin_rules` VALUES (224, 222, '添加', '/system.usergroup/add', 'system.usergroup:add', 1, NULL, '', 223, '', 1, 'normal', 0, 1621989911, 1621989911, NULL);
INSERT INTO `sa_admin_rules` VALUES (225, 222, '编辑', '/system.usergroup/edit', 'system.usergroup:edit', 1, NULL, '', 224, '', 1, 'normal', 0, 1621989911, 1621989911, NULL);
INSERT INTO `sa_admin_rules` VALUES (226, 222, '删除', '/system.usergroup/del', 'system.usergroup:del', 1, NULL, '', 225, '', 1, 'normal', 0, 1621989911, 1621989911, NULL);
INSERT INTO `sa_admin_rules` VALUES (227, 222, '状态', '/system.usergroup/status', 'system.usergroup:status', 2, NULL, '', 226, '', 1, 'normal', 0, 1621989911, 1621989911, NULL);
INSERT INTO `sa_admin_rules` VALUES (253, 0, '代码生成', '/generate.index/index', 'generate.index:index', 0, NULL, '', 120, 'fa-codepen', 1, 'normal', 0, 1652950607, 1649298971, NULL);

-- ----------------------------
-- Table structure for sa_attachment
-- ----------------------------
DROP TABLE IF EXISTS `sa_attachment`;
CREATE TABLE `sa_attachment`  (
  `id` int(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `pid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '类别',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '物理路径',
  `suffix` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '文件后缀',
  `filename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '文件名称',
  `filesize` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '文件大小',
  `mimetype` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT 'mime类型',
  `sha1` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '文件 sha1编码',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '管理员ID',
  `update_time` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` int(10) NULL DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '附件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for sa_ceshi
-- ----------------------------
DROP TABLE IF EXISTS `sa_ceshi`;
CREATE TABLE `sa_ceshi`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '姓名;中文饭',
  `sex` int(1) NULL DEFAULT NULL COMMENT '性别',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `hobby` set('write','game','read') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '爱好',
  `text` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容页',
  `age` int(11) NULL DEFAULT NULL COMMENT '年龄',
  `tags` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键词',
  `album` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '相册;多文件上传必须为text类型',
  `stars` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '星级',
  `interest` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '签名',
  `week` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '星期',
  `birthday` int(11) NULL DEFAULT NULL COMMENT '生日;必须要int类型',
  `json` json NULL COMMENT '数组',
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '色彩',
  `lines` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '额度',
  `status` int(255) NULL DEFAULT NULL COMMENT '状态',
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '城市',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容;内容字段必须是longtext类型',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_ceshi
-- ----------------------------

-- ----------------------------
-- Table structure for sa_comment
-- ----------------------------
DROP TABLE IF EXISTS `sa_comment`;
CREATE TABLE `sa_comment`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tid` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '属性ID 内容1 问题2',
  `cid` mediumint(9) UNSIGNED NULL DEFAULT 0 COMMENT '栏目ID',
  `sid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '对象ID 内容ID',
  `rid` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '被回复的用户ID',
  `pid` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '父级ID',
  `user_id` mediumint(9) NULL DEFAULT 0 COMMENT '用户UID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `up` mediumint(9) NULL DEFAULT 0 COMMENT '顶一下',
  `down` mediumint(9) NULL DEFAULT 0 COMMENT '踩一下',
  `ip` bigint(20) NOT NULL COMMENT '评论IP地址',
  `adopt` int(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最佳评论',
  `count` int(11) NULL DEFAULT 0 COMMENT '回复数量',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '审核状态',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '添加时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  INDEX `uid`(`user_id`) USING BTREE,
  INDEX `sid`(`sid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_comment
-- ----------------------------
INSERT INTO `sa_comment` VALUES (1, 2, 0, 1, 0, 0, 1, '是的，只是为了测试', 0, 0, 2525678147, 0, 0, 0, 1653039569, 1653018139, NULL);

-- ----------------------------
-- Table structure for sa_company
-- ----------------------------
DROP TABLE IF EXISTS `sa_company`;
CREATE TABLE `sa_company`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公司名称',
  `alias` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公司标识',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公司地址',
  `postcode` int(11) NULL DEFAULT NULL COMMENT '邮编',
  `contact` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `mobile` bigint(20) NULL DEFAULT NULL COMMENT '手机号',
  `phone` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `blicense` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '营业执照代码',
  `longitude` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地图经度',
  `latitude` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地图纬度',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公司信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_company
-- ----------------------------
INSERT INTO `sa_company` VALUES (1, '北京总部技术公司', 'bj', '北京市东城区长安街880号', 10000, '权栈', 15100000001, '010-10000', 'coolsec@foxmail.com', '91130403XXA0AJ7XXM', '01', '02', 1613711884);
INSERT INTO `sa_company` VALUES (2, '河北分公司', 'hb', '河北省邯郸市丛台区公园路880号', 56000, '权栈', 12345678901, '0310-12345678', 'coolsec@foxmail.com', 'code', NULL, NULL, 1613787702);

-- ----------------------------
-- Table structure for sa_config
-- ----------------------------
DROP TABLE IF EXISTS `sa_config`;
CREATE TABLE `sa_config`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段',
  `system` int(1) UNSIGNED NULL DEFAULT 0 COMMENT '系统',
  `group` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '配置组',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字段类型',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字段值',
  `tips` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提示信息',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 91 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_config
-- ----------------------------
INSERT INTO `sa_config` VALUES (1, 'site_name', 1, 'site', 'string', '基于ThinkPHP和layui的极速后台开发框架2', '网站名称');
INSERT INTO `sa_config` VALUES (2, 'site_url', 1, 'site', 'string', 'www.swiftadmin.net', '网站URL');
INSERT INTO `sa_config` VALUES (3, 'site_logo', 1, 'site', 'string', '/static/images/logo.png', '网站logo');
INSERT INTO `sa_config` VALUES (4, 'site_http', 1, 'site', 'string', 'http://www.swiftadmin.net', 'HTTP地址');
INSERT INTO `sa_config` VALUES (5, 'site_state', 1, 'site', 'string', '1', '是否开启手机版');
INSERT INTO `sa_config` VALUES (6, 'site_type', 1, 'site', 'string', '1', '手机版类型');
INSERT INTO `sa_config` VALUES (7, 'site_mobile', 1, 'site', 'string', '', '手机版地址');
INSERT INTO `sa_config` VALUES (8, 'site_icp', 1, 'site', 'string', '京ICP备13000001号', '备案号');
INSERT INTO `sa_config` VALUES (9, 'site_email', 1, 'site', 'string', 'admin@swiftadmin.net', '站长邮箱');
INSERT INTO `sa_config` VALUES (10, 'site_keyword', 1, 'site', 'string', '网站关键字', '网站关键字');
INSERT INTO `sa_config` VALUES (11, 'site_description', 1, 'site', 'string', '网站描述', '网站描述');
INSERT INTO `sa_config` VALUES (12, 'site_total', 1, 'site', 'string', '统计代码：', '统计代码');
INSERT INTO `sa_config` VALUES (13, 'site_copyright', 1, 'site', 'string', '版权信息：', '版权信息');
INSERT INTO `sa_config` VALUES (14, 'site_clearLink', 1, 'site', 'string', '1', '清理非本站链接');
INSERT INTO `sa_config` VALUES (15, 'site_status', 1, 'site', 'string', '0', '运营状态');
INSERT INTO `sa_config` VALUES (16, 'site_notice', 1, 'site', 'string', 'html', '关闭通知');
INSERT INTO `sa_config` VALUES (17, 'auth_key', 0, NULL, 'string', '38nfCIlkqNMI2', '授权码');
INSERT INTO `sa_config` VALUES (18, 'auth_code', 0, NULL, 'string', 'wMRkfKO4Lr37HTJQ', '加密KEY');
INSERT INTO `sa_config` VALUES (19, 'system_alogs', 0, NULL, 'string', '0', '后台日志');
INSERT INTO `sa_config` VALUES (20, 'system_exception', 0, NULL, 'string', '1', '异常日志');
INSERT INTO `sa_config` VALUES (21, 'cache_status', 0, 'cache', 'string', '0', '缓存状态');
INSERT INTO `sa_config` VALUES (22, 'cache_type', 0, 'cache', 'string', 'redis', '缓存类型');
INSERT INTO `sa_config` VALUES (23, 'cache_time', 0, 'cache', 'string', '6000', '缓存时间');
INSERT INTO `sa_config` VALUES (24, 'cache_host', 0, 'cache', 'string', '127.0.0.1', '服务器IP');
INSERT INTO `sa_config` VALUES (25, 'cache_port', 0, 'cache', 'string', '6379', '端口');
INSERT INTO `sa_config` VALUES (26, 'cache_select', 0, 'cache', 'string', '1', '缓存数据库');
INSERT INTO `sa_config` VALUES (27, 'cache_user', 0, 'cache', 'string', '', '用户名');
INSERT INTO `sa_config` VALUES (28, 'cache_pass', 0, 'cache', 'string', '', '密码');
INSERT INTO `sa_config` VALUES (29, 'upload_path', 0, 'upload', 'string', 'upload', '上传路径');
INSERT INTO `sa_config` VALUES (30, 'upload_style', 0, 'upload', 'string', 'Y-m-d', '文件夹格式');
INSERT INTO `sa_config` VALUES (31, 'upload_class', 0, 'upload', 'array', '{\"images\":\".bmp.jpg.jpeg.png.gif.svg\",\"video\":\".flv.swf.mkv.avi.rm.rmvb.mpeg.mpg.ogg.ogv.mov.wmv.mp4.webm.mp3.wav.mid\",\"document\":\".txt.doc.xls.ppt.docx.xlsx.pptx\",\"files\":\".exe.dll.sys.so.dmg.iso.zip.rar.7z.sql.pem.pdf.psd\"}', '文件分类');
INSERT INTO `sa_config` VALUES (32, 'upload_ftp', 0, 'upload', 'string', '0', 'FTP上传');
INSERT INTO `sa_config` VALUES (33, 'upload_del', 0, 'upload', 'string', '0', '上传后删除');
INSERT INTO `sa_config` VALUES (34, 'upload_ftp_host', 0, 'upload', 'string', '127.0.0.1', 'FTP服务器');
INSERT INTO `sa_config` VALUES (35, 'upload_ftp_port', 0, 'upload', 'string', '26655', 'FTP端口');
INSERT INTO `sa_config` VALUES (36, 'upload_ftp_user', 0, 'upload', 'string', '123123', 'FTP用户名');
INSERT INTO `sa_config` VALUES (37, 'upload_ftp_pass', 0, 'upload', 'string', '5BGMMATwC7mtGp4m', 'FTP密码');
INSERT INTO `sa_config` VALUES (38, 'upload_http_prefix', 0, 'upload', 'string', '', '图片CDN地址');
INSERT INTO `sa_config` VALUES (39, 'upload_chunk_size', 0, 'upload', 'string', '2097152', '文件分片大小 字节');
INSERT INTO `sa_config` VALUES (40, 'upload_thumb', 0, 'upload', 'string', '0', '是否开启缩略图');
INSERT INTO `sa_config` VALUES (41, 'upload_thumb_w', 0, 'upload', 'string', '120', '宽度');
INSERT INTO `sa_config` VALUES (42, 'upload_thumb_h', 0, 'upload', 'string', '140', '高度');
INSERT INTO `sa_config` VALUES (43, 'upload_water', 0, 'upload', 'string', '0', '是否水印');
INSERT INTO `sa_config` VALUES (44, 'upload_water_type', 0, 'upload', 'string', '1', '水印类型');
INSERT INTO `sa_config` VALUES (45, 'upload_water_font', 0, 'upload', 'string', 'www.swiftadmin.net', '水印文字');
INSERT INTO `sa_config` VALUES (46, 'upload_water_size', 0, 'upload', 'string', '20', '字体大小');
INSERT INTO `sa_config` VALUES (47, 'upload_water_color', 0, 'upload', 'string', '#0fbeea', '字体颜色');
INSERT INTO `sa_config` VALUES (48, 'upload_water_pct', 0, 'upload', 'string', '47', '透明度');
INSERT INTO `sa_config` VALUES (49, 'upload_water_img', 0, 'upload', 'string', '/', '图片水印地址');
INSERT INTO `sa_config` VALUES (50, 'upload_water_pos', 0, 'upload', 'string', '9', '水印位置');
INSERT INTO `sa_config` VALUES (51, 'play', 0, NULL, 'array', '{\"play_width\":\"960\",\"play_height\":\"450\",\"play_show\":\"0\",\"play_second\":\"10\",\"play_area\":\"大陆,香港,中国台湾,美国,韩国,日本,泰国,印度,英国,法国,俄罗斯,新加坡,其它\",\"play_year\":\"2022,2021,2020,2019,2018,2017,2016,2015,2014,2013,2012,2011,2010,2009,2008,2007,2006,2005,2004,2003,2002,2001,2000,1999\",\"play_version\":\"高清版,剧场版,抢先版,OVA,TV,影院版\",\"play_language\":\"国语,英语,粤语,韩语,日语,法语,德语,泰语,俄语,其它\",\"play_week\":\"周一,周二,周三,周四,周五,周六,周日\",\"play_playad\":\"http:\\/\\/www.swiftadmin.net\\/api\\/show.html\",\"play_down\":\"http:\\/\\/www.swiftadmin.net\\/api\\/show.html\",\"play_downgorup\":\"http:\\/\\/down.swiftadmin.net\\/\"}', '播放器数据');
INSERT INTO `sa_config` VALUES (52, 'cloud_status', 0, NULL, 'string', '0', '是否开启OSS上传');
INSERT INTO `sa_config` VALUES (53, 'cloud_type', 0, NULL, 'string', 'aliyun_oss', 'OSS上传类型');
INSERT INTO `sa_config` VALUES (54, 'aliyun_oss', 0, NULL, 'array', '{\"accessId\":\"LTAI5333kuER9w3xNnVMe1vC\",\"accessSecret\":\"kFStrmkXjHjw9sankaJdocxsSScjRt9A\",\"bucket\":\"demo\",\"endpoint\":\"oss-cn-beijing.aliyuncs.com\",\"url\":\"http:\\/\\/oss-cn-beijing.aliyuncs.com\"}', '阿里云OSS');
INSERT INTO `sa_config` VALUES (55, 'qcloud_oss', 0, NULL, 'array', '{\"app_id\":\"1252296528\",\"secret_id\":\"LTAI5333kuER9w3xNnVMe1vC\",\"secret_key\":\"kFStrmkXjHjw9sankaJdocxsSScjRt9A\",\"bucket\":\"testpack\",\"region\":\"ap-beijing\",\"url\":\"\"}', '腾讯云OSS');
INSERT INTO `sa_config` VALUES (56, 'email', 0, NULL, 'array', '{\"smtp_debug\":\"0\",\"smtp_host\":\"smtp.163.com\",\"smtp_port\":\"587\",\"smtp_name\":\"管理员\",\"smtp_user\":\"yourname@163.com\",\"smtp_pass\":\"password\",\"smtp_test\":\"\"}', '邮箱配置');
INSERT INTO `sa_config` VALUES (57, 'qq', 0, NULL, 'array', '{\"app_id\":\"\",\"app_key\":\"\",\"callback\":\"\"}', 'QQ登录');
INSERT INTO `sa_config` VALUES (58, 'weixin', 0, NULL, 'array', '{\"app_id\":\"\",\"app_key\":\"\",\"callback\":\"\"}', '微信登录');
INSERT INTO `sa_config` VALUES (59, 'gitee', 0, NULL, 'array', '{\"app_id\":\"\",\"app_key\":\"\",\"callback\":\"\"}', '码云登录');
INSERT INTO `sa_config` VALUES (60, 'weibo', 0, NULL, 'array', '{\"app_id\":\"\",\"app_key\":\"\",\"callback\":\"\"}', '微博登录');
INSERT INTO `sa_config` VALUES (61, 'alipay', 0, NULL, 'array', '{\"mode\":\"0\",\"app_id\":\"202100213462****\",\"app_public_cert_path\":\"appCertPublicKey_20210021346*****.crt\",\"app_secret_cert\":\"7eUBvZLxn8XwZPuCA==\",\"return_url\":\"https:\\/\\/www.swiftadmin.net\\/\",\"notify_url\":\"https:\\/\\/www.swiftadmin.net\\/\",\"alipay_public_cert_path\":\"alipayCertPublicKey_RSA2.crt\",\"alipay_root_cert_path\":\"alipayRootCert.crt\"}', '支付宝');
INSERT INTO `sa_config` VALUES (62, 'wechat', 0, NULL, 'array', '{\"mode\":\"0\",\"mch_id\":\"16138*****\",\"mch_secret_key\":\"GgnohjtLdR******rprA6duxQ8k0AuVA\",\"mp_app_id\":\"wxd2bf0834be*****\",\"mini_app_id\":\"\",\"notify_url\":\"https:\\/\\/www.swiftadmin.net\\/\",\"mch_secret_cert\":\"apiclient_key.pem\",\"mch_public_cert_path\":\"apiclient_cert.pem\"}', '微信支付');
INSERT INTO `sa_config` VALUES (63, 'smstype', 0, NULL, 'string', 'alisms', '短信类型');
INSERT INTO `sa_config` VALUES (64, 'alisms', 0, NULL, 'array', '{\"app_id\":\"cn-hangzhou\",\"app_sign\":\"河北邯郸市有限公司\",\"access_id\":\"kFStrmkXjHjw9sankaJdoIXXSScjRt9A\",\"access_secret\":\"kFStrmkXjHjw9sankaJdoIXXSScjRt9A\"}', '阿里云短信');
INSERT INTO `sa_config` VALUES (65, 'tensms', 0, NULL, 'array', '{\"app_id\":\"1400459798\",\"app_sign\":\"河北邯郸市有限公司\",\"secret_id\":\"kFStrmkXjHjw9sankaJdoIXXSScjRt9A\",\"secret_key\":\"kFStrmkXjHjw9sankaJdoIXXSScjRt9A\"}', '腾讯云短信');
INSERT INTO `sa_config` VALUES (66, 'mpwechat', 0, NULL, 'array', '{\"secret_id\":\"\",\"secret_key\":\"\",\"secret_token\":\"\",\"EncodingAESKey\":\"\"}', '微信公众号');
INSERT INTO `sa_config` VALUES (67, 'user_status', 0, 'user', 'string', '1', '注册状态');
INSERT INTO `sa_config` VALUES (68, 'user_register_style', 0, 'user', 'string', 'normal', '注册方式');
INSERT INTO `sa_config` VALUES (69, 'user_document', 0, 'user', 'string', '1', '用户投稿');
INSERT INTO `sa_config` VALUES (70, 'user_sensitive', 0, 'user', 'string', '1', '开启违禁词检测');
INSERT INTO `sa_config` VALUES (71, 'user_document_integra', 0, 'user', 'string', '1', '投稿获得积分');
INSERT INTO `sa_config` VALUES (72, 'user_valitime', 0, 'user', 'string', '10', '激活码有效期');
INSERT INTO `sa_config` VALUES (73, 'user_register_second', 0, 'user', 'string', '10', '每日注册');
INSERT INTO `sa_config` VALUES (74, 'user_login_integra', 0, 'user', 'string', '1', '登录获得积分');
INSERT INTO `sa_config` VALUES (75, 'user_spread_integra', 0, 'user', 'string', '1', '推广获得积分');
INSERT INTO `sa_config` VALUES (76, 'user_search_interval', 0, 'user', 'string', '1', '用户搜索间隔');
INSERT INTO `sa_config` VALUES (77, 'user_reg_notallow', 0, 'user', 'string', 'www,bbs,ftp,mail,user,users,admin,administrator', '禁止注册');
INSERT INTO `sa_config` VALUES (78, 'user_form_status', 0, 'user', 'string', '1', '评论开关');
INSERT INTO `sa_config` VALUES (79, 'user_form_check', 0, 'user', 'string', '0', '评论审核');
INSERT INTO `sa_config` VALUES (80, 'user_isLogin', 0, 'user', 'string', '1', '游客评论');
INSERT INTO `sa_config` VALUES (81, 'user_anonymous', 0, 'user', 'string', '0', '匿名评论');
INSERT INTO `sa_config` VALUES (82, 'user_form_second', 0, 'user', 'string', '10', '最大注册');
INSERT INTO `sa_config` VALUES (83, 'user_replace', 0, 'user', 'string', '她妈|它妈|他妈|你妈|去死|贱人', '过滤字符');
INSERT INTO `sa_config` VALUES (84, 'sitemap', 0, NULL, 'array', '', '地图配置');
INSERT INTO `sa_config` VALUES (85, 'rewrite', 0, NULL, 'string', '', 'URL配置');
INSERT INTO `sa_config` VALUES (86, 'database', 0, NULL, 'string', '', '数据库维护');
INSERT INTO `sa_config` VALUES (87, 'variable', 0, NULL, 'array', '{\"test\":\"我是值2\",\"ceshi\":\"我是测试变量的值\"}', '自定义变量');
INSERT INTO `sa_config` VALUES (88, 'param', 0, NULL, 'string', '', '测试代码');
INSERT INTO `sa_config` VALUES (89, 'full_status', 0, NULL, 'string', '1', '全文检索');
INSERT INTO `sa_config` VALUES (90, 'editor', 0, NULL, 'string', 'lay-editor', '编辑器选项');

-- ----------------------------
-- Table structure for sa_department
-- ----------------------------
DROP TABLE IF EXISTS `sa_department`;
CREATE TABLE `sa_department`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NULL DEFAULT 0 COMMENT '上级ID',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '部门名称',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门区域',
  `head` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '负责人',
  `mobile` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门简介',
  `sort` tinyint(4) NULL DEFAULT NULL COMMENT '排序',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '添加时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门管理表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_department
-- ----------------------------
INSERT INTO `sa_department` VALUES (1, 0, '北京总部', '北京市昌平区体育馆南300米', '秦老板', '1510000001', 'coolsec@foxmail.com', '总部，主要负责广告的营销，策划！', 1, 1, 1611213045, NULL);
INSERT INTO `sa_department` VALUES (2, 1, '河北分公司', '河北省邯郸市丛台区政府路', '刘备', '15100020003', 'liubei@qq.com', '', 2, 1, 1611227478, NULL);
INSERT INTO `sa_department` VALUES (3, 2, '市场部', '一楼', '大乔', '15100010003', 'xiaoqiao@foxmail.com', '', 3, 1, 1611228586, NULL);
INSERT INTO `sa_department` VALUES (4, 2, '开发部', '二楼2', '赵云', '15100010003', 'zhaoyun@shijiazhuang.com', '', 4, 1, 1611228626, NULL);
INSERT INTO `sa_department` VALUES (5, 2, '营销部', '二楼', '许攸', '15100010003', 'xuyou@henan.com', '', 5, 1, 1611228674, NULL);

-- ----------------------------
-- Table structure for sa_dictionary
-- ----------------------------
DROP TABLE IF EXISTS `sa_dictionary`;
CREATE TABLE `sa_dictionary`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '字典分类id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典值',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序号',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `isSystem` tinyint(3) UNSIGNED NULL DEFAULT NULL COMMENT '系统级,只可手动操作',
  `update_time` int(11) NULL DEFAULT 0 COMMENT '更新时间',
  `create_time` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `name`(`name`) USING BTREE,
  INDEX `value`(`value`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_dictionary
-- ----------------------------
INSERT INTO `sa_dictionary` VALUES (1, 0, '内容属性', 'cattr', 1, '', 1, 1637738903, 1637738903, NULL);
INSERT INTO `sa_dictionary` VALUES (2, 1, '头条', '1', 2, '', 1, 1638093403, 1638093403, NULL);
INSERT INTO `sa_dictionary` VALUES (3, 1, '推荐', '2', 3, '', 1, 1649300011, 1638093425, NULL);
INSERT INTO `sa_dictionary` VALUES (4, 1, '幻灯', '3', 4, '', 1, 1638093430, 1638093430, NULL);
INSERT INTO `sa_dictionary` VALUES (5, 1, '滚动', '4', 5, '', 1, 1638093435, 1638093435, NULL);
INSERT INTO `sa_dictionary` VALUES (6, 1, '图文', '5', 6, '', 1, 1638093456, 1638093456, NULL);
INSERT INTO `sa_dictionary` VALUES (7, 1, '跳转', '6', 7, '', 1, 1638093435, 1638093435, NULL);
INSERT INTO `sa_dictionary` VALUES (8, 0, '友链类型', 'ftype', 8, '', 1, 1638093456, 1638093456, NULL);
INSERT INTO `sa_dictionary` VALUES (9, 8, '资源', '1', 9, '', 1, 1638093430, 1638093430, NULL);
INSERT INTO `sa_dictionary` VALUES (10, 8, '社区', '2', 10, '', 1, 1638093435, 1638093435, NULL);
INSERT INTO `sa_dictionary` VALUES (11, 8, '合作伙伴', '3', 11, '', 1, 1638093456, 1638093456, NULL);
INSERT INTO `sa_dictionary` VALUES (12, 8, '关于我们', '4', 12, '', 1, 1638093461, 1638093461, NULL);
INSERT INTO `sa_dictionary` VALUES (13, 0, '视频属性', 'vattr', 13, '', NULL, 1649300145, 1646900854, NULL);
INSERT INTO `sa_dictionary` VALUES (14, 13, '首页推荐', '1', 14, '', NULL, 1646900865, 1646900865, NULL);
INSERT INTO `sa_dictionary` VALUES (15, 13, '正在热映', '2', 15, '', NULL, 1646900869, 1646900869, NULL);
INSERT INTO `sa_dictionary` VALUES (16, 13, '卫视同步', '3', 16, '', NULL, 1646900874, 1646900874, NULL);
INSERT INTO `sa_dictionary` VALUES (17, 13, '即将上映', '4', 17, '', NULL, 1646900880, 1646900880, NULL);
INSERT INTO `sa_dictionary` VALUES (18, 13, '锁定', '5', 18, '', NULL, 1646900886, 1646900886, NULL);

-- ----------------------------
-- Table structure for sa_generate
-- ----------------------------
DROP TABLE IF EXISTS `sa_generate`;
CREATE TABLE `sa_generate`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单标题',
  `pid` int(1) UNSIGNED NULL DEFAULT 0 COMMENT '顶级菜单',
  `table` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据库表',
  `force` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '强制覆盖',
  `auth` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '菜单鉴权',
  `create` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '生成菜单',
  `global` int(1) UNSIGNED NULL DEFAULT 0 COMMENT '全局模型',
  `icons` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `listField` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列表字段',
  `controller` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '控制器',
  `menus` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '菜单内容',
  `formName` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单名称',
  `formType` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '表单类型',
  `formDesign` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '表单内容',
  `width` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单宽度',
  `height` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表单高度',
  `relation` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '关联数据',
  `status` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成状态',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成器' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_generate
-- ----------------------------
INSERT INTO `sa_generate` VALUES (1, '测试代码', 0, 'sa_ceshi', '1', '1', '1', 0, 'layui-icon-android', 'name,sex,avatar,hobby,age,tags,stars,city,album,json', '/ceshi/index', 'a:5:{i:0;a:6:{s:5:\"title\";s:6:\"查看\";s:5:\"route\";s:11:\"ceshi:index\";s:6:\"router\";s:12:\"/ceshi/index\";s:8:\"template\";s:6:\"默认\";s:4:\"auth\";s:1:\"1\";s:4:\"type\";s:1:\"1\";}i:1;a:6:{s:5:\"title\";s:6:\"添加\";s:5:\"route\";s:9:\"ceshi:add\";s:6:\"router\";s:10:\"/ceshi/add\";s:8:\"template\";s:6:\"默认\";s:4:\"auth\";s:1:\"1\";s:4:\"type\";s:1:\"1\";}i:2;a:6:{s:5:\"title\";s:6:\"编辑\";s:5:\"route\";s:9:\"ceshi:zdy\";s:6:\"router\";s:10:\"/ceshi/zdy\";s:8:\"template\";s:6:\"默认\";s:4:\"auth\";s:1:\"1\";s:4:\"type\";s:1:\"1\";}i:3;a:6:{s:5:\"title\";s:6:\"删除\";s:5:\"route\";s:14:\"ceshi:xiaoMing\";s:6:\"router\";s:15:\"/ceshi/xiaoMing\";s:8:\"template\";s:6:\"默认\";s:4:\"auth\";s:1:\"1\";s:4:\"type\";s:1:\"2\";}i:4;a:6:{s:5:\"title\";s:6:\"状态\";s:5:\"route\";s:12:\"ceshi:status\";s:6:\"router\";s:13:\"/ceshi/status\";s:8:\"template\";s:6:\"默认\";s:4:\"auth\";s:1:\"1\";s:4:\"type\";s:1:\"2\";}}', 'form', '1', '[{\"index\":0,\"tag\":\"input\",\"label\":\"姓名\",\"name\":\"name\",\"type\":\"text\",\"placeholder\":\"请输入\",\"default\":\"\",\"labelwidth\":\"110\",\"width\":100,\"maxlength\":\"\",\"min\":0,\"max\":0,\"required\":false,\"readonly\":false,\"disabled\":false,\"labelhide\":false,\"lay_verify\":\"\"},{\"index\":2,\"tag\":\"radio\",\"name\":\"sex\",\"label\":\"性别\",\"labelwidth\":110,\"width\":100,\"disabled\":false,\"labelhide\":false,\"options\":[{\"title\":\"男\",\"value\":\"1\",\"checked\":true},{\"title\":\"女\",\"value\":\"0\",\"checked\":false}]},{\"index\":3,\"tag\":\"upload\",\"name\":\"avatar\",\"label\":\"用户头像\",\"uploadtype\":\"images\",\"labelwidth\":110,\"width\":100,\"data_size\":102400,\"data_accept\":\"file\",\"disabled\":false,\"required\":false,\"labelhide\":false},{\"index\":5,\"tag\":\"cascader\",\"name\":\"city\",\"label\":\"城市\",\"data_value\":\"label\",\"labelwidth\":110,\"width\":100,\"data_parents\":true,\"labelhide\":false},{\"index\":4,\"tag\":\"checkbox\",\"name\":\"hobby\",\"label\":\"爱好\",\"lay_skin\":\"primary\",\"labelwidth\":110,\"width\":100,\"disabled\":false,\"labelhide\":false,\"options\":[{\"title\":\"写作\",\"value\":\"write\",\"checked\":true},{\"title\":\"阅读\",\"value\":\"read\",\"checked\":true},{\"title\":\"游戏\",\"value\":\"game\",\"checked\":false}]},{\"index\":6,\"tag\":\"json\",\"name\":\"json\",\"label\":\"数组组件\",\"labelwidth\":110,\"width\":100,\"labelhide\":false},{\"index\":7,\"tag\":\"editor\",\"name\":\"content\",\"label\":\"编辑器\",\"editorType\":\"lay-markdown\",\"labelwidth\":110,\"width\":100,\"labelhide\":false}]', '1100px', '750px', 'a:1:{i:0;a:5:{s:5:\"table\";s:7:\"sa_user\";s:5:\"style\";s:6:\"hasOne\";s:10:\"foreignKey\";s:8:\"group_id\";s:8:\"localKey\";s:2:\"id\";s:13:\"relationField\";s:12:\"group_id,pwd\";}}', '0', 1653189709, 1646395278);

-- ----------------------------
-- Table structure for sa_guestbook
-- ----------------------------
DROP TABLE IF EXISTS `sa_guestbook`;
CREATE TABLE `sa_guestbook`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cid` mediumint(9) NULL DEFAULT 0 COMMENT '分类ID',
  `user_id` mediumint(9) NULL DEFAULT 0 COMMENT '用户UID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '游客' COMMENT '姓名 默认游客',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '回复',
  `ip` bigint(20) NULL DEFAULT NULL COMMENT '留言IP',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '留言状态',
  `update_time` int(11) NULL DEFAULT NULL COMMENT '回复时间',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '留言时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `uid`(`user_id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户留言表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_guestbook
-- ----------------------------
INSERT INTO `sa_guestbook` VALUES (1, 0, 1, '游客', 'SwiftAdmin后台极速开发框架，安全高效，简单易懂，不错不错！', '感谢老铁支持！！！', 2130706433, 1, 1653039917, 1611143750, NULL);

-- ----------------------------
-- Table structure for sa_jobs
-- ----------------------------
DROP TABLE IF EXISTS `sa_jobs`;
CREATE TABLE `sa_jobs`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `alias` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位标识',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '岗位描述',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '岗位状态',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_jobs
-- ----------------------------
INSERT INTO `sa_jobs` VALUES (1, '董事长', 'ceo', '日常划水~', 1, 1, 1611234206, NULL);
INSERT INTO `sa_jobs` VALUES (2, '人力资源', 'hr', '招聘人员，员工考核，绩效奖励！', 2, 1, 1611234288, NULL);
INSERT INTO `sa_jobs` VALUES (3, '首席技术岗', 'cto', '主要职责是设计公司的未来，其更多的工作应该是前瞻性的，也就是制定下一代产品的策略和进行研究工作，属于技术战略的重要执行者。CTO还是高级市场人员，他可以从技术角度非常有效地帮助公司推广理念，其中包括公司对技术趋势所持的看法。因此，在大型用户会议上CTO会阐述产品下一代的走向和功能，这也是重要的市场策略。', 3, 1, 1611274959, NULL);
INSERT INTO `sa_jobs` VALUES (4, '首席运营官', 'coo', '又常称为运营官或营运总监)是公司团体里负责监督管理每日活动的高阶官员。COO是企业组织中最高层的成员之一，监测每日的公司运作，并直接报告给首席执行官。在某些公司中COO会同时兼任总裁，但通常COO还是以兼任常务或资深副总裁的情况居多。', 4, 1, 1611274981, NULL);
INSERT INTO `sa_jobs` VALUES (5, '首席财务官', 'cof', '企业治理结构发展到一个新阶段的必然产物。没有首席财务官的治理结构不是现代意义上完善的治理结构。从这一层面上看，中国构造治理结构也应设立CFO之类的职位。当然，从本质上讲，CFO在现代治理结构中的真正含义，不是其名称的改变、官位的授予，而是其职责权限的取得，在管理中作用的真正发挥。', 5, 1, 1611275010, NULL);
INSERT INTO `sa_jobs` VALUES (6, '普通员工', 'pop', '一线员工', 6, 1, 1611275128, NULL);

-- ----------------------------
-- Table structure for sa_systemlog
-- ----------------------------
DROP TABLE IF EXISTS `sa_systemlog`;
CREATE TABLE `sa_systemlog`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名/或系统',
  `module` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模块名',
  `controller` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '控制器',
  `action` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问地址',
  `file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '错误文件地址',
  `line` int(11) NULL DEFAULT NULL COMMENT '错误代码行号',
  `error` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '异常消息',
  `params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求参数',
  `ip` bigint(20) NOT NULL COMMENT 'IP地址',
  `method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问方式',
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志类型',
  `status` int(11) NULL DEFAULT 1 COMMENT '执行状态',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_systemlog
-- ----------------------------

-- ----------------------------
-- Table structure for sa_user
-- ----------------------------
DROP TABLE IF EXISTS `sa_user`;
CREATE TABLE `sa_user`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_id` smallint(5) UNSIGNED NOT NULL DEFAULT 1 COMMENT '组id',
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `pwd` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `salt` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码盐',
  `qq` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'QQ',
  `wechat` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信号',
  `avatar` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `heart` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '这个人很懒，什么都没有留下～ ' COMMENT '用户心情',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'emain',
  `mobile` bigint(20) NULL DEFAULT NULL COMMENT '手机号',
  `card` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '身份证号',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '家庭住址',
  `modify_name` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '修改次数',
  `score` mediumint(9) UNSIGNED NULL DEFAULT 0 COMMENT '积分',
  `question` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密保问题',
  `answer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '答案',
  `gender` int(1) NULL DEFAULT NULL COMMENT '性别',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态',
  `app_id` int(11) NULL DEFAULT NULL COMMENT '用户appid',
  `app_secret` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户appsecret',
  `hits` mediumint(8) UNSIGNED NULL DEFAULT NULL COMMENT '点击量',
  `hits_day` mediumint(8) UNSIGNED NULL DEFAULT NULL COMMENT '日点击',
  `hits_week` mediumint(8) UNSIGNED NULL DEFAULT NULL COMMENT '周点击',
  `hits_month` mediumint(8) UNSIGNED NULL DEFAULT NULL COMMENT '月点击',
  `hits_lasttime` int(11) NULL DEFAULT NULL COMMENT '点击时间',
  `invite_id` int(11) NULL DEFAULT NULL COMMENT '邀请人',
  `valicode` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '激活码',
  `login_ip` bigint(20) NULL DEFAULT NULL COMMENT '登录ip',
  `login_time` int(11) NULL DEFAULT NULL COMMENT '登录时间',
  `login_count` smallint(6) NULL DEFAULT 1 COMMENT '登录次数',
  `url` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '获取用户地址 占位',
  `create_ip` bigint(20) NULL DEFAULT NULL COMMENT '注册IP',
  `create_time` int(11) NOT NULL COMMENT '注册时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `group_id`(`group_id`, `status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_user
-- ----------------------------
INSERT INTO `sa_user` VALUES (1, 1, '测试用户', '66d0e19a2c50829d5e44d9f9288587a7', 'QCjibDrGfW', NULL, NULL, '', '这个人很懒，什么都没有留下～ ', 'test@swiftadmin.net', NULL, NULL, '河北省邯郸市中华区人民东路023号', 0, 0, '你家的宠物叫啥？', '111', NULL, 1, 10001, 'NPcHEZsmentVWSwJDBhTvu', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1861775580, 1653193365, 8, NULL, NULL, 1649039829, NULL);

-- ----------------------------
-- Table structure for sa_user_group
-- ----------------------------
DROP TABLE IF EXISTS `sa_user_group`;
CREATE TABLE `sa_user_group`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '会员组名',
  `alias` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会员标识',
  `score` int(11) NULL DEFAULT NULL COMMENT '会员组积分',
  `upgrade` int(1) NULL DEFAULT NULL COMMENT '是否自动升级',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '会员组状态',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会员组说明',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员组管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_user_group
-- ----------------------------
INSERT INTO `sa_user_group` VALUES (1, '初级会员', 'v1', 10, 1, 1, '新注册会员', NULL);
INSERT INTO `sa_user_group` VALUES (2, '中级会员', 'v2', 100, 1, 1, '活跃会员', NULL);
INSERT INTO `sa_user_group` VALUES (3, '高级会员', 'v3', 500, 1, 1, '高级会员', NULL);
INSERT INTO `sa_user_group` VALUES (4, '超级会员', 'v4', 0, 1, 1, '超神会员', NULL);

-- ----------------------------
-- Table structure for sa_user_third
-- ----------------------------
DROP TABLE IF EXISTS `sa_user_third`;
CREATE TABLE `sa_user_third`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '会员ID',
  `type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录类型',
  `apptype` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '应用类型',
  `unionid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '第三方UNIONID',
  `openid` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '第三方OPENID',
  `nickname` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '第三方会员昵称',
  `access_token` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'AccessToken',
  `refresh_token` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `expires_in` int(10) UNSIGNED NULL DEFAULT 0 COMMENT '有效期',
  `create_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `logintime` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '登录时间',
  `expiretime` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`id`, `user_id`) USING BTREE,
  INDEX `user_id`(`user_id`, `type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方登录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_user_third
-- ----------------------------

-- ----------------------------
-- Table structure for sa_user_validate
-- ----------------------------
DROP TABLE IF EXISTS `sa_user_validate`;
CREATE TABLE `sa_user_validate`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '手机号',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '验证码',
  `event` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '事务类型',
  `status` int(11) NULL DEFAULT 0 COMMENT '验证码状态',
  `create_time` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户验证码表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_user_validate
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
