/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : sademo

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 16/03/2022 14:11:01
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
  `logintime` int(11) NULL DEFAULT NULL COMMENT '最后登录时间',
  `createip` bigint(12) NULL DEFAULT NULL COMMENT '注册IP',
  `status` int(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '用户状态',
  `banned` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封号原因',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '注册时间',
  `updatetime` int(11) NOT NULL COMMENT '修改时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE,
  INDEX `pwd`(`pwd`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台管理员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_admin
-- ----------------------------
INSERT INTO `sa_admin` VALUES (1, '1', '2', '3', 'admin', '权栈', '89780c1518385ef45fd8d8256074e8df', 1, 'a:2:{i:3;s:15:\"隔壁帅小伙\";i:4;s:9:\"技术宅\";}', '/upload/avatar/f8e34ec67a2a0233_100x100.jpg', '海阔天空，有容乃大', 'admin@swiftadmin.net', '0310', '15188888888', '高级管理人员', 188, '河北省邯郸市', 2130706433, 1647329152, 3232254977, 1, NULL, 1596682835, 1647399260, NULL);
INSERT INTO `sa_admin` VALUES (2, '2', '4', '5,6', 'ceshi', '白眉大侠', '89780c1518385ef45fd8d8256074e8df', 1, 'a:3:{i:0;s:6:\"呵呵\";i:1;s:5:\"Think\";i:2;s:12:\"铁血柔肠\";}', '/upload/avatar/a0b923820dcc509a_100x100.png', '吃我一招乾坤大挪移', 'baimei@your.com', '0310', '15188888888', '我原本以为吕布已经天下无敌了，没想到还有比吕布勇猛的，这谁的部将？', 40, '河北省邯郸市廉颇大道110号指挥中心', 2130706433, 1647001149, 3232254977, 1, '违规', 1609836672, 1647001149, NULL);

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '组规则表' ROW_FORMAT = DYNAMIC;

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
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户组表' ROW_FORMAT = DYNAMIC;

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
  `updatetime` int(11) NULL DEFAULT 0 COMMENT '添加时间',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `sort`(`sort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 283 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_admin_rules
-- ----------------------------
INSERT INTO `sa_admin_rules` VALUES (1, 0, 'Dashboard', '#', '#', 0, NULL, '', 0, 'layui-icon-home', 0, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (2, 1, '控制台', '/index/console', 'index:console', 0, NULL, '', 1, '', 0, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (3, 1, '分析页', '/index/analysis', 'index:analysis', 0, NULL, '', 2, '', 0, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (4, 1, '监控页', '/index/monitor', 'index:monitor', 0, NULL, '', 3, '', 0, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (5, 0, '内容管理', '#', '#', 0, NULL, '', 4, 'layui-icon-app', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (6, 5, '栏目管理', '/system.category/index', 'system.category:index', 0, NULL, '', 5, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (7, 6, '查看', '/system.category/index', 'system.category:index', 1, NULL, '', 6, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (8, 6, '添加', '/system.category/add', 'system.category:add', 1, NULL, '', 7, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (9, 6, '编辑', '/system.category/edit', 'system.category:edit', 1, NULL, '', 8, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (10, 6, '删除', '/system.category/del', 'system.category:del', 1, NULL, '', 9, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (11, 6, '状态', '/system.category/status', 'system.category:status', 2, NULL, '', 10, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (12, 5, '内容管理', '/system.content/index', 'system.content:index', 0, NULL, '', 11, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (13, 12, '查看', '/system.content/index', 'system.content:index', 1, NULL, '', 12, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (14, 12, '添加', '/system.content/add', 'system.content:add', 1, NULL, '', 13, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (15, 12, '编辑', '/system.content/edit', 'system.content:edit', 1, NULL, '', 14, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (16, 12, '删除', '/system.content/del', 'system.content:del', 1, NULL, '', 15, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (17, 12, '状态', '/system.content/status', 'system.content:status', 1, NULL, '', 16, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (18, 5, '导航管理', '/system.navmenu/index', 'system.navmenu:index', 0, NULL, '', 17, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (19, 18, '查看', '/system.navmenu/index', 'system.navmenu:index', 1, NULL, '', 18, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (20, 18, '添加', '/system.navmenu/add', 'system.navmenu:add', 1, NULL, '', 19, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (21, 18, '编辑', '/system.navmenu/edit', 'system.navmenu:edit', 1, NULL, '', 20, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (22, 18, '删除', '/system.navmenu/del', 'system.navmenu:del', 1, NULL, '', 21, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (23, 18, '状态', '/system.navmenu/status', 'system.navmenu:status', 2, NULL, '', 22, '', 1, 'normal', 0, 1621989902, 1621989902, NULL);
INSERT INTO `sa_admin_rules` VALUES (24, 0, '运营管理', '#', '#', 0, NULL, '', 23, 'layui-icon-rmb', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (25, 24, '广告管理', '/system.adwords/index', 'system.adwords:index', 0, NULL, '', 24, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (26, 25, '查看', '/system.adwords/index', 'system.adwords:index', 1, NULL, '', 25, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (27, 25, '添加', '/system.adwords/add', 'system.adwords:add', 1, NULL, '', 26, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (28, 25, '编辑', '/system.adwords/edit', 'system.adwords:edit', 1, NULL, '', 27, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (29, 25, '删除', '/system.adwords/del', 'system.adwords:del', 1, NULL, '', 28, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
INSERT INTO `sa_admin_rules` VALUES (30, 25, '状态', '/system.adwords/status', 'system.adwords:status', 2, NULL, '', 29, '', 1, 'normal', 0, 1621989903, 1621989903, NULL);
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
INSERT INTO `sa_admin_rules` VALUES (52, 37, '数据接口', '/system.admin/authorizeinterface', 'system.admin:authorizeinterface', 3, NULL, '', 51, '', 0, 'normal', 0, 1621989904, 1621989904, NULL);
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
INSERT INTO `sa_admin_rules` VALUES (85, 0, 'SEO设置', '#', '#', 0, NULL, '', 84, 'layui-icon-util', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (86, 85, '网址管理', '/system.rewrite/index', 'system.rewrite:index', 0, NULL, '', 85, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (87, 86, '查看', '/system.rewrite/index', 'system.rewrite:index', 1, NULL, '', 86, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (88, 86, '编辑', '/system.rewrite/basecfg', 'system.rewrite:basecfg', 1, NULL, '', 87, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (89, 86, '生成首页', '/system.rewrite/createindex', 'system.rewrite:createindex', 2, NULL, '', 88, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (90, 86, '生成内容', '/system.rewrite/createhtml', 'system.rewrite:createhtml', 2, NULL, '', 89, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (91, 86, '网站地图', '/system.rewrite/createmap', 'system.rewrite:createmap', 2, NULL, '', 90, '', 1, 'normal', 0, 1621989905, 1621989905, NULL);
INSERT INTO `sa_admin_rules` VALUES (97, 85, '标签管理', '/system.tags/index', 'system.tags:index', 0, NULL, '', 96, '', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (98, 97, '查看', '/system.tags/index', 'system.tags:index', 1, NULL, '', 97, '', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (99, 97, '添加', '/system.tags/add', 'system.tags:add', 1, NULL, '', 98, '', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (100, 97, '编辑', '/system.tags/edit', 'system.tags:edit', 1, NULL, '', 99, '', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (101, 97, '删除', '/system.tags/del', 'system.tags:del', 1, NULL, '', 100, '', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (102, 97, '状态', '/system.tags/status', 'system.tags:status', 1, NULL, '', 101, '', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (109, 85, '友情链接', '/system.friendlink/index', 'system.friendlink:index', 0, NULL, '', 108, '', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (110, 109, '查看', '/system.friendlink/index', 'system.friendlink:index', 1, NULL, '', 109, '', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (111, 109, '添加', '/system.friendlink/add', 'system.friendlink:add', 1, NULL, '', 110, '', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (112, 109, '编辑', '/system.friendlink/edit', 'system.friendlink:edit', 1, NULL, '', 111, '', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (113, 109, '删除', '/system.friendlink/del', 'system.friendlink:del', 1, NULL, '', 112, '', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (114, 109, '状态', '/system.friendlink/status', 'system.friendlink:status', 2, NULL, '', 113, '', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (115, 0, '接口管理', '#', '#', 0, NULL, '', 114, 'layui-icon-release', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (116, 115, '项目管理', '/system.project/index', 'system.project:index', 0, NULL, '', 115, '', 1, 'normal', 0, 1621989906, 1621989906, NULL);
INSERT INTO `sa_admin_rules` VALUES (117, 116, '查看', '/system.project/index', 'system.project:index', 1, NULL, '', 116, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (118, 116, '添加', '/system.project/add', 'system.project:add', 1, NULL, '', 117, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (119, 116, '编辑', '/system.project/edit', 'system.project:edit', 1, NULL, '', 118, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (120, 116, '删除', '/system.project/del', 'system.project:del', 1, NULL, '', 119, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (121, 116, '状态', '/system.project/status', 'system.project:status', 2, NULL, '', 120, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (122, 115, '接口配置', '/system.api/index', 'system.api:index', 0, NULL, '', 121, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (123, 122, '查看', '/system.api/index', 'system.api:index', 1, NULL, '', 122, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (124, 122, '添加', '/system.api/add', 'system.api:add', 1, NULL, '', 123, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (125, 122, '编辑', '/system.api/edit', 'system.api:edit', 1, NULL, '', 124, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (126, 122, '删除', '/system.api/del', 'system.api:del', 1, NULL, '', 125, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (127, 122, '状态', '/system.api/status', 'system.api:status', 2, NULL, '', 126, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (128, 122, '请求参数', '/system.api/params', 'system.api:params', 2, NULL, '', 127, '', 0, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (129, 122, '添加参数', '/system.api/paramsadd', 'system.api:paramsadd', 1, NULL, '', 128, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (130, 122, '编辑参数', '/system.api/paramsedit', 'system.api:paramsedit', 1, NULL, '', 129, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (131, 122, '删除参数', '/system.api/paramsdel', 'system.api:paramsdel', 2, NULL, '', 130, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (132, 122, '返回参数', '/system.api/restful', 'system.api:restful', 2, NULL, '', 131, '', 0, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (133, 122, '添加返参', '/system.api/restfuladd', 'system.api:restfuladd', 1, NULL, '', 132, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (134, 122, '编辑返参', '/system.api/restfuledit', 'system.api:restfuledit', 1, NULL, '', 133, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (135, 122, '删除返参', '/system.api/restfuldel', 'system.api:restfuldel', 2, NULL, '', 134, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (136, 122, '请求分组', '/system.api/group', 'system.api:group', 2, NULL, '', 135, '', 0, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (137, 122, '添加分组', '/system.api/groupadd', 'system.api:groupadd', 1, NULL, '', 136, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (138, 122, '编辑分组', '/system.api/groupedit', 'system.api:groupedit', 1, NULL, '', 137, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (139, 122, '删除分组', '/system.api/groupdel', 'system.api:groupdel', 2, NULL, '', 138, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (140, 115, '接口鉴权', '/system.apiaccess/index', 'system.apiaccess:index', 0, NULL, '', 139, '', 1, 'normal', 0, 1621989907, 1621989907, NULL);
INSERT INTO `sa_admin_rules` VALUES (141, 140, '查看', '/system.apiaccess/index', 'system.apiaccess:index', 1, NULL, '', 140, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (142, 140, '添加', '/system.apiaccess/add', 'system.apiaccess:add', 1, NULL, '', 141, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (143, 140, '编辑', '/system.apiaccess/edit', 'system.apiaccess:edit', 1, NULL, '', 142, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (144, 140, '删除', '/system.apiaccess/del', 'system.apiaccess:del', 1, NULL, '', 143, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
INSERT INTO `sa_admin_rules` VALUES (145, 140, '状态', '/system.apiaccess/status', 'system.apiaccess:status', 2, NULL, '', 144, '', 1, 'normal', 0, 1621989908, 1621989908, NULL);
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
INSERT INTO `sa_admin_rules` VALUES (176, 171, '头像上传', '/upload/avatar', 'upload:avatar', 2, NULL, '', 175, '', 0, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (177, 146, '模型管理', '/system.channel/index', 'system.channel:index', 0, NULL, '', 176, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (178, 177, '查看', '/system.channel/index', 'system.channel:index', 1, NULL, '', 177, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (179, 177, '添加', '/system.channel/add', 'system.channel:add', 1, NULL, '', 178, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (180, 177, '编辑', '/system.channel/edit', 'system.channel:edit', 1, NULL, '', 179, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
INSERT INTO `sa_admin_rules` VALUES (181, 177, '删除', '/system.channel/del', 'system.channel:del', 1, NULL, '', 180, '', 1, 'normal', 0, 1621989909, 1621989909, NULL);
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
INSERT INTO `sa_admin_rules` VALUES (228, 0, '其他设置', '#', '#', 0, NULL, '', 227, 'layui-icon-about', 1, 'normal', 0, 1621989911, 1621989911, NULL);
INSERT INTO `sa_admin_rules` VALUES (229, 228, '回收站', '/system.recyclebin/index', 'system.recyclebin:index', 0, NULL, '', 228, '', 1, 'normal', 0, 1621989911, 1621989911, NULL);
INSERT INTO `sa_admin_rules` VALUES (230, 229, '还原', '/system.recyclebin/restore', 'system.recyclebin:restore', 1, NULL, '', 229, '', 1, 'normal', 0, 1621989911, 1621989911, NULL);
INSERT INTO `sa_admin_rules` VALUES (231, 229, '销毁', '/system.recyclebin/destroy', 'system.recyclebin:destroy', 1, NULL, '', 230, '', 1, 'normal', 0, 1621989911, 1621989911, NULL);
INSERT INTO `sa_admin_rules` VALUES (232, 229, '查看', '/system.recyclebin/index', 'system.recyclebin:index', 1, NULL, '', 231, '', 1, 'normal', 0, 1621989911, 1621989911, NULL);
INSERT INTO `sa_admin_rules` VALUES (245, 146, '索引管理', '/system.fulltext/index', 'system.fulltext:index', 0, NULL, '', 245, '', 1, 'normal', 0, 1636198445, 1636198445, NULL);
INSERT INTO `sa_admin_rules` VALUES (252, 0, '代码生成', '/generate.index/index', 'generate.index:index', 0, NULL, '', 33, 'layui-icon-layer', 1, 'normal', 0, 1646735985, 1639725879, NULL);

-- ----------------------------
-- Table structure for sa_adwords
-- ----------------------------
DROP TABLE IF EXISTS `sa_adwords`;
CREATE TABLE `sa_adwords`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '广告标题',
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '广告标识',
  `pic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '代码',
  `remind` tinyint(1) NULL DEFAULT 1 COMMENT '到期提醒',
  `status` smallint(6) NULL DEFAULT 1 COMMENT '状态',
  `expirestime` int(11) NULL DEFAULT NULL COMMENT '过期时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `createtime` int(11) NOT NULL COMMENT '添加时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '广告管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_adwords
-- ----------------------------
INSERT INTO `sa_adwords` VALUES (1, '阿里联盟1', 'alimama_300x250', '/upload/images/2021-04-21/607f877516a50.jpeg', '<script>当前模块未过滤XSS，如不需要请删除该模块！</script>', 1, 1, 1619793011, 1646972507, 1610942227, NULL);

-- ----------------------------
-- Table structure for sa_api
-- ----------------------------
DROP TABLE IF EXISTS `sa_api`;
CREATE TABLE `sa_api`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `app_id` int(11) NOT NULL COMMENT 'appid',
  `pid` int(11) NOT NULL COMMENT '分组ID',
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '接口名称',
  `class` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '接口类/方法名',
  `hash` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '路由映射',
  `model` int(11) NULL DEFAULT 1 COMMENT '接口模式',
  `status` int(11) NULL DEFAULT NULL COMMENT '接口状态',
  `access` int(11) NULL DEFAULT 1 COMMENT '认证方式',
  `method` int(11) NULL DEFAULT 0 COMMENT '请求方式',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序号',
  `version` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'v1' COMMENT '接口版本号',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接口信息描述',
  `request` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '请求示例',
  `restful` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '返回示例',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'API接口信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_api
-- ----------------------------
INSERT INTO `sa_api` VALUES (1, 1, 0, '', 'index/index', 'b5mxzuc2ea', 1, 1, 1, 0, 1, 'v1', '', 'http://www.swiftadmin.net/api/b5mxzuc2ea?id=2&cid=1', '{\"error_code\":\"20000\",\"error_msg\":\"search word not found\"}', 1612082386, NULL);
INSERT INTO `sa_api` VALUES (2, 1, 0, '', 'index/list', 'hdxtwfcd42', 1, 1, 1, 1, 2, 'v1.1.3', '', NULL, NULL, 1612083114, NULL);
INSERT INTO `sa_api` VALUES (3, 1, 0, '', 'index/nodes', 'tc4fdkaghq', 1, 1, 1, 2, 3, 'v1', '', NULL, NULL, 1612083147, NULL);

-- ----------------------------
-- Table structure for sa_api_access
-- ----------------------------
DROP TABLE IF EXISTS `sa_api_access`;
CREATE TABLE `sa_api_access`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `api_id` int(11) NOT NULL COMMENT '接口id',
  `day` int(11) NULL DEFAULT NULL COMMENT '每日调用次数',
  `qps` int(11) NULL DEFAULT NULL COMMENT 'QPS',
  `seconds` int(11) NULL DEFAULT 0 COMMENT '间隔秒数，适合测试接口',
  `ceiling` int(11) NULL DEFAULT NULL COMMENT '接口调用总次数',
  `status` int(10) UNSIGNED NULL DEFAULT 1 COMMENT '规则状态',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序字段',
  `contents` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '规则备注',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '规则创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'api权限规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_api_access
-- ----------------------------
INSERT INTO `sa_api_access` VALUES (1, 1, 1, 5, 0, 0, 10, 1, 1, '这里是规则备注哦', 1612243570);
INSERT INTO `sa_api_access` VALUES (2, 1, 2, 0, 0, 0, 0, 1, 2, '这里可以随便写！备忘', 1613612287);

-- ----------------------------
-- Table structure for sa_api_condition
-- ----------------------------
DROP TABLE IF EXISTS `sa_api_condition`;
CREATE TABLE `sa_api_condition`  (
  `hash` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '主键',
  `day` int(11) NULL DEFAULT NULL COMMENT '每日访问上限',
  `qps` int(11) NULL DEFAULT NULL COMMENT 'QPS',
  `ceiling` int(11) NULL DEFAULT NULL COMMENT '访问总数',
  `seconds` int(11) NULL DEFAULT NULL COMMENT '秒间隔',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`hash`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'api访问控制表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_api_condition
-- ----------------------------
INSERT INTO `sa_api_condition` VALUES ('72225c90a6430113', 1, NULL, 10, 1617199269, 1617199237);

-- ----------------------------
-- Table structure for sa_api_group
-- ----------------------------
DROP TABLE IF EXISTS `sa_api_group`;
CREATE TABLE `sa_api_group`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '上级分类',
  `app_id` int(11) NOT NULL COMMENT '应用类型',
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分组名称',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分组说明',
  `sort` int(11) NULL DEFAULT NULL COMMENT '分组排序',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'api请求参数表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_api_group
-- ----------------------------
INSERT INTO `sa_api_group` VALUES (1, 0, 1, '概述', 'API开始', 1, 1621843822, NULL);
INSERT INTO `sa_api_group` VALUES (2, 0, 1, '获取分类', '分类接口', 2, 1621843876, NULL);
INSERT INTO `sa_api_group` VALUES (3, 0, 1, '接口验证', '会员分类', 3, 1621843892, NULL);
INSERT INTO `sa_api_group` VALUES (4, 1, 1, '基础接口', 'base', 4, 1621846765, NULL);

-- ----------------------------
-- Table structure for sa_api_params
-- ----------------------------
DROP TABLE IF EXISTS `sa_api_params`;
CREATE TABLE `sa_api_params`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL COMMENT '所属接口',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字段名',
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段类型',
  `default` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '默认值',
  `mandatory` int(11) NOT NULL DEFAULT 0 COMMENT '强制必选',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段说明',
  `sort` int(11) NULL DEFAULT NULL COMMENT '字段排序',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'api请求参数表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_api_params
-- ----------------------------
INSERT INTO `sa_api_params` VALUES (1, 1, 'id', 'Integer', '1', 1, '文章id', 1, 1612092258, NULL);
INSERT INTO `sa_api_params` VALUES (2, 1, 'cid', 'Integer', '2', 0, '分类id', 2, 1612092808, NULL);
INSERT INTO `sa_api_params` VALUES (3, 1, 'limit', 'Integer', '10', 0, '分页大小', 3, 1612092872, NULL);
INSERT INTO `sa_api_params` VALUES (4, 1, 'page', 'Integer', '1', 0, '页码', 4, 1612093015, NULL);

-- ----------------------------
-- Table structure for sa_api_restful
-- ----------------------------
DROP TABLE IF EXISTS `sa_api_restful`;
CREATE TABLE `sa_api_restful`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL COMMENT '所属接口',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '返回参数名',
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '返回参数类型',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序字段',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '返回参数说明',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'api返回参数表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_api_restful
-- ----------------------------
INSERT INTO `sa_api_restful` VALUES (1, 1, 'num', 'Integer', 1, '返回数据长度', 1612103650);
INSERT INTO `sa_api_restful` VALUES (2, 1, 'code', 'Integer', 2, '应用返回的响应代码', 1612104178);

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
  `updatetime` int(10) NULL DEFAULT NULL COMMENT '更新时间',
  `createtime` int(10) NULL DEFAULT NULL COMMENT '创建日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '附件表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for sa_category
-- ----------------------------
DROP TABLE IF EXISTS `sa_category`;
CREATE TABLE `sa_category`  (
  `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` smallint(6) NOT NULL COMMENT '父类di',
  `cid` tinyint(1) NOT NULL COMMENT '模型id',
  `name` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '栏目名称',
  `alias` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目别名',
  `access` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问权限',
  `pinyin` varchar(90) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '栏目路径/拼音',
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图片地址',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目SEO标题',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目SEO关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目SEO描述',
  `contribute` int(11) NULL DEFAULT 0 COMMENT '是否支持投稿',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '栏目单页信息',
  `sort` smallint(6) NULL DEFAULT NULL COMMENT '排序id',
  `skin` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目列表页',
  `pages` tinyint(1) NULL DEFAULT 0 COMMENT '是否单页面',
  `items` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '文档数量',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '栏目状态',
  `readurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问地址',
  `jumpurl` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目跳转地址',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `title`(`title`) USING BTREE,
  INDEX `alias`(`alias`) USING BTREE,
  INDEX `access`(`access`) USING BTREE,
  INDEX `pinyin`(`pinyin`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '栏目管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_category
-- ----------------------------
INSERT INTO `sa_category` VALUES (1, 0, 2, '图集2', NULL, '', 'xwpd', '', '', '', '', 0, '', 1, '', 0, 2, 1, NULL, '', 1647163994, 1639749226, NULL);
INSERT INTO `sa_category` VALUES (2, 0, 1, '文章', NULL, '', '', '', '', '', '', 0, '', 2, '', 0, 34, 1, NULL, '', 1647158806, 1646296100, NULL);
INSERT INTO `sa_category` VALUES (3, 0, 3, '视频', NULL, '', '', '', '', '', '', 0, '', 3, '', 0, 1, 1, NULL, '', 1647163033, 1646296108, NULL);
INSERT INTO `sa_category` VALUES (4, 0, 4, '软件', NULL, '', 'rj', '', '', '', '', 0, '', 4, '', 0, 1, 1, NULL, '', 1647163073, 1646296117, NULL);
INSERT INTO `sa_category` VALUES (5, 0, 5, '产品', NULL, '', 'cp', '', '', '', '', 0, '', 5, '', 0, 1, 1, NULL, '', 1647163208, 1646296125, NULL);

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
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_ceshi
-- ----------------------------

-- ----------------------------
-- Table structure for sa_channel
-- ----------------------------
DROP TABLE IF EXISTS `sa_channel`;
CREATE TABLE `sa_channel`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模型名称',
  `table` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据库表',
  `template` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模板名称',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态',
  `sort` tinyint(4) NULL DEFAULT NULL COMMENT '排序字段',
  `updatetime` int(11) NOT NULL COMMENT '更新时间',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据模型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_channel
-- ----------------------------
INSERT INTO `sa_channel` VALUES (1, '文章模型', 'article', 'article', 1, 1, 1636675687, 1595545811, NULL);
INSERT INTO `sa_channel` VALUES (2, '图片模型', 'images', 'images', 1, 2, 1636675700, 1595545853, NULL);
INSERT INTO `sa_channel` VALUES (3, '视频模型', 'video', 'video', 1, 3, 1636675708, 1595545827, NULL);
INSERT INTO `sa_channel` VALUES (4, '软件模型', 'soft', 'soft', 1, 4, 1636676518, 1595545858, NULL);
INSERT INTO `sa_channel` VALUES (5, '产品模型', 'product', 'product', 1, 6, 1636693188, 1595061806, NULL);

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
  `best` int(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最佳评论',
  `count` int(11) NULL DEFAULT 0 COMMENT '回复数量',
  `status` tinyint(3) UNSIGNED NOT NULL DEFAULT 1 COMMENT '审核状态',
  `updatetime` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '添加时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `tid`(`tid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `rid`(`rid`) USING BTREE,
  INDEX `uid`(`user_id`) USING BTREE,
  INDEX `sid`(`sid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_comment
-- ----------------------------

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
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '公司信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_company
-- ----------------------------
INSERT INTO `sa_company` VALUES (1, '北京总部技术公司', 'bj', '北京市东城区长安街880号', 10000, '权栈', 15100000001, '010-10000', 'coolsec@foxmail.com', '91130403XXA0AJ7XXM', '01', '02', 1613711884);
INSERT INTO `sa_company` VALUES (2, '河北分公司', 'hb', '河北省邯郸市丛台区公园路880号', 56000, '权栈', 12345678901, '0310-12345678', 'coolsec@foxmail.com', 'code', NULL, NULL, 1613787702);

-- ----------------------------
-- Table structure for sa_content
-- ----------------------------
DROP TABLE IF EXISTS `sa_content`;
CREATE TABLE `sa_content`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL COMMENT '当前栏目',
  `cid` int(11) NOT NULL COMMENT '当前模型',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `seotitle` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'SEO标题',
  `keywords` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关键词',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述信息',
  `access` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '访问权限',
  `letter` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '首字母',
  `color` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题颜色',
  `thumb` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '缩略图',
  `image` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '文章封面',
  `attribute` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '当前属性',
  `hits` mediumint(8) NULL DEFAULT NULL COMMENT '点击量',
  `hits_day` mediumint(8) NULL DEFAULT NULL COMMENT '日点击',
  `hits_week` mediumint(8) NULL DEFAULT NULL COMMENT '周点击',
  `hits_month` mediumint(8) NULL DEFAULT NULL COMMENT '月点击',
  `hits_lasttime` int(11) NULL DEFAULT NULL COMMENT '点击时间',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `stars` tinyint(3) UNSIGNED NULL DEFAULT 1 COMMENT '星级',
  `score` int(11) NULL DEFAULT NULL COMMENT '浏览所需积分',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态',
  `up` mediumint(9) NULL DEFAULT NULL COMMENT '顶一下',
  `down` mediumint(9) NULL DEFAULT NULL COMMENT '踩一下',
  `gold` decimal(3, 1) NULL DEFAULT NULL COMMENT '评分',
  `golder` smallint(6) NULL DEFAULT NULL COMMENT '评分人数',
  `author` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '作者',
  `admin_id` int(11) NULL DEFAULT NULL COMMENT '管理员id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '会员投稿id',
  `skin` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模板文件',
  `reurl` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源URL',
  `readurl` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问地址',
  `jumpurl` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转地址',
  `updatetime` int(11) NULL DEFAULT 0 COMMENT '更新时间',
  `createtime` int(11) NOT NULL DEFAULT 0 COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `sort`(`sort`) USING BTREE,
  INDEX `createtime`(`createtime`) USING BTREE,
  INDEX `updatetime`(`updatetime`) USING BTREE,
  INDEX `title`(`title`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_content
-- ----------------------------

-- ----------------------------
-- Table structure for sa_content_article
-- ----------------------------
DROP TABLE IF EXISTS `sa_content_article`;
CREATE TABLE `sa_content_article`  (
  `id` int(10) UNSIGNED NOT NULL COMMENT '主键',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容字段',
  `createtime` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_content_article
-- ----------------------------

-- ----------------------------
-- Table structure for sa_content_images
-- ----------------------------
DROP TABLE IF EXISTS `sa_content_images`;
CREATE TABLE `sa_content_images`  (
  `id` int(10) UNSIGNED NOT NULL COMMENT '主键',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容字段',
  `album` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '相册图集',
  `createtime` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '图片模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_content_images
-- ----------------------------

-- ----------------------------
-- Table structure for sa_content_product
-- ----------------------------
DROP TABLE IF EXISTS `sa_content_product`;
CREATE TABLE `sa_content_product`  (
  `id` int(10) UNSIGNED NOT NULL COMMENT '主键',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容字段',
  `album` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '产品图册',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '产品价格',
  `discount` decimal(10, 2) NULL DEFAULT NULL COMMENT '优惠价格',
  `inventory` int(11) NULL DEFAULT NULL COMMENT '库存余量',
  `updatetime` int(11) NULL DEFAULT 0 COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产品模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_content_product
-- ----------------------------

-- ----------------------------
-- Table structure for sa_content_soft
-- ----------------------------
DROP TABLE IF EXISTS `sa_content_soft`;
CREATE TABLE `sa_content_soft`  (
  `id` int(10) UNSIGNED NOT NULL COMMENT '主键',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容字段',
  `file_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '下载地址',
  `file_code` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '软件提取码',
  `file_size` int(11) NULL DEFAULT NULL COMMENT '软件大小',
  `file_ext` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '软件后缀名',
  `file_type` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '软件类型',
  `file_language` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '软件语言',
  `file_env` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '运行软件',
  `file_auth` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '授权方式',
  `file_author` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '软件作者',
  `file_website` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '软件官网',
  `file_downtotal` int(11) NULL DEFAULT NULL COMMENT '下载次数',
  `createtime` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '下载模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_content_soft
-- ----------------------------

-- ----------------------------
-- Table structure for sa_content_video
-- ----------------------------
DROP TABLE IF EXISTS `sa_content_video`;
CREATE TABLE `sa_content_video`  (
  `id` int(8) UNSIGNED NOT NULL COMMENT '主键',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容字段',
  `alias` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '别名',
  `desc` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '简述',
  `class` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类小标签',
  `marks` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '影片备注',
  `actor` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '演员',
  `banner` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '幻灯片',
  `director` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '导演',
  `area` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '地区',
  `language` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '语言',
  `year` smallint(4) NULL DEFAULT NULL COMMENT '年份',
  `continu` int(20) NULL DEFAULT 0 COMMENT '连载',
  `total` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '总数',
  `play` varchar(120) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '播放器组',
  `server` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务器组',
  `note` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '播放器备注',
  `url` longtext CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '播放地址',
  `isfilm` tinyint(1) NULL DEFAULT 1 COMMENT '已上映、未上映',
  `filmtime` int(11) NULL DEFAULT NULL COMMENT '上映日期',
  `minutes` int(11) NULL DEFAULT NULL COMMENT '影片时长',
  `weekday` varchar(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '节目周期，周几播出',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `createtime`(`createtime`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_content_video
-- ----------------------------

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
  `createtime` int(11) NULL DEFAULT NULL COMMENT '添加时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门管理表' ROW_FORMAT = DYNAMIC;

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
  `updatetime` int(11) NULL DEFAULT 0 COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `name`(`name`) USING BTREE,
  INDEX `value`(`value`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 19 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_dictionary
-- ----------------------------
INSERT INTO `sa_dictionary` VALUES (1, 0, '内容属性', 'cattr', 1, '', 1, 1637738903, 1637738903, NULL);
INSERT INTO `sa_dictionary` VALUES (2, 1, '头条', '1', 2, '', 1, 1638093403, 1638093403, NULL);
INSERT INTO `sa_dictionary` VALUES (3, 1, '推荐', '2', 3, '', 1, 1638093425, 1638093425, NULL);
INSERT INTO `sa_dictionary` VALUES (4, 1, '幻灯', '3', 4, '', 1, 1638093430, 1638093430, NULL);
INSERT INTO `sa_dictionary` VALUES (5, 1, '滚动', '4', 5, '', 1, 1638093435, 1638093435, NULL);
INSERT INTO `sa_dictionary` VALUES (6, 1, '图文', '5', 6, '', 1, 1638093456, 1638093456, NULL);
INSERT INTO `sa_dictionary` VALUES (7, 1, '跳转', '6', 7, '', 1, 1638093435, 1638093435, NULL);
INSERT INTO `sa_dictionary` VALUES (8, 0, '友链类型', 'ftype', 8, '', 1, 1638093456, 1638093456, NULL);
INSERT INTO `sa_dictionary` VALUES (9, 8, '资源', '1', 9, '', 1, 1638093430, 1638093430, NULL);
INSERT INTO `sa_dictionary` VALUES (10, 8, '社区', '2', 10, '', 1, 1638093435, 1638093435, NULL);
INSERT INTO `sa_dictionary` VALUES (11, 8, '合作伙伴', '3', 11, '', 1, 1638093456, 1638093456, NULL);
INSERT INTO `sa_dictionary` VALUES (12, 8, '关于我们', '4', 12, '', 1, 1638093461, 1638093461, NULL);
INSERT INTO `sa_dictionary` VALUES (13, 0, '视频属性', 'vattr', 13, '', NULL, 1646900854, 1646900854, NULL);
INSERT INTO `sa_dictionary` VALUES (14, 13, '首页推荐', '1', 14, '', NULL, 1646900865, 1646900865, NULL);
INSERT INTO `sa_dictionary` VALUES (15, 13, '正在热映', '2', 15, '', NULL, 1646900869, 1646900869, NULL);
INSERT INTO `sa_dictionary` VALUES (16, 13, '卫视同步', '3', 16, '', NULL, 1646900874, 1646900874, NULL);
INSERT INTO `sa_dictionary` VALUES (17, 13, '即将上映', '4', 17, '', NULL, 1646900880, 1646900880, NULL);
INSERT INTO `sa_dictionary` VALUES (18, 13, '锁定', '5', 18, '', NULL, 1646900886, 1646900886, NULL);

-- ----------------------------
-- Table structure for sa_friendlink
-- ----------------------------
DROP TABLE IF EXISTS `sa_friendlink`;
CREATE TABLE `sa_friendlink`  (
  `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '友链名称',
  `desc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '友链简介',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '友链logo',
  `url` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '友链地址',
  `type` int(11) NULL DEFAULT 0 COMMENT '友链类型',
  `sort` tinyint(4) NULL DEFAULT NULL COMMENT '排序ID',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '友链状态',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '友情链接表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_friendlink
-- ----------------------------
INSERT INTO `sa_friendlink` VALUES (1, 'SAPHP极速开发', 'ThinkPHP框架里第二好用的框架', '', 'https://www.swiftadmin.net', 9, 1, 1, 1602040473, NULL);

-- ----------------------------
-- Table structure for sa_fulltext
-- ----------------------------
DROP TABLE IF EXISTS `sa_fulltext`;
CREATE TABLE `sa_fulltext`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '索引库',
  `index` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '索引服务器',
  `search` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '搜索服务器',
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '索引服务类型',
  `field` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '字段内容',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_fulltext
-- ----------------------------

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
  `delete` enum('0','1') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除模式',
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
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成器' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_generate
-- ----------------------------
INSERT INTO `sa_generate` VALUES (1, '测试代码', 0, 'sa_ceshi', '0', '0', '1', '1', 0, 'layui-icon-android', 'name,sex,avatar,hobby,age,tags,stars,city,createtime,album,content,json', '/ceshi/index', 'a:5:{i:0;a:6:{s:5:\"title\";s:6:\"查看\";s:5:\"route\";s:11:\"ceshi:index\";s:6:\"router\";s:12:\"/ceshi/index\";s:8:\"template\";s:6:\"默认\";s:4:\"auth\";s:1:\"1\";s:4:\"type\";s:1:\"1\";}i:1;a:6:{s:5:\"title\";s:6:\"添加\";s:5:\"route\";s:9:\"ceshi:add\";s:6:\"router\";s:10:\"/ceshi/add\";s:8:\"template\";s:6:\"默认\";s:4:\"auth\";s:1:\"1\";s:4:\"type\";s:1:\"1\";}i:2;a:6:{s:5:\"title\";s:6:\"编辑\";s:5:\"route\";s:9:\"ceshi:zdy\";s:6:\"router\";s:10:\"/ceshi/zdy\";s:8:\"template\";s:6:\"默认\";s:4:\"auth\";s:1:\"1\";s:4:\"type\";s:1:\"1\";}i:3;a:6:{s:5:\"title\";s:6:\"删除\";s:5:\"route\";s:14:\"ceshi:xiaoMing\";s:6:\"router\";s:15:\"/ceshi/xiaoMing\";s:8:\"template\";s:6:\"默认\";s:4:\"auth\";s:1:\"1\";s:4:\"type\";s:1:\"2\";}i:4;a:6:{s:5:\"title\";s:6:\"状态\";s:5:\"route\";s:12:\"ceshi:status\";s:6:\"router\";s:13:\"/ceshi/status\";s:8:\"template\";s:6:\"默认\";s:4:\"auth\";s:1:\"1\";s:4:\"type\";s:1:\"2\";}}', 'form', '1', '[{\"index\":0,\"tag\":\"input\",\"label\":\"姓名\",\"name\":\"name\",\"type\":\"text\",\"placeholder\":\"请输入\",\"default\":\"\",\"labelwidth\":\"110\",\"width\":100,\"maxlength\":\"\",\"min\":0,\"max\":0,\"required\":false,\"readonly\":false,\"disabled\":false,\"labelhide\":false,\"lay_verify\":\"\"},{\"index\":2,\"tag\":\"radio\",\"name\":\"sex\",\"label\":\"性别\",\"labelwidth\":110,\"width\":100,\"disabled\":false,\"labelhide\":false,\"options\":[{\"title\":\"男\",\"value\":\"1\",\"checked\":true},{\"title\":\"女\",\"value\":\"0\",\"checked\":false}]},{\"index\":3,\"tag\":\"upload\",\"name\":\"avatar\",\"label\":\"用户头像\",\"uploadtype\":\"images\",\"labelwidth\":110,\"width\":100,\"data_size\":102400,\"data_accept\":\"file\",\"disabled\":false,\"required\":false,\"labelhide\":false},{\"index\":5,\"tag\":\"cascader\",\"name\":\"city\",\"label\":\"城市\",\"data_value\":\"label\",\"labelwidth\":110,\"width\":100,\"data_parents\":true,\"labelhide\":false},{\"index\":4,\"tag\":\"checkbox\",\"name\":\"hobby\",\"label\":\"爱好\",\"lay_skin\":\"primary\",\"labelwidth\":110,\"width\":100,\"disabled\":false,\"labelhide\":false,\"options\":[{\"title\":\"写作\",\"value\":\"write\",\"checked\":true},{\"title\":\"阅读\",\"value\":\"read\",\"checked\":true},{\"title\":\"游戏\",\"value\":\"game\",\"checked\":false}]},{\"index\":6,\"tag\":\"json\",\"name\":\"json\",\"label\":\"数组组件\",\"labelwidth\":110,\"width\":100,\"labelhide\":false},{\"index\":1,\"tag\":\"editor\",\"name\":\"content\",\"label\":\"编辑器\",\"labelwidth\":110,\"width\":100,\"labelhide\":false}]', '1100px', '750px', 'a:1:{i:0;a:5:{s:5:\"table\";s:7:\"sa_user\";s:5:\"style\";s:6:\"hasOne\";s:10:\"foreignKey\";s:8:\"group_id\";s:8:\"localKey\";s:2:\"id\";s:13:\"relationField\";s:12:\"group_id,pwd\";}}', '0', 1647410738, 1646395278);

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
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '回复时间',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '留言时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `uid`(`user_id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户留言表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_guestbook
-- ----------------------------
INSERT INTO `sa_guestbook` VALUES (1, 0, 0, '游客', 'SwiftAdmin后台极速开发框架，安全高效，简单易懂，不错不错！', '感谢老铁支持！！！', 2130706433, 1, 1647328244, 1611143750, NULL);

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
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位管理' ROW_FORMAT = DYNAMIC;

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
-- Table structure for sa_navmenu
-- ----------------------------
DROP TABLE IF EXISTS `sa_navmenu`;
CREATE TABLE `sa_navmenu`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NULL DEFAULT 0 COMMENT '父类ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '导航地址',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `status` int(11) NULL DEFAULT 1 COMMENT '状态',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '添加时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '导航表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_navmenu
-- ----------------------------
INSERT INTO `sa_navmenu` VALUES (1, 0, '导航测试', '/xiazai', 1, 1, 1610788293, NULL);
INSERT INTO `sa_navmenu` VALUES (2, 1, '二级导航2', '/daohang', 2, 1, 1610788293, NULL);
INSERT INTO `sa_navmenu` VALUES (3, 1, '网站编辑3', '/xiazaiD', 3, 1, 1610788293, NULL);

-- ----------------------------
-- Table structure for sa_project
-- ----------------------------
DROP TABLE IF EXISTS `sa_project`;
CREATE TABLE `sa_project`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(10) UNSIGNED NULL DEFAULT 0,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `app_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `app_key` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `createtime` int(11) NULL DEFAULT NULL,
  `delete_time` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'APP项目表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_project
-- ----------------------------
INSERT INTO `sa_project` VALUES (1, 0, '示例应用', '/upload/images/2021-04-26/6086c217cb526.jpg', '1000001', 'ydFbQVBsRzovUMiISn0m2pLfY9WDTjkq', '这里只是一个示例应用，是为了方便你的API接口分类用的，仅仅只是一个展示功能！', 1612073268, NULL);

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
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_systemlog
-- ----------------------------
INSERT INTO `sa_systemlog` VALUES (1, 'admin', 'admin', 'ceshi', 'add', '/admin.php/ceshi/add.html', 'C:\\wwwroot\\demo.swiftadmin.net\\runtime\\admin\\temp\\f416d078dcb3b7f4d6deda53c7a98eb2.php', 59, 'Undefined array key \"avatat\"', 'a:0:{}', 2130706433, 'GET', '1', 1, 1647410443);
INSERT INTO `sa_systemlog` VALUES (2, 'admin', 'admin', 'ceshi', 'index', '/admin.php/ceshi/index.html', 'C:\\wwwroot\\demo.swiftadmin.net\\vendor\\topthink\\framework\\src\\think\\route\\dispatch\\Controller.php', 76, 'controller not exists:app\\admin\\controller\\Ceshi', 'a:0:{}', 2130706433, 'GET', '1', 1, 1647410688);

-- ----------------------------
-- Table structure for sa_tags
-- ----------------------------
DROP TABLE IF EXISTS `sa_tags`;
CREATE TABLE `sa_tags`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '词名称',
  `pinyin` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拼音',
  `type` int(11) UNSIGNED NULL DEFAULT 1 COMMENT '1 正常词 2 敏感词',
  `sort` int(11) NULL DEFAULT NULL COMMENT '字段排序',
  `total` int(11) NULL DEFAULT NULL COMMENT '标签调用总数',
  `index` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '搜索指数',
  `link` int(1) UNSIGNED NULL DEFAULT 0 COMMENT '是否内链',
  `status` int(1) UNSIGNED NULL DEFAULT 1 COMMENT '词语状态',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'SEO关键词库' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_tags
-- ----------------------------

-- ----------------------------
-- Table structure for sa_tags_mapping
-- ----------------------------
DROP TABLE IF EXISTS `sa_tags_mapping`;
CREATE TABLE `sa_tags_mapping`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tag_id` int(11) NULL DEFAULT NULL COMMENT '关键词id',
  `aid` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '文档内容id',
  `oid` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '预留其他ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `cid`(`aid`) USING BTREE,
  INDEX `tid`(`tag_id`) USING BTREE,
  INDEX `oid`(`oid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '关键词映射表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_tags_mapping
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
  `salt` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码盐',
  `qq` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'QQ',
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
  `valicode` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '激活码',
  `loginip` bigint(20) NULL DEFAULT NULL COMMENT '登录ip',
  `logintime` int(11) NULL DEFAULT NULL COMMENT '登录时间',
  `logincount` smallint(6) NULL DEFAULT 1 COMMENT '登录次数',
  `readurl` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '获取用户地址 占位',
  `createip` bigint(20) NULL DEFAULT NULL COMMENT '注册IP',
  `createtime` int(11) NOT NULL COMMENT '注册时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `group_id`(`group_id`, `status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_user
-- ----------------------------

-- ----------------------------
-- Table structure for sa_user_group
-- ----------------------------
DROP TABLE IF EXISTS `sa_user_group`;
CREATE TABLE `sa_user_group`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '会员组名',
  `alias` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会员标识',
  `score` int(11) NULL DEFAULT NULL COMMENT '会员组积分',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '会员组状态',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会员组说明',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员组管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_user_group
-- ----------------------------
INSERT INTO `sa_user_group` VALUES (1, '初级会员', 'v1', 10, 1, '新注册会员', NULL);
INSERT INTO `sa_user_group` VALUES (2, '中级会员', 'v2', 100, 1, '活跃会员', NULL);
INSERT INTO `sa_user_group` VALUES (3, '高级会员', 'v3', 500, 1, '高级会员', NULL);
INSERT INTO `sa_user_group` VALUES (4, '超级会员', 'v4', 0, 1, '超神会员', NULL);

-- ----------------------------
-- Table structure for sa_user_invitecode
-- ----------------------------
DROP TABLE IF EXISTS `sa_user_invitecode`;
CREATE TABLE `sa_user_invitecode`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) NULL DEFAULT NULL COMMENT '用户uid',
  `ruid` int(11) NULL DEFAULT NULL COMMENT '使用者uid',
  `code` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邀请码',
  `status` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否使用',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户邀请码表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_user_invitecode
-- ----------------------------

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
  `createtime` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `logintime` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '登录时间',
  `expiretime` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '过期时间',
  PRIMARY KEY (`id`, `user_id`) USING BTREE,
  INDEX `user_id`(`user_id`, `type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方登录表' ROW_FORMAT = DYNAMIC;

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
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户验证码表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_user_validate
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
