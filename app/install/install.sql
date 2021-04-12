/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : saphp

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 12/04/2021 14:47:16
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
  `pwd` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '密码',
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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '后台管理员表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_admin
-- ----------------------------
INSERT INTO `sa_admin` VALUES (1, '1', '1', '', 'admin', '权栈', '8bcb6ea31d829170b639e33d2da633d2', 1, 'a:3:{i:0;s:21:\"家有傻猫两三只\";i:1;s:15:\"隔壁帅小伙\";i:2;s:9:\"技术宅\";}', '/upload/avatar/f8e34ec67a2a0233_100x100.png', '海阔天空，有容乃大', 'admin@swiftadmin.net', '0310', '15100038819', '高级管理人员', 114, '河北省邯郸市', 2130706433, 1618209462, 3232254977, 1, NULL, 1596682835, 1618209462, NULL);
INSERT INTO `sa_admin` VALUES (2, '2', '4', '5,6', 'ceshi', '白眉大侠', '8bcb6ea31d829170b639e33d2da633d2', 1, 'a:3:{i:0;s:5:\"Think\";i:1;s:12:\"铁血柔肠\";i:2;s:12:\"道骨仙风\";}', '/upload/avatar/a7ab69d052d46a33_100x100.jpg', '吃我一招乾坤大挪移', 'baimei@swiftadmin.net', '0310', '15188888888', '刀是什么刀，菜刀~来一记webshell~', 20, '河北省邯郸市廉颇大道110号指挥中心', 2130706433, 1618158681, 3232254977, 1, '', 1609836672, 1618191555, NULL);

