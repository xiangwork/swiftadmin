/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : sademo

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 26/04/2021 22:06:58
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
  `dep_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门id',
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
INSERT INTO `sa_admin` VALUES (1, '1', '2', '3', 'admin', '权栈', '94b35cfc5e48ba2e317b880ef8ca14f54ec134f3d2027dd160e7c9c514b88ef9', 1, 'a:3:{i:0;s:21:\"家有傻猫两三只\";i:1;s:15:\"隔壁帅小伙\";i:2;s:9:\"技术宅\";}', '/upload/avatar/f8e34ec67a2a0233_100x100.jpg', '海阔天空，有容乃大', 'admin@swiftadmin.net', '0310', '15100038819', '高级管理人员', 126, '河北省邯郸市', 2130706433, 1619440493, 3232254977, 1, NULL, 1596682835, 1619440493, NULL);
INSERT INTO `sa_admin` VALUES (2, '2', '1', '5,6', 'ceshi', '白眉大侠', '94b35cfc5e48ba2e317b880ef8ca14f54ec134f3d2027dd160e7c9c514b88ef9', 1, 'a:3:{i:0;s:5:\"Think\";i:1;s:12:\"铁血柔肠\";i:2;s:12:\"道骨仙风\";}', '/upload/avatar/a0b923820dcc509a_100x100.png', '吃我一招乾坤大挪移', 'baimei@your.com', '0310', '15188888888', '刀是什么刀，菜刀~来一记webshell~', 28, '河北省邯郸市廉颇大道110号指挥中心', 2130706433, 1619443158, 3232254977, 1, '违规', 1609836672, 1619443158, NULL);

-- ----------------------------
-- Table structure for sa_admin_access
-- ----------------------------
DROP TABLE IF EXISTS `sa_admin_access`;
CREATE TABLE `sa_admin_access`  (
  `uid` mediumint(8) UNSIGNED NOT NULL COMMENT '用户ID',
  `group_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理员分组',
  `rules` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自定义权限',
  `cates` varchar(2048) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目权限',
  PRIMARY KEY (`uid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '组规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_admin_access
-- ----------------------------
INSERT INTO `sa_admin_access` VALUES (1, '1', '4,18,69,70,71,72,19,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,20,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,21,103,104,105,106,107,108,109,22,110,111,112,113,114,23,115', '3');
INSERT INTO `sa_admin_access` VALUES (2, '2', '', '3');

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
  `type` int(2) NULL DEFAULT NULL COMMENT '分组类型',
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
INSERT INTO `sa_admin_group` VALUES (1, 0, NULL, '超级管理员', 'admin', 1, 1, '网站超级管理员组的', NULL, NULL, 'layui-bg-blue', 1607832158, NULL);
INSERT INTO `sa_admin_group` VALUES (2, 1, 2, '网站编辑', 'editor', 1, 1, '负责公司软文的编写', '2,14,49,50,51,52,53,15,54,55,56,57,58,16,59,60,61,62,63,3,17,64,65,66,67,68,4,18,69,70,71,72,19,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,20,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,21,103,104,105,106,107,108,109,22,110,111,112,113,114,23,115', '', 'layui-bg-cyan', 1607832158, NULL);

-- ----------------------------
-- Table structure for sa_admin_rules
-- ----------------------------
DROP TABLE IF EXISTS `sa_admin_rules`;
CREATE TABLE `sa_admin_rules`  (
  `id` int(255) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL DEFAULT 0 COMMENT '父栏目id',
  `title` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '菜单标题',
  `router` char(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '路由地址',
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '菜单，按钮，接口，系统',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `condition` char(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '正则表达式',
  `sort` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '排序',
  `icons` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `auth` tinyint(3) NULL DEFAULT 1 COMMENT '状态',
  `status` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'normal' COMMENT '状态码',
  `isSystem` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '系统级,只可手动操作',
  `updatetime` int(11) NULL DEFAULT 0 COMMENT '添加时间',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `sort`(`sort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 241 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_admin_rules
-- ----------------------------
INSERT INTO `sa_admin_rules` VALUES (1, 0, 'Dashboard', '#', '#', 0, NULL, '', 1, 'layui-icon-home', 0, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (2, 0, '内容管理', '#', '#', 0, NULL, '', 2, 'layui-icon-app', 1, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (3, 0, '运营管理', '#', '#', 0, NULL, '', 3, 'layui-icon-rmb', 1, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (4, 0, '系统管理', '#', '#', 0, NULL, '', 4, 'layui-icon-set-fill', 1, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (5, 0, 'SEO设置', '#', '#', 0, NULL, '', 5, 'layui-icon-util', 1, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (6, 0, '接口管理', '#', '#', 0, NULL, '', 6, 'layui-icon-release', 1, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (7, 0, '高级管理', '#', '#', 0, NULL, '', 7, 'layui-icon-engine', 1, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (8, 0, '插件应用', '#', '#', 0, NULL, '', 8, 'layui-icon-component', 1, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (9, 0, '会员管理', '#', '#', 0, NULL, '', 9, 'layui-icon-user', 1, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (10, 0, '其他设置', '#', '#', 0, NULL, '', 10, 'layui-icon-about', 1, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (11, 1, '控制台', '/index/console', 'index:console', 0, NULL, '', 11, '', 0, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (12, 1, '分析页', '/index/analysis', 'index:analysis', 0, NULL, '', 12, '', 0, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (13, 1, '监控页', '/index/monitor', 'index:monitor', 0, NULL, '', 13, '', 0, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (14, 2, '栏目管理', '/system.category/index', 'system.category:index', 0, NULL, '', 13, '', 1, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (15, 2, '内容管理', '/system.content/index', 'system.content:index', 0, NULL, '', 14, '', 1, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (16, 2, '导航管理', '/system.navmenu/index', 'system.navmenu:index', 0, NULL, '', 15, '', 1, 'normal', 0, 0, 1619437744, NULL);
INSERT INTO `sa_admin_rules` VALUES (17, 3, '广告管理', '/system.adwords/index', 'system.adwords:index', 0, NULL, '', 16, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (18, 4, '基本设置', '/index/basecfg', 'index:basecfg', 0, NULL, '', 17, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (19, 4, '用户管理', '/system.admin/index', 'system.admin:index', 0, NULL, '', 18, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (20, 4, '用户中心', '/system.admin/center', 'system.admin:center', 0, NULL, '', 19, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (21, 4, '角色管理', '/system.admingroup/index', 'system.admingroup:index', 0, NULL, '', 20, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (22, 4, '菜单管理', '/system.adminrules/index', 'system.adminrules:index', 0, NULL, '', 21, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (23, 4, '操作日志', '/system.systemlog/index', 'system.systemlog:index', 0, NULL, '', 22, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (24, 5, 'URL生成', '/system.rewrite/index', 'system.rewrite:index', 0, NULL, '', 23, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (25, 5, 'SEO优化', '/system.seoer/index', 'system.seoer:index', 0, NULL, '', 24, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (26, 5, '标签管理', '/system.tags/index', 'system.tags:index', 0, NULL, '', 25, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (27, 5, '采集接口', '/system.collect/index', 'system.collect:index', 0, NULL, '', 26, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (28, 5, '友情链接', '/system.friendlink/index', 'system.friendlink:index', 0, NULL, '', 30, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (29, 6, '项目管理', '/system.project/index', 'system.project:index', 0, NULL, '', 27, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (30, 6, '接口配置', '/system.api/index', 'system.api:index', 0, NULL, '', 28, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (31, 6, '接口鉴权', '/system.apiaccess/index', 'system.apiaccess:index', 0, NULL, '', 29, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (32, 7, '公司管理', '/system.company/index', 'system.company:index', 0, NULL, '', 30, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (33, 7, '部门管理', '/system.department/index', 'system.department:index', 0, NULL, '', 31, '', 1, 'normal', 0, 0, 1619437745, NULL);
INSERT INTO `sa_admin_rules` VALUES (34, 7, '岗位管理', '/system.jobs/index', 'system.jobs:index', 0, NULL, '', 32, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (35, 7, '字典设置', '/system.dictionary/index', 'system.dictionary:index', 0, NULL, '', 33, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (36, 7, '附件管理', '/system.adminfile/index', 'system.adminfile:index', 0, NULL, '', 34, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (37, 7, '模型管理', '/system.channel/index', 'system.channel:index', 0, NULL, '', 35, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (38, 8, '插件管理', '/system.plugin/index', 'system.plugin:index', 0, NULL, '', 35, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (39, 8, '插件钩子', '/system.pluginhook/index', 'system.pluginhook:index', 0, NULL, '', 36, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (40, 8, '占位菜单', '#', '#', 0, NULL, '', 37, '', 1, 'hidden', 1, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (41, 9, '会员管理', '/system.user/index', 'system.user:index', 0, NULL, '', 38, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (42, 9, '评论管理', '/system.comment/index', 'system.comment:index', 0, NULL, '', 39, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (43, 9, '留言板管理', '/system.guestbook/index', 'system.guestbook:index', 0, NULL, '', 40, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (44, 9, '会员组管理', '/system.usergroup/index', 'system.usergroup:index', 0, NULL, '', 41, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (45, 10, '回收站', '/system.recyclebin/index', 'system.recyclebin:index', 0, NULL, '', 41, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (46, 10, '数据库', '/system.database/index', 'system.database:index', 0, NULL, '', 42, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (47, 10, '限权标志', '###', '###', 3, NULL, '', 224, '', 0, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (48, 10, '模板权限', '/index.tpl/index', 'index.tpl:index', 2, NULL, '', 225, '', 0, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (49, 14, '查看', '/system.category/index', 'system.category:index', 1, NULL, '', 45, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (50, 14, '添加', '/system.category/add', 'system.category:add', 1, NULL, '', 46, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (51, 14, '编辑', '/system.category/edit', 'system.category:edit', 1, NULL, '', 47, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (52, 14, '删除', '/system.category/del', 'system.category:del', 1, NULL, '', 48, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (53, 14, '状态', '/system.category/status', 'system.category:status', 2, NULL, '', 49, '', 1, 'normal', 0, 0, 1619437746, NULL);
INSERT INTO `sa_admin_rules` VALUES (54, 15, '查看', '/system.content/index', 'system.content:index', 1, NULL, '', 228, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (55, 15, '添加', '/system.content/add', 'system.content:add', 1, NULL, '', 229, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (56, 15, '编辑', '/system.content/edit', 'system.content:edit', 1, NULL, '', 230, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (57, 15, '删除', '/system.content/del', 'system.content:del', 1, NULL, '', 255, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (58, 15, '状态', '/system.content/status', 'system.content:status', 1, NULL, '', 256, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (59, 16, '查看', '/system.navmenu/index', 'system.navmenu:index', 1, NULL, '', 53, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (60, 16, '添加', '/system.navmenu/add', 'system.navmenu:add', 1, NULL, '', 54, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (61, 16, '编辑', '/system.navmenu/edit', 'system.navmenu:edit', 1, NULL, '', 55, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (62, 16, '删除', '/system.navmenu/del', 'system.navmenu:del', 1, NULL, '', 56, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (63, 16, '状态', '/system.navmenu/status', 'system.navmenu:status', 2, NULL, '', 57, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (64, 17, '查看', '/system.adwords/index', 'system.adwords:index', 1, NULL, '', 61, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (65, 17, '添加', '/system.adwords/add', 'system.adwords:add', 1, NULL, '', 62, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (66, 17, '编辑', '/system.adwords/edit', 'system.adwords:edit', 1, NULL, '', 63, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (67, 17, '删除', '/system.adwords/del', 'system.adwords:del', 1, NULL, '', 64, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (68, 17, '状态', '/system.adwords/status', 'system.adwords:status', 2, NULL, '', 65, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (69, 18, '修改配置', '/index/baseset', 'index:baseset', 2, NULL, '', 69, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (70, 18, 'FTP接口', '/index/testftp', 'index:testftp', 2, NULL, '', 70, '', 0, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (71, 18, '邮件接口', '/index/testemail', 'index:testemail', 2, NULL, '', 71, '', 0, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (72, 18, '缓存接口', '/index/testcache', 'index:testcache', 2, NULL, '', 72, '', 0, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (73, 19, '查看', '/system.admin/index', 'system.admin:index', 1, NULL, '', 73, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (74, 19, '添加', '/system.admin/add', 'system.admin:add', 1, NULL, '', 74, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (75, 19, '编辑', '/system.admin/edit', 'system.admin:edit', 1, NULL, '', 75, '', 1, 'normal', 0, 0, 1619437747, NULL);
INSERT INTO `sa_admin_rules` VALUES (76, 19, '删除', '/system.admin/del', 'system.admin:del', 1, NULL, '', 76, '', 1, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (77, 19, '状态', '/system.admin/status', 'system.admin:status', 2, NULL, '', 77, '', 1, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (78, 19, '编辑权限', '/system.admin/editrules', 'system.admin:editrules', 2, NULL, '', 84, '', 1, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (79, 19, '编辑栏目', '/system.admin/editcates', 'system.admin:editcates', 2, NULL, '', 87, '', 1, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (80, 19, '系统模板', '/system.admin/theme', 'system.admin:theme', 2, NULL, '', 89, '', 0, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (81, 19, '短消息', '/system.admin/message', 'system.admin:message', 2, NULL, '', 90, '', 0, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (82, 19, '个人中心', '/system.admin/center', 'system.admin:center', 2, NULL, '', 91, '', 0, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (83, 19, '修改资料', '/system.admin/modify', 'system.admin:modify', 2, NULL, '', 92, '', 0, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (84, 19, '修改密码', '/system.admin/pwd', 'system.admin:pwd', 2, NULL, '', 93, '', 0, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (85, 19, '系统语言', '/system.admin/language', 'system.admin:language', 2, NULL, '', 94, '', 0, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (86, 19, '清理缓存', '/system.admin/clear', 'system.admin:clear', 2, NULL, '', 95, '', 0, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (87, 19, '数据接口', '/system.admin/_get_auth_func', 'system.admin:_get_auth_func', 3, NULL, '', 220, '', 1, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (88, 20, '查看', '/system.admin/index', 'system.admin:index', 1, NULL, '', 73, '', 1, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (89, 20, '添加', '/system.admin/add', 'system.admin:add', 1, NULL, '', 74, '', 1, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (90, 20, '编辑', '/system.admin/edit', 'system.admin:edit', 1, NULL, '', 75, '', 1, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (91, 20, '删除', '/system.admin/del', 'system.admin:del', 1, NULL, '', 76, '', 1, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (92, 20, '状态', '/system.admin/status', 'system.admin:status', 2, NULL, '', 77, '', 1, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (93, 20, '编辑权限', '/system.admin/editrules', 'system.admin:editrules', 2, NULL, '', 84, '', 1, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (94, 20, '编辑栏目', '/system.admin/editcates', 'system.admin:editcates', 2, NULL, '', 87, '', 1, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (95, 20, '系统模板', '/system.admin/theme', 'system.admin:theme', 2, NULL, '', 89, '', 0, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (96, 20, '短消息', '/system.admin/message', 'system.admin:message', 2, NULL, '', 90, '', 0, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (97, 20, '个人中心', '/system.admin/center', 'system.admin:center', 2, NULL, '', 91, '', 0, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (98, 20, '修改资料', '/system.admin/modify', 'system.admin:modify', 2, NULL, '', 92, '', 0, 'normal', 0, 0, 1619437748, NULL);
INSERT INTO `sa_admin_rules` VALUES (99, 20, '修改密码', '/system.admin/pwd', 'system.admin:pwd', 2, NULL, '', 93, '', 0, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (100, 20, '系统语言', '/system.admin/language', 'system.admin:language', 2, NULL, '', 94, '', 0, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (101, 20, '清理缓存', '/system.admin/clear', 'system.admin:clear', 2, NULL, '', 95, '', 0, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (102, 20, '数据接口', '/system.admin/_get_auth_func', 'system.admin:_get_auth_func', 3, NULL, '', 220, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (103, 21, '查看', '/system.admingroup/index', 'system.admingroup:index', 1, NULL, '', 96, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (104, 21, '添加', '/system.admingroup/add', 'system.admingroup:add', 1, NULL, '', 97, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (105, 21, '编辑', '/system.admingroup/edit', 'system.admingroup:edit', 1, NULL, '', 98, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (106, 21, '删除', '/system.admingroup/del', 'system.admingroup:del', 1, NULL, '', 99, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (107, 21, '状态', '/system.admingroup/status', 'system.admingroup:status', 2, NULL, '', 100, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (108, 21, '编辑权限', '/system.admingroup/editrules', 'system.admingroup:editrules', 2, NULL, '', 105, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (109, 21, '编辑栏目', '/system.admingroup/editcates', 'system.admingroup:editcates', 2, NULL, '', 107, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (110, 22, '查询', '/system.adminrules/index', 'system.adminrules:index', 1, NULL, '', 108, NULL, 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (111, 22, '添加', '/system.adminrules/add', 'system.adminrules:add', 1, NULL, '', 109, NULL, 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (112, 22, '编辑', '/system.adminrules/edit', 'system.adminrules:edit', 1, NULL, '', 110, NULL, 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (113, 22, '删除', '/system.adminrules/del', 'system.adminrules:del', 1, NULL, '', 111, NULL, 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (114, 22, '状态', '/system.adminrules/status', 'system.adminrules:status', 2, NULL, '', 112, NULL, 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (115, 23, '查询', '/system.systemlog/index', 'system.systemlog:index', 1, NULL, '', 117, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (116, 24, '查看', '/system.rewrite/index', 'system.rewrite:index', 1, NULL, '', 118, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (117, 24, '编辑', '/system.rewrite/basecfg', 'system.rewrite:basecfg', 1, NULL, '', 119, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (118, 24, '生成首页', '/system.rewrite/createindex', 'system.rewrite:createindex', 2, NULL, '', 220, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (119, 24, '生成内容', '/system.rewrite/createhtml', 'system.rewrite:createhtml', 2, NULL, '', 221, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (120, 24, '网站地图', '/system.rewrite/createmap', 'system.rewrite:createmap', 2, NULL, '', 222, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (121, 25, '查看流量', '/system.seoer/index', 'system.seoer:index', 1, NULL, '', 120, '', 1, 'normal', 0, 0, 1619437749, NULL);
INSERT INTO `sa_admin_rules` VALUES (122, 25, '站点列表', '/system.seoer/getsitelist', 'system.seoer:getsitelist', 2, NULL, '', 121, '', 0, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (123, 25, '目录列表', '/system.seoer/getsitedir', 'system.seoer:getsitedir', 2, NULL, '', 122, '', 0, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (124, 25, '数据接口', '/system.seoer/getdata', 'system.seoer:getdata', 2, NULL, '', 123, '', 0, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (125, 26, '查看', '/system.tags/index', 'system.tags:index', 1, NULL, '', 213, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (126, 26, '添加', '/system.tags/add', 'system.tags:add', 1, NULL, '', 213, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (127, 26, '编辑', '/system.tags/edit', 'system.tags:edit', 1, NULL, '', 213, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (128, 26, '删除', '/system.tags/del', 'system.tags:del', 1, NULL, '', 213, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (129, 26, '状态', '/system.tags/status', 'system.tags:status', 1, NULL, '', 213, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (130, 27, '查看', '/system.collect/index', 'system.collect:index', 1, NULL, '', 132, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (131, 27, '添加', '/system.collect/add', 'system.collect:add', 1, NULL, '', 133, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (132, 27, '编辑', '/system.collect/edit', 'system.collect:edit', 1, NULL, '', 134, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (133, 27, '删除', '/system.collect/del', 'system.collect:del', 1, NULL, '', 135, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (134, 27, '状态', '/system.collect/status', 'system.collect:status', 2, NULL, '', 136, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (135, 28, '查看', '/system.friendlink/index', 'system.friendlink:index', 1, NULL, '', 124, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (136, 28, '添加', '/system.friendlink/add', 'system.friendlink:add', 1, NULL, '', 125, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (137, 28, '编辑', '/system.friendlink/edit', 'system.friendlink:edit', 1, NULL, '', 126, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (138, 28, '删除', '/system.friendlink/del', 'system.friendlink:del', 1, NULL, '', 127, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (139, 28, '状态', '/system.friendlink/status', 'system.friendlink:status', 2, NULL, '', 128, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (140, 29, '查看', '/system.project/index', 'system.project:index', 1, NULL, '', 140, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (141, 29, '添加', '/system.project/add', 'system.project:add', 1, NULL, '', 141, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (142, 29, '编辑', '/system.project/edit', 'system.project:edit', 1, NULL, '', 142, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (143, 29, '删除', '/system.project/del', 'system.project:del', 1, NULL, '', 143, '', 1, 'normal', 0, 0, 1619437750, NULL);
INSERT INTO `sa_admin_rules` VALUES (144, 29, '状态', '/system.project/status', 'system.project:status', 2, NULL, '', 144, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (145, 30, '查看', '/system.api/index', 'system.api:index', 1, NULL, '', 148, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (146, 30, '添加', '/system.api/add', 'system.api:add', 1, NULL, '', 149, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (147, 30, '编辑', '/system.api/edit', 'system.api:edit', 1, NULL, '', 150, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (148, 30, '删除', '/system.api/del', 'system.api:del', 1, NULL, '', 151, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (149, 30, '状态', '/system.api/status', 'system.api:status', 2, NULL, '', 152, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (150, 30, '请求参数', '/system.api/params', 'system.api:params', 2, NULL, '', 156, '', 0, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (151, 30, '添加参数', '/system.api/paramsadd', 'system.api:paramsadd', 1, NULL, '', 157, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (152, 30, '编辑参数', '/system.api/paramsedit', 'system.api:paramsedit', 1, NULL, '', 158, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (153, 30, '删除参数', '/system.api/paramsdel', 'system.api:paramsdel', 2, NULL, '', 159, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (154, 30, '返回参数', '/system.api/restful', 'system.api:restful', 2, NULL, '', 160, '', 0, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (155, 30, '添加返参', '/system.api/restfuladd', 'system.api:restfuladd', 1, NULL, '', 161, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (156, 30, '编辑返参', '/system.api/restfuledit', 'system.api:restfuledit', 1, NULL, '', 162, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (157, 30, '删除返参', '/system.api/restfuldel', 'system.api:restfuldel', 2, NULL, '', 163, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (158, 31, '查看', '/system.apiaccess/index', 'system.apiaccess:index', 1, NULL, '', 164, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (159, 31, '添加', '/system.apiaccess/add', 'system.apiaccess:add', 1, NULL, '', 165, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (160, 31, '编辑', '/system.apiaccess/edit', 'system.apiaccess:edit', 1, NULL, '', 166, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (161, 31, '删除', '/system.apiaccess/del', 'system.apiaccess:del', 1, NULL, '', 167, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (162, 31, '状态', '/system.apiaccess/status', 'system.apiaccess:status', 2, NULL, '', 168, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (163, 32, '查看', '/system.company/index', 'system.company:index', 1, NULL, '', 172, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (164, 32, '添加', '/system.company/add', 'system.company:add', 1, NULL, '', 173, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (165, 32, '编辑', '/system.company/edit', 'system.company:edit', 1, NULL, '', 174, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (166, 32, '删除', '/system.company/del', 'system.company:del', 1, NULL, '', 175, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (167, 32, '状态', '/system.company/status', 'system.company:status', 2, NULL, '', 176, '', 1, 'normal', 0, 0, 1619437751, NULL);
INSERT INTO `sa_admin_rules` VALUES (168, 33, '查看', '/system.department/index', 'system.department:index', 1, NULL, '', 180, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (169, 33, '添加', '/system.department/add', 'system.department:add', 1, NULL, '', 181, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (170, 33, '编辑', '/system.department/edit', 'system.department:edit', 1, NULL, '', 182, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (171, 33, '删除', '/system.department/del', 'system.department:del', 1, NULL, '', 183, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (172, 33, '状态', '/system.department/status', 'system.department:status', 2, NULL, '', 184, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (173, 34, '查看', '/system.jobs/index', 'system.jobs:index', 1, NULL, '', 189, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (174, 34, '添加', '/system.jobs/add', 'system.jobs:add', 1, NULL, '', 190, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (175, 34, '编辑', '/system.jobs/edit', 'system.jobs:edit', 1, NULL, '', 191, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (176, 34, '删除', '/system.jobs/del', 'system.jobs:del', 1, NULL, '', 192, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (177, 34, '状态', '/system.jobs/status', 'system.jobs:status', 2, NULL, '', 193, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (178, 35, '查看', '/system.dictionary/index', 'system.dictionary:index', 1, NULL, '', 266, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (179, 35, '添加', '/system.dictionary/add', 'system.dictionary:add', 1, NULL, '', 267, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (180, 35, '编辑', '/system.dictionary/edit', 'system.dictionary:edit', 1, NULL, '', 268, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (181, 35, '删除', '/system.dictionary/del', 'system.dictionary:del', 1, NULL, '', 269, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (182, 35, '状态', '/system.dictionary/status', 'system.dictionary:status', 2, NULL, '', 270, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (183, 36, '查看', '/system.adminfile/index', 'system.adminfile:index', 1, NULL, '', 197, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (184, 36, '编辑', '/system.adminfile/edit', 'system.adminfile:edit', 1, NULL, '', 198, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (185, 36, '删除', '/system.adminfile/del', 'system.adminfile:del', 1, NULL, '', 199, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (186, 36, '附件上传', '/upload/upload', 'upload:upload', 2, NULL, '', 276, '', 0, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (187, 36, '头像上传', '/upload/avatar', 'upload:avatar', 2, NULL, '', 285, '', 0, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (188, 37, '查看', '/system.channel/index', 'system.channel:index', 1, NULL, '', 200, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (189, 37, '添加', '/system.channel/add', 'system.channel:add', 1, NULL, '', 201, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (190, 37, '编辑', '/system.channel/edit', 'system.channel:edit', 1, NULL, '', 202, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (191, 37, '删除', '/system.channel/del', 'system.channel:del', 1, NULL, '', 203, '', 1, 'normal', 0, 0, 1619437752, NULL);
INSERT INTO `sa_admin_rules` VALUES (192, 38, '查看', '/system.plugin/index', 'system.plugin:index', 1, NULL, '', 207, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (193, 38, '安装', '/system.plugin/install', 'system.plugin:install', 1, NULL, '', 208, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (194, 38, '卸载', '/system.plugin/uninstall', 'system.plugin:uninstall', 1, NULL, '', 209, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (195, 38, '配置', '/system.plugin/config', 'system.plugin:config', 1, NULL, '', 210, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (196, 38, '状态', '/system.plugin/status', 'system.plugin:status', 2, NULL, '', 211, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (197, 38, '升级', '/system.plugin/upgrade', 'system.plugin:upgrade', 2, NULL, '', 212, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (198, 38, '数据表', '/system.plugin/tables', 'system.plugin:tables', 2, NULL, '', 213, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (199, 39, '查看', '/system.pluginhook/index', 'system.pluginhook:index', 1, NULL, '', 215, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (200, 39, '添加', '/system.pluginhook/add', 'system.pluginhook:add', 1, NULL, '', 216, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (201, 39, '编辑', '/system.pluginhook/edit', 'system.pluginhook:edit', 1, NULL, '', 217, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (202, 39, '删除', '/system.pluginhook/del', 'system.pluginhook:del', 1, NULL, '', 218, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (203, 39, '状态', '/system.pluginhook/status', 'system.pluginhook:status', 2, NULL, '', 219, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (204, 40, '查看', '#', '#', 1, NULL, '', 223, '', 1, 'hidden', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (205, 40, '安装', '#', '#', 1, NULL, '', 224, '', 1, 'hidden', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (206, 40, '卸载', '#', '#', 1, NULL, '', 225, '', 1, 'hidden', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (207, 40, '预留1', '#', '#', 1, NULL, '', 226, '', 1, 'hidden', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (208, 40, '预留2', '#', '#', 2, NULL, '', 227, '', 1, 'hidden', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (209, 41, '查看', '/system.user/index', 'system.user:index', 1, NULL, '', 228, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (210, 41, '添加', '/system.user/add', 'system.user:add', 1, NULL, '', 229, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (211, 41, '编辑', '/system.user/edit', 'system.user:edit', 1, NULL, '', 230, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (212, 41, '删除', '/system.user/del', 'system.user:del', 1, NULL, '', 231, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (213, 41, '状态', '/system.user/status', 'system.user:status', 2, NULL, '', 232, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (214, 42, '查看', '/system.comment/index', 'system.comment:index', 1, NULL, '', 236, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (215, 42, '回复', '/system.comment/view', 'system.comment:view', 1, NULL, '', 237, '', 1, 'normal', 0, 0, 1619437753, NULL);
INSERT INTO `sa_admin_rules` VALUES (216, 42, '添加', '/system.comment/add', 'system.comment:add', 1, NULL, '', 238, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (217, 42, '编辑', '/system.comment/edit', 'system.comment:edit', 1, NULL, '', 239, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (218, 42, '删除', '/system.comment/del', 'system.comment:del', 1, NULL, '', 240, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (219, 42, '状态', '/system.comment/status', 'system.comment:status', 2, NULL, '', 241, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (220, 43, '查看', '/system.guestbook/index', 'system.guestbook:index', 1, NULL, '', 245, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (221, 43, '回复', '/system.guestbook/reply', 'system.guestbook:reply', 1, NULL, '', 246, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (222, 43, '删除', '/system.guestbook/del', 'system.guestbook:del', 1, NULL, '', 247, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (223, 43, '状态', '/system.guestbook/status', 'system.guestbook:status', 2, NULL, '', 248, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (224, 44, '查看', '/system.usergroup/index', 'system.usergroup:index', 1, NULL, '', 252, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (225, 44, '添加', '/system.usergroup/add', 'system.usergroup:add', 1, NULL, '', 253, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (226, 44, '编辑', '/system.usergroup/edit', 'system.usergroup:edit', 1, NULL, '', 254, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (227, 44, '删除', '/system.usergroup/del', 'system.usergroup:del', 1, NULL, '', 255, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (228, 44, '状态', '/system.usergroup/status', 'system.usergroup:status', 2, NULL, '', 256, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (229, 45, '还原', '/system.recyclebin/restore', 'system.recyclebin:restore', 1, NULL, '', 222, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (230, 45, '销毁', '/system.recyclebin/destroy', 'system.recyclebin:destroy', 1, NULL, '', 223, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (231, 45, '查看', '/system.recyclebin/index', 'system.recyclebin:index', 1, NULL, '', 265, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (232, 46, '查看', '/system.database/index', 'system.database:index', 1, NULL, '', 260, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (233, 46, '优化', '/system.database/optimize', 'system.database:optimize', 1, NULL, '', 261, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (234, 46, '修复', '/system.database/repair', 'system.database:repair', 1, NULL, '', 262, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (235, 46, '配置', '/system.database/config', 'system.database:config', 1, NULL, '', 263, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (236, 46, '备份', '/system.database/export', 'system.database:export', 1, NULL, '', 264, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (237, 47, '栏目限权', 'everycate', 'everycate', 3, '是否限制栏目权限！', '', 274, '', 1, 'normal', 1, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (238, 47, '编辑限权', 'privateauth', 'privateauth', 3, '只可编辑自己发布的数据！请勿删除！', '', 275, '', 1, 'normal', 1, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (239, 48, '查看模板', '/index.tpl/showtpl', 'index.tpl:showtpl', 2, NULL, '', 277, '', 1, 'normal', 0, 0, 1619437754, NULL);
INSERT INTO `sa_admin_rules` VALUES (240, 48, '编辑模板', '/index.tpl/edittpl', 'index.tpl:edittpl', 2, NULL, '', 278, '', 1, 'normal', 0, 0, 1619437755, NULL);

-- ----------------------------
-- Table structure for sa_adwords
-- ----------------------------
DROP TABLE IF EXISTS `sa_adwords`;
CREATE TABLE `sa_adwords`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '广告标题',
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '广告标识',
  `pic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '代码',
  `remind` tinyint(1) NULL DEFAULT 1 COMMENT '到期提醒',
  `status` smallint(1) NULL DEFAULT 1 COMMENT '状态',
  `expirestime` int(11) NULL DEFAULT NULL COMMENT '过期时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `createtime` int(11) NOT NULL COMMENT '添加时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '广告管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_adwords
-- ----------------------------
INSERT INTO `sa_adwords` VALUES (1, '阿里联盟', 'alimama_300x250', '/upload/images/2021-04-21/607f877516a50.jpeg', '<script>当前未过滤XSS，如不需要请删除该模块！</script>', 1, 1, 1619793011, 1619443241, 1610942227, NULL);

-- ----------------------------
-- Table structure for sa_api
-- ----------------------------
DROP TABLE IF EXISTS `sa_api`;
CREATE TABLE `sa_api`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `app_id` int(11) NOT NULL COMMENT 'appid',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '接口名称',
  `class` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '接口类/方法名',
  `hash` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '路由映射',
  `model` int(1) NULL DEFAULT 1 COMMENT '接口模式',
  `status` int(1) NULL DEFAULT NULL COMMENT '接口状态',
  `access` int(1) NULL DEFAULT 1 COMMENT '认证方式',
  `method` int(1) NULL DEFAULT 0 COMMENT '请求方式',
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
INSERT INTO `sa_api` VALUES (1, 1, '接口示例', 'index/index', 'b5mxzuc2ea', 1, 1, 1, 0, 1, 'v1', '', 'http://www.swiftadmin.net/api/b5mxzuc2ea?id=2&cid=1', '{\"error_code\":\"20000\",\"error_msg\":\"search word not found\"}', 1612082386, NULL);
INSERT INTO `sa_api` VALUES (2, 1, '获取分类', 'index/list', 'hdxtwfcd42', 1, 1, 1, 1, 2, 'v1.1.3', '', NULL, NULL, 1612083114, NULL);
INSERT INTO `sa_api` VALUES (3, 1, '获取节点', 'index/nodes', 'tc4fdkaghq', 1, 1, 1, 2, 3, 'v1', '', NULL, NULL, 1612083147, NULL);

-- ----------------------------
-- Table structure for sa_api_access
-- ----------------------------
DROP TABLE IF EXISTS `sa_api_access`;
CREATE TABLE `sa_api_access`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `api_id` int(11) NOT NULL COMMENT '接口id',
  `day` int(11) NULL DEFAULT NULL COMMENT '每日调用次数',
  `qps` int(11) NULL DEFAULT NULL COMMENT 'QPS',
  `seconds` int(11) NULL DEFAULT 0 COMMENT '间隔秒数，适合测试接口',
  `ceiling` int(11) NULL DEFAULT NULL COMMENT '接口调用总次数',
  `status` int(1) UNSIGNED NULL DEFAULT 1 COMMENT '规则状态',
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
-- Table structure for sa_api_params
-- ----------------------------
DROP TABLE IF EXISTS `sa_api_params`;
CREATE TABLE `sa_api_params`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL COMMENT '所属接口',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字段名',
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '字段类型',
  `default` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '默认值',
  `mandatory` int(1) NOT NULL DEFAULT 0 COMMENT '强制必选',
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
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL COMMENT '所属接口',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '返回参数名',
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '返回参数类型',
  `sort` int(255) NULL DEFAULT NULL COMMENT '排序字段',
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
-- Table structure for sa_article
-- ----------------------------
DROP TABLE IF EXISTS `sa_article`;
CREATE TABLE `sa_article`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL COMMENT '当前栏目',
  `cid` int(11) NOT NULL COMMENT '当前模型',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `hash` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '哈希值',
  `access` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '访问权限',
  `letter` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '首字母',
  `color` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题颜色',
  `pinyin` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拼音标识',
  `thumb` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '缩略图',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '文章封面',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容字段',
  `attribute` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '当前属性',
  `seo_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO标题',
  `seo_keywords` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO关键词',
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'SEO描述',
  `hits` mediumint(8) NULL DEFAULT NULL COMMENT '点击量',
  `hits_day` mediumint(8) NULL DEFAULT NULL COMMENT '日点击',
  `hits_week` mediumint(8) NULL DEFAULT NULL COMMENT '周点击',
  `hits_month` mediumint(8) NULL DEFAULT NULL COMMENT '月点击',
  `hits_lasttime` int(11) NULL DEFAULT NULL COMMENT '点击时间',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `stars` tinyint(1) NULL DEFAULT NULL COMMENT '星级',
  `score` int(11) NULL DEFAULT NULL COMMENT '浏览所需积分',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态',
  `up` mediumint(8) NULL DEFAULT NULL COMMENT '顶一下',
  `down` mediumint(8) NULL DEFAULT NULL COMMENT '踩一下',
  `gold` decimal(3, 1) NULL DEFAULT NULL COMMENT '评分',
  `golder` smallint(6) NULL DEFAULT NULL COMMENT '评分人数',
  `skin` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模板文件',
  `reurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源URL',
  `readurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问地址',
  `author` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '作者',
  `admin_id` int(11) NULL DEFAULT NULL COMMENT '管理员id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '会员投稿id',
  `jumpurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转地址',
  `updatetime` int(11) NULL DEFAULT 0 COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `sort`(`sort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_article
-- ----------------------------
INSERT INTO `sa_article` VALUES (1, 1, 1, '“熟蛋返生”作者：身份多重头衔亮眼，宣称曾和熟绿豆“对话”', 'ff34fce19d6b804e', '', 'S', '', 'sdfszzsfdctxlyxcchslddh', '', '', '&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 36px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;已经煮熟的鸡蛋还能&amp;ldquo;返生&amp;rdquo;？甚至孵出小鸡？河南一职业学校校长的&amp;ldquo;论文&amp;rdquo;言之凿凿声称已通过实验完成，立刻在各大网络舆论平台&amp;ldquo;炸屏&amp;rdquo;。&lt;span class=&quot;bjh-p&quot;&gt;这篇题为《熟鸡蛋变成生鸡蛋(鸡蛋返生)-孵化雏鸡的实验报告》的论文宣称：&amp;ldquo;&amp;lsquo;鸡蛋返生&amp;rsquo;，顾名思义，由熟鸡蛋再变成生鸡蛋。这是一个难以想象的，甚至是不可能的，但是这样奇特的现象确实在郑州春霖职业培训学校发生了。一群特别培训的学生，在郭萍老师指导下，正在进行一个奇特实验，即熟鸡蛋重新变成生鸡蛋，并将返生后的生鸡蛋进行孵化成雏鸡，并且已经成功返生了40多枚。&amp;rdquo;&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;澎湃新闻记者4月26日注意到，在万方数据平台上能检索到这篇《熟鸡蛋变成生鸡蛋(鸡蛋返生)-孵化雏鸡的实验报告》。文章刊发于《写真地理》杂志2020年22期，作者是郑州市春霖职业培训学校校长郭平和河南某医院医生白卫云。&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;这位让煮熟的鸡蛋&amp;ldquo;返生&amp;rdquo;的郭平不仅拥有&amp;ldquo;企业家&amp;rdquo;&amp;ldquo;校长&amp;rdquo;&amp;ldquo;学者&amp;rdquo;多重身份，各类&amp;rdquo;头衔&amp;ldquo;亮眼，还与国内热衷传播&amp;rdquo;特异功能&amp;ldquo;人士过从甚密，甚至共同做实验、撰文，宣称自己的学员能和熟绿豆&amp;ldquo;对话&amp;rdquo;。&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;&lt;span class=&quot;bjh-strong&quot; style=&quot;font-size: 18px; font-weight: bold;&quot;&gt;&amp;ldquo;企业家&amp;rdquo;&amp;ldquo;校长&amp;rdquo;&amp;ldquo;学者&amp;rdquo;，身份多元&lt;/span&gt;&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;事实上，郭平并不是发表这一&amp;ldquo;炸屏&amp;rdquo;论文作者的本名。澎湃新闻记者从郑州市春霖职业培训学校方面确认，上述论文作者&amp;ldquo;郭平&amp;rdquo;确系该校校长，本名&amp;ldquo;郭花平&amp;rdquo;，平时也使用名字&amp;ldquo;郭萍&amp;rdquo;。这三个名字在各种场景下都有使用。&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;澎湃新闻记者通过天眼查等工商信息查询系统查询发现，郭花平2018年11月在河南郑州注册了一家名为&amp;ldquo;河南省春霖教育科技有限公司&amp;rdquo;的企业，注册资本100万元，其本人担任公司执行董事。&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;一名与郭平打过交道的河南媒体人26日向澎湃新闻记者证实，郭平（郭萍）确实经常以企业家的身份在郑州活动，近年来又开始以&amp;ldquo;校长&amp;rdquo;&amp;ldquo;学者&amp;rdquo;等多个头衔亮相。&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;值得注意的是，河南媒体大河报&amp;middot;大河客户端2020年10月曾刊文《萍生不息 追梦不止丨访郑州市春霖职业培训学校校长郭萍》，对其做了详细介绍。文章写道：&amp;ldquo;作为业界的领军人物，郑州市春霖职业培训学校校长郭萍教授的头衔自然很多，每一个都是能证明她辉煌的头衔。&amp;rdquo;&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;来看看郭平（郭萍）的头衔。根据上述河南媒体文章介绍，&amp;ldquo;郭萍是国家二级心理咨询师，国家二级企业培训师，河南省科技咨询专家，担任中国科学管理学院学术委员会心脑教育研究中心副主任、心脑教育研究课题组副组长，北京正兴军民融合中心培训部副部长，北京相对论研究联谊会副理事长、河南站站长，国际华人超心理学会中国分会秘书长、华中分会会长，钱学森教育思想研究院研究员，河南省妇联、河南电视台&amp;lsquo;枫调豫顺&amp;rsquo;百人专家团专家，河南省民办教育研究会职业教育专业委员会副理事长，郑州大学省直校友会副秘书长，郑州市春霖心脑教育实验室主任。&amp;rdquo;&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;荣誉方面，&amp;ldquo;多年来，郭萍先后获得&amp;lsquo;民进郑州大学委员会先进个人&amp;rsquo;&amp;lsquo;郑州大学省直校友会先进个人&amp;rsquo;&amp;lsquo;河南省民办教育先进个人&amp;rsquo;&amp;lsquo;河南省首届民办教育优秀教师&amp;rsquo;&amp;lsquo;河南省民办教育行业特色办学先进个人&amp;rsquo;等荣誉称号。&amp;rdquo;&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;对于郭平（郭萍）本人的&amp;ldquo;专业&amp;rdquo;领域，上述文章介绍：&amp;ldquo;郭萍长期从事人体潜意识唤醒开发运用研究的同时，在国内外专业学术杂志发表多篇有关人体大脑潜能开发的科学研究和人体潜能综合运用研究的宝贵经验和优秀的学术论文，诸如在《写真地理》、《格物》(美)、《北京相对论研究快报》等国内外学术期刊发表40余篇著作，并获得多项优秀论文奖，获得了国内外专业人士的首肯和多学科领域学术研究人员的高度认可，倍受人体科学研究专家们的爱戴与赞扬。&amp;rdquo;&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;再来看看郭平（郭萍）担任校长的郑州市春霖职业培训学校，这篇河南媒体的文章透露：&amp;ldquo;关于人体大脑潜能的开发研究与人体潜能综合运用的实践和探索方面，郭萍说，能把这些知识紧密运用到为更多的学生提高学习能力服务中，并带领培训的学生参加北京大学&amp;lsquo;人感应肌能研究&amp;rsquo;国家项目中实验工作，而郑州市春霖职业培训学校便是承载这一事业的特殊组织。该校成立于2009年，拥有雄厚的教育资源，以一流的师资团队、优美的教学环境、先进的教学设施和教学课程服务学员。十一年来，学校秉承&amp;lsquo;诚信办学，服务社会&amp;rsquo;的办学宗旨和&amp;lsquo;学新兴职业技能，让知识与时俱进&amp;rsquo;的办学理念，专业从事国家职业资格认证培训和继续教育提升培训等，推动新职业新工种，培养高技能专业技术人才，连续四年被河南省民办教育研究会和郑州市民政局评授予&amp;lsquo;先进单位&amp;rsquo;荣誉称号。&amp;rdquo;&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;', NULL, '', '鸡蛋,返生,论文,已经,煮熟,还能,甚至', '已经煮熟的鸡蛋还能返生？甚至孵出小鸡？河南一职业学校校长的论文言之凿凿声称已通过实验完成，立刻在各大网络舆论平台炸屏。这篇题为《熟鸡蛋变成生鸡蛋(鸡蛋返...', 0, 0, 0, 0, NULL, 1, 0, 0, 1, 0, 0, 0.0, 0, '', '', NULL, 'admin', 1, NULL, '', 1619444953, 1619444953, NULL);

-- ----------------------------
-- Table structure for sa_category
-- ----------------------------
DROP TABLE IF EXISTS `sa_category`;
CREATE TABLE `sa_category`  (
  `id` smallint(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` smallint(3) NOT NULL COMMENT '父类di',
  `cid` tinyint(1) NOT NULL COMMENT '模型id',
  `title` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '栏目名称',
  `access` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问权限',
  `pinyin` varchar(90) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '栏目路径/拼音',
  `image` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '图片地址',
  `seo_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目SEO标题',
  `seo_keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目SEO关键字',
  `seo_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目SEO描述',
  `contribute` int(1) NULL DEFAULT 0 COMMENT '是否支持投稿',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '栏目单页信息',
  `sort` smallint(3) NULL DEFAULT NULL COMMENT '排序id',
  `skin` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '栏目列表页',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '栏目状态',
  `readurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问地址',
  `skin_detail` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '栏目内容页',
  `skin_child` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '栏目子页面',
  `skin_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '栏目筛选页',
  `jumpurl` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目跳转地址',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '栏目管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_category
-- ----------------------------
INSERT INTO `sa_category` VALUES (1, 0, 1, '默认文章', '', 'mrwz', '', '', NULL, '', 0, '', 1, '', 1, NULL, '', '', '', '', 1619444522, 1619444522, NULL);
INSERT INTO `sa_category` VALUES (2, 0, 2, '美女图片', '', 'mntp', '', '', NULL, '', 0, '', 2, '', 1, NULL, '', '', '', '', 1619444540, 1619444540, NULL);
INSERT INTO `sa_category` VALUES (3, 0, 3, '最新电影', '', 'zxdy', '', '', NULL, '', 0, '', 3, '', 1, NULL, '', '', '', '', 1619444553, 1619444553, NULL);
INSERT INTO `sa_category` VALUES (4, 0, 4, '软件下载', '', 'rjxz', '', '', NULL, '', 0, '', 4, '', 1, NULL, '', '', '', '', 1619444564, 1619444564, NULL);
INSERT INTO `sa_category` VALUES (5, 0, 5, '手机电脑', '', 'sjdn', '', '', NULL, '', 0, '', 5, '', 1, NULL, '', '', '', '', 1619444587, 1619444587, NULL);
INSERT INTO `sa_category` VALUES (6, 1, 1, '二级分类', '', 'ejfl', '', '', NULL, '', 0, '', 6, '', 1, NULL, '', '', '', '', 1619444822, 1619444822, NULL);

-- ----------------------------
-- Table structure for sa_channel
-- ----------------------------
DROP TABLE IF EXISTS `sa_channel`;
CREATE TABLE `sa_channel`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模型名称',
  `table` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '数据库表',
  `skin` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '列表模板',
  `skin_detail` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容页模板',
  `skin_child` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '子页面模板',
  `skin_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '筛选页模板',
  `sort` tinyint(3) NULL DEFAULT NULL COMMENT '排序字段',
  `updatetime` int(11) NOT NULL COMMENT '更新时间',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据模型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_channel
-- ----------------------------
INSERT INTO `sa_channel` VALUES (1, '文章模型', 'article', 'article', 'article_detail', 'article_child', 'article_type', 1, 1596712387, 1595545811, NULL);
INSERT INTO `sa_channel` VALUES (2, '图片模型', 'image', 'image', 'image_detail', 'image_child', 'image_type', 2, 1596711899, 1595545853, NULL);
INSERT INTO `sa_channel` VALUES (3, '视频模型', 'video', 'video', 'video_detail', 'video_child', 'video_type', 3, 1618708753, 1595545827, NULL);
INSERT INTO `sa_channel` VALUES (4, '下载模型', 'download', 'download', 'download_detail', 'download_child', 'download_type', 4, 1618708738, 1595545858, NULL);
INSERT INTO `sa_channel` VALUES (5, '产品模型', 'product', 'product', 'produc_detail', 'product_child', 'product_type', 6, 1595061806, 1595061806, NULL);

-- ----------------------------
-- Table structure for sa_collect
-- ----------------------------
DROP TABLE IF EXISTS `sa_collect`;
CREATE TABLE `sa_collect`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接口名',
  `table` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '数据库表',
  `class` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类方法名',
  `pwd` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接口密码',
  `files` int(1) NULL DEFAULT 0 COMMENT '是否下载附件',
  `token` int(1) NULL DEFAULT NULL COMMENT '是否验证密码',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接口简述',
  `sort` int(11) NULL DEFAULT NULL COMMENT '接口排序',
  `status` int(1) NULL DEFAULT NULL COMMENT '接口状态',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据采集接口' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_collect
-- ----------------------------
INSERT INTO `sa_collect` VALUES (1, '测试接口', 'article', 'cc.index/insert', '123456', 0, 1, '测试入库接口！', 1, 1, 1614309774, NULL);

-- ----------------------------
-- Table structure for sa_comment
-- ----------------------------
DROP TABLE IF EXISTS `sa_comment`;
CREATE TABLE `sa_comment`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cid` mediumint(9) NOT NULL COMMENT '栏目ID',
  `sid` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT '对象ID',
  `rid` int(11) NULL DEFAULT 0 COMMENT '回复ID',
  `pid` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '父级ID',
  `uid` mediumint(9) NULL DEFAULT 0 COMMENT '用户UID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `up` mediumint(9) NULL DEFAULT 0 COMMENT '顶一下',
  `down` mediumint(9) NULL DEFAULT 0 COMMENT '踩一下',
  `ip` bigint(12) NOT NULL COMMENT '评论IP地址',
  `count` int(11) NULL DEFAULT 0 COMMENT '回复数量',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '审核状态',
  `updatetime` int(11) UNSIGNED NULL DEFAULT NULL COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '添加时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户评论表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_comment
-- ----------------------------
INSERT INTO `sa_comment` VALUES (1, 1, 2, 0, 0, 0, 'aaaa', 0, 0, 2130706433, 0, 1, 1613488720, 1613488720, NULL);
INSERT INTO `sa_comment` VALUES (2, 1, 2, 1, 1, 0, 'aaaa', 0, 0, 2130706433, 0, 1, 1613488791, 1613488791, NULL);
INSERT INTO `sa_comment` VALUES (3, 1, 2, 2, 1, 0, '<img src=\"/static/images/face/2.gif\"/>', 0, 0, 2130706433, 0, 1, 1613523621, 1613523621, NULL);
INSERT INTO `sa_comment` VALUES (4, 1, 2, 0, 0, 0, 'aaaa', 0, 0, 2130706433, 0, 1, 1613523649, 1613523649, NULL);
INSERT INTO `sa_comment` VALUES (5, 1, 2, 0, 0, 0, '测试一下评论', 0, 0, 2130706433, 0, 1, 1613527024, 1613527024, NULL);
INSERT INTO `sa_comment` VALUES (6, 1, 2, 0, 0, 0, '呵呵阿萨德', 0, 0, 2130706433, 0, 1, 1619420738, 1613527166, NULL);
INSERT INTO `sa_comment` VALUES (7, 1, 2, 0, 0, 0, '奥术大师大所多', 0, 0, 2130706433, 0, 1, 1619420738, 1613527189, NULL);
INSERT INTO `sa_comment` VALUES (8, 1, 2, 0, 0, 0, '111111111', 1, 1, 2130706433, 0, 1, 1619441875, 1613527272, NULL);
INSERT INTO `sa_comment` VALUES (9, 1, 2, 0, 0, 0, '啊啊啊啊', 2, 1, 2130706433, 0, 1, 1613527283, 1613527283, NULL);
INSERT INTO `sa_comment` VALUES (10, 1, 2, 0, 0, 0, '<img src=\"/static/images/face/2.gif\"/>', 1, 1, 2130706433, 0, 1, 1613528499, 1613528499, NULL);
INSERT INTO `sa_comment` VALUES (11, 1, 2, 0, 0, 0, '<img src=\"/static/images/face/5.gif\"/>', 1, 2, 2130706433, 0, 1, 1619420562, 1613528587, NULL);
INSERT INTO `sa_comment` VALUES (12, 1, 2, 0, 0, 1, '登录状态下的评论', 2, 9, 2130706433, 0, 1, 1619420562, 1613528610, NULL);
INSERT INTO `sa_comment` VALUES (13, 1, 2, 12, 12, 113, '呵呵的', 0, 0, 2130706433, 0, 1, 1619420623, 1613528905, NULL);
INSERT INTO `sa_comment` VALUES (14, 1, 2, 0, 0, 0, '呵呵', 1, 10, 2130706433, 0, 1, 1619420423, 1613536466, NULL);
INSERT INTO `sa_comment` VALUES (15, 1, 2, 0, 0, 113, '呵呵', 18, 36, 2130706433, 0, 1, 1619420423, 1613536520, NULL);
INSERT INTO `sa_comment` VALUES (16, 1, 2, 10, 10, 113, '在这里回复看看', 0, 0, 2130706433, 0, 1, 1619253770, 1613536552, NULL);
INSERT INTO `sa_comment` VALUES (17, 1, 2, 15, 15, 113, '123132', 0, 0, 2130706433, 0, 1, 1619253770, 1613536653, NULL);
INSERT INTO `sa_comment` VALUES (18, 1, 2, 14, 14, 113, '211212', 0, 0, 2130706433, 0, 1, 1619253765, 1613536691, NULL);
INSERT INTO `sa_comment` VALUES (19, 1, 2, 18, 14, 113, '奥术大师大', 0, 0, 2130706433, 0, 1, 1619420623, 1613536707, NULL);
INSERT INTO `sa_comment` VALUES (20, 1, 2, 0, 0, 1, '测试看看', 1, 5, 2130706433, 0, 1, 1617417100, 1617417100, NULL);
INSERT INTO `sa_comment` VALUES (21, 1, 2, 0, 0, 1, '11111', 1, 1, 2130706433, 0, 1, 1619253761, 1617417174, NULL);
INSERT INTO `sa_comment` VALUES (22, 1, 2, 0, 0, 1, '2222', 1, 1, 2130706433, 0, 1, 1619194125, 1617417227, NULL);
INSERT INTO `sa_comment` VALUES (23, 1, 2, 15, 15, 1, '12313', 0, 0, 2130706433, 0, 1, 1619192477, 1617417296, NULL);
INSERT INTO `sa_comment` VALUES (24, 1, 2, 0, 0, 1, '这里是一个什么评论', 0, 1, 2130706433, 0, 1, 1619192477, 1617417311, NULL);
INSERT INTO `sa_comment` VALUES (25, 1, 2, 15, 15, 1, '12313', 0, 0, 2130706433, 0, 1, 1619192477, 1617417339, NULL);
INSERT INTO `sa_comment` VALUES (26, 1, 2, 0, 0, 1, '<img src=\"/static/images/face/2.gif\"/>', 1, 0, 2130706433, 0, 1, 1617417419, 1617417419, NULL);

-- ----------------------------
-- Table structure for sa_company
-- ----------------------------
DROP TABLE IF EXISTS `sa_company`;
CREATE TABLE `sa_company`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公司名称',
  `alias` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公司标识',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公司地址',
  `postcode` int(6) NULL DEFAULT NULL COMMENT '邮编',
  `contact` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `mobile` bigint(11) NULL DEFAULT NULL COMMENT '手机号',
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
-- Table structure for sa_department
-- ----------------------------
DROP TABLE IF EXISTS `sa_department`;
CREATE TABLE `sa_department`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NULL DEFAULT 0 COMMENT '上级ID',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '部门名称',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门区域',
  `head` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '负责人',
  `mobile` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '手机号',
  `email` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '邮箱',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门简介',
  `sort` tinyint(6) NULL DEFAULT NULL COMMENT '排序',
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
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) UNSIGNED NULL DEFAULT 0 COMMENT '字典分类id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典名称',
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '字典值',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序号',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注信息',
  `updatetime` int(11) NULL DEFAULT 0 COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_dictionary
-- ----------------------------
INSERT INTO `sa_dictionary` VALUES (1, 0, '公司类型', 'ctype', 1, '', 1619335705, 1619315177, NULL);
INSERT INTO `sa_dictionary` VALUES (2, 0, '性别', 'sex', 2, '', 1619317798, 1619317798, NULL);
INSERT INTO `sa_dictionary` VALUES (3, 2, '男', '1', 3, '', 1619328741, 1619318908, NULL);
INSERT INTO `sa_dictionary` VALUES (4, 2, '女', '0', 4, '备注', 1619328739, 1619318917, NULL);
INSERT INTO `sa_dictionary` VALUES (5, 2, '未知', '-1', 5, '', 1619319450, 1619318926, NULL);
INSERT INTO `sa_dictionary` VALUES (6, 1, '联盟', 'union', 6, '', 1619333525, 1619330991, NULL);
INSERT INTO `sa_dictionary` VALUES (7, 1, '代码', 'code', 7, '', 1619406074, 1619331113, NULL);
INSERT INTO `sa_dictionary` VALUES (8, 0, 'union', '11', 8, '', 1619335818, 1619333402, NULL);
INSERT INTO `sa_dictionary` VALUES (9, 0, '数据维护', 'data', 9, '', 1619335721, 1619335721, NULL);
INSERT INTO `sa_dictionary` VALUES (10, 0, '多表', '11', 10, '', 1619348044, 1619335795, NULL);
INSERT INTO `sa_dictionary` VALUES (11, 1, 'union', 'dd', 11, '', 1619335801, 1619335801, NULL);

-- ----------------------------
-- Table structure for sa_download
-- ----------------------------
DROP TABLE IF EXISTS `sa_download`;
CREATE TABLE `sa_download`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NULL DEFAULT NULL COMMENT '当前栏目',
  `cid` int(11) NULL DEFAULT NULL COMMENT '当前模型',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称标题',
  `hash` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '哈希值',
  `access` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问权限',
  `letter` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '首字母',
  `color` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题颜色',
  `pinyin` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拼音标识',
  `thumb` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '缩略图',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文章封面',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容字段',
  `attribute` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '当前属性',
  `seo_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO标题',
  `seo_keywords` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO关键词',
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'SEO描述',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '下载地址',
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
  `hits` mediumint(8) NULL DEFAULT NULL COMMENT '点击量',
  `hits_day` mediumint(8) NULL DEFAULT NULL COMMENT '日点击',
  `hits_week` mediumint(8) NULL DEFAULT NULL COMMENT '周点击',
  `hits_month` mediumint(8) NULL DEFAULT NULL COMMENT '月点击',
  `hits_lasttime` int(11) NULL DEFAULT NULL COMMENT '点击时间',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `stars` tinyint(1) NULL DEFAULT NULL COMMENT '星级',
  `score` int(11) NULL DEFAULT NULL COMMENT '浏览所需积分',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态',
  `up` mediumint(8) NULL DEFAULT NULL COMMENT '顶一下',
  `down` mediumint(8) NULL DEFAULT NULL COMMENT '踩一下',
  `gold` decimal(3, 1) NULL DEFAULT NULL COMMENT '评分',
  `golder` smallint(6) NULL DEFAULT NULL COMMENT '评分人数',
  `skin` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模板文件',
  `reurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源URL',
  `readurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问地址',
  `author` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '作者',
  `admin_id` int(11) NULL DEFAULT NULL COMMENT '管理员id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '会员投稿id',
  `jumpurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转地址',
  `updatetime` int(11) NULL DEFAULT 0 COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `sort`(`sort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '下载模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_download
-- ----------------------------
INSERT INTO `sa_download` VALUES (1, 4, 4, '钉钉电脑版 v6.0.12.4190263官方版', 'd4dd1fc61c6f884f', '', 'D', '', 'dddnbgfb', 'http://6.pic.pc6.com/thumb/n231fz325h12xp36/16f600e218286bbc_600_0.jpeg', '/upload/images/2021-04-26/6086c8354fc3b.jpg', '&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;&lt;strong&gt;　企业沟通功能&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　视频电话会议&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.高清稳定的画面&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.随时随地高效沟通&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　3.支持3到5人同时加入&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　商务电话&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.一键发起商务电话，让团队内部沟通变得简单便捷，简易高效的电话会议体验，支持2~9人同时加入。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.商务电话免费，降低沟通成本。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　3.新颖的电话面板控制方式，实时显示参会者在线状态和通话质量；&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　4.快速发起会议，实时增加、删除成员，控制静音，面板皆可实现。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　5.高清电话会议语音，底层采用业界顶尖语音编解码引擎和运营商级语音线路。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　DING功能&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.&lt;a style=&quot;text-decoration-line: none; color: #0984c5;&quot; href=&quot;/&quot; target=&quot;_blank&quot; rel=&quot;noopener&quot;&gt;钉钉&lt;/a&gt;发出的DING消息将会以免费电话OR免费短信OR应用内消息的方式通知到对方。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.无论接收手机有无安装钉钉APP，是否开启网络流量，均可收到DING消息，实现无障碍的信息必达。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　3.当接受人收到DING消息提醒电话时，号码显示为发送方的电话，接收方接听电话听到发送方的语音信息后，如果是文字信息，系统会将文字播报给收听方，接收方即可直接进行语音回复，发送方便可及时收到回复。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　&lt;strong&gt;消息已读未读&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.无论是一对一聊天，还是一对多的群消息，钉钉让用户都能知道发出的消息对方是否阅读，哪些人已阅，哪些人未读。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.用户发送信息后，消息旁显示&amp;ldquo;n人未读&amp;rdquo;，尤其是在群里发布信息（钉钉支持1500人大群），点击&amp;ldquo;n人未读&amp;rdquo;可查看未读人和已读人的详细列表，并能够对未读人发送DING消息。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　团队组建功能&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　钉钉推出了所有用户新建团队OR企业功能，任意一个企业、组织或者个人，无论你是企业内的部门、企业内的兴趣团体、企业内的虚拟项目组等待，甚至是社团、班级及其他社会组织&amp;middot;&amp;middot;&amp;middot;你都可以快速创建你的团队，并且享受大量免费权益。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　澡堂模式&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.澡堂模式是基于消息分层理念的升级，在普通聊天窗点击聊页面点击右上角的墨镜图标开启澡堂对话。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.在此模式下，信息不能被复制，用户不用担心被&lt;a style=&quot;text-decoration-line: none; color: #0984c5;&quot; href=&quot;/&quot; target=&quot;_blank&quot; rel=&quot;noopener&quot;&gt;录音&lt;/a&gt;，姓名、头像都会被打马赛克。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　3.聊天内容在已读后30秒内消失，不留痕迹。如同在澡堂一般，只能&amp;ldquo;看在眼里、烂在心里&amp;rdquo;，保证重要信息沟通隐私安全。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　4.针对安全诉求更高的用户，钉钉可以在设置中开启隐藏澡堂对话功能，让信息真正安全！&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　企业&lt;a style=&quot;text-decoration-line: none; color: #0984c5;&quot; href=&quot;/&quot; target=&quot;_blank&quot; rel=&quot;noopener&quot;&gt;通讯录&lt;/a&gt;&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.上传企业内部全体成员、同事的职务title、负责业务、联系等到钉钉后用户即可不存号码，就能找到同事、团队成员。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.钉钉通讯录还与个人通讯录打通，可同时添加公司同事和个人通讯录朋友，方便发起各种聊天、群、多人电话。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;&lt;img style=&quot;border: 0px; display: block; margin: 0px auto;&quot; src=&quot;http://6.pic.pc6.com/thumb/n231fz325h12xp36/16f600e218286bbc_600_0.jpeg&quot; /&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　&lt;strong&gt;企业群&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.钉钉可以成立企业群，&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　企业群员是经过员工表格确定的，保障安全。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.&amp;ldquo;认证用户&amp;rdquo;才能进入到&amp;ldquo;企业群&amp;rdquo;中，该群只包含企业内通讯人，一旦出现人事变动，离职员工会即时从整个通讯录和所有群组中退出。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　3.企业群支持群公告发布，发布后支持实时查看已读未读[29] &amp;nbsp;。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　企业（团队）办公协同功能&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　&lt;strong&gt;C-S martWork&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.多种方式&lt;a style=&quot;text-decoration-line: none; color: #0984c5;&quot; href=&quot;/&quot; target=&quot;_blank&quot; rel=&quot;noopener&quot;&gt;考勤&lt;/a&gt;，支持无网络信号打卡。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.日志智能报表，实时掌握团队业务数据。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　3.审批支持自定义，自建模版表单，满足个性需求。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　C-OA【钉OA】&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.与通讯结合的企业办公，高效快速完成审批，通知，日志等办公必备应用。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.结合钉钉的基础通信能力，将各种办公审批快速短信，电话通知对方，消息必达。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　审批功能&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　钉钉中审批有着自己独到的功能，融合通讯移动办公，随时随地申请秒批，零等待和更强大的执行力。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　公告功能&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.C-OA提供了DING公告的概念，员工是否阅读过公&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　告内容清晰可见。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.公告内容只有企业群内部人员才可以看到，独有的&amp;ldquo;水印&amp;rdquo;功能保障信息安全。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　3.和线下公告不同的是，除了文本内容以外，线上公告还可以提供附件功能，文件可添加。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　日志功能&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.钉钉日志支持，不同的企业，日志有不同的统一格式，方便员工填写。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.日志支持，横屏手机即可自动汇总报表。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　管理日历&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.钉钉推出了管理模式，管理者&amp;ldquo;方寸之间，尽在掌握&amp;rdquo;。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.进入管理日历之后，企业人员的签到、请假外出、日报提交等状态，将会一览无遗。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　签到功能&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　外勤签到，管理者可快速查看团队外出员工分布，掌握员工外勤工作情况。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　&lt;strong&gt;企业主页&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.钉钉认证企业可以在PC端管理后台设置自己的主页，企业可上传自己企业的LOGO，简介，业务，电话，网址等信息；&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.支持把企业对外的联系人显示出来，非本企业员工可以通过企业主页联系到企业相应人员。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　C-mail【钉邮】&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　与&lt;a style=&quot;text-decoration-line: none; color: #0984c5;&quot; href=&quot;/&quot; target=&quot;_blank&quot; rel=&quot;noopener&quot;&gt;即时通讯&lt;/a&gt;高度融合的商务办公邮箱，把Email进化为C-Mail，已读未读一目了然，沟通进度可追踪可推动，重要邮件不再错过。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　邮件发送方&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.在C-Mail中，员工发送的邮件，&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　不仅仅能够投递到对方的邮箱中，同时还会在对方的聊天窗口里有所提示。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.写邮件时候变得轻松，支持选择聊天群组发送给全员，无需一一选人，同时，添加附件也极其方便，与C-Space无缝衔接，快捷选择、快捷查看企业文件、群文件、个人文件。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　3.拥有邮件的已读未读功能，第一时间知道邮件是否送达。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　4.邮件DING功能则可以将信息通过信息甚至电话直接送达到对方手中。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　邮件接收方&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.钉钉支持重要邮件自动推送，&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　自动在邮箱里置顶，重要的邮件不会错过。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.钉钉拥有一键唤起电话会议功能，当邮件已经不能解决问题时，只要点击电话按钮，钉钉将会自动联系所有的邮件收件人，唤起电话会议。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　&lt;strong&gt;　C-Space【钉盘】&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　1.与统一通讯打通的企业&lt;a style=&quot;text-decoration-line: none; color: #0984c5;&quot; href=&quot;/&quot; target=&quot;_blank&quot; rel=&quot;noopener&quot;&gt;云盘&lt;/a&gt;体验，基于专业的阿里云服务。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　2.除了满足可靠、稳定、安全等企业基础诉求之外，还针对工作中的文件场景进行了专门的设计。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　3.在C-Space里，你可以自由设置自己文件的权限。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　4.C-Space打通了多端跨平台存储共享，不管是电脑上存储了，手机取出，还是手机存储了，电脑取出，再无限制。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　5.针对离职员工甚至调职员工可能产生的信息泄露，钉钉提供了权限保护功能，员工一旦离开了相应的权限，则会自动失去了文件的访问能力。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　6.企业聊天文件自动存储到钉盘，在网页版还可以进行批量下载&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;&lt;strong&gt;　　开放平台&lt;/strong&gt;&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　钉钉坚持，为企业服务需要有一个开放的心态！&lt;/p&gt;\n&lt;p style=&quot;margin: 0px 0px 15px; padding: 0px; line-height: 24px; clear: both; color: #676767; font-family: 微软雅黑, 宋体, arial; font-size: 14px; background-color: #ffffff;&quot;&gt;　　用户采购的现成OA系统，还是自主开发的OA解决方案，钉钉提供了解决方案：大型企业自有OA，可以与钉钉通讯打通。&lt;/p&gt;', NULL, '', '沟通,电话会议,高效,同时,加入,商务电话,企业', '企业沟通功能 视频电话会议 1.高清稳定的画面 2.随时随地高效沟通 3.支持3到5人同时加入 商务电话 1.一键发起商务电话，让团队内部沟通变得简单便...', NULL, '', 12112, '.rar', '国产软件', '简体中文', '', '免费软件', '阿里巴巴', 'http://www.dingtalk.com/', 999, 0, 0, 0, 0, NULL, 1, 0, 0, 1, 0, 0, 0.0, 0, '', '', NULL, 'admin', 1, NULL, '', 1619445818, 1619445818, NULL);

-- ----------------------------
-- Table structure for sa_friendlink
-- ----------------------------
DROP TABLE IF EXISTS `sa_friendlink`;
CREATE TABLE `sa_friendlink`  (
  `id` tinyint(4) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '友链名称',
  `logo` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '友链logo',
  `url` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '友链地址',
  `type` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '友链类型',
  `sort` tinyint(4) NULL DEFAULT NULL COMMENT '排序ID',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '友链状态',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '友情链接表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_friendlink
-- ----------------------------
INSERT INTO `sa_friendlink` VALUES (1, '百度', '/upload/images/2021-04-23/6082688028cc5.png', 'http://www.baidu.com/', '社区', 0, 1, 1602040473, NULL);
INSERT INTO `sa_friendlink` VALUES (2, 'swiftadmin', '', 'http://www.swiftadmin.net', '合作伙伴', NULL, 1, 1619159727, NULL);

-- ----------------------------
-- Table structure for sa_guestbook
-- ----------------------------
DROP TABLE IF EXISTS `sa_guestbook`;
CREATE TABLE `sa_guestbook`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cid` mediumint(8) NULL DEFAULT 0 COMMENT '分类ID',
  `uid` mediumint(9) NULL DEFAULT 0 COMMENT '用户UID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '游客' COMMENT '姓名 默认游客',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '内容',
  `reply` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '回复',
  `ip` bigint(12) NULL DEFAULT NULL COMMENT '留言IP',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '留言状态',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '回复时间',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '留言时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户留言表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_guestbook
-- ----------------------------
INSERT INTO `sa_guestbook` VALUES (1, 0, 0, '游客', 'SwiftAdmin后台极速开发框架，安全高效，简单易懂，不错不错！', '感谢老铁支持！！！', 2130706433, 1, 1612536747, 1611143750, NULL);

-- ----------------------------
-- Table structure for sa_image
-- ----------------------------
DROP TABLE IF EXISTS `sa_image`;
CREATE TABLE `sa_image`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL COMMENT '当前栏目',
  `cid` int(11) NOT NULL COMMENT '当前模型',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `hash` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '哈希值',
  `access` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问权限',
  `letter` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '首字母',
  `color` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题颜色',
  `pinyin` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拼音标识',
  `thumb` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '缩略图',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文章封面',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容字段',
  `album` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '相册图集',
  `attribute` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '当前属性',
  `seo_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO标题',
  `seo_keywords` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO关键词',
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'SEO描述',
  `hits` mediumint(8) NULL DEFAULT NULL COMMENT '点击量',
  `hits_day` mediumint(8) NULL DEFAULT NULL COMMENT '日点击',
  `hits_week` mediumint(8) NULL DEFAULT NULL COMMENT '周点击',
  `hits_month` mediumint(8) NULL DEFAULT NULL COMMENT '月点击',
  `hits_lasttime` int(11) NULL DEFAULT NULL COMMENT '点击时间',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `stars` tinyint(1) NULL DEFAULT NULL COMMENT '星级',
  `score` int(11) NULL DEFAULT NULL COMMENT '浏览所需积分',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态',
  `up` mediumint(8) NULL DEFAULT NULL COMMENT '顶一下',
  `down` mediumint(8) NULL DEFAULT NULL COMMENT '踩一下',
  `gold` decimal(3, 1) NULL DEFAULT NULL COMMENT '评分',
  `golder` smallint(6) NULL DEFAULT NULL COMMENT '评分人数',
  `skin` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模板文件',
  `reurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源URL',
  `readurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问地址',
  `author` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '作者',
  `admin_id` int(11) NULL DEFAULT NULL COMMENT '管理员id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '会员投稿id',
  `jumpurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转地址',
  `updatetime` int(11) NULL DEFAULT 0 COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `sort`(`sort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '图片模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_image
-- ----------------------------
INSERT INTO `sa_image` VALUES (1, 2, 2, '2021春天樱花季和服少女写真', '9d4c2f636f067f89', '', 'X', '', 'ctyhjhfsnxz', '', '', '&lt;p&gt;樱花季终于来啦！！做了模特两三年第一次拍到了樱花虽然杭州的天气不是特别给力 但是还是给面子的出来了一点点&lt;/p&gt;\n&lt;p&gt;我们去的是良渚那边的四歌樱花园 应该是全杭州樱花树最多的地方了吧 虽然真的有点远 但是一大片樱花树林在哪里等着你们 而且这里的樱花树非常矮 拍起来很方便&lt;/p&gt;', 'a:3:{i:0;a:2:{s:3:\"src\";s:43:\"/upload/images/2021-04-26/6086c57b85ca2.jpg\";s:5:\"title\";s:0:\"\";}i:1;a:2:{s:3:\"src\";s:43:\"/upload/images/2021-04-26/6086c57ed0e56.jpg\";s:5:\"title\";s:0:\"\";}i:2;a:2:{s:3:\"src\";s:43:\"/upload/images/2021-04-26/6086c581cb02d.jpg\";s:5:\"title\";s:0:\"\";}}', '4', '', '这里,简介', '这里是简介', 0, 0, 0, 0, NULL, 1, 3, 0, 1, 0, 0, 0.0, 0, '', '', NULL, 'admin', 1, NULL, '', 1619445186, 1619107275, NULL);

-- ----------------------------
-- Table structure for sa_jobs
-- ----------------------------
DROP TABLE IF EXISTS `sa_jobs`;
CREATE TABLE `sa_jobs`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `alias` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位标识',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '岗位描述',
  `sort` int(6) NULL DEFAULT NULL COMMENT '排序',
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
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NULL DEFAULT 0 COMMENT '父类ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '导航地址',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `status` int(1) NULL DEFAULT 1 COMMENT '状态',
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
-- Table structure for sa_pluginhook
-- ----------------------------
DROP TABLE IF EXISTS `sa_pluginhook`;
CREATE TABLE `sa_pluginhook`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '接口名',
  `class` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '类方法名',
  `trigger` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '触发位置',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '事件简述',
  `sort` int(11) NULL DEFAULT NULL COMMENT '事件排序',
  `status` int(1) NULL DEFAULT NULL COMMENT '事件状态',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '插件钩子管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_pluginhook
-- ----------------------------
INSERT INTO `sa_pluginhook` VALUES (1, 'appInit', 'plugin', '插件初始化前触发', '插件加载初始化,请注意区分AppInit系统内核钩子', 1, 1, 1614309774, NULL);
INSERT INTO `sa_pluginhook` VALUES (2, 'user_sidenav_before', 'plugin', '用户左侧菜单前置', '用户菜单前置hook', 2, 1, 1617428894, NULL);
INSERT INTO `sa_pluginhook` VALUES (3, 'user_sidenav_after', 'plugin', '用户左侧菜单后置', '用户菜单后置hook', 3, 1, 1617428915, NULL);
INSERT INTO `sa_pluginhook` VALUES (4, 'template', '插件', '插件安装，禁用启用，切换模板触发', '为你插件目录下的template文件夹', 4, 1, 1617428969, NULL);
INSERT INTO `sa_pluginhook` VALUES (5, 'clouduploads', '插件', '支持腾讯云阿里云上传钩子', '', 5, 1, 1617432900, NULL);

-- ----------------------------
-- Table structure for sa_product
-- ----------------------------
DROP TABLE IF EXISTS `sa_product`;
CREATE TABLE `sa_product`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL COMMENT '当前栏目',
  `cid` int(11) NOT NULL COMMENT '当前模型',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `hash` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '哈希值',
  `access` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问权限',
  `letter` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '首字母',
  `color` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题颜色',
  `pinyin` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拼音标识',
  `thumb` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '缩略图',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文章封面',
  `album` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '产品图册',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容字段',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '产品价格',
  `discount` decimal(10, 2) NULL DEFAULT NULL COMMENT '优惠价格',
  `inventory` int(11) NULL DEFAULT NULL COMMENT '库存余量',
  `attribute` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '当前属性',
  `seo_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO标题',
  `seo_keywords` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO关键词',
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'SEO描述',
  `hits` mediumint(8) NULL DEFAULT NULL COMMENT '点击量',
  `hits_day` mediumint(8) NULL DEFAULT NULL COMMENT '日点击',
  `hits_week` mediumint(8) NULL DEFAULT NULL COMMENT '周点击',
  `hits_month` mediumint(8) NULL DEFAULT NULL COMMENT '月点击',
  `hits_lasttime` int(11) NULL DEFAULT NULL COMMENT '点击时间',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `stars` tinyint(1) NULL DEFAULT NULL COMMENT '星级',
  `score` int(11) NULL DEFAULT NULL COMMENT '浏览所需积分',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态',
  `up` mediumint(8) NULL DEFAULT NULL COMMENT '顶一下',
  `down` mediumint(8) NULL DEFAULT NULL COMMENT '踩一下',
  `gold` decimal(3, 1) NULL DEFAULT NULL COMMENT '评分',
  `golder` smallint(6) NULL DEFAULT NULL COMMENT '评分人数',
  `skin` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模板文件',
  `reurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源URL',
  `readurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问地址',
  `author` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '作者',
  `admin_id` int(11) NULL DEFAULT NULL COMMENT '管理员id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '会员投稿id',
  `jumpurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转地址',
  `updatetime` int(11) NULL DEFAULT 0 COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `sort`(`sort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产品模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_product
-- ----------------------------
INSERT INTO `sa_product` VALUES (1, 5, 5, 'vivo S9 5G手机 8GB+256GB 印象拾光 前置4400万超清双摄', 'bbce2345d7772b06', '', 'S', '', 'sjyxsgqzwcqss', '/upload/images/2021-04-26/thumb_6086c74a68c9a.jpg', '/upload/images/2021-04-26/6086c704365a4.jpg', 'a:4:{i:0;a:2:{s:3:\"src\";s:43:\"/upload/images/2021-04-26/6086c6e04c3bc.jpg\";s:5:\"title\";s:0:\"\";}i:1;a:2:{s:3:\"src\";s:43:\"/upload/images/2021-04-26/6086c6e331b30.jpg\";s:5:\"title\";s:0:\"\";}i:2;a:2:{s:3:\"src\";s:43:\"/upload/images/2021-04-26/6086c6e76efe9.jpg\";s:5:\"title\";s:0:\"\";}i:3;a:2:{s:3:\"src\";s:43:\"/upload/images/2021-04-26/6086c6eb7c1e7.jpg\";s:5:\"title\";s:0:\"\";}}', '&lt;div class=&quot;p-parameter&quot; style=&quot;margin: 0px 0px 10px; padding: 0px 10px 10px; border-bottom: 1px solid #eeeeee; color: #666666; font-family: tahoma, arial, \'Microsoft YaHei\', \'Hiragino Sans GB\', u5b8bu4f53, sans-serif; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;ul id=&quot;parameter-brand&quot; class=&quot;p-parameter-list&quot; style=&quot;margin: 0px; padding: 20px 0px 0px; list-style: none; overflow: hidden;&quot;&gt;\n&lt;li style=&quot;margin: 0px 0px 5px; padding: 0px 0px 0px 42px; white-space: nowrap; text-overflow: ellipsis; overflow: hidden; width: 485px; float: left;&quot; title=&quot;vivo&quot;&gt;品牌：&amp;nbsp;&lt;a style=&quot;margin: 0px; padding: 0px; color: #5e69ad; text-decoration-line: none;&quot; href=&quot;#&quot; target=&quot;_blank&quot; rel=&quot;noopener&quot;&gt;vivo&lt;/a&gt;&lt;/li&gt;\n&lt;/ul&gt;\n&lt;ul class=&quot;parameter2 p-parameter-list&quot; style=&quot;margin: 0px; padding: 20px 0px 15px; list-style: none; overflow: hidden;&quot;&gt;\n&lt;li style=&quot;margin: 0px 0px 5px; padding: 0px 0px 0px 42px; white-space: nowrap; text-overflow: ellipsis; overflow: hidden; width: 200px; float: left;&quot; title=&quot;vivoS9&quot;&gt;商品名称：vivoS9&lt;/li&gt;\n&lt;li style=&quot;margin: 0px 0px 5px; padding: 0px 0px 0px 42px; white-space: nowrap; text-overflow: ellipsis; overflow: hidden; width: 200px; float: left;&quot; title=&quot;100011214925&quot;&gt;商品编号：100011214925&lt;/li&gt;\n&lt;li style=&quot;margin: 0px 0px 5px; padding: 0px 0px 0px 42px; white-space: nowrap; text-overflow: ellipsis; overflow: hidden; width: 200px; float: left;&quot; title=&quot;0.555kg&quot;&gt;商品毛重：0.555kg&lt;/li&gt;\n&lt;li style=&quot;margin: 0px 0px 5px; padding: 0px 0px 0px 42px; white-space: nowrap; text-overflow: ellipsis; overflow: hidden; width: 200px; float: left;&quot; title=&quot;中国大陆&quot;&gt;商品产地：中国大陆&lt;/li&gt;\n&lt;li style=&quot;margin: 0px 0px 5px; padding: 0px 0px 0px 42px; white-space: nowrap; text-overflow: ellipsis; overflow: hidden; width: 200px; float: left;&quot; title=&quot;超大字体，语音识别(文字语音互转)，极简桌面模式&quot;&gt;特殊功能：超大字体，语音识别(文字语音互转)，极简桌面模式&lt;/li&gt;\n&lt;li style=&quot;margin: 0px 0px 5px; padding: 0px 0px 0px 42px; white-space: nowrap; text-overflow: ellipsis; overflow: hidden; width: 200px; float: left;&quot; title=&quot;&amp;ge;91%&quot;&gt;屏占比：&amp;ge;91%&lt;/li&gt;\n&lt;li style=&quot;margin: 0px 0px 5px; padding: 0px 0px 0px 42px; white-space: nowrap; text-overflow: ellipsis; overflow: hidden; width: 200px; float: left;&quot; title=&quot;Android(安卓)&quot;&gt;操作系统：Android(安卓)&lt;/li&gt;\n&lt;/ul&gt;\n&lt;p class=&quot;more-par&quot; style=&quot;margin: -5px 0px 0px; padding: 0px 20px 0px 0px; text-align: right;&quot;&gt;&lt;a class=&quot;J-more-param&quot; style=&quot;margin: 0px; padding: 0px; color: #005aa0; text-decoration-line: none;&quot; href=&quot;#&quot;&gt;更多参数&lt;span class=&quot;txt-arr&quot;&gt;&amp;gt;&amp;gt;&lt;/span&gt;&lt;/a&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div id=&quot;suyuan-video&quot; style=&quot;margin: 0px; padding: 0px; color: #666666; font-family: tahoma, arial, \'Microsoft YaHei\', \'Hiragino Sans GB\', u5b8bu4f53, sans-serif; font-size: 12px; background-color: #ffffff;&quot;&gt;&lt;/div&gt;\n&lt;div id=&quot;J-detail-banner&quot; style=&quot;margin: 0px; padding: 0px; text-align: center; color: #666666; font-family: tahoma, arial, \'Microsoft YaHei\', \'Hiragino Sans GB\', u5b8bu4f53, sans-serif; font-size: 12px; background-color: #ffffff;&quot;&gt;&lt;/div&gt;\n&lt;div id=&quot;activity_header&quot; style=&quot;margin: 0px; padding: 0px; color: #666666; font-family: tahoma, arial, \'Microsoft YaHei\', \'Hiragino Sans GB\', u5b8bu4f53, sans-serif; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;div style=&quot;margin: 0px; padding: 0px;&quot; align=&quot;center&quot;&gt;&lt;a style=&quot;margin: 0px; padding: 0px; color: #666666; text-decoration-line: none;&quot; href=&quot;/&quot; target=&quot;_blank&quot; rel=&quot;noopener&quot;&gt;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74a68c9a.jpg&quot; alt=&quot;&quot; align=&quot;middle&quot; /&gt;&lt;/a&gt;&lt;/div&gt;\n&lt;/div&gt;\n&lt;div id=&quot;J-detail-pop-tpl-top-new&quot; style=&quot;margin: 0px; padding: 0px; overflow: hidden; color: #666666; font-family: tahoma, arial, \'Microsoft YaHei\', \'Hiragino Sans GB\', u5b8bu4f53, sans-serif; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;div class=&quot;ssd-module-wrap ssd-format-wrap&quot; style=&quot;margin: 0px auto; padding: 0px; position: relative; width: 750px;&quot;&gt;\n&lt;div class=&quot;ssd-format-floor ssd-floor-activity&quot; style=&quot;margin: 0px; padding: 0px; max-height: 380px; overflow: hidden;&quot;&gt;\n&lt;div class=&quot;ssd-floor-type&quot; style=&quot;margin: 0px; padding: 0px;&quot; data-type=&quot;activity&quot;&gt;&amp;nbsp;&lt;/div&gt;\n&lt;div id=&quot;zbViewFloorHeight_activity&quot; style=&quot;margin: 0px; padding: 0px;&quot;&gt;&lt;/div&gt;\n&lt;img style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74a99f9b.jpg&quot; /&gt;&lt;/div&gt;\n&lt;/div&gt;\n&lt;div class=&quot;ssd-module-wrap ssd-format-wrap&quot; style=&quot;margin: 0px auto; padding: 0px; position: relative; width: 750px;&quot;&gt;\n&lt;div class=&quot;ssd-format-floor ssd-floor-shopPrior&quot; style=&quot;margin: 0px; padding: 0px; max-height: 900px; overflow: hidden;&quot;&gt;\n&lt;div class=&quot;ssd-floor-type&quot; style=&quot;margin: 0px; padding: 0px;&quot; data-type=&quot;shopPrior&quot;&gt;&amp;nbsp;&lt;/div&gt;\n&lt;div id=&quot;zbViewFloorHeight_shopPrior&quot; style=&quot;margin: 0px; padding: 0px;&quot;&gt;&lt;/div&gt;\n&lt;img style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74ab080f.jpg&quot; usemap=&quot;#test3&quot; border=&quot;0&quot; /&gt;&amp;nbsp;&lt;map name=&quot;test3&quot;&gt;\n&lt;area coords=&quot;256,11,489,264&quot; shape=&quot;rect&quot; href=&quot;https://item.jd.com/100018752514.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;504,10,740,266&quot; shape=&quot;rect&quot; href=&quot;https://item.jd.com/100009737523.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;14,11,245,267&quot; shape=&quot;rect&quot; href=&quot;https://item.jd.com/100017141382.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;/map&gt;&lt;img style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74acab47.jpg&quot; usemap=&quot;#test8&quot; border=&quot;0&quot; /&gt;&lt;map name=&quot;test8&quot;&gt;\n&lt;area coords=&quot;380,209,741,316&quot; shape=&quot;rect&quot; href=&quot;https://jdcs.jd.com/pop/chat?shopId=1000085868&amp;amp;code=1&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;12,326,254,432&quot; shape=&quot;rect&quot; href=&quot;https://jdcs.jd.com/pop/chat?shopId=1000085868&amp;amp;code=1&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;500,322,735,427&quot; shape=&quot;rect&quot; href=&quot;https://pro.jd.com/mall/active/2NVU7CSzCbBmCxiwu36rXE7uU6mN/index.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;261,321,492,428&quot; shape=&quot;rect&quot; href=&quot;https://lzkj-isv.isvjcloud.com/lzclient/22bc80c21de345edbd2cc78062f692e8/cjwx/common/entry.html?activityId=22bc80c21de345edbd2cc78062f692e8&amp;amp;gameType=wxNineGrid&amp;amp;adsource=tg_storePage&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;11,443,245,549&quot; shape=&quot;rect&quot; href=&quot;https://item.jd.com/100010499425.html#crumb-wrap&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;261,440,490,545&quot; shape=&quot;rect&quot; href=&quot;https://pro.jd.com/mall/active/2EEzeHttCcpi2gEtkUaFXdB3N3AM/index.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;501,441,739,547&quot; shape=&quot;rect&quot; href=&quot;https://pro.jd.com/mall/active/DV4kuL9HgD3ce5j7aWZE2ig8hfQ/index.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;/map&gt;&lt;/div&gt;\n&lt;/div&gt;\n&lt;div class=&quot;ssd-module-wrap ssd-format-wrap ssd-format-center&quot; style=&quot;margin: 0px auto; padding: 0px; position: relative; width: 750px; display: flex; -webkit-box-pack: center; justify-content: center;&quot;&gt;\n&lt;div class=&quot;ssd-format-floor ssd-floor-dynamic J_formatDynamic&quot; style=&quot;margin: 0px; padding: 0px;&quot;&gt;\n&lt;div id=&quot;detail-video-player&quot; class=&quot;video-js vjs-default-skin vjs-paused detail-video-player-dimensions vjs-controls-enabled vjs-workinghover vjs-v5 vjs-user-inactive&quot; style=&quot;margin: 0px; padding: 0px; width: 750px; height: 422px; color: #ffffff; background-color: #000000; vertical-align: top; box-sizing: border-box; position: relative; line-height: 1; font-family: Arial, Helvetica, sans-serif; user-select: none; font-size: 14px; overflow: hidden;&quot; tabindex=&quot;-1&quot; role=&quot;region&quot; aria-label=&quot;video player&quot;&gt;&lt;video id=&quot;detail-video-player_html5_api&quot; class=&quot;vjs-tech&quot; style=&quot;box-sizing: inherit; font-size: inherit; color: inherit; line-height: inherit; width: 750px; height: 422px; position: absolute; top: 0px; left: 0px;&quot; tabindex=&quot;-1&quot; src=&quot;https://jvod.300hu.com/vod/product/63cc1ef2-55e8-419a-b792-136132a3914e/dfaa9dd20a9c466d9448a0666c22d40b.mp4?source=2&amp;amp;h265=h265/18799/5b4770b75497456a9b383d63a639136b.mp4&quot; poster=&quot;https://jvod.300hu.com/img/2021/64521235/1/img2.jpg&quot; preload=&quot;auto&quot;&gt;&lt;/video&gt;\n&lt;div style=&quot;margin: 0px; padding: 0px; box-sizing: inherit; font-size: inherit; color: inherit; line-height: inherit;&quot;&gt;&amp;nbsp;&lt;/div&gt;\n&lt;div class=&quot;vjs-poster&quot; style=&quot;margin: 0px; padding: 0px; box-sizing: inherit; display: inline-block; vertical-align: middle; background-repeat: no-repeat; background-position: 50% 50%; background-size: contain; cursor: pointer; position: absolute; top: 0px; right: 0px; bottom: 0px; left: 0px; height: 422px; font-size: inherit; color: inherit; line-height: inherit; background-image: url(\'https://jvod.300hu.com/img/2021/64521235/1/img2.jpg\');&quot; tabindex=&quot;-1&quot; aria-disabled=&quot;false&quot;&gt;&amp;nbsp;&lt;/div&gt;\n&lt;div class=&quot;vjs-text-track-display&quot; style=&quot;margin: 0px; padding: 0px; box-sizing: inherit; position: absolute; bottom: 3em; left: 0px; right: 0px; top: 0px; pointer-events: none; font-size: inherit; color: inherit; line-height: inherit;&quot; aria-live=&quot;off&quot; aria-atomic=&quot;true&quot;&gt;&amp;nbsp;&lt;/div&gt;\n&lt;button class=&quot;vjs-big-play-button&quot; style=&quot;cursor: pointer; box-sizing: inherit; font-size: 2.5em; color: #ffffff; background: 0px center rgba(0, 0, 0, 0.5); display: block; overflow: visible; transition: border-color 0.4s ease 0s, outline 0.4s ease 0s, background-color 0.4s ease 0s; -webkit-appearance: none; font-family: VideoJS; position: absolute; padding: 0px; opacity: 1; border-radius: 20%; top: 211px; left: 375px; margin-left: -1em; width: 2em; line-height: 1.4em !important; height: 1.4em !important; margin-top: -0.7em !important; border: 0px initial initial;&quot; title=&quot;播放视频&quot; type=&quot;button&quot; aria-live=&quot;polite&quot; aria-disabled=&quot;false&quot;&gt;&lt;span class=&quot;vjs-control-text&quot; style=&quot;margin: -1px; padding: 0px; box-sizing: inherit; font-size: inherit; color: inherit; line-height: inherit; border: 0px; clip: rect(0px, 0px, 0px, 0px); height: 1px; overflow: hidden; position: absolute; width: 1px;&quot;&gt;播放视频&lt;/span&gt;&lt;/button&gt;&lt;/div&gt;\n&lt;/div&gt;\n&lt;/div&gt;\n&lt;/div&gt;\n&lt;div class=&quot;detail-content clearfix&quot; style=&quot;margin: 10px 0px; padding: 0px; position: relative; background: #f7f7f7; color: #666666; font-family: tahoma, arial, \'Microsoft YaHei\', \'Hiragino Sans GB\', u5b8bu4f53, sans-serif; font-size: 12px;&quot; data-name=&quot;z-have-detail-nav&quot;&gt;\n&lt;div class=&quot;detail-content-wrap&quot; style=&quot;margin: 0px; padding: 0px; width: 990px; float: left; background-color: #ffffff;&quot;&gt;\n&lt;div id=&quot;tencent-video&quot; style=&quot;margin: 0px; padding: 0px;&quot;&gt;&lt;/div&gt;\n&lt;div class=&quot;detail-content-item&quot; style=&quot;margin: 0px; padding: 0px; width: 990px;&quot;&gt;\n&lt;div id=&quot;J-detail-top&quot; style=&quot;margin: 0px; padding: 0px;&quot;&gt;&lt;/div&gt;\n&lt;div id=&quot;J-detail-content&quot; style=&quot;margin: 0px; padding: 0px;&quot;&gt;&lt;br /&gt;\n&lt;div style=&quot;margin: 0px; padding: 0px;&quot;&gt;&amp;nbsp;&lt;/div&gt;\n&lt;div style=&quot;margin: 0px; padding: 0px;&quot;&gt;&amp;nbsp;&lt;/div&gt;\n&lt;div style=&quot;margin: 0px; padding: 0px;&quot; align=&quot;center&quot;&gt;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74ae15f0.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74b1c79e.gif&quot; usemap=&quot;#Map99&quot; border=&quot;0&quot; /&gt;&amp;nbsp;&lt;map name=&quot;Map99&quot;&gt;\n&lt;area coords=&quot;9,8,725,225&quot; shape=&quot;rect&quot; href=&quot;https://h5.m.jd.com/babelDiy/Zeus/4W4yzZqmzmit4FexhcrRLPVktxPk/index.html?id=1001614833443225&amp;amp;status=1&quot; target=&quot;_blank&quot; /&gt;\n&lt;/map&gt;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74b362cb.jpg&quot; usemap=&quot;#Map111&quot; border=&quot;0&quot; /&gt;&amp;nbsp;&lt;map name=&quot;Map111&quot;&gt;\n&lt;area coords=&quot;436,88,729,345&quot; shape=&quot;rect&quot; href=&quot;https://item.jd.com/100014296840.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;/map&gt;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74b57c35.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74b7b408.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74b94b3d.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74bada64.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74bc4cd1.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74bdd1d2.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74c05002.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74c1f9ef.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74c391b0.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74c5a819.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74c78001.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74c9627b.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74cac0d3.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74cc5edd.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74cde43c.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74d05f4b.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74d1ee3c.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74d392d2.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74d4ee81.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74d6d93f.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74d89224.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74da7b2e.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74db960b.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74dd1d04.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74deacda.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74e0e7a5.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74e24283.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74e46bce.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-26/6086c74e5cc99.jpg&quot; /&gt;&lt;/div&gt;\n&lt;br /&gt;&lt;br /&gt;&lt;/div&gt;\n&lt;div id=&quot;J-detail-bottom&quot; style=&quot;margin: 0px; padding: 0px;&quot;&gt;&lt;/div&gt;\n&lt;div id=&quot;activity_footer&quot; style=&quot;margin: 0px; padding: 0px;&quot;&gt;&lt;/div&gt;\n&lt;/div&gt;\n&lt;/div&gt;\n&lt;/div&gt;\n&lt;div id=&quot;J-detail-pop-tpl-bottom-new&quot; style=&quot;margin: 0px; padding: 0px; color: #666666; font-family: tahoma, arial, \'Microsoft YaHei\', \'Hiragino Sans GB\', u5b8bu4f53, sans-serif; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;div class=&quot;ssd-module-wrap ssd-format-wrap&quot; style=&quot;margin: 0px auto; padding: 0px; position: relative; width: 750px;&quot;&gt;\n&lt;div class=&quot;ssd-format-floor ssd-floor-reminder&quot; style=&quot;margin: 0px; padding: 0px; max-height: 4000px; overflow: hidden;&quot;&gt;\n&lt;div class=&quot;ssd-floor-type&quot; style=&quot;margin: 0px; padding: 0px;&quot; data-type=&quot;reminder&quot;&gt;&amp;nbsp;&lt;/div&gt;\n&lt;div id=&quot;zbViewFloorHeight_reminder&quot; style=&quot;margin: 0px; padding: 0px;&quot;&gt;&lt;/div&gt;\n&lt;/div&gt;\n&lt;/div&gt;\n&lt;/div&gt;', 3299.00, 1800.00, 99999, '5', '', '商品,语音,品牌,vivo,名称,vivoS9,编号', '111', 0, 0, 0, 0, NULL, 1, 0, 0, 1, 0, 0, 0.0, 0, '', '', NULL, 'admin', 1, NULL, '', 1619445582, 1619145018, NULL);

-- ----------------------------
-- Table structure for sa_project
-- ----------------------------
DROP TABLE IF EXISTS `sa_project`;
CREATE TABLE `sa_project`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `pid` int(1) NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
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
-- Table structure for sa_recyclebin
-- ----------------------------
DROP TABLE IF EXISTS `sa_recyclebin`;
CREATE TABLE `sa_recyclebin`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cid` int(11) NOT NULL COMMENT '模型id',
  `pid` int(11) NOT NULL COMMENT '栏目id',
  `oid` int(11) NOT NULL COMMENT '对象id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '标题',
  `category` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分类',
  `channel` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '模型',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '删除时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '回收站数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_recyclebin
-- ----------------------------

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
  `ip` bigint(12) NOT NULL COMMENT 'IP地址',
  `method` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问方式',
  `type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志类型',
  `status` int(1) NULL DEFAULT 1 COMMENT '执行状态',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_systemlog
-- ----------------------------
INSERT INTO `sa_systemlog` VALUES (1, 'admin', 'admin', 'system.systemlog', 'index', NULL, '\\app\\admin\\controller\\system\\Systemlog.php', 37, 'Call to a member function where() on null', 'a:2:{s:4:\"page\";s:1:\"1\";s:5:\"limit\";s:2:\"10\";}', 2130706433, 'GET', '1', 1, 1611569935);

-- ----------------------------
-- Table structure for sa_tags
-- ----------------------------
DROP TABLE IF EXISTS `sa_tags`;
CREATE TABLE `sa_tags`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '词名称',
  `type` int(1) NULL DEFAULT 1 COMMENT '1 正常词 2 敏感词',
  `sort` int(11) NULL DEFAULT NULL COMMENT '字段排序',
  `total` int(11) NULL DEFAULT NULL COMMENT '标签调用总数',
  `status` int(1) NULL DEFAULT 1 COMMENT '词语状态',
  `updatetime` int(11) NULL DEFAULT 0 COMMENT '添加时间',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'SEO关键词库' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_tags
-- ----------------------------
INSERT INTO `sa_tags` VALUES (1, '法克', 0, 1, 0, 1, 1619185861, 1611213045, NULL);
INSERT INTO `sa_tags` VALUES (2, '卧槽', 0, 2, 0, 1, 1618924118, 1611227478, NULL);
INSERT INTO `sa_tags` VALUES (3, 'PHP', 1, 3, 1, 1, 1619362238, 1611228586, NULL);
INSERT INTO `sa_tags` VALUES (4, 'SAPHP', 1, 4, 0, 1, 1618926778, 1611228626, NULL);
INSERT INTO `sa_tags` VALUES (5, '不要脸', 0, 5, 0, 1, 1619362230, 1611228674, NULL);
INSERT INTO `sa_tags` VALUES (6, 'PHP编程', 1, 6, 0, 1, 1618926774, 1618924018, NULL);
INSERT INTO `sa_tags` VALUES (7, '极速开发', 1, 7, 1, 1, 1618924030, 1618924030, NULL);
INSERT INTO `sa_tags` VALUES (8, 'THINKPHP后台开发', 1, 8, 0, 1, 1618926693, 1618926693, NULL);

-- ----------------------------
-- Table structure for sa_user
-- ----------------------------
DROP TABLE IF EXISTS `sa_user`;
CREATE TABLE `sa_user`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_id` smallint(5) UNSIGNED NOT NULL DEFAULT 1 COMMENT '组id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `pwd` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
  `qq` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'QQ',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '头像',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'emain',
  `mobile` bigint(11) NULL DEFAULT NULL COMMENT '手机号',
  `modify_name` int(1) UNSIGNED NULL DEFAULT 0 COMMENT '修改次数',
  `money` mediumint(9) NULL DEFAULT NULL COMMENT '货币',
  `question` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密保问题',
  `answer` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '答案',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态',
  `app_id` int(11) NULL DEFAULT NULL COMMENT '用户appid',
  `app_secret` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户appsecret',
  `valicode` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '激活码',
  `loginip` bigint(12) NULL DEFAULT NULL COMMENT '登录ip',
  `logintime` int(10) NULL DEFAULT NULL COMMENT '登录时间',
  `logincount` smallint(5) NULL DEFAULT 1 COMMENT '登录次数',
  `createip` bigint(12) NULL DEFAULT NULL COMMENT '注册IP',
  `createtime` int(10) NOT NULL COMMENT '注册时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `group_id`(`group_id`, `status`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_user
-- ----------------------------
INSERT INTO `sa_user` VALUES (1, 1, 'test', '测试用户', '94b35cfc5e48ba2e317b880ef8ca14f54ec134f3d2027dd160e7c9c514b88ef9', '1', '/upload/avatar/a0b923820dcc509a_100x100.png?GS9U8WQvOBhk', 'ceshi@foxmail.com', NULL, 0, 100, '你叫什么？', '不告诉你', 1, 10001, 'qIsSBNpcOuJeyw8mb9KilQFLWX34GEg5', NULL, 2130706433, 1618118998, 96, 2130706433, 1597125391, NULL);

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
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `uid` int(11) NULL DEFAULT NULL COMMENT '用户uid',
  `code` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邀请码',
  `status` int(1) UNSIGNED NOT NULL DEFAULT 1 COMMENT '是否使用',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户邀请码表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_user_invitecode
-- ----------------------------
INSERT INTO `sa_user_invitecode` VALUES (1, NULL, 'admin123', 1, NULL, NULL);

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
  `access_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'AccessToken',
  `refresh_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
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
  `status` int(1) NULL DEFAULT 0 COMMENT '验证码状态',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户验证码表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_user_validate
-- ----------------------------

-- ----------------------------
-- Table structure for sa_video
-- ----------------------------
DROP TABLE IF EXISTS `sa_video`;
CREATE TABLE `sa_video`  (
  `id` int(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` int(11) NOT NULL COMMENT '当前栏目',
  `cid` int(11) NULL DEFAULT NULL COMMENT '当前模型',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '视频标题',
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '别名',
  `hash` char(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '哈希值',
  `access` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问权限',
  `letter` char(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '首字母',
  `color` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题颜色',
  `pinyin` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '拼音',
  `desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简述',
  `class` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '分类小标签',
  `marks` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '影片备注',
  `actor` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '演员',
  `attribute` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '当前属性',
  `thumb` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '缩略图',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '文章封面',
  `director` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '导演',
  `area` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地区',
  `language` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '语言',
  `year` smallint(4) NULL DEFAULT NULL COMMENT '年份',
  `continu` int(20) NULL DEFAULT 0 COMMENT '连载',
  `total` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '总数',
  `play` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '播放器组',
  `server` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '服务器组',
  `note` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '播放器备注',
  `url` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '播放地址',
  `isfilm` tinyint(1) NULL DEFAULT 1 COMMENT '已上映、未上映',
  `filmtime` int(11) NULL DEFAULT NULL COMMENT '上映日期',
  `minutes` int(11) NULL DEFAULT NULL COMMENT '影片时长',
  `weekday` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '节目周期，周几播出',
  `seo_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO标题',
  `seo_keywords` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'SEO关键词',
  `seo_description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT 'SEO描述',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '内容介绍',
  `hits` mediumint(8) NULL DEFAULT NULL COMMENT '点击量',
  `hits_day` mediumint(8) NULL DEFAULT NULL COMMENT '日点击',
  `hits_week` mediumint(8) NULL DEFAULT NULL COMMENT '周点击',
  `hits_month` mediumint(8) NULL DEFAULT NULL COMMENT '月点击',
  `hits_lasttime` int(11) NULL DEFAULT NULL COMMENT '点击时间',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序',
  `stars` tinyint(1) NULL DEFAULT NULL COMMENT '星级',
  `score` int(11) NULL DEFAULT NULL COMMENT '浏览所需积分',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '状态',
  `up` mediumint(8) NULL DEFAULT NULL COMMENT '顶一下',
  `down` mediumint(8) NULL DEFAULT NULL COMMENT '踩一下',
  `gold` decimal(3, 1) NULL DEFAULT NULL COMMENT '评分',
  `golder` smallint(6) NULL DEFAULT NULL COMMENT '评分人数',
  `skin` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模板文件',
  `reurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '来源URL',
  `readurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '访问地址',
  `author` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '作者',
  `admin_id` int(11) NULL DEFAULT NULL COMMENT '管理员id',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '会员投稿id',
  `jumpurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '跳转地址',
  `updatetime` int(11) NULL DEFAULT 0 COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT 0 COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `id`(`id`) USING BTREE,
  INDEX `cid`(`cid`) USING BTREE,
  INDEX `pid`(`pid`) USING BTREE,
  INDEX `sort`(`sort`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视频模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_video
-- ----------------------------
INSERT INTO `sa_video` VALUES (1, 3, 3, '电视剧版有翡', '电视剧版有匪/有匪', 'asdas', '', 'Y', '#9d3636', NULL, '一句话简述', '台湾是中国的', 'BD高清', '赵丽颖 王一博 张慧雯 陈若轩 周洁琼 孙坚', '1,5', '/upload/images/2021-04-26/thumb_6086c6252853a.jpg', '/upload/images/2021-04-26/6086c6252853a.jpg', '吴锦源', '大陆', '国语', 2021, 13, '36', 'ckplayer', '', '', '第01集$https://d.mhqiyi.com/20210224/LfNO3InW/index.m3u8#第02集$https://mhcdn.mhqiyi.com/20210303/QiLcl2jL/index.m3u8#', 1, 1619712000, 116, '周四', '', '江湖,李徵,年前,祸乱,一代,大侠,南刀', '多年前江湖祸乱，一代大侠南刀李徵奉旨围匪，从此便有了四十八寨。后李徵病逝，江湖名门也相继落败。李徵的女儿李瑾容接任大当家，与周以棠成婚。周家有女初成长，...', '&lt;p&gt;多年前江湖祸乱，一代大侠南刀李徵奉旨围匪，从此便有了四十八寨。后李徵病逝，江湖名门也相继落败。李徵的女儿李瑾容接任大当家，与周以棠成婚。周家有女初成长，周翡所生的朝代却是一个江湖没落的时候，前辈们的光辉与意气风发在南刀李徵逝去后逐渐都销声匿迹了。周翡十三岁那年离家出走，差点命丧洗墨江，被端王谢允救下，冥冥之中结下良缘。三年后，两位头角峥嵘的少年再次在霍家堡相遇，引出了多年前隐匿江湖的各类宗师高手。同时遭到曹贼手下北斗七位高手的追杀，令两位少年陷入了一场暗潮汹涌的阴谋。周翡以&amp;ldquo;破雪刀&amp;rdquo;之招数名震江湖，以浩然之姿，为这江湖名册再添上了浓墨重彩的一笔。&lt;img src=&quot;/upload/images/2021-04-22/60811a355453c.jpeg&quot; alt=&quot;&quot; width=&quot;600&quot; height=&quot;800&quot; /&gt;&lt;/p&gt;\n&lt;p&gt;&lt;img src=&quot;/upload/images/2021-04-26/6086c6252853a.jpg&quot; alt=&quot;&quot; width=&quot;268&quot; height=&quot;375&quot; /&gt;&lt;/p&gt;', 0, 0, 0, 0, NULL, 0, 3, 0, 1, 0, 0, 0.0, 0, '', '', NULL, 'admin', NULL, NULL, '', 1619445842, 1617632959, NULL);

SET FOREIGN_KEY_CHECKS = 1;