-- ----------------------------
-- Table structure for sa_admin_access
-- ----------------------------
DROP TABLE IF EXISTS `sa_admin_access`;
CREATE TABLE `sa_admin_access`  (
  `uid` mediumint(8) UNSIGNED NOT NULL COMMENT '用户ID',
  `group_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '管理员分组',
  `rules` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '自定义权限',
  `cateids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目权限',
  PRIMARY KEY (`uid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `group_id`(`group_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '组规则表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_admin_access
-- ----------------------------
INSERT INTO `sa_admin_access` VALUES (1, '1', NULL, NULL);
INSERT INTO `sa_admin_access` VALUES (2, '2', '', '');

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
  `rules` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '规则字符串',
  `cateids` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目权限',
  `color` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '颜色',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_admin_group
-- ----------------------------
INSERT INTO `sa_admin_group` VALUES (1, 0, NULL, '超级管理员', 'admin', 1, 1, '网站超级管理员组的', '1', NULL, 'layui-bg-blue', 1607832158, NULL);
INSERT INTO `sa_admin_group` VALUES (2, 1, 2, '网站编辑', 'editor', 1, 1, '负责公司软文的编写', '2,14,45,15,53,54,55', '1,2', 'layui-bg-cyan', 1607832158, NULL);
INSERT INTO `sa_admin_group` VALUES (3, 2, 2, '市场部', 'market', 0, 1, '市场部，项目需要', '', '2', 'layui-bg-gray', 1609162674, NULL);

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
  `auth` tinyint(1) NULL DEFAULT 1 COMMENT '状态',
  `status` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '状态码',
  `isSystem` tinyint(1) UNSIGNED NULL DEFAULT 0 COMMENT '系统级,只可手动操作',
  `updatetime` int(11) NOT NULL DEFAULT 0 COMMENT '添加时间',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 280 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_admin_rules
-- ----------------------------
INSERT INTO `sa_admin_rules` VALUES (1, 0, 'Dashboard', '#', '#', 0, NULL, '', 1, 'layui-icon-home', 0, 'normal', 0, 1614258949, 1614258949, NULL);
INSERT INTO `sa_admin_rules` VALUES (2, 0, '内容管理', '#', '#', 0, NULL, '', 2, 'layui-icon-app', 1, 'normal', 0, 1614258949, 1614258949, NULL);
INSERT INTO `sa_admin_rules` VALUES (3, 0, '运营管理', '#', '#', 0, NULL, '', 3, 'layui-icon-rmb', 1, 'normal', 0, 1614259183, 1614259183, NULL);
INSERT INTO `sa_admin_rules` VALUES (4, 0, '系统管理', '#', '#', 0, NULL, '', 4, 'layui-icon-set-fill', 1, 'normal', 0, 1614259195, 1614259195, NULL);
INSERT INTO `sa_admin_rules` VALUES (5, 0, 'SEO设置', '#', '#', 0, NULL, '', 5, 'layui-icon-util', 1, 'normal', 0, 1614259211, 1614259211, NULL);
INSERT INTO `sa_admin_rules` VALUES (6, 0, '接口管理', '#', '#', 0, NULL, '', 6, 'layui-icon-release', 1, 'normal', 0, 1614259243, 1614259243, NULL);
INSERT INTO `sa_admin_rules` VALUES (7, 0, '高级管理', '#', '#', 0, NULL, '', 7, 'layui-icon-engine', 1, 'normal', 0, 1614259245, 1614259245, NULL);
INSERT INTO `sa_admin_rules` VALUES (8, 0, '插件应用', '#', '#', 0, NULL, '', 8, 'layui-icon-component', 1, 'normal', 0, 1614259533, 1614259533, NULL);
INSERT INTO `sa_admin_rules` VALUES (9, 0, '会员管理', '#', '#', 0, NULL, '', 9, 'layui-icon-user', 1, 'normal', 0, 1614259556, 1614259556, NULL);
INSERT INTO `sa_admin_rules` VALUES (10, 0, '其他设置', '#', '#', 0, NULL, '', 10, 'layui-icon-about', 1, 'normal', 0, 1614259568, 1614259568, NULL);
INSERT INTO `sa_admin_rules` VALUES (11, 1, '控制台', '/index/console', 'index:console', 0, NULL, '', 11, '', 0, 'normal', 0, 1614259969, 1614259945, NULL);
INSERT INTO `sa_admin_rules` VALUES (12, 1, '分析页', '/index/analysis', 'index:analysis', 0, NULL, '', 12, '', 0, 'normal', 0, 1614259966, 1614259966, NULL);
INSERT INTO `sa_admin_rules` VALUES (13, 1, '监控页', '/index/monitor', 'index:monitor', 0, NULL, '', 13, '', 0, 'normal', 0, 1614260189, 1614260189, NULL);
INSERT INTO `sa_admin_rules` VALUES (14, 2, '栏目管理', '/system.category/index', 'system.category:index', 0, NULL, '', 14, '', 1, 'normal', 0, 1614260208, 1614260208, NULL);
INSERT INTO `sa_admin_rules` VALUES (15, 2, '导航管理', '/system.navmenu/index', 'system.navmenu:index', 0, NULL, '', 15, '', 1, 'normal', 0, 1614260227, 1614260227, NULL);
INSERT INTO `sa_admin_rules` VALUES (16, 3, '广告管理', '/system.adwords/index', 'system.adwords:index', 0, NULL, '', 16, '', 1, 'normal', 0, 1614260239, 1614260239, NULL);
INSERT INTO `sa_admin_rules` VALUES (17, 4, '基本设置', '/index/basecfg', 'index:basecfg', 0, NULL, '', 17, '', 1, 'normal', 0, 1614260255, 1614260255, NULL);
INSERT INTO `sa_admin_rules` VALUES (18, 4, '用户管理', '/system.admin/index', 'system.admin:index', 0, NULL, '', 18, '', 1, 'normal', 0, 1614260616, 1614260616, NULL);
INSERT INTO `sa_admin_rules` VALUES (19, 4, '用户中心', '/system.admin/center', 'system.admin:center', 0, NULL, '', 19, '', 1, 'normal', 0, 1614260628, 1614260628, NULL);
INSERT INTO `sa_admin_rules` VALUES (20, 4, '角色管理', '/system.admingroup/index', 'system.admingroup:index', 0, NULL, '', 20, '', 1, 'normal', 0, 1614260649, 1614260649, NULL);
INSERT INTO `sa_admin_rules` VALUES (21, 4, '菜单管理', '/system.adminrules/index', 'system.adminrules:index', 0, NULL, '', 21, '', 1, 'normal', 0, 1614260663, 1614260663, NULL);
INSERT INTO `sa_admin_rules` VALUES (22, 4, '操作日志', '/system.systemlog/index', 'system.systemlog:index', 0, NULL, '', 22, '', 1, 'normal', 0, 1614260759, 1614260751, NULL);
INSERT INTO `sa_admin_rules` VALUES (23, 5, 'URL生成', '/system.rewrite/index', 'system.rewrite:index', 0, NULL, '', 23, '', 1, 'normal', 0, 1614260780, 1614260780, NULL);
INSERT INTO `sa_admin_rules` VALUES (24, 5, 'SEO优化', '/system.seoer/index', 'system.seoer:index', 0, NULL, '', 24, '', 1, 'normal', 0, 1614260798, 1614260798, NULL);
INSERT INTO `sa_admin_rules` VALUES (25, 5, '友情链接', '/system.friendlink/index', 'system.friendlink:index', 0, NULL, '', 25, '', 1, 'normal', 0, 1614260823, 1614260823, NULL);
INSERT INTO `sa_admin_rules` VALUES (26, 5, '采集接口', '/system.collect/index', 'system.collect:index', 0, NULL, '', 26, '', 1, 'normal', 0, 1614260836, 1614260836, NULL);
INSERT INTO `sa_admin_rules` VALUES (27, 6, '项目管理', '/system.project/index', 'system.project:index', 0, NULL, '', 27, '', 1, 'normal', 0, 1614260870, 1614260870, NULL);
INSERT INTO `sa_admin_rules` VALUES (28, 6, '接口配置', '/system.api/index', 'system.api:index', 0, NULL, '', 28, '', 1, 'normal', 0, 1614260885, 1614260885, NULL);
INSERT INTO `sa_admin_rules` VALUES (29, 6, '接口鉴权', '/system.apiaccess/index', 'system.apiaccess:index', 0, NULL, '', 29, '', 1, 'normal', 0, 1614260897, 1614260897, NULL);
INSERT INTO `sa_admin_rules` VALUES (30, 7, '公司管理', '/system.company/index', 'system.company:index', 0, NULL, '', 30, '', 1, 'normal', 0, 1614260922, 1614260922, NULL);
INSERT INTO `sa_admin_rules` VALUES (31, 7, '部门管理', '/system.department/index', 'system.department:index', 0, NULL, '', 31, '', 1, 'normal', 0, 1614260957, 1614260957, NULL);
INSERT INTO `sa_admin_rules` VALUES (32, 7, '岗位管理', '/system.jobs/index', 'system.jobs:index', 0, NULL, '', 32, '', 1, 'normal', 0, 1614260977, 1614260977, NULL);
INSERT INTO `sa_admin_rules` VALUES (33, 7, '附件管理', '/system.adminfile/index', 'system.adminfile:index', 0, NULL, '', 33, '', 1, 'normal', 0, 1614261038, 1614261038, NULL);
INSERT INTO `sa_admin_rules` VALUES (34, 7, '模型管理', '/system.channel/index', 'system.channel:index', 0, NULL, '', 34, '', 1, 'normal', 0, 1614261058, 1614261058, NULL);
INSERT INTO `sa_admin_rules` VALUES (35, 8, '插件管理', '/system.plugin/index', 'system.plugin:index', 0, NULL, '', 35, '', 1, 'normal', 0, 1614261100, 1614261100, NULL);
INSERT INTO `sa_admin_rules` VALUES (36, 8, '插件钩子', '/system.pluginhook/index', 'system.pluginhook:index', 0, NULL, '', 36, '', 1, 'normal', 0, 1614343420, 1614261111, NULL);
INSERT INTO `sa_admin_rules` VALUES (37, 8, '占位菜单', '#', '#', 0, NULL, '', 37, '', 1, 'hidden', 1, 1614261143, 1614261143, NULL);
INSERT INTO `sa_admin_rules` VALUES (38, 9, '会员管理', '/system.user/index', 'system.user:index', 0, NULL, '', 38, '', 1, 'normal', 0, 1614261169, 1614261169, NULL);
INSERT INTO `sa_admin_rules` VALUES (39, 9, '评论管理', '/system.comment/index', 'system.comment:index', 0, NULL, '', 39, '', 1, 'normal', 0, 1614261181, 1614261181, NULL);
INSERT INTO `sa_admin_rules` VALUES (40, 9, '留言板管理', '/system.guestbook/index', 'system.guestbook:index', 0, NULL, '', 40, '', 1, 'normal', 0, 1614261194, 1614261194, NULL);
INSERT INTO `sa_admin_rules` VALUES (41, 9, '会员组管理', '/system.usergroup/index', 'system.usergroup:index', 0, NULL, '', 41, '', 1, 'normal', 0, 1614261212, 1614261212, NULL);
INSERT INTO `sa_admin_rules` VALUES (42, 10, '数据库', '/system.database/index', 'system.database:index', 0, NULL, '', 42, '', 1, 'normal', 0, 1614261249, 1614261249, NULL);
INSERT INTO `sa_admin_rules` VALUES (43, 10, '回收站', '/system.recyclebin/index', 'system.recyclebin:index', 0, NULL, '', 43, '', 1, 'normal', 0, 1614261270, 1614261270, NULL);
INSERT INTO `sa_admin_rules` VALUES (44, 10, '字典设置', '/system.dictionary/index', 'system.dictionary:index', 0, NULL, '', 44, '', 1, 'normal', 0, 1614261283, 1614261283, NULL);
INSERT INTO `sa_admin_rules` VALUES (45, 14, '查看', '/system.category/index', 'system.category:index', 1, NULL, '', 45, '', 1, 'normal', 0, 1614261658, 1614261658, NULL);
INSERT INTO `sa_admin_rules` VALUES (46, 14, '添加', '/system.category/add', 'system.category:add', 1, NULL, '', 46, '', 1, 'normal', 0, 1614261692, 1614261692, NULL);
INSERT INTO `sa_admin_rules` VALUES (47, 14, '编辑', '/system.category/edit', 'system.category:edit', 1, NULL, '', 47, '', 1, 'normal', 0, 1614261705, 1614261705, NULL);
INSERT INTO `sa_admin_rules` VALUES (48, 14, '删除', '/system.category/del', 'system.category:del', 1, NULL, '', 48, '', 1, 'normal', 0, 1614261738, 1614261738, NULL);
INSERT INTO `sa_admin_rules` VALUES (49, 14, '状态', '/system.category/status', 'system.category:status', 2, NULL, '', 49, '', 1, 'normal', 0, 1614261826, 1614261826, NULL);
INSERT INTO `sa_admin_rules` VALUES (50, 14, '回收站', '/system.category/recyclebin', 'system.category:recyclebin', 2, NULL, '', 50, '', 1, 'normal', 0, 1614261884, 1614261864, NULL);
INSERT INTO `sa_admin_rules` VALUES (51, 14, '还原', '/system.category/restore', 'system.category:restore', 2, NULL, '', 51, '', 1, 'normal', 0, 1614261938, 1614261938, NULL);
INSERT INTO `sa_admin_rules` VALUES (52, 14, '销毁', '/system.category/destroy', 'system.category:destroy', 2, NULL, '', 52, '', 1, 'normal', 0, 1614261952, 1614261952, NULL);
INSERT INTO `sa_admin_rules` VALUES (53, 15, '查看', '/system.navmenu/index', 'system.navmenu:index', 1, NULL, '', 53, '', 1, 'normal', 0, 1615261658, 1615261658, NULL);
INSERT INTO `sa_admin_rules` VALUES (54, 15, '添加', '/system.navmenu/add', 'system.navmenu:add', 1, NULL, '', 54, '', 1, 'normal', 0, 1615261692, 1615261692, NULL);
INSERT INTO `sa_admin_rules` VALUES (55, 15, '编辑', '/system.navmenu/edit', 'system.navmenu:edit', 1, NULL, '', 55, '', 1, 'normal', 0, 1615261705, 1615261705, NULL);
INSERT INTO `sa_admin_rules` VALUES (56, 15, '删除', '/system.navmenu/del', 'system.navmenu:del', 1, NULL, '', 56, '', 1, 'normal', 0, 1615261738, 1615261738, NULL);
INSERT INTO `sa_admin_rules` VALUES (57, 15, '状态', '/system.navmenu/status', 'system.navmenu:status', 2, NULL, '', 57, '', 1, 'normal', 0, 1615261826, 1615261826, NULL);
INSERT INTO `sa_admin_rules` VALUES (58, 15, '回收站', '/system.navmenu/recyclebin', 'system.navmenu:recyclebin', 2, NULL, '', 58, '', 1, 'normal', 0, 1615261884, 1615261864, NULL);
INSERT INTO `sa_admin_rules` VALUES (59, 15, '还原', '/system.navmenu/restore', 'system.navmenu:restore', 2, NULL, '', 59, '', 1, 'normal', 0, 1615261938, 1615261938, NULL);
INSERT INTO `sa_admin_rules` VALUES (60, 15, '销毁', '/system.navmenu/destroy', 'system.navmenu:destroy', 2, NULL, '', 60, '', 1, 'normal', 0, 1615261952, 1615261952, NULL);
INSERT INTO `sa_admin_rules` VALUES (61, 16, '查看', '/system.adwords/index', 'system.adwords:index', 1, NULL, '', 61, '', 1, 'normal', 0, 1615261658, 1615261658, NULL);
INSERT INTO `sa_admin_rules` VALUES (62, 16, '添加', '/system.adwords/add', 'system.adwords:add', 1, NULL, '', 62, '', 1, 'normal', 0, 1615261692, 1615261692, NULL);
INSERT INTO `sa_admin_rules` VALUES (63, 16, '编辑', '/system.adwords/edit', 'system.adwords:edit', 1, NULL, '', 63, '', 1, 'normal', 0, 1615261705, 1615261705, NULL);
INSERT INTO `sa_admin_rules` VALUES (64, 16, '删除', '/system.adwords/del', 'system.adwords:del', 1, NULL, '', 64, '', 1, 'normal', 0, 1615261738, 1615261738, NULL);
INSERT INTO `sa_admin_rules` VALUES (65, 16, '状态', '/system.adwords/status', 'system.adwords:status', 2, NULL, '', 65, '', 1, 'normal', 0, 1615261826, 1615261826, NULL);
INSERT INTO `sa_admin_rules` VALUES (66, 16, '回收站', '/system.adwords/recyclebin', 'system.adwords:recyclebin', 2, NULL, '', 66, '', 1, 'normal', 0, 1615261884, 1615261864, NULL);
INSERT INTO `sa_admin_rules` VALUES (67, 16, '还原', '/system.adwords/restore', 'system.adwords:restore', 2, NULL, '', 67, '', 1, 'normal', 0, 1615261938, 1615261938, NULL);
INSERT INTO `sa_admin_rules` VALUES (68, 16, '销毁', '/system.adwords/destroy', 'system.adwords:destroy', 2, NULL, '', 68, '', 1, 'normal', 0, 1615261952, 1615261952, NULL);
INSERT INTO `sa_admin_rules` VALUES (69, 17, '修改配置', '/index/baseset', 'index:baseset', 2, NULL, '', 69, '', 1, 'normal', 0, 1614262831, 1614262831, NULL);
INSERT INTO `sa_admin_rules` VALUES (70, 17, 'FTP接口', '/index/testftp', 'index:testftp', 2, NULL, '', 70, '', 0, 'normal', 0, 1614262879, 1614262879, NULL);
INSERT INTO `sa_admin_rules` VALUES (71, 17, '邮件接口', '/index/testemail', 'index:testemail', 2, NULL, '', 71, '', 0, 'normal', 0, 1614262897, 1614262897, NULL);
INSERT INTO `sa_admin_rules` VALUES (72, 17, '缓存接口', '/index/testcache', 'index:testcache', 2, NULL, '', 72, '', 0, 'normal', 0, 1614262920, 1614262920, NULL);
INSERT INTO `sa_admin_rules` VALUES (73, 18, '查看', '/system.admin/index', 'system.admin:index', 1, NULL, '', 73, '', 1, 'normal', 0, 1614262972, 1614262972, NULL);
INSERT INTO `sa_admin_rules` VALUES (74, 18, '添加', '/system.admin/add', 'system.admin:add', 1, NULL, '', 74, '', 1, 'normal', 0, 1614262987, 1614262987, NULL);
INSERT INTO `sa_admin_rules` VALUES (75, 18, '编辑', '/system.admin/edit', 'system.admin:edit', 1, NULL, '', 75, '', 1, 'normal', 0, 1614263001, 1614263001, NULL);
INSERT INTO `sa_admin_rules` VALUES (76, 18, '删除', '/system.admin/del', 'system.admin:del', 1, NULL, '', 76, '', 1, 'normal', 0, 1614263022, 1614263022, NULL);
INSERT INTO `sa_admin_rules` VALUES (77, 18, '状态', '/system.admin/status', 'system.admin:status', 2, NULL, '', 77, '', 1, 'normal', 0, 1614263239, 1614263239, NULL);
INSERT INTO `sa_admin_rules` VALUES (78, 18, '回收站', '/system.admin/recyclebin', 'system.admin:recyclebin', 2, NULL, '', 78, '', 1, 'normal', 0, 1614263630, 1614263630, NULL);
INSERT INTO `sa_admin_rules` VALUES (79, 18, '还原', '/system.admin/restore', 'system.admin:restore', 2, NULL, '', 79, '', 1, 'normal', 0, 1614298448, 1614298448, NULL);
INSERT INTO `sa_admin_rules` VALUES (80, 18, '销毁', '/system.admin/destroy', 'system.admin:destroy', 2, NULL, '', 80, '', 1, 'normal', 0, 1614298476, 1614298476, NULL);
INSERT INTO `sa_admin_rules` VALUES (81, 18, '查询职位', '/system.admin/getgrouprrjobs', 'system.admin:getgrouprrjobs', 2, NULL, '', 81, '', 0, 'normal', 0, 1614300843, 1614300582, NULL);
INSERT INTO `sa_admin_rules` VALUES (82, 18, '查询权限', '/system.admin/getprivaterules', 'system.admin:getprivaterules', 2, NULL, '', 82, '', 0, 'normal', 0, 1614300906, 1614300622, NULL);
INSERT INTO `sa_admin_rules` VALUES (83, 18, '查询节点', '/system.admin/queryrules', 'system.admin:queryrules', 2, NULL, '', 83, '', 0, 'normal', 0, 1614300921, 1614300655, NULL);
INSERT INTO `sa_admin_rules` VALUES (84, 18, '编辑权限', '/system.admin/editrules', 'system.admin:editrules', 2, NULL, '', 84, '', 1, 'normal', 0, 1614300700, 1614300700, NULL);
INSERT INTO `sa_admin_rules` VALUES (85, 18, '栏目权限', '/system.admin/getprivatecates', 'system.admin:getprivatecates', 2, NULL, '', 85, '', 0, 'normal', 0, 1614300988, 1614300988, NULL);
INSERT INTO `sa_admin_rules` VALUES (86, 18, '查询栏目', '/system.admin/querycates', 'system.admin:querycates', 2, NULL, '', 86, '', 0, 'normal', 0, 1614301054, 1614301002, NULL);
INSERT INTO `sa_admin_rules` VALUES (87, 18, '编辑栏目', '/system.admin/editcates', 'system.admin:editcates', 2, NULL, '', 87, '', 1, 'normal', 0, 1614301117, 1614301031, NULL);
INSERT INTO `sa_admin_rules` VALUES (88, 18, '用户菜单', '/system.admin/getauthmenus', 'system.admin:getauthmenus', 2, NULL, '', 88, '', 0, 'normal', 0, 1614301142, 1614301142, NULL);
INSERT INTO `sa_admin_rules` VALUES (89, 18, '系统模板', '/system.admin/theme', 'system.admin:theme', 2, NULL, '', 89, '', 0, 'normal', 0, 1614301191, 1614301191, NULL);
INSERT INTO `sa_admin_rules` VALUES (90, 18, '短消息', '/system.admin/message', 'system.admin:message', 2, NULL, '', 90, '', 0, 'normal', 0, 1614301215, 1614301215, NULL);
INSERT INTO `sa_admin_rules` VALUES (91, 18, '个人中心', '/system.admin/center', 'system.admin:center', 2, NULL, '', 91, '', 0, 'normal', 0, 1614301242, 1614301242, NULL);
INSERT INTO `sa_admin_rules` VALUES (92, 18, '修改资料', '/system.admin/modify', 'system.admin:modify', 2, NULL, '', 92, '', 0, 'normal', 0, 1614301275, 1614301275, NULL);
INSERT INTO `sa_admin_rules` VALUES (93, 18, '修改密码', '/system.admin/pwd', 'system.admin:pwd', 2, NULL, '', 93, '', 0, 'normal', 0, 1614301295, 1614301295, NULL);
INSERT INTO `sa_admin_rules` VALUES (94, 18, '系统语言', '/system.admin/language', 'system.admin:language', 2, NULL, '', 94, '', 0, 'normal', 0, 1614301316, 1614301316, NULL);
INSERT INTO `sa_admin_rules` VALUES (95, 18, '清理缓存', '/system.admin/clear', 'system.admin:clear', 2, NULL, '', 95, '', 0, 'normal', 0, 1614301336, 1614301336, NULL);
INSERT INTO `sa_admin_rules` VALUES (96, 20, '查看', '/system.admingroup/index', 'system.admingroup:index', 1, NULL, '', 96, '', 1, 'normal', 0, 1615261658, 1615261658, NULL);
INSERT INTO `sa_admin_rules` VALUES (97, 20, '添加', '/system.admingroup/add', 'system.admingroup:add', 1, NULL, '', 97, '', 1, 'normal', 0, 1615261692, 1615261692, NULL);
INSERT INTO `sa_admin_rules` VALUES (98, 20, '编辑', '/system.admingroup/edit', 'system.admingroup:edit', 1, NULL, '', 98, '', 1, 'normal', 0, 1615261705, 1615261705, NULL);
INSERT INTO `sa_admin_rules` VALUES (99, 20, '删除', '/system.admingroup/del', 'system.admingroup:del', 1, NULL, '', 99, '', 1, 'normal', 0, 1615261738, 1615261738, NULL);
INSERT INTO `sa_admin_rules` VALUES (100, 20, '状态', '/system.admingroup/status', 'system.admingroup:status', 2, NULL, '', 100, '', 1, 'normal', 0, 1615261826, 1615261826, NULL);
INSERT INTO `sa_admin_rules` VALUES (101, 20, '回收站', '/system.admingroup/recyclebin', 'system.admingroup:recyclebin', 2, NULL, '', 101, '', 1, 'normal', 0, 1615261884, 1615261864, NULL);
INSERT INTO `sa_admin_rules` VALUES (102, 20, '还原', '/system.admingroup/restore', 'system.admingroup:restore', 2, NULL, '', 102, '', 1, 'normal', 0, 1615261938, 1615261938, NULL);
INSERT INTO `sa_admin_rules` VALUES (103, 20, '销毁', '/system.admingroup/destroy', 'system.admingroup:destroy', 2, NULL, '', 103, '', 1, 'normal', 0, 1615261952, 1615261952, NULL);
INSERT INTO `sa_admin_rules` VALUES (104, 20, '查询权限', '/system.admingroup/queryrules', 'system.admingroup:queryrules', 2, NULL, '', 104, '', 0, 'normal', 0, 1614302262, 1614302262, NULL);
INSERT INTO `sa_admin_rules` VALUES (105, 20, '编辑权限', '/system.admingroup/editrules', 'system.admingroup:editrules', 2, NULL, '', 105, '', 1, 'normal', 0, 1614302276, 1614302276, NULL);
INSERT INTO `sa_admin_rules` VALUES (106, 20, '查询栏目', '/system.admingroup/querycate', 'system.admingroup:querycate', 2, NULL, '', 106, '', 0, 'normal', 0, 1614302289, 1614302289, NULL);
INSERT INTO `sa_admin_rules` VALUES (107, 20, '编辑栏目', '/system.admingroup/editcate', 'system.admingroup:editcate', 2, NULL, '', 107, '', 1, 'normal', 0, 1614302302, 1614302302, NULL);
INSERT INTO `sa_admin_rules` VALUES (108, 21, '查询', '/system.adminrules/index', 'system.adminrules:index', 1, NULL, '', 108, NULL, 1, 'normal', 0, 1614303315, 1614303315, NULL);
INSERT INTO `sa_admin_rules` VALUES (109, 21, '添加', '/system.adminrules/add', 'system.adminrules:add', 1, NULL, '', 109, NULL, 1, 'normal', 0, 1614303315, 1614303315, NULL);
INSERT INTO `sa_admin_rules` VALUES (110, 21, '编辑', '/system.adminrules/edit', 'system.adminrules:edit', 1, NULL, '', 110, NULL, 1, 'normal', 0, 1614303315, 1614303315, NULL);
INSERT INTO `sa_admin_rules` VALUES (111, 21, '删除', '/system.adminrules/del', 'system.adminrules:del', 1, NULL, '', 111, NULL, 1, 'normal', 0, 1614303315, 1614303315, NULL);
INSERT INTO `sa_admin_rules` VALUES (112, 21, '状态', '/system.adminrules/status', 'system.adminrules:status', 2, NULL, '', 112, NULL, 1, 'normal', 0, 1614303315, 1614303315, NULL);
INSERT INTO `sa_admin_rules` VALUES (113, 21, '回收站', '/system.adminrules/recyclebin', 'system.adminrules:recyclebin', 2, NULL, '', 113, NULL, 1, 'normal', 0, 1614303315, 1614303315, NULL);
INSERT INTO `sa_admin_rules` VALUES (114, 21, '还原', '/system.adminrules/restore', 'system.adminrules:restore', 2, NULL, '', 114, NULL, 1, 'normal', 0, 1614303315, 1614303315, NULL);
INSERT INTO `sa_admin_rules` VALUES (115, 21, '销毁', '/system.adminrules/destroy', 'system.adminrules:destroy', 2, NULL, '', 115, NULL, 1, 'normal', 0, 1614303315, 1614303315, NULL);
INSERT INTO `sa_admin_rules` VALUES (116, 21, '数据节点', '/system.admin/authlisttree', 'system.admin:authlisttree', 2, NULL, '', 116, '', 0, 'normal', 0, 1614303509, 1614303509, NULL);
INSERT INTO `sa_admin_rules` VALUES (117, 22, '查询', '/system.systemlog/index', 'system.systemlog:index', 1, NULL, '', 117, '', 1, 'normal', 0, 1614303556, 1614303556, NULL);
INSERT INTO `sa_admin_rules` VALUES (118, 23, '查看', '/system.rewrite/index', 'system.rewrite:index', 1, NULL, '', 118, '', 1, 'normal', 0, 1614305286, 1614303605, NULL);
INSERT INTO `sa_admin_rules` VALUES (119, 23, '编辑', '/system.rewrite/basecfg', 'system.rewrite:basecfg', 2, NULL, '', 119, '', 1, 'normal', 0, 1614303648, 1614303630, NULL);
INSERT INTO `sa_admin_rules` VALUES (120, 24, '查看流量', '/system.seoer/index', 'system.seoer:index', 1, NULL, '', 120, '', 1, 'normal', 0, 1614305276, 1614305005, NULL);
INSERT INTO `sa_admin_rules` VALUES (121, 24, '查询站点', '/system.seoer/getsitelist', 'system.seoer:getsitelist', 2, NULL, '', 121, '', 0, 'normal', 0, 1614305035, 1614305035, NULL);
INSERT INTO `sa_admin_rules` VALUES (122, 24, '查询目录', '/system.seoer/getsitedir', 'system.seoer:getsitedir', 2, NULL, '', 122, '', 0, 'normal', 0, 1614305050, 1614305050, NULL);
INSERT INTO `sa_admin_rules` VALUES (123, 24, '查询数据', '/system.seoer/getdata', 'system.seoer:getdata', 2, NULL, '', 123, '', 0, 'normal', 0, 1614305063, 1614305063, NULL);
INSERT INTO `sa_admin_rules` VALUES (124, 25, '查看', '/system.friendlink/index', 'system.friendlink:index', 1, NULL, '', 124, '', 1, 'normal', 0, 1614305676, 1614305676, NULL);
INSERT INTO `sa_admin_rules` VALUES (125, 25, '添加', '/system.friendlink/add', 'system.friendlink:add', 1, NULL, '', 125, '', 1, 'normal', 0, 1614305676, 1614305676, NULL);
INSERT INTO `sa_admin_rules` VALUES (126, 25, '编辑', '/system.friendlink/edit', 'system.friendlink:edit', 1, NULL, '', 126, '', 1, 'normal', 0, 1614305676, 1614305676, NULL);
INSERT INTO `sa_admin_rules` VALUES (127, 25, '删除', '/system.friendlink/del', 'system.friendlink:del', 1, NULL, '', 127, '', 1, 'normal', 0, 1614305677, 1614305677, NULL);
INSERT INTO `sa_admin_rules` VALUES (128, 25, '状态', '/system.friendlink/status', 'system.friendlink:status', 2, NULL, '', 128, '', 1, 'normal', 0, 1614305677, 1614305677, NULL);
INSERT INTO `sa_admin_rules` VALUES (129, 25, '回收站', '/system.friendlink/recyclebin', 'system.friendlink:recyclebin', 2, NULL, '', 129, '', 1, 'normal', 0, 1614305677, 1614305677, NULL);
INSERT INTO `sa_admin_rules` VALUES (130, 25, '还原', '/system.friendlink/restore', 'system.friendlink:restore', 2, NULL, '', 130, '', 1, 'normal', 0, 1614305677, 1614305677, NULL);
INSERT INTO `sa_admin_rules` VALUES (131, 25, '销毁', '/system.friendlink/destroy', 'system.friendlink:destroy', 2, NULL, '', 131, '', 1, 'normal', 0, 1614305677, 1614305677, NULL);
INSERT INTO `sa_admin_rules` VALUES (132, 26, '查看', '/system.collect/index', 'system.collect:index', 1, NULL, '', 132, '', 1, 'normal', 0, 1614312452, 1614312452, NULL);
INSERT INTO `sa_admin_rules` VALUES (133, 26, '添加', '/system.collect/add', 'system.collect:add', 1, NULL, '', 133, '', 1, 'normal', 0, 1614312452, 1614312452, NULL);
INSERT INTO `sa_admin_rules` VALUES (134, 26, '编辑', '/system.collect/edit', 'system.collect:edit', 1, NULL, '', 134, '', 1, 'normal', 0, 1614312452, 1614312452, NULL);
INSERT INTO `sa_admin_rules` VALUES (135, 26, '删除', '/system.collect/del', 'system.collect:del', 1, NULL, '', 135, '', 1, 'normal', 0, 1614312452, 1614312452, NULL);
INSERT INTO `sa_admin_rules` VALUES (136, 26, '状态', '/system.collect/status', 'system.collect:status', 2, NULL, '', 136, '', 1, 'normal', 0, 1614312452, 1614312452, NULL);
INSERT INTO `sa_admin_rules` VALUES (137, 26, '回收站', '/system.collect/recyclebin', 'system.collect:recyclebin', 2, NULL, '', 137, '', 1, 'normal', 0, 1614312452, 1614312452, NULL);
INSERT INTO `sa_admin_rules` VALUES (138, 26, '还原', '/system.collect/restore', 'system.collect:restore', 2, NULL, '', 138, '', 1, 'normal', 0, 1614312452, 1614312452, NULL);
INSERT INTO `sa_admin_rules` VALUES (139, 26, '销毁', '/system.collect/destroy', 'system.collect:destroy', 2, NULL, '', 139, '', 1, 'normal', 0, 1614312453, 1614312453, NULL);
INSERT INTO `sa_admin_rules` VALUES (140, 27, '查看', '/system.project/index', 'system.project:index', 1, NULL, '', 140, '', 1, 'normal', 0, 1614312719, 1614312719, NULL);
INSERT INTO `sa_admin_rules` VALUES (141, 27, '添加', '/system.project/add', 'system.project:add', 1, NULL, '', 141, '', 1, 'normal', 0, 1614312719, 1614312719, NULL);
INSERT INTO `sa_admin_rules` VALUES (142, 27, '编辑', '/system.project/edit', 'system.project:edit', 1, NULL, '', 142, '', 1, 'normal', 0, 1614312719, 1614312719, NULL);
INSERT INTO `sa_admin_rules` VALUES (143, 27, '删除', '/system.project/del', 'system.project:del', 1, NULL, '', 143, '', 1, 'normal', 0, 1614312719, 1614312719, NULL);
INSERT INTO `sa_admin_rules` VALUES (144, 27, '状态', '/system.project/status', 'system.project:status', 2, NULL, '', 144, '', 1, 'normal', 0, 1614312719, 1614312719, NULL);
INSERT INTO `sa_admin_rules` VALUES (145, 27, '回收站', '/system.project/recyclebin', 'system.project:recyclebin', 2, NULL, '', 145, '', 1, 'normal', 0, 1614312719, 1614312719, NULL);
INSERT INTO `sa_admin_rules` VALUES (146, 27, '还原', '/system.project/restore', 'system.project:restore', 2, NULL, '', 146, '', 1, 'normal', 0, 1614312719, 1614312719, NULL);
INSERT INTO `sa_admin_rules` VALUES (147, 27, '销毁', '/system.project/destroy', 'system.project:destroy', 2, NULL, '', 147, '', 1, 'normal', 0, 1614312719, 1614312719, NULL);
INSERT INTO `sa_admin_rules` VALUES (148, 28, '查看', '/system.api/index', 'system.api:index', 1, NULL, '', 148, '', 1, 'normal', 0, 1614313050, 1614313050, NULL);
INSERT INTO `sa_admin_rules` VALUES (149, 28, '添加', '/system.api/add', 'system.api:add', 1, NULL, '', 149, '', 1, 'normal', 0, 1614313050, 1614313050, NULL);
INSERT INTO `sa_admin_rules` VALUES (150, 28, '编辑', '/system.api/edit', 'system.api:edit', 1, NULL, '', 150, '', 1, 'normal', 0, 1614313051, 1614313051, NULL);
INSERT INTO `sa_admin_rules` VALUES (151, 28, '删除', '/system.api/del', 'system.api:del', 1, NULL, '', 151, '', 1, 'normal', 0, 1614313051, 1614313051, NULL);
INSERT INTO `sa_admin_rules` VALUES (152, 28, '状态', '/system.api/status', 'system.api:status', 2, NULL, '', 152, '', 1, 'normal', 0, 1614313051, 1614313051, NULL);
INSERT INTO `sa_admin_rules` VALUES (153, 28, '回收站', '/system.api/recyclebin', 'system.api:recyclebin', 2, NULL, '', 153, '', 1, 'normal', 0, 1614313051, 1614313051, NULL);
INSERT INTO `sa_admin_rules` VALUES (154, 28, '还原', '/system.api/restore', 'system.api:restore', 2, NULL, '', 154, '', 1, 'normal', 0, 1614313051, 1614313051, NULL);
INSERT INTO `sa_admin_rules` VALUES (155, 28, '销毁', '/system.api/destroy', 'system.api:destroy', 2, NULL, '', 155, '', 1, 'normal', 0, 1614313051, 1614313051, NULL);
INSERT INTO `sa_admin_rules` VALUES (156, 28, '请求参数', '/system.api/params', 'system.api:params', 2, NULL, '', 156, '', 0, 'normal', 0, 1614313109, 1614313109, NULL);
INSERT INTO `sa_admin_rules` VALUES (157, 28, '添加参数', '/system.api/paramsadd', 'system.api:paramsadd', 1, NULL, '', 157, '', 1, 'normal', 0, 1614313143, 1614313143, NULL);
INSERT INTO `sa_admin_rules` VALUES (158, 28, '编辑参数', '/system.api/paramsedit', 'system.api:paramsedit', 1, NULL, '', 158, '', 1, 'normal', 0, 1614313157, 1614313157, NULL);
INSERT INTO `sa_admin_rules` VALUES (159, 28, '删除参数', '/system.api/paramsdel', 'system.api:paramsdel', 2, NULL, '', 159, '', 1, 'normal', 0, 1614313169, 1614313169, NULL);
INSERT INTO `sa_admin_rules` VALUES (160, 28, '返回参数', '/system.api/restful', 'system.api:restful', 2, NULL, '', 160, '', 0, 'normal', 0, 1614313207, 1614313207, NULL);
INSERT INTO `sa_admin_rules` VALUES (161, 28, '添加返参', '/system.api/restfuladd', 'system.api:restfuladd', 1, NULL, '', 161, '', 1, 'normal', 0, 1614313220, 1614313220, NULL);
INSERT INTO `sa_admin_rules` VALUES (162, 28, '编辑返参', '/system.api/restfuledit', 'system.api:restfuledit', 1, NULL, '', 162, '', 1, 'normal', 0, 1614313234, 1614313234, NULL);
INSERT INTO `sa_admin_rules` VALUES (163, 28, '删除返参', '/system.api/restfuldel', 'system.api:restfuldel', 2, NULL, '', 163, '', 1, 'normal', 0, 1614313245, 1614313245, NULL);
INSERT INTO `sa_admin_rules` VALUES (164, 29, '查看', '/system.apiaccess/index', 'system.apiaccess:index', 1, NULL, '', 164, '', 1, 'normal', 0, 1614313620, 1614313620, NULL);
INSERT INTO `sa_admin_rules` VALUES (165, 29, '添加', '/system.apiaccess/add', 'system.apiaccess:add', 1, NULL, '', 165, '', 1, 'normal', 0, 1614313620, 1614313620, NULL);
INSERT INTO `sa_admin_rules` VALUES (166, 29, '编辑', '/system.apiaccess/edit', 'system.apiaccess:edit', 1, NULL, '', 166, '', 1, 'normal', 0, 1614313620, 1614313620, NULL);
INSERT INTO `sa_admin_rules` VALUES (167, 29, '删除', '/system.apiaccess/del', 'system.apiaccess:del', 1, NULL, '', 167, '', 1, 'normal', 0, 1614313620, 1614313620, NULL);
INSERT INTO `sa_admin_rules` VALUES (168, 29, '状态', '/system.apiaccess/status', 'system.apiaccess:status', 2, NULL, '', 168, '', 1, 'normal', 0, 1614313620, 1614313620, NULL);
INSERT INTO `sa_admin_rules` VALUES (169, 29, '回收站', '/system.apiaccess/recyclebin', 'system.apiaccess:recyclebin', 2, NULL, '', 169, '', 1, 'normal', 0, 1614313620, 1614313620, NULL);
INSERT INTO `sa_admin_rules` VALUES (170, 29, '还原', '/system.apiaccess/restore', 'system.apiaccess:restore', 2, NULL, '', 170, '', 1, 'normal', 0, 1614313620, 1614313620, NULL);
INSERT INTO `sa_admin_rules` VALUES (171, 29, '销毁', '/system.apiaccess/destroy', 'system.apiaccess:destroy', 2, NULL, '', 171, '', 1, 'normal', 0, 1614313620, 1614313620, NULL);
INSERT INTO `sa_admin_rules` VALUES (172, 30, '查看', '/system.company/index', 'system.company:index', 1, NULL, '', 172, '', 1, 'normal', 0, 1614315312, 1614315312, NULL);
INSERT INTO `sa_admin_rules` VALUES (173, 30, '添加', '/system.company/add', 'system.company:add', 1, NULL, '', 173, '', 1, 'normal', 0, 1614315312, 1614315312, NULL);
INSERT INTO `sa_admin_rules` VALUES (174, 30, '编辑', '/system.company/edit', 'system.company:edit', 1, NULL, '', 174, '', 1, 'normal', 0, 1614315312, 1614315312, NULL);
INSERT INTO `sa_admin_rules` VALUES (175, 30, '删除', '/system.company/del', 'system.company:del', 1, NULL, '', 175, '', 1, 'normal', 0, 1614315312, 1614315312, NULL);
INSERT INTO `sa_admin_rules` VALUES (176, 30, '状态', '/system.company/status', 'system.company:status', 2, NULL, '', 176, '', 1, 'normal', 0, 1614315312, 1614315312, NULL);
INSERT INTO `sa_admin_rules` VALUES (177, 30, '回收站', '/system.company/recyclebin', 'system.company:recyclebin', 2, NULL, '', 177, '', 1, 'normal', 0, 1614315312, 1614315312, NULL);
INSERT INTO `sa_admin_rules` VALUES (178, 30, '还原', '/system.company/restore', 'system.company:restore', 2, NULL, '', 178, '', 1, 'normal', 0, 1614315312, 1614315312, NULL);
INSERT INTO `sa_admin_rules` VALUES (179, 30, '销毁', '/system.company/destroy', 'system.company:destroy', 2, NULL, '', 179, '', 1, 'normal', 0, 1614315312, 1614315312, NULL);
INSERT INTO `sa_admin_rules` VALUES (180, 31, '查看', '/system.department/index', 'system.department:index', 1, NULL, '', 180, '', 1, 'normal', 0, 1614315439, 1614315439, NULL);
INSERT INTO `sa_admin_rules` VALUES (181, 31, '添加', '/system.department/add', 'system.department:add', 1, NULL, '', 181, '', 1, 'normal', 0, 1614315439, 1614315439, NULL);
INSERT INTO `sa_admin_rules` VALUES (182, 31, '编辑', '/system.department/edit', 'system.department:edit', 1, NULL, '', 182, '', 1, 'normal', 0, 1614315439, 1614315439, NULL);
INSERT INTO `sa_admin_rules` VALUES (183, 31, '删除', '/system.department/del', 'system.department:del', 1, NULL, '', 183, '', 1, 'normal', 0, 1614315439, 1614315439, NULL);
INSERT INTO `sa_admin_rules` VALUES (184, 31, '状态', '/system.department/status', 'system.department:status', 2, NULL, '', 184, '', 1, 'normal', 0, 1614315439, 1614315439, NULL);
INSERT INTO `sa_admin_rules` VALUES (185, 31, '回收站', '/system.department/recyclebin', 'system.department:recyclebin', 2, NULL, '', 185, '', 1, 'normal', 0, 1614315439, 1614315439, NULL);
INSERT INTO `sa_admin_rules` VALUES (186, 31, '还原', '/system.department/restore', 'system.department:restore', 2, NULL, '', 186, '', 1, 'normal', 0, 1614315439, 1614315439, NULL);
INSERT INTO `sa_admin_rules` VALUES (187, 31, '销毁', '/system.department/destroy', 'system.department:destroy', 2, NULL, '', 187, '', 1, 'normal', 0, 1614315439, 1614315439, NULL);
INSERT INTO `sa_admin_rules` VALUES (188, 31, '部门节点', '/system.department/getlisttree', 'system.department:getlisttree', 2, NULL, '', 188, '', 0, 'normal', 0, 1614315492, 1614315492, NULL);
INSERT INTO `sa_admin_rules` VALUES (189, 32, '查看', '/system.jobs/index', 'system.jobs:index', 1, NULL, '', 189, '', 1, 'normal', 0, 1614315517, 1614315517, NULL);
INSERT INTO `sa_admin_rules` VALUES (190, 32, '添加', '/system.jobs/add', 'system.jobs:add', 1, NULL, '', 190, '', 1, 'normal', 0, 1614315517, 1614315517, NULL);
INSERT INTO `sa_admin_rules` VALUES (191, 32, '编辑', '/system.jobs/edit', 'system.jobs:edit', 1, NULL, '', 191, '', 1, 'normal', 0, 1614315517, 1614315517, NULL);
INSERT INTO `sa_admin_rules` VALUES (192, 32, '删除', '/system.jobs/del', 'system.jobs:del', 1, NULL, '', 192, '', 1, 'normal', 0, 1614315517, 1614315517, NULL);
INSERT INTO `sa_admin_rules` VALUES (193, 32, '状态', '/system.jobs/status', 'system.jobs:status', 2, NULL, '', 193, '', 1, 'normal', 0, 1614315517, 1614315517, NULL);
INSERT INTO `sa_admin_rules` VALUES (194, 32, '回收站', '/system.jobs/recyclebin', 'system.jobs:recyclebin', 2, NULL, '', 194, '', 1, 'normal', 0, 1614315517, 1614315517, NULL);
INSERT INTO `sa_admin_rules` VALUES (195, 32, '还原', '/system.jobs/restore', 'system.jobs:restore', 2, NULL, '', 195, '', 1, 'normal', 0, 1614315517, 1614315517, NULL);
INSERT INTO `sa_admin_rules` VALUES (196, 32, '销毁', '/system.jobs/destroy', 'system.jobs:destroy', 2, NULL, '', 196, '', 1, 'normal', 0, 1614315517, 1614315517, NULL);
INSERT INTO `sa_admin_rules` VALUES (197, 33, '查看', '/system.adminfile/index', 'system.adminfile:index', 1, NULL, '', 197, '', 1, 'normal', 0, 1614315880, 1614315880, NULL);
INSERT INTO `sa_admin_rules` VALUES (198, 33, '编辑', '/system.adminfile/edit', 'system.adminfile:edit', 1, NULL, '', 198, '', 1, 'normal', 0, 1614316018, 1614316018, NULL);
INSERT INTO `sa_admin_rules` VALUES (199, 33, '删除', '/system.adminfile/del', 'system.adminfile:del', 1, NULL, '', 199, '', 1, 'normal', 0, 1614316043, 1614316043, NULL);
INSERT INTO `sa_admin_rules` VALUES (200, 34, '查看', '/system.channel/index', 'system.channel:index', 1, NULL, '', 200, '', 1, 'normal', 0, 1614316182, 1614316182, NULL);
INSERT INTO `sa_admin_rules` VALUES (201, 34, '添加', '/system.channel/add', 'system.channel:add', 1, NULL, '', 201, '', 1, 'normal', 0, 1614316182, 1614316182, NULL);
INSERT INTO `sa_admin_rules` VALUES (202, 34, '编辑', '/system.channel/edit', 'system.channel:edit', 1, NULL, '', 202, '', 1, 'normal', 0, 1614316182, 1614316182, NULL);
INSERT INTO `sa_admin_rules` VALUES (203, 34, '删除', '/system.channel/del', 'system.channel:del', 1, NULL, '', 203, '', 1, 'normal', 0, 1614316182, 1614316182, NULL);
INSERT INTO `sa_admin_rules` VALUES (204, 34, '回收站', '/system.channel/recyclebin', 'system.channel:recyclebin', 2, NULL, '', 204, '', 1, 'normal', 0, 1614316182, 1614316182, NULL);
INSERT INTO `sa_admin_rules` VALUES (205, 34, '还原', '/system.channel/restore', 'system.channel:restore', 2, NULL, '', 205, '', 1, 'normal', 0, 1614316182, 1614316182, NULL);
INSERT INTO `sa_admin_rules` VALUES (206, 34, '销毁', '/system.channel/destroy', 'system.channel:destroy', 2, NULL, '', 206, '', 1, 'normal', 0, 1614316182, 1614316182, NULL);
INSERT INTO `sa_admin_rules` VALUES (207, 35, '查看', '/system.plugin/index', 'system.plugin:index', 1, NULL, '', 207, '', 1, 'normal', 0, 1614407835, 1614407835, NULL);
INSERT INTO `sa_admin_rules` VALUES (208, 35, '安装', '/system.plugin/install', 'system.plugin:install', 1, NULL, '', 208, '', 1, 'normal', 0, 1614407865, 1614407835, NULL);
INSERT INTO `sa_admin_rules` VALUES (209, 35, '卸载', '/system.plugin/uninstall', 'system.plugin:uninstall', 1, NULL, '', 209, '', 1, 'normal', 0, 1614407918, 1614407835, NULL);
INSERT INTO `sa_admin_rules` VALUES (210, 35, '配置', '/system.plugin/config', 'system.plugin:config', 1, NULL, '', 210, '', 1, 'normal', 0, 1614407935, 1614407835, NULL);
INSERT INTO `sa_admin_rules` VALUES (211, 35, '状态', '/system.plugin/status', 'system.plugin:status', 2, NULL, '', 211, '', 1, 'normal', 0, 1614407835, 1614407835, NULL);
INSERT INTO `sa_admin_rules` VALUES (212, 35, '升级', '/system.plugin/upgrade', 'system.plugin:upgrade', 2, NULL, '', 212, '', 1, 'normal', 0, 1614407952, 1614407835, NULL);
INSERT INTO `sa_admin_rules` VALUES (213, 35, '数据表', '/system.plugin/tables', 'system.plugin:tables', 2, NULL, '', 213, '', 1, 'normal', 0, 1614407969, 1614407835, NULL);
INSERT INTO `sa_admin_rules` VALUES (214, 35, '更新缓存', '/system.plugin/cache', 'system.plugin:cache', 2, NULL, '', 214, '', 1, 'normal', 0, 1614407977, 1614407836, NULL);
INSERT INTO `sa_admin_rules` VALUES (215, 36, '查看', '/system.pluginhook/index', 'system.pluginhook:index', 1, NULL, '', 215, '', 1, 'normal', 0, 1614410768, 1614410768, NULL);
INSERT INTO `sa_admin_rules` VALUES (216, 36, '添加', '/system.pluginhook/add', 'system.pluginhook:add', 1, NULL, '', 216, '', 1, 'normal', 0, 1614410768, 1614410768, NULL);
INSERT INTO `sa_admin_rules` VALUES (217, 36, '编辑', '/system.pluginhook/edit', 'system.pluginhook:edit', 1, NULL, '', 217, '', 1, 'normal', 0, 1614410768, 1614410768, NULL);
INSERT INTO `sa_admin_rules` VALUES (218, 36, '删除', '/system.pluginhook/del', 'system.pluginhook:del', 1, NULL, '', 218, '', 1, 'normal', 0, 1614410768, 1614410768, NULL);
INSERT INTO `sa_admin_rules` VALUES (219, 36, '状态', '/system.pluginhook/status', 'system.pluginhook:status', 2, NULL, '', 219, '', 1, 'normal', 0, 1614410768, 1614410768, NULL);
INSERT INTO `sa_admin_rules` VALUES (220, 36, '回收站', '/system.pluginhook/recyclebin', 'system.pluginhook:recyclebin', 2, NULL, '', 220, '', 1, 'normal', 0, 1614410768, 1614410768, NULL);
INSERT INTO `sa_admin_rules` VALUES (221, 36, '还原', '/system.pluginhook/restore', 'system.pluginhook:restore', 2, NULL, '', 221, '', 1, 'normal', 0, 1614410768, 1614410768, NULL);
INSERT INTO `sa_admin_rules` VALUES (222, 36, '销毁', '/system.pluginhook/destroy', 'system.pluginhook:destroy', 2, NULL, '', 222, '', 1, 'normal', 0, 1614410768, 1614410768, NULL);
INSERT INTO `sa_admin_rules` VALUES (223, 37, '查看', '#', '#', 1, NULL, '', 223, '', 1, 'hidden', 0, 1614410973, 1614410973, NULL);
INSERT INTO `sa_admin_rules` VALUES (224, 37, '安装', '#', '#', 1, NULL, '', 224, '', 1, 'hidden', 0, 1614411328, 1614410973, NULL);
INSERT INTO `sa_admin_rules` VALUES (225, 37, '卸载', '#', '#', 1, NULL, '', 225, '', 1, 'hidden', 0, 1614411340, 1614410974, NULL);
INSERT INTO `sa_admin_rules` VALUES (226, 37, '预留1', '#', '#', 1, NULL, '', 226, '', 1, 'hidden', 0, 1614411360, 1614410974, NULL);
INSERT INTO `sa_admin_rules` VALUES (227, 37, '预留2', '#', '#', 2, NULL, '', 227, '', 1, 'hidden', 0, 1614411378, 1614410974, NULL);
INSERT INTO `sa_admin_rules` VALUES (228, 38, '查看', '/system.user/index', 'system.user:index', 1, NULL, '', 228, '', 1, 'normal', 0, 1614411464, 1614411464, NULL);
INSERT INTO `sa_admin_rules` VALUES (229, 38, '添加', '/system.user/add', 'system.user:add', 1, NULL, '', 229, '', 1, 'normal', 0, 1614411464, 1614411464, NULL);
INSERT INTO `sa_admin_rules` VALUES (230, 38, '编辑', '/system.user/edit', 'system.user:edit', 1, NULL, '', 230, '', 1, 'normal', 0, 1614411465, 1614411465, NULL);
INSERT INTO `sa_admin_rules` VALUES (231, 38, '删除', '/system.user/del', 'system.user:del', 1, NULL, '', 231, '', 1, 'normal', 0, 1614411465, 1614411465, NULL);
INSERT INTO `sa_admin_rules` VALUES (232, 38, '状态', '/system.user/status', 'system.user:status', 2, NULL, '', 232, '', 1, 'normal', 0, 1614411465, 1614411465, NULL);
INSERT INTO `sa_admin_rules` VALUES (233, 38, '回收站', '/system.user/recyclebin', 'system.user:recyclebin', 2, NULL, '', 233, '', 1, 'normal', 0, 1614411465, 1614411465, NULL);
INSERT INTO `sa_admin_rules` VALUES (234, 38, '还原', '/system.user/restore', 'system.user:restore', 2, NULL, '', 234, '', 1, 'normal', 0, 1614411465, 1614411465, NULL);
INSERT INTO `sa_admin_rules` VALUES (235, 38, '销毁', '/system.user/destroy', 'system.user:destroy', 2, NULL, '', 235, '', 1, 'normal', 0, 1614411465, 1614411465, NULL);
INSERT INTO `sa_admin_rules` VALUES (236, 39, '查看', '/system.comment/index', 'system.comment:index', 1, NULL, '', 236, '', 1, 'normal', 0, 1614412121, 1614412121, NULL);
INSERT INTO `sa_admin_rules` VALUES (237, 39, '回复', '/system.comment/view', 'system.comment:view', 1, NULL, '', 237, '', 1, 'normal', 0, 1614412121, 1614412121, NULL);
INSERT INTO `sa_admin_rules` VALUES (238, 39, '添加', '/system.comment/add', 'system.comment:add', 1, NULL, '', 238, '', 1, 'normal', 0, 1614412121, 1614412121, NULL);
INSERT INTO `sa_admin_rules` VALUES (239, 39, '编辑', '/system.comment/edit', 'system.comment:edit', 1, NULL, '', 239, '', 1, 'normal', 0, 1614412121, 1614412121, NULL);
INSERT INTO `sa_admin_rules` VALUES (240, 39, '删除', '/system.comment/del', 'system.comment:del', 1, NULL, '', 240, '', 1, 'normal', 0, 1614412121, 1614412121, NULL);
INSERT INTO `sa_admin_rules` VALUES (241, 39, '状态', '/system.comment/status', 'system.comment:status', 2, NULL, '', 241, '', 1, 'normal', 0, 1614412121, 1614412121, NULL);
INSERT INTO `sa_admin_rules` VALUES (242, 39, '回收站', '/system.comment/recyclebin', 'system.comment:recyclebin', 2, NULL, '', 242, '', 1, 'normal', 0, 1614412121, 1614412121, NULL);
INSERT INTO `sa_admin_rules` VALUES (243, 39, '还原', '/system.comment/restore', 'system.comment:restore', 2, NULL, '', 243, '', 1, 'normal', 0, 1614412121, 1614412121, NULL);
INSERT INTO `sa_admin_rules` VALUES (244, 39, '销毁', '/system.comment/destroy', 'system.comment:destroy', 2, NULL, '', 244, '', 1, 'normal', 0, 1614412122, 1614412122, NULL);
INSERT INTO `sa_admin_rules` VALUES (245, 40, '查看', '/system.guestbook/index', 'system.guestbook:index', 1, NULL, '', 245, '', 1, 'normal', 0, 1614412258, 1614412258, NULL);
INSERT INTO `sa_admin_rules` VALUES (246, 40, '回复', '/system.guestbook/reply', 'system.guestbook:reply', 1, NULL, '', 246, '', 1, 'normal', 0, 1614412258, 1614412258, NULL);
INSERT INTO `sa_admin_rules` VALUES (247, 40, '删除', '/system.guestbook/del', 'system.guestbook:del', 1, NULL, '', 247, '', 1, 'normal', 0, 1614412258, 1614412258, NULL);
INSERT INTO `sa_admin_rules` VALUES (248, 40, '状态', '/system.guestbook/status', 'system.guestbook:status', 2, NULL, '', 248, '', 1, 'normal', 0, 1614412258, 1614412258, NULL);
INSERT INTO `sa_admin_rules` VALUES (249, 40, '回收站', '/system.guestbook/recyclebin', 'system.guestbook:recyclebin', 2, NULL, '', 249, '', 1, 'normal', 0, 1614412258, 1614412258, NULL);
INSERT INTO `sa_admin_rules` VALUES (250, 40, '还原', '/system.guestbook/restore', 'system.guestbook:restore', 2, NULL, '', 250, '', 1, 'normal', 0, 1614412258, 1614412258, NULL);
INSERT INTO `sa_admin_rules` VALUES (251, 40, '销毁', '/system.guestbook/destroy', 'system.guestbook:destroy', 2, NULL, '', 251, '', 1, 'normal', 0, 1614412258, 1614412258, NULL);
INSERT INTO `sa_admin_rules` VALUES (252, 41, '查看', '/system.usergroup/index', 'system.usergroup:index', 1, NULL, '', 252, '', 1, 'normal', 0, 1614412309, 1614412309, NULL);
INSERT INTO `sa_admin_rules` VALUES (253, 41, '添加', '/system.usergroup/add', 'system.usergroup:add', 1, NULL, '', 253, '', 1, 'normal', 0, 1614412309, 1614412309, NULL);
INSERT INTO `sa_admin_rules` VALUES (254, 41, '编辑', '/system.usergroup/edit', 'system.usergroup:edit', 1, NULL, '', 254, '', 1, 'normal', 0, 1614412309, 1614412309, NULL);
INSERT INTO `sa_admin_rules` VALUES (255, 41, '删除', '/system.usergroup/del', 'system.usergroup:del', 1, NULL, '', 255, '', 1, 'normal', 0, 1614412309, 1614412309, NULL);
INSERT INTO `sa_admin_rules` VALUES (256, 41, '状态', '/system.usergroup/status', 'system.usergroup:status', 2, NULL, '', 256, '', 1, 'normal', 0, 1614412309, 1614412309, NULL);
INSERT INTO `sa_admin_rules` VALUES (257, 41, '回收站', '/system.usergroup/recyclebin', 'system.usergroup:recyclebin', 2, NULL, '', 257, '', 1, 'normal', 0, 1614412309, 1614412309, NULL);
INSERT INTO `sa_admin_rules` VALUES (258, 41, '还原', '/system.usergroup/restore', 'system.usergroup:restore', 2, NULL, '', 258, '', 1, 'normal', 0, 1614412310, 1614412310, NULL);
INSERT INTO `sa_admin_rules` VALUES (259, 41, '销毁', '/system.usergroup/destroy', 'system.usergroup:destroy', 2, NULL, '', 259, '', 1, 'normal', 0, 1614412310, 1614412310, NULL);
INSERT INTO `sa_admin_rules` VALUES (260, 42, '查看', '/system.database/index', 'system.database:index', 1, NULL, '', 260, '', 1, 'normal', 0, 1614412456, 1614412456, NULL);
INSERT INTO `sa_admin_rules` VALUES (261, 42, '优化', '/system.database/optimize', 'system.database:optimize', 1, NULL, '', 261, '', 1, 'normal', 0, 1614412456, 1614412456, NULL);
INSERT INTO `sa_admin_rules` VALUES (262, 42, '修复', '/system.database/repair', 'system.database:repair', 1, NULL, '', 262, '', 1, 'normal', 0, 1614412456, 1614412456, NULL);
INSERT INTO `sa_admin_rules` VALUES (263, 42, '配置', '/system.database/config', 'system.database:config', 1, NULL, '', 263, '', 1, 'normal', 0, 1614412456, 1614412456, NULL);
INSERT INTO `sa_admin_rules` VALUES (264, 42, '备份', '/system.database/export', 'system.database:export', 1, NULL, '', 264, '', 1, 'normal', 0, 1614412456, 1614412456, NULL);
INSERT INTO `sa_admin_rules` VALUES (265, 43, '查看', '/system.recyclebin/index', 'system.recyclebin:index', 1, NULL, '', 265, '', 1, 'normal', 0, 1614412500, 1614412500, NULL);
INSERT INTO `sa_admin_rules` VALUES (266, 44, '查看', '/system.dictionary/index', 'system.dictionary:index', 1, NULL, '', 266, '', 1, 'normal', 0, 1614413136, 1614413136, NULL);
INSERT INTO `sa_admin_rules` VALUES (267, 44, '添加', '/system.dictionary/add', 'system.dictionary:add', 1, NULL, '', 267, '', 1, 'normal', 0, 1614413136, 1614413136, NULL);
INSERT INTO `sa_admin_rules` VALUES (268, 44, '编辑', '/system.dictionary/edit', 'system.dictionary:edit', 1, NULL, '', 268, '', 1, 'normal', 0, 1614413136, 1614413136, NULL);
INSERT INTO `sa_admin_rules` VALUES (269, 44, '删除', '/system.dictionary/del', 'system.dictionary:del', 1, NULL, '', 269, '', 1, 'normal', 0, 1614413136, 1614413136, NULL);
INSERT INTO `sa_admin_rules` VALUES (270, 44, '状态', '/system.dictionary/status', 'system.dictionary:status', 2, NULL, '', 270, '', 1, 'normal', 0, 1614413136, 1614413136, NULL);
INSERT INTO `sa_admin_rules` VALUES (271, 44, '回收站', '/system.dictionary/recyclebin', 'system.dictionary:recyclebin', 2, NULL, '', 271, '', 1, NULL, 0, 1614413136, 1614413136, NULL);
INSERT INTO `sa_admin_rules` VALUES (272, 44, '还原', '/system.dictionary/restore', 'system.dictionary:restore', 2, NULL, '', 272, '', 1, NULL, 0, 1614413136, 1614413136, NULL);
INSERT INTO `sa_admin_rules` VALUES (273, 44, '销毁', '/system.dictionary/destroy', 'system.dictionary:destroy', 2, NULL, '', 273, '', 1, NULL, 0, 1614413136, 1614413136, NULL);
INSERT INTO `sa_admin_rules` VALUES (274, 10, '栏目限权', 'everycate', 'everycate', 3, '是否限制栏目权限！', '', 274, '', 1, NULL, 1, 1614413293, 1614413252, NULL);
INSERT INTO `sa_admin_rules` VALUES (275, 10, '编辑限权', 'privateauth', 'privateauth', 3, '只可编辑自己发布的数据！请勿删除！', '', 275, '', 1, NULL, 1, 1614413315, 1614413315, NULL);
INSERT INTO `sa_admin_rules` VALUES (276, 10, '附件上传', '/upload/upload', 'upload:upload', 2, NULL, '', 276, '', 0, NULL, 0, 1614424707, 1614424707, NULL);
INSERT INTO `sa_admin_rules` VALUES (277, 10, '查看模板', '/index.tpl/showtpl', 'index.tpl:showtpl', 2, NULL, '', 277, '', 1, NULL, 0, 1614427716, 1614427716, NULL);
INSERT INTO `sa_admin_rules` VALUES (278, 10, '编辑模板', '/index.tpl/edittpl', 'index.tpl:edittpl', 2, NULL, '', 278, '', 1, NULL, 0, 1614427741, 1614427741, NULL);
INSERT INTO `sa_admin_rules` VALUES (279, 10, '头像上传', '/upload/avatar', 'upload:avatar', 2, NULL, '', 285, '', 0, NULL, 0, 1618158541, 1618158541, NULL);

-- ----------------------------
-- Table structure for sa_adwords
-- ----------------------------
DROP TABLE IF EXISTS `sa_adwords`;
CREATE TABLE `sa_adwords`  (
  `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '广告标题',
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '广告标识',
  `pic` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '代码',
  `remind` tinyint(1) NULL DEFAULT 1 COMMENT '到期提醒',
  `status` smallint(1) NULL DEFAULT 1 COMMENT '状态',
  `expirestime` int(11) NULL DEFAULT NULL COMMENT '过期时间',
  `createtime` int(11) NOT NULL COMMENT '添加时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '广告管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_adwords
-- ----------------------------
INSERT INTO `sa_adwords` VALUES (1, '阿里联盟', 'alimama_300x250', '', '<script>当前未过滤XSS，如不需要请删除该模块！</script>', 1, 1, 1612022400, 1610942227, NULL);

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
-- Table structure for sa_category
-- ----------------------------
DROP TABLE IF EXISTS `sa_category`;
CREATE TABLE `sa_category`  (
  `id` smallint(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `pid` smallint(3) NOT NULL COMMENT '父类di',
  `cid` tinyint(1) NOT NULL COMMENT '模型id',
  `title` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '栏目名称',
  `pinyin` varchar(90) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '栏目路径/拼音',
  `seotitle` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目SEO标题',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目SEO关键字',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目SEO描述',
  `sort` smallint(3) NULL DEFAULT NULL COMMENT '排序id',
  `skin` char(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '栏目列表页',
  `skin_detail` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '栏目内容页',
  `skin_child` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '栏目子页面',
  `skin_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '栏目筛选页',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '栏目状态',
  `jumpurl` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '栏目跳转地址',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '栏目管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_category
-- ----------------------------
INSERT INTO `sa_category` VALUES (1, 0, 3, '电影', 'dianying', '', '', '', 1, 'video', 'video_detail', 'video_child', 'video_type', 1, 'http://', NULL);
INSERT INTO `sa_category` VALUES (2, 0, 1, '文章管理', 'wenzhang', '', '', '', 2, 'article', 'article_detail', 'article_child', 'article_type', 1, 'http://', NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据模型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_channel
-- ----------------------------
INSERT INTO `sa_channel` VALUES (1, '文章模型', 'article', 'article', 'article_detail', 'article_child', 'article_type', 1, 1596712387, 1595545811, NULL);
INSERT INTO `sa_channel` VALUES (2, '图片模型', 'image', 'image', 'image_detail', 'image_child', 'image_type', 2, 1596711899, 1595545853, NULL);
INSERT INTO `sa_channel` VALUES (3, '视频模型', 'video', 'vod', 'video_detail', 'video_child', 'video_type', 3, 1595061806, 1595545827, NULL);
INSERT INTO `sa_channel` VALUES (4, '下载模型', 'down', 'down', 'down_detail', 'down_child', 'down_type', 4, 1595061806, 1595545858, NULL);
INSERT INTO `sa_channel` VALUES (5, '单页模型', 'page', 'page', 'page_detail', 'page_child', 'page_type', 5, 1595061806, 1595545839, NULL);
INSERT INTO `sa_channel` VALUES (6, '产品模型', 'product', 'product', 'produc_detail', 'product_child', 'product_type', 6, 1595061806, 1595061806, NULL);

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
INSERT INTO `sa_comment` VALUES (6, 1, 2, 0, 0, 0, '呵呵阿萨德', 0, 0, 2130706433, 0, 1, 1613527166, 1613527166, NULL);
INSERT INTO `sa_comment` VALUES (7, 1, 2, 0, 0, 0, '奥术大师大所多', 0, 0, 2130706433, 0, 1, 1613527189, 1613527189, NULL);
INSERT INTO `sa_comment` VALUES (8, 1, 2, 0, 0, 0, '111111111', 1, 1, 2130706433, 0, 1, 1613527272, 1613527272, NULL);
INSERT INTO `sa_comment` VALUES (9, 1, 2, 0, 0, 0, '啊啊啊啊', 2, 1, 2130706433, 0, 1, 1613527283, 1613527283, NULL);
INSERT INTO `sa_comment` VALUES (10, 1, 2, 0, 0, 0, '<img src=\"/static/images/face/2.gif\"/>', 1, 1, 2130706433, 0, 1, 1613528499, 1613528499, NULL);
INSERT INTO `sa_comment` VALUES (11, 1, 2, 0, 0, 0, '<img src=\"/static/images/face/5.gif\"/>', 1, 2, 2130706433, 0, 1, 1613528587, 1613528587, NULL);
INSERT INTO `sa_comment` VALUES (12, 1, 2, 0, 0, 1, '登录状态下的评论', 2, 9, 2130706433, 0, 1, 1613528610, 1613528610, NULL);
INSERT INTO `sa_comment` VALUES (13, 1, 2, 12, 12, 113, '呵呵的', 0, 0, 2130706433, 0, 1, 1613528905, 1613528905, NULL);
INSERT INTO `sa_comment` VALUES (14, 1, 2, 0, 0, 0, '呵呵', 1, 10, 2130706433, 0, 1, 1613536466, 1613536466, NULL);
INSERT INTO `sa_comment` VALUES (15, 1, 2, 0, 0, 113, '呵呵', 18, 36, 2130706433, 0, 1, 1613536520, 1613536520, NULL);
INSERT INTO `sa_comment` VALUES (16, 1, 2, 10, 10, 113, '在这里回复看看', 0, 0, 2130706433, 0, 1, 1614411817, 1613536552, NULL);
INSERT INTO `sa_comment` VALUES (17, 1, 2, 15, 15, 113, '123132', 0, 0, 2130706433, 0, 1, 1613536653, 1613536653, NULL);
INSERT INTO `sa_comment` VALUES (18, 1, 2, 14, 14, 113, '211212', 0, 0, 2130706433, 0, 1, 1613536691, 1613536691, NULL);
INSERT INTO `sa_comment` VALUES (19, 1, 2, 18, 14, 113, '奥术大师大', 0, 0, 2130706433, 0, 1, 1613536707, 1613536707, NULL);
INSERT INTO `sa_comment` VALUES (20, 1, 2, 0, 0, 1, '测试看看', 1, 5, 2130706433, 0, 1, 1617417100, 1617417100, NULL);
INSERT INTO `sa_comment` VALUES (21, 1, 2, 0, 0, 1, '11111', 1, 1, 2130706433, 0, 1, 1617417174, 1617417174, NULL);
INSERT INTO `sa_comment` VALUES (22, 1, 2, 0, 0, 1, '2222', 1, 1, 2130706433, 0, 1, 1617417227, 1617417227, NULL);
INSERT INTO `sa_comment` VALUES (23, 1, 2, 15, 15, 1, '12313', 0, 0, 2130706433, 0, 1, 1617417296, 1617417296, NULL);
INSERT INTO `sa_comment` VALUES (24, 1, 2, 0, 0, 1, '这里是一个什么评论', 0, 1, 2130706433, 0, 1, 1617417311, 1617417311, NULL);
INSERT INTO `sa_comment` VALUES (25, 1, 2, 15, 15, 1, '12313', 0, 0, 2130706433, 0, 1, 1617417339, 1617417339, NULL);
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
INSERT INTO `sa_department` VALUES (4, 2, '开发部', '二楼', '赵云', '15100010003', 'zhaoyun@shijiazhuang.com', '', 4, 1, 1611228626, NULL);
INSERT INTO `sa_department` VALUES (5, 2, '营销部', '二楼', '许攸', '15100010003', 'xuyou@henan.com', '', 5, 1, 1611228674, NULL);

-- ----------------------------
-- Table structure for sa_friendlink
-- ----------------------------
DROP TABLE IF EXISTS `sa_friendlink`;
CREATE TABLE `sa_friendlink`  (
  `id` tinyint(4) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '友链名称',
  `logo` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '友链logo',
  `url` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '友链地址',
  `sort` tinyint(4) NULL DEFAULT NULL COMMENT '排序ID',
  `type` tinyint(1) NULL DEFAULT 0 COMMENT '友链类型',
  `status` tinyint(1) NULL DEFAULT 1 COMMENT '友链状态',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '友情链接表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_friendlink
-- ----------------------------
INSERT INTO `sa_friendlink` VALUES (1, '百度', '', 'http://www.baidu.com/', 0, 0, 1, 1602040473, NULL);

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
INSERT INTO `sa_navmenu` VALUES (3, 1, '网站编辑3', '/xiazai', 3, 1, 1610788293, NULL);

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
INSERT INTO `sa_project` VALUES (1, 0, '示例应用', '/upload/images/2021-04-06/606c7049b5640.png', '1000001', 'ydFbQVBsRzovUMiISn0m2pLfY9WDTjkq', '这里只是一个示例应用，是为了方便你的API接口分类用的，仅仅只是一个展示功能！', 1612073268, NULL);

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
INSERT INTO `sa_systemlog` VALUES (1, 'admin', 'admin', 'system.systemlog', 'index', NULL, 'app\\admin\\controller\\system\\Systemlog.php', 37, 'Call to a member function where() on null', 'a:2:{s:4:\"page\";s:1:\"1\";s:5:\"limit\";s:2:\"10\";}', 2130706433, 'GET', '1', 1, 1611569935);

-- ----------------------------
-- Table structure for sa_user
-- ----------------------------
DROP TABLE IF EXISTS `sa_user`;
CREATE TABLE `sa_user`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `group_id` smallint(5) UNSIGNED NOT NULL DEFAULT 1 COMMENT '组id',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '昵称',
  `nickname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户昵称',
  `pwd` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密码',
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
  INDEX `id`(`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会员管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_user
-- ----------------------------
INSERT INTO `sa_user` VALUES (1, 1, 'test', '测试用户', '8bcb6ea31d829170b639e33d2da633d2', '1', '/upload/avatar/a0b923820dcc509a_100x100.png?GS9U8WQvOBhk', 'ceshi@foxmail.com', NULL, 0, 100, '你叫什么？', '不告诉你', 1, 10001, 'qIsSBNpcOuJeyw8mb9KilQFLWX34GEg5', NULL, 2130706433, 1617409577, 84, 2130706433, 1597125391, NULL);

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

SET FOREIGN_KEY_CHECKS = 1;
