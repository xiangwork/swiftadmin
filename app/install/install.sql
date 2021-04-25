/*
 Navicat MySQL Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : swiftadmin

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 25/04/2021 19:01:48
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
INSERT INTO `sa_admin` VALUES (1, '1', '2', '3', 'admin', '权栈', '8bcb6ea31d829170b639e33d2da633d2', 1, 'a:3:{i:0;s:21:\"家有傻猫两三只\";i:1;s:15:\"隔壁帅小伙\";i:2;s:9:\"技术宅\";}', '/upload/avatar/f8e34ec67a2a0233_100x100.jpg', '海阔天空，有容乃大', 'admin@swiftadmin.net', '0310', '15100038819', '高级管理人员', 123, '河北省邯郸市', 2130706433, 1618632027, 3232254977, 0, NULL, 1596682835, 1618715053, NULL);
INSERT INTO `sa_admin` VALUES (2, '2', '1', '5,6', 'ceshi', '白眉大侠', '8bcb6ea31d829170b639e33d2da633d2', 1, 'a:3:{i:0;s:5:\"Think\";i:1;s:12:\"铁血柔肠\";i:2;s:12:\"道骨仙风\";}', '/upload/avatar/f8e34ec67a2a0233_100x100.jpg', '吃我一招乾坤大挪移', 'baimei@your.com', '0310', '15188888888', '刀是什么刀，菜刀~来一记webshell~', 24, '河北省邯郸市廉颇大道110号指挥中心', 2130706433, 1618735372, 3232254977, 1, '违规', 1609836672, 1618735372, NULL);

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
INSERT INTO `sa_admin_access` VALUES (1, '1', NULL, NULL);
INSERT INTO `sa_admin_access` VALUES (2, '2', '2,14,45,46,47,48,49,50,51,52,280,281,282,283,17,69,70,71,72,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95,19,20,96,97,98,99,100,101,102,103,104,105,106,107,21,108,109,110,111,112,113,114,115,116,22,117,7,30,172,173,174,175,176,177,178,179,31,180,181,182,183,184,185,186,187,188,32,189,190,191,192,193,194,195,196,33,197,198,199,34,200,201,202,203,204,205,206', '');

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_admin_group
-- ----------------------------
INSERT INTO `sa_admin_group` VALUES (1, 0, NULL, '超级管理员', 'admin', 1, 1, '网站超级管理员组的', NULL, NULL, 'layui-bg-blue', 1607832158, NULL);
INSERT INTO `sa_admin_group` VALUES (2, 1, 2, '网站编辑', 'editor', 1, 1, '负责公司软文的编写', '3,16,61,62,63,64,65,66,67,68,4,17,69,70,71,72,18,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,92,93,94,95', '', 'layui-bg-cyan', 1607832158, NULL);
INSERT INTO `sa_admin_group` VALUES (4, 2, NULL, '阿萨德', '按说', NULL, 1, '阿萨德', '', '', NULL, 1618652499, NULL);
INSERT INTO `sa_admin_group` VALUES (5, 1, NULL, '网站编辑的下方', '12', NULL, 1, '21', '', '', NULL, 1618652563, NULL);

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
  `updatetime` int(11) NOT NULL DEFAULT 0 COMMENT '添加时间',
  `createtime` int(11) NOT NULL COMMENT '创建时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 285 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sa_admin_rules` VALUES (12, 1, '分析页', '/index/analysis', 'index:analysis', 0, NULL, '', 12, '', 0, 'normal', 0, 1619166587, 1614259966, NULL);
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
INSERT INTO `sa_admin_rules` VALUES (25, 5, '友情链接', '/system.friendlink/index', 'system.friendlink:index', 0, NULL, '', 30, '', 1, 'normal', 0, 1618922566, 1614260823, NULL);
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
INSERT INTO `sa_admin_rules` VALUES (271, 44, '回收站', '/system.dictionary/recyclebin', 'system.dictionary:recyclebin', 2, NULL, '', 271, '', 1, 'normal', 0, 1614413136, 1614413136, NULL);
INSERT INTO `sa_admin_rules` VALUES (272, 44, '还原', '/system.dictionary/restore', 'system.dictionary:restore', 2, NULL, '', 272, '', 1, 'normal', 0, 1614413136, 1614413136, NULL);
INSERT INTO `sa_admin_rules` VALUES (273, 44, '销毁', '/system.dictionary/destroy', 'system.dictionary:destroy', 2, NULL, '', 273, '', 1, 'normal', 0, 1614413136, 1614413136, NULL);
INSERT INTO `sa_admin_rules` VALUES (274, 10, '栏目限权', 'everycate', 'everycate', 3, '是否限制栏目权限！', '', 274, '', 1, 'normal', 1, 1614413293, 1614413252, NULL);
INSERT INTO `sa_admin_rules` VALUES (275, 10, '编辑限权', 'privateauth', 'privateauth', 3, '只可编辑自己发布的数据！请勿删除！', '', 275, '', 1, 'normal', 1, 1614413315, 1614413315, NULL);
INSERT INTO `sa_admin_rules` VALUES (276, 10, '附件上传', '/system.upload/upload', 'system.upload:upload', 2, NULL, '', 276, '', 0, 'normal', 0, 1614424707, 1614424707, NULL);
INSERT INTO `sa_admin_rules` VALUES (277, 10, '查看模板', '/index.tpl/showtpl', 'index.tpl:showtpl', 2, NULL, '', 277, '', 1, 'normal', 0, 1614427716, 1614427716, NULL);
INSERT INTO `sa_admin_rules` VALUES (278, 10, '编辑模板', '/index.tpl/edittpl', 'index.tpl:edittpl', 2, NULL, '', 278, '', 1, 'normal', 0, 1614427741, 1614427741, NULL);
INSERT INTO `sa_admin_rules` VALUES (279, 10, '头像上传', '/upload/avatar', 'upload:avatar', 2, NULL, '', 285, '', 0, 'normal', 0, 1618158541, 1618158541, NULL);
INSERT INTO `sa_admin_rules` VALUES (280, 2, '内容管理', '/system.content/index', 'system.content:index', 0, NULL, '', 280, '', 1, 'normal', 0, 1618533490, 1618532768, NULL);
INSERT INTO `sa_admin_rules` VALUES (281, 280, '查看', '/system.content/index', 'system.content:index', 1, NULL, '', 228, '', 1, 'normal', 0, 1614411464, 1614411464, NULL);
INSERT INTO `sa_admin_rules` VALUES (282, 280, '添加', '/system.content/add', 'system.content:add', 1, NULL, '', 229, '', 1, 'normal', 0, 1614411464, 1614411464, NULL);
INSERT INTO `sa_admin_rules` VALUES (283, 280, '编辑', '/system.content/edit', 'system.content:edit', 1, NULL, '', 230, '', 1, 'normal', 0, 1614411465, 1614411465, NULL);
INSERT INTO `sa_admin_rules` VALUES (284, 5, '标签管理', '/system.tags/index', 'system.tags:index', 0, NULL, '', 25, '', 1, 'normal', 0, 1618922693, 1618922598, NULL);

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
INSERT INTO `sa_adwords` VALUES (1, '阿里联盟', 'alimama_300x250', '/upload/images/2021-04-21/607f877516a50.jpeg', '<script>当前未过滤XSS，如不需要请删除该模块！</script>', 1, 1, 1619793011, 1619015549, 1610942227, NULL);

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '文章模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_article
-- ----------------------------
INSERT INTO `sa_article` VALUES (2, 1, 1, '测试下啊', '6fe97759aa27a0c9', '2,3', 'C', '', '121', '/upload/images/2021-04-19/607d773cf1a15.jpg', '/upload/images/2021-04-19/607ce69bce8ef.png', '&lt;p&gt;&lt;strong&gt;asdasx&lt;/strong&gt;shuode&lt;/p&gt;\n&lt;p&gt;&lt;strong&gt;saxlkjs d&lt;/strong&gt;&lt;/p&gt;', NULL, '', '', '', 89577, 0, 0, 0, 0, 3, 4, NULL, 1, 0, 0, 6.0, 0, '', '', NULL, 'iaozhang', NULL, NULL, '', 1618845304, 1617417100, NULL);
INSERT INTO `sa_article` VALUES (3, 1, 1, '呵呵。这是一篇文章', 'a0b923820dcc509a', '', 'H', '', 'hhzsypwz', '', '', '&lt;p&gt;&lt;br data-mce-bogus=&quot;1&quot;&gt;&lt;/p&gt;', NULL, '', '', '', 0, 0, 0, 0, NULL, 3, 0, NULL, 1, 0, 0, 0.0, 0, '', '', NULL, '', NULL, NULL, '', 1619285363, 1618845506, NULL);
INSERT INTO `sa_article` VALUES (5, 1, 1, '爱丽丝肯德基阿萨德dddx', 'a0b923820dcc509a', '', 'A', '', 'alskdjasd', '', '', '&lt;p&gt;asdasd&lt;/p&gt;', '', '', 'asdasd', 'asdasd', 0, 0, 0, 0, NULL, 5, 0, 0, 1, 0, 0, 0.0, 0, '', '', NULL, 'admin', 1, NULL, '', 1619311875, 1618845644, NULL);
INSERT INTO `sa_article` VALUES (6, 1, 1, '1111', 'a0b923820dcc509a', '', '', '', '', '', '', '&lt;p&gt;asdasdasdasd&lt;/p&gt;', '', '', 'asdasdasdasd', 'asdasdasdasd', 0, 0, 0, 0, NULL, 6, 0, 0, 1, 0, 0, 0.0, 0, '', '', NULL, 'admin', 1, NULL, '', 1619275294, 1618845837, NULL);
INSERT INTO `sa_article` VALUES (8, 1, 1, '快讯！特斯拉已提交车辆原始数据', 'a0b923820dcc509a', '', 'K', '', 'kxtslytjclyssj', '/upload/images/2021-04-23/thumb_6082531ccc682.jpeg', '/upload/images/2021-04-23/6082531ccc682.jpeg', '&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;极目新闻记者 余渊 郑州报道&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;刚刚，极目新闻记者采访获悉，特斯拉已提交事发前半小时的车辆原始数据。&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_mediaWrap_213jB&quot; style=&quot;display: flex; margin-top: 36px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;div class=&quot;index-module_contentImg_JmmC0&quot; style=&quot;display: flex; -webkit-box-orient: vertical; -webkit-box-direction: normal; flex-direction: column; -webkit-box-align: center; align-items: center; width: 599px;&quot;&gt;&lt;img class=&quot;index-module_large_1mscr&quot; style=&quot;border: 0px; width: 599px; border-radius: 13px;&quot; src=&quot;/upload/images/2021-04-23/6082531ccc682.jpeg&quot; width=&quot;640&quot; /&gt;&lt;/div&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 36px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;4月22日下午5时46分，特斯拉相关工作人员告诉极目新闻记者，22日上午他们已经将加盖公章的数据拿到了郑州市市场监督管理局，但该局工作人员建议，由当事车主来对接接收。&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;该工作人员称，22日下午，他们多次致电张女士及其家属，但一直未能联系上。22日下午5时30分，他们已经通过快递的形式，将相关数据寄出。&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;4月19日，因在上海车展&amp;ldquo;车顶维权&amp;rdquo;扰乱公共秩序，河南特斯拉车主张女士被上海警方行政拘留5日。此前，她曾质疑特斯拉&amp;ldquo;刹车失灵&amp;rdquo;多次发声（极目新闻曾连续报道）。事件一时引发全国关注。&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;更多精彩资讯请在应用市场下载&amp;ldquo;极目新闻&amp;rdquo;客户端。&lt;/p&gt;\n&lt;/div&gt;', NULL, '', '极目,新闻记者,特斯,数据,22日,余渊,郑州', '极目新闻记者 余渊 郑州报道 刚刚，极目新闻记者采访获悉，特斯拉已提交事发前半小时的车辆原始数据。 4月22日下午5时46分，特斯拉相关工作人员告诉极目...', 0, 0, 0, 0, NULL, 8, 0, 0, 1, 0, 0, 0.0, 0, '', '', NULL, 'admin', 1, NULL, '', 1619312089, 1619153692, NULL);

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
INSERT INTO `sa_category` VALUES (1, 0, 1, '解决方案', NULL, 'case', NULL, '', '', '', NULL, NULL, 1, 'article', 1, NULL, 'article_detail', 'article_child', 'article_type', 'http://', NULL, NULL, NULL);
INSERT INTO `sa_category` VALUES (2, 0, 2, '成功案例', '', 'case', '', '', '', '', 0, NULL, 2, 'page', 1, NULL, 'page_detail', 'page_child', 'page_type', 'http://', 1619171366, NULL, NULL);
INSERT INTO `sa_category` VALUES (3, 0, 3, '插件市场', '2,3', 'plugin', NULL, '', '', '', NULL, NULL, 3, 'down', 1, NULL, 'down_detail', 'down_child', 'down_type', '', NULL, NULL, NULL);
INSERT INTO `sa_category` VALUES (4, 0, 4, '服务支持', '', 'service', '', '', '', '', 0, '<p>呵呵阿萨德爱上了空间下拉谁的asdasd</p><p><mark class=\"marker-yellow\"><strong>粗口</strong></mark></p>', 4, 'article', 1, NULL, 'article_detail', 'article_child', 'article_type', '', NULL, NULL, NULL);
INSERT INTO `sa_category` VALUES (5, 0, 5, '秒杀服务器', '', 'fqw', '', '', '', '', 0, '', 5, 'article', 1, NULL, 'article_detail', 'article_child', 'article_type', 'http://www.baidu.com', NULL, NULL, NULL);
INSERT INTO `sa_category` VALUES (6, 1, 2, '测试', '2,3', 'ceshi', '', '', '', '', 0, '&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;中新网4月23日电 据日本共同社报道，日本复兴厅对旨在宣传核电站处理水&amp;ldquo;安全性&amp;rdquo;的海报进行了修改，删除了表示处理水中所含放射性物质氚的卡通形象，改为元素符号&amp;ldquo;T&amp;rdquo;，并于22日公开了新海报。&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_mediaWrap_213jB&quot; style=&quot;display: flex; margin-top: 36px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;div class=&quot;index-module_contentImg_JmmC0&quot; style=&quot;display: flex; -webkit-box-orient: vertical; -webkit-box-direction: normal; flex-direction: column; -webkit-box-align: center; align-items: center; width: 599px;&quot;&gt;&lt;img class=&quot;index-module_normal_Bq4DA&quot; style=&quot;border: 0px; margin: 0px auto; border-radius: 13px;&quot; src=&quot;/upload/images/2021-04-23/608299a673c98.jpeg&quot; width=&quot;520&quot; /&gt;&lt;/div&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 36px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;日本复兴厅修改了海报，删除了上图中表示处理水中所含放射性物质氚的卡通形象，改为下图中的元素符号&amp;ldquo;T&amp;rdquo;。(图片来源：日本复兴厅官网)&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;13日，日本政府在内阁会议上正式决定，将在两年后把东京电力福岛第一核电站的处理水陆续排入太平洋，引发多方反对。为了宣传处理水的&amp;ldquo;安全性&amp;rdquo;，复兴厅当天在官网上发布包括氚卡通形象的海报和视频，&amp;ldquo;放射性氚&amp;rdquo;被拟化成像&amp;ldquo;吉祥物&amp;rdquo;般的可爱角色。&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;日本复兴厅负责人当时表示，将&amp;ldquo;放射性氚&amp;rdquo;做成&amp;ldquo;吉祥物&amp;rdquo;，是因为这很&amp;ldquo;平易近人&amp;rdquo;，希望塑造一种既不是&amp;ldquo;善&amp;rdquo;、也不是&amp;ldquo;恶&amp;rdquo;的中间感觉。&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;然而，该海报发布后，&amp;ldquo;与福岛面临的严峻现实之间，感觉上存在偏差&amp;rdquo;等批评接踵而来，14日复兴厅撤下了海报和视频。&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;20日，复兴相平泽胜荣道歉称：&amp;ldquo;以令人感到不快的方式发布了信息，由衷表示道歉。&amp;rdquo;&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;海报和视频的制作委托给广告业巨头电通公司，花费了数百万日元的费用。据悉，海报的修改没有委托外部企业，而是由复兴厅职员操作，因此并未产生新增费用。正在讨论在尽可能不产生费用的情况下修改视频的方法，视频修正版的发布时间未定。&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;\n&lt;div class=&quot;index-module_textWrap_3ygOc&quot; style=&quot;margin-top: 22px; font-family: arial; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px; font-size: 16px; line-height: 24px; color: #333333; text-align: justify;&quot;&gt;&lt;span class=&quot;bjh-p&quot;&gt;复兴厅原计划在福岛县内也分发这些海报。负责人表示&amp;ldquo;因为引发了问题，所以将谨慎对待用于在(福岛)当地的说明&amp;rdquo;，强调称会讨论今后如何应对。&lt;/span&gt;&lt;/p&gt;\n&lt;/div&gt;', 6, '', 1, NULL, '', '', '', '', 1619171750, NULL, NULL);

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
INSERT INTO `sa_channel` VALUES (4, '下载模型', 'download', 'download', 'down_detail', 'down_child', 'down_type', 4, 1618708738, 1595545858, NULL);
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
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '数据采集接口' ROW_FORMAT = Dynamic;

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
INSERT INTO `sa_comment` VALUES (16, 1, 2, 10, 10, 113, '在这里回复看看', 0, 0, 2130706433, 0, 1, 1619253770, 1613536552, 1619253770);
INSERT INTO `sa_comment` VALUES (17, 1, 2, 15, 15, 113, '123132', 0, 0, 2130706433, 0, 1, 1619253770, 1613536653, 1619253770);
INSERT INTO `sa_comment` VALUES (18, 1, 2, 14, 14, 113, '211212', 0, 0, 2130706433, 0, 1, 1619253765, 1613536691, 1619253765);
INSERT INTO `sa_comment` VALUES (19, 1, 2, 18, 14, 113, '奥术大师大', 0, 0, 2130706433, 0, 1, 1613536707, 1613536707, NULL);
INSERT INTO `sa_comment` VALUES (20, 1, 2, 0, 0, 1, '测试看看', 1, 5, 2130706433, 0, 1, 1617417100, 1617417100, NULL);
INSERT INTO `sa_comment` VALUES (21, 1, 2, 0, 0, 1, '11111', 1, 1, 2130706433, 0, 1, 1619253761, 1617417174, 1619253761);
INSERT INTO `sa_comment` VALUES (22, 1, 2, 0, 0, 1, '2222', 1, 1, 2130706433, 0, 1, 1619194125, 1617417227, NULL);
INSERT INTO `sa_comment` VALUES (23, 1, 2, 15, 15, 1, '12313', 0, 0, 2130706433, 0, 1, 1619192477, 1617417296, 1619192477);
INSERT INTO `sa_comment` VALUES (24, 1, 2, 0, 0, 1, '这里是一个什么评论', 0, 1, 2130706433, 0, 1, 1619192477, 1617417311, 1619192477);
INSERT INTO `sa_comment` VALUES (25, 1, 2, 15, 15, 1, '12313', 0, 0, 2130706433, 0, 1, 1619192477, 1617417339, 1619192477);
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
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_dictionary
-- ----------------------------
INSERT INTO `sa_dictionary` VALUES (1, 0, '公司类型', 'ctype', 1, '', 1619335705, 1619315177, NULL);
INSERT INTO `sa_dictionary` VALUES (2, 0, '性别', 'sex', 2, '', 1619317798, 1619317798, NULL);
INSERT INTO `sa_dictionary` VALUES (3, 2, '男', '1', 3, '', 1619328741, 1619318908, NULL);
INSERT INTO `sa_dictionary` VALUES (4, 2, '女', '0', 4, '备注', 1619328739, 1619318917, NULL);
INSERT INTO `sa_dictionary` VALUES (5, 2, '未知', '-1', 5, '', 1619319450, 1619318926, NULL);
INSERT INTO `sa_dictionary` VALUES (6, 1, '联盟', 'union', 6, '', 1619333525, 1619330991, NULL);
INSERT INTO `sa_dictionary` VALUES (7, 1, '代码', 'code', 7, '', 1619331113, 1619331113, NULL);
INSERT INTO `sa_dictionary` VALUES (8, 0, 'union', '11', 8, '', 1619335818, 1619333402, 1619335818);
INSERT INTO `sa_dictionary` VALUES (9, 0, '数据维护', 'data', 9, '', 1619335721, 1619335721, NULL);
INSERT INTO `sa_dictionary` VALUES (10, 0, '多表', '11', 10, '', 1619348044, 1619335795, 1619348044);
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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '下载模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_download
-- ----------------------------
INSERT INTO `sa_download` VALUES (2, 4, 4, '迅捷PDF转换器 8.7.8', 'a2f3e71d9181a67b', '3,2', 'X', '#983434', 'xjzhq', '/upload/images/2021-04-22/thumb_60815a1e5cfc7.jpg', '/upload/images/2021-04-22/60815a1e5cfc7.jpg', '&lt;div class=&quot;sub-section&quot; style=&quot;margin-top: 20px; border: 0px none; background: #ffffff; color: #333333; font-family: arial, \'Microsoft YaHei\', 微软雅黑; font-size: 12px;&quot;&gt;\n&lt;div class=&quot;section-header&quot; style=&quot;background: none; height: 24px; overflow: visible; padding: 0px; border: 0px none; line-height: 24px;&quot;&gt;\n&lt;h2 class=&quot;section-title&quot; style=&quot;margin: 0px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 14px; line-height: 24px; float: none; border: 0px none;&quot;&gt;迅捷PDF转换器下载 官方版软件截图&lt;/h2&gt;\n&lt;/div&gt;\n&lt;div class=&quot;screenshot-box&quot; style=&quot;width: 680px; height: 295px; overflow: hidden; margin: 9px 0px 0px; padding: 0px 0px 7px;&quot;&gt;\n&lt;ul class=&quot;screenshot-items clearfix&quot; style=&quot;margin: 0px; padding: 0px; list-style: none; width: 2040px; background: #f2f2f2;&quot;&gt;\n&lt;li class=&quot;item&quot; style=&quot;margin: 0px; padding: 0px 10px 0px 0px; display: table-cell; float: left; height: 250px; overflow: hidden; line-height: 250px; vertical-align: middle;&quot;&gt;&lt;a class=&quot;pic&quot; style=&quot;color: #333333; text-decoration-line: none; outline: none 0px; word-break: break-all;&quot; href=&quot;/&quot;&gt;&lt;img style=&quot;border: 0px; vertical-align: middle; opacity: 1;&quot; title=&quot;[迅捷PDF转换器下载 官方版] 点击看大图&quot; src=&quot;/upload/images/2021-04-22/60815a1e5cfc7.jpg&quot; alt=&quot;迅捷PDF转换器 8.7.8&quot; width=&quot;400&quot; height=&quot;250&quot; /&gt;&lt;/a&gt;&lt;/li&gt;\n&lt;/ul&gt;\n&lt;/div&gt;\n&lt;/div&gt;\n&lt;div class=&quot;sub-section&quot; style=&quot;margin-top: 20px; border: 0px none; background: #ffffff; color: #333333; font-family: arial, \'Microsoft YaHei\', 微软雅黑; font-size: 12px;&quot;&gt;\n&lt;div class=&quot;section-header&quot; style=&quot;background: none; height: 24px; overflow: visible; padding: 0px; border: 0px none; line-height: 24px;&quot;&gt;\n&lt;h2 class=&quot;section-title&quot; style=&quot;margin: 0px; padding: 0px; font-variant-numeric: normal; font-variant-east-asian: normal; font-stretch: normal; font-size: 14px; line-height: 24px; float: none; border: 0px none;&quot;&gt;迅捷PDF转换器下载 官方版软件简介&lt;/h2&gt;\n&lt;/div&gt;\n&lt;div class=&quot;summary-text&quot;&gt;\n&lt;div class=&quot;text-wrap&quot; style=&quot;position: relative; max-height: 810px; overflow: hidden; margin: 8px 0px 0px; color: #666666; line-height: 22px;&quot;&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px;&quot;&gt;迅捷PDF转换器一款功能强大、操作简单的PDF转换成word转换器，支持PDF文档和doc、ppt、图片以及txt文档等多种格式之间的转换，zol提供迅捷PDF转换器官方版下载。&lt;/p&gt;\n&lt;p style=&quot;margin: 0px; padding: 0px;&quot;&gt;pdf转换器软件的转换效果非常出众，其采用的深度解析技术，对于复杂的pdf文件内容也可以做到精准转换。迅捷PDF转换器基于深度PDF转换技术的转换核心，采用了先进的超线程技术，融合最新的批量PDF文件添加转换功能，使得用户可以在同一时间内完成大量PDF文件的转换，极大地提升了软件的转换效率。目前，最新版本的迅捷PDF转换器，已经成功支持任意文件格式的转换。&lt;/p&gt;\n&lt;/div&gt;\n&lt;/div&gt;\n&lt;/div&gt;', '2,4,5', '', 'PDF,转换器,迅捷,下载,官方,软件,文档', '迅捷PDF转换器下载 官方版软件截图 迅捷PDF转换器下载 官方版软件简介 迅捷PDF转换器一款功能强大、操作简单的PDF转换成word转换器，支持PD...', NULL, '', 11220, '.exe', '国产软件', '简体中文', '', '开源软件', 'admin', '', 100, 0, 0, 0, 0, NULL, 1, 3, 0, 1, 0, 0, 0.0, 0, '', '', NULL, 'admin', 1, NULL, '', 1619285360, 1619089950, NULL);

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
INSERT INTO `sa_friendlink` VALUES (2, 'thinkphp', '', 'http://www.thinkphp.cn', '合作伙伴', NULL, 1, 1619159727, NULL);

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '图片模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_image
-- ----------------------------
INSERT INTO `sa_image` VALUES (1, 2, 2, '相册数据集合', '9d4c2f636f067f89', '', 'X', '', 'xcsjjh', '', '', '&lt;p&gt;这里是简介&lt;/p&gt;', 'a:4:{i:0;a:2:{s:3:\"src\";s:44:\"/upload/images/2021-04-22/6081952b27a36.jpeg\";s:5:\"title\";s:7:\"说明1\";}i:1;a:2:{s:3:\"src\";s:44:\"/upload/images/2021-04-22/6081952b27a36.jpeg\";s:5:\"title\";s:7:\"说明2\";}i:2;a:2:{s:3:\"src\";s:44:\"/upload/images/2021-04-22/6081952b27a36.jpeg\";s:5:\"title\";s:7:\"说明3\";}i:3;a:2:{s:3:\"src\";s:44:\"/upload/images/2021-04-22/6081952b27a36.jpeg\";s:5:\"title\";s:7:\"说明4\";}}', '4', '', '这里,简介', '这里是简介', 0, 0, 0, 0, NULL, 1, 3, 0, 1, 0, 0, 0.0, 0, '', '', NULL, 'admin', 1, NULL, '', 1619109426, 1619107275, NULL);

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
-- Table structure for sa_order
-- ----------------------------
DROP TABLE IF EXISTS `sa_order`;
CREATE TABLE `sa_order`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `cid` int(11) NOT NULL COMMENT '分类id/模板/插件',
  `pid` int(11) NOT NULL COMMENT '商品id',
  `oid` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单id',
  `uid` int(11) NOT NULL COMMENT '用户id',
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '商品名称',
  `type` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付类型',
  `status` int(1) UNSIGNED NULL DEFAULT 0 COMMENT '支付状态',
  `updatetime` int(1) NULL DEFAULT NULL COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户订单表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_order
-- ----------------------------
INSERT INTO `sa_order` VALUES (1, 1, 3, '1', 1, 'demo', 'alipay', 0, 1602812266, 1602812266);
INSERT INTO `sa_order` VALUES (7, 1, 9, '202103280941377632983812', 1, 'docs', NULL, 0, NULL, 1616895697);
INSERT INTO `sa_order` VALUES (8, 1, 10, '202103280941441671909324', 1, 'upyun', NULL, 0, NULL, 1616895704);
INSERT INTO `sa_order` VALUES (9, 1, 7, '202103281058587145057719', 1, 'comment', NULL, 0, NULL, 1616900338);
INSERT INTO `sa_order` VALUES (10, 1, 4, '202103281134152464396132', 1, 'nologinurl', NULL, 0, NULL, 1616902455);
INSERT INTO `sa_order` VALUES (11, 1, 2, '202103281139473912805227', 1, 'mobilediy', NULL, 0, NULL, 1616902787);
INSERT INTO `sa_order` VALUES (18, 2, 3, '202103301021327264761146', 1, 'test', NULL, 0, NULL, 1617070892);
INSERT INTO `sa_order` VALUES (19, 2, 2, '202103301216141675830143', 1, 'null', NULL, 0, NULL, 1617077774);
INSERT INTO `sa_order` VALUES (20, 1, 15, '202103301601237176188929', 1, 'customform', NULL, 0, NULL, 1617091283);
INSERT INTO `sa_order` VALUES (21, 1, 13, '202104100948165691994217', 1, 'bos', NULL, 0, NULL, 1618019296);
INSERT INTO `sa_order` VALUES (22, 1, 15, '202104101133303777332542', 1, 'customform1', NULL, 1, NULL, 1618025610);
INSERT INTO `sa_order` VALUES (23, 1, 21, '202104102031148446787233', 1, 'driverschool', NULL, 0, NULL, 1618057874);
INSERT INTO `sa_order` VALUES (24, 1, 10, '202104111048141068506144', 1, 'cloudfiles', NULL, 0, NULL, 1618109294);
INSERT INTO `sa_order` VALUES (25, 1, 16, '202104111119115185508142', 1, 'wxo', NULL, 1, NULL, 1618111151);

-- ----------------------------
-- Table structure for sa_plugin
-- ----------------------------
DROP TABLE IF EXISTS `sa_plugin`;
CREATE TABLE `sa_plugin`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `type` int(1) NULL DEFAULT NULL COMMENT '类型',
  `name` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标识',
  `title` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称',
  `intro` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简述',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述信息',
  `image` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '封面',
  `screenshots` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '相册',
  `user_id` int(11) NULL DEFAULT NULL COMMENT '作者id',
  `author` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作者',
  `url` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'URL地址',
  `demourl` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '演示地址',
  `filepath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '插件路径',
  `qq` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作者QQ',
  `stars` int(1) NULL DEFAULT NULL COMMENT '星级',
  `score` decimal(6, 0) NULL DEFAULT NULL COMMENT '评分',
  `version` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '版本',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  `sort` int(11) NULL DEFAULT NULL COMMENT '排序号',
  `extendedprice` decimal(10, 2) NULL DEFAULT NULL COMMENT '高级版价格',
  `likes` int(10) NULL DEFAULT NULL COMMENT '点击次数',
  `download` int(10) NULL DEFAULT NULL COMMENT '下载次数',
  `status` int(1) UNSIGNED NULL DEFAULT 0 COMMENT '状态',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `delete_time` int(11) NULL DEFAULT NULL COMMENT '软删除标识',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 52 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_plugin
-- ----------------------------
INSERT INTO `sa_plugin` VALUES (2, 5, 'mobilediy', '移动端DIY拖拽布局组件', '基于uni-app开发的DIY可视化拖拽布局组件', '适配H5/APP/各大平台小程序，支持任意整合使用基于uniapp开发的应用系统。', 'https://cdn.fastadmin.net/uploads/addons/mobilediy.png', 'https://cdn.fastadmin.net/uploads/20210318/c1d96d5fe53f995469cab245dd82c60d.jpg#https://cdn.fastadmin.net/uploads/20210318/f49a4f3a637662cd9d03fb224348ce6a.jpg#https://cdn.fastadmin.net/uploads/20210318/f457d7d5ba900bafb4f1a8c40683071f.jpg#https://cdn.fastadmin.net/uploads/20210318/07dd3178cf2a280aac26bbd8bc1b188c.png#https://cdn.fastadmin.net/uploads/20210318/ef3e0d19e78968f44c003c2b1ede3f87.png#https://cdn.fastadmin.net/uploads/20210318/4a00ac21c88318f64992b09743a31f9f.png#https://cdn.fastadmin.net/uploads/20210318/d6655afa8c52e434e052165ea8344aec.png#https://cdn.fastadmin.net/uploads/20210318/81242ed0451d4843212fa3d7dda315ea.png', NULL, 'zhj9922', 'https://www.fastadmin.net/store/mobilediy.html', 'http://diy2.xiaowo6.cn/H5', NULL, '', NULL, 0, '1.0.0', 29.00, NULL, 79.00, 0, 18, 1, 1605884501, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (3, 5, 'demo', 'web云打印机', '一款基于ThinkPHP5+FastAdmin的Web云打印机', '强大灵活的web云打印，包括（易联云，飞鹅，中午）', 'https://cdn.fastadmin.net/uploads/addons/uniprint.png', 'https://cdn.fastadmin.net/uploads/20201112/138162d8cb7f8f9dfe36c631ab285168.png#https://cdn.fastadmin.net/uploads/20201112/b34d8f8cacf5bd40f6d7847819cbf613.png#https://cdn.fastadmin.net/uploads/20201112/249f7fcfdf7e9aaf96bf2655d393498f.png', NULL, 'joelzheng', 'https://www.fastadmin.net/store/uniprint.html', '', '/upload/plugin/demo.zip', '', NULL, 0, '1.0.2', 19.90, NULL, 49.90, 2, 88, 1, 1605927585, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (4, 5, 'nologinurl', '免登录自动鉴权链接', '生成指定用户一次性无需登录自动鉴权URL', '可生成指定用户的一次性无需登录自动鉴权URL，常用于通知消息中的链接', 'https://cdn.fastadmin.net/uploads/addons/nologinurl.png', 'https://cdn.fastadmin.net/uploads/20201209/a9d683e032030a2b5e17e95516ced364.png', NULL, '白衣素袖', 'https://www.fastadmin.net/store/nologinurl.html', 'http://login.ggacm.org/url/5WqLCy', NULL, '', NULL, 4, '1.0.0', 19.90, NULL, 199.00, 3, 34, 1, 1607589624, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (5, 2, 'recharge', '会员充值余额插件', '快速添加余额充值和余额日志功能', '用于整合FastAdmin会员在线充值余额', 'https://cdn.fastadmin.net/uploads/addons/recharge.png', 'https://cdn.fastadmin.net/uploads/20181123/63c0bbd16384ac707def19d705773a2e.png#https://cdn.fastadmin.net/uploads/20181123/7190987233670b76079fb59f9dba67a9.png#https://cdn.fastadmin.net/uploads/20181123/31f4972150c660d667db386053606191.png', NULL, '官方', 'https://www.fastadmin.net/store/recharge.html', '', NULL, '', NULL, 0, '1.0.9', 0.00, NULL, 0.00, 66, 11402, 1, 1542986018, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (6, 5, 'geetest', '全新极验验证码', '为你的FastAdmin添加上AI智能验证码', '将FastAdmin中的前后台验证码切换为极验验证码', 'https://cdn.fastadmin.net/uploads/addons/geetest.png', 'https://cdn.fastadmin.net/uploads/20181112/dc8e5258fa0a7862ce48019368a4cb5b.png#https://cdn.fastadmin.net/uploads/20181112/95f4fdc82ffbf2d5af9242bedc0dca5a.png#https://cdn.fastadmin.net/uploads/20181112/cdd652332c91fb4b27570327440ffe4e.png', NULL, '官方', 'https://www.fastadmin.net/store/geetest.html', '', NULL, '', NULL, 5, '1.0.0', 0.00, NULL, 0.00, 62, 14679, 1, 1541999586, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (7, 9, 'comment', '一站式社会化评论系统', '快速搭建自己的一站式网站评论系统', '基于FastAdmin和ThinkPHP极速开发的类式多说,畅言,友言的一站式网站评论管理系统', 'https://cdn.fastadmin.net/uploads/addons/comment.png', 'https://cdn.fastadmin.net/uploads/20180720/bd53c142c3d27491e8cff8e780ae42de.png#https://cdn.fastadmin.net/uploads/20180720/99b9e25e4f53c57baa95a54b224f0d46.png#https://cdn.fastadmin.net/uploads/20180720/9ce8059853f0f62dca54ed69c53b7b49.png#https://cdn.fastadmin.net/uploads/20180720/426cb174adb5342db9c26878e2753366.png#https://cdn.fastadmin.net/uploads/20180720/80e2807ec4cf3eeacc6d436c8cc7dd4d.png#https://cdn.fastadmin.net/uploads/20180720/f3cbd9f1341e6734d7e0746e88a0e889.png', NULL, '官方', 'https://www.fastadmin.net/store/comment.html', '', NULL, '', NULL, 5, '1.0.4', 99.90, NULL, 199.00, 20, 1264, 1, 1532087960, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (8, 6, 'markdown', 'Markdown编辑器', '一款简洁强大的Markdown编辑器', '在线快速编写Markdown内容,支持预览、剪贴板粘贴图片上传等功能', 'https://cdn.fastadmin.net/uploads/addons/markdown.png', 'https://cdn.fastadmin.net/uploads/20180505/8919cca24fa7aa3cb78fd584e40804f9.png', NULL, '官方', 'https://www.fastadmin.net/store/markdown.html', '', NULL, '', NULL, 5, '1.0.1', 0.00, NULL, 0.00, 52, 11191, 1, 1525489286, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (9, 9, 'docs', 'Markdown文档生成插件', '可根据Markdown文件生成文档', '将Github或本地Git环境中的Markdown文件解析并生成HTML，可在线浏览或导出为HTML离线浏览', 'https://cdn.fastadmin.net/uploads/addons/docs.png', 'https://cdn.fastadmin.net/uploads/20180505/5529b0be0a4e67a2f8061450a0f303f6.png#https://cdn.fastadmin.net/uploads/20180505/6921356e84a7d3af11d43536bfa42c99.png#https://cdn.fastadmin.net/uploads/20180505/f6ab62258e38179a6d5a308a847a704a.png#https://cdn.fastadmin.net/uploads/20180505/ee62613dcaec9767b66baf9dd9ef399b.png#https://cdn.fastadmin.net/uploads/20180505/654c12cdf8be11ad072bf0c5018e853f.png', NULL, '官方', 'https://www.fastadmin.net/store/docs.html', '', NULL, '', NULL, 5, '1.0.4', 99.00, NULL, 299.00, 57, 1505, 1, 1502687956, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (10, 7, 'cloudfiles', '云上传存储插件', '支持客户端直传、服务端中转、分片上传', '启用后将使用又拍云作为默认云存储，支持直传和中转两种上传模式', 'https://cdn.fastadmin.net/uploads/addons/upyun.png', '', NULL, '官方', 'https://www.fastadmin.net/store/upyun.html', '', '/upload/plugin/cloudfiles.zip', '', NULL, 0, '1.1.1', 19.90, NULL, 59.00, 67, 4095, 1, 1500000000, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (11, 6, 'loginbg', '登录背景图', '后台登录背景图', '可自定义后台登录背景图，支持随机和固定模式', 'https://cdn.fastadmin.net/uploads/addons/loginbg.png', '', NULL, '官方', 'https://www.fastadmin.net/store/loginbg.html', '', NULL, '', NULL, 5, '1.0.1', 0.00, NULL, 0.00, 55, 18097, 1, 1500000000, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (12, 4, 'qrcoded', '二维码生成', '前台二维码生成示例', '一个简单的通过PHP生成二维码的示例', 'https://cdn.fastadmin.net/uploads/addons/qrcode.png', 'https://cdn.fastadmin.net/uploads/20180505/c769e488e1cfa928c0a84af431089e2c.png', NULL, '官方', 'https://www.fastadmin.net/store/qrcode.html', '', NULL, '', NULL, 5, '1.0.4', 0.00, NULL, 0.00, 79, 19015, 1, 1500000000, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (13, 7, 'bos', '百度BOS云存储上传插件', '支持客户端直传、服务端中转、分片上传', '将百度BOS作为默认云存储，支持直传和中转两种上传模式', 'https://cdn.fastadmin.net/uploads/addons/bos.png', '', NULL, '官方', 'https://www.fastadmin.net/store/bos.html', '', NULL, '', NULL, 0, '1.1.1', 19.90, NULL, 59.00, 10, 93, 1, 1576896081, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (14, 5, 'bdtts', '百度语音合成', '百度语音合成插件', '百度语音合成', 'https://cdn.fastadmin.net/uploads/addons/bdtts.png', 'https://cdn.fastadmin.net/uploads/20201113/4986a019f743eb27b0b2e93926da1392.png', NULL, '10516487', 'https://www.fastadmin.net/store/bdtts.html', '', NULL, '', NULL, 4, '1.0.0', 0.00, NULL, 0.00, 3, 462, 1, 1605232746, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (15, 4, 'customform1', 'vue可视化表单设计器', '兼容pc+wap，可hook页面引入，提供vue源码', '前端基于vue+iview开发，兼容pc+wap端，提供hook页面引入，实时预览修改样式', 'https://cdn.fastadmin.net/uploads/addons/customform.png', 'https://cdn.fastadmin.net/uploads/20201102/de89251cbd354dee4af67b79d65d1cc8.png#https://cdn.fastadmin.net/uploads/20201102/e4575708af229af67583175043473015.png#https://cdn.fastadmin.net/uploads/20201102/0d6e312b0bc96968845879f9df01b28c.png#https://cdn.fastadmin.net/uploads/20201102/ac5259c7900bbd2a498983797673b291.png#https://cdn.fastadmin.net/uploads/20201102/0eb5ce2622fb92a2f44b8c3eedfbcfe2.png#https://cdn.fastadmin.net/uploads/20201102/5171f4886de41367bc67ea30b6665827.png', NULL, '佐', 'https://www.fastadmin.net/store/customform.html', 'http://balltest.mboo.com.cn/yHwMKztUau.php', NULL, '', NULL, 4, '1.0.4', 49.90, NULL, 199.00, 14, 272, 1, 1604310696, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (16, 5, 'wxo', '微信管理插件', '自动回复、多菜单管理、粉丝&素材管理', '自动回复、多菜单管理、粉丝&素材管理', 'https://cdn.fastadmin.net/uploads/addons/wxo.png', 'https://cdn.fastadmin.net/uploads/20201106/cc09817908537270c5381e000be3e1ef.png#https://cdn.fastadmin.net/uploads/20201106/8a59c805c343811074b61edfe02b1f5d.png#https://cdn.fastadmin.net/uploads/20201106/7c70321c686f0edf854dae41a5c82217.png#https://cdn.fastadmin.net/uploads/20201106/4839560e8e285fa284056e62fffef0d1.png#https://cdn.fastadmin.net/uploads/20201106/79011bf1ef07939afb591b1e411ef1c9.png', NULL, '小星', 'https://www.fastadmin.net/store/wxo.html', '', NULL, '', NULL, 0, '1.0.0', 19.90, NULL, 69.90, 2, 127, 1, 1604632860, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (17, 3, 'bdfanyi', '百度通用翻译', '百度通用翻译插件', '百度通用翻译插件', 'https://cdn.fastadmin.net/uploads/addons/bdfanyi.png', 'https://cdn.fastadmin.net/uploads/20201109/c8ed4c35d6a58b430f9e3e4dfddf955d.png#https://cdn.fastadmin.net/uploads/20201109/2adce3cc47dfdda983234169ef4eac2b.png', NULL, '10516487', 'https://www.fastadmin.net/store/bdfanyi.html', '', NULL, '', NULL, 4, '1.0.0', 0.00, NULL, 0.00, 0, 294, 1, 1605237068, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (18, 9, 'ygame', '赛事报名系统', '基于Fastadmin和Uniapp开发的赛事报名系统', '基于Fastadmin和Uniapp开发的赛事报名系统', 'https://cdn.fastadmin.net/uploads/addons/ygame.png', 'https://cdn.fastadmin.net/uploads/20210113/f9d3acb0ee7dbeb144cf97e55957f808.jpg#https://cdn.fastadmin.net/uploads/20210113/3b789bc61cd2d134ccc3e0c21e987453.jpg#https://cdn.fastadmin.net/uploads/20210113/8957b0999f37b1a52b757000ad113fd4.jpg#https://cdn.fastadmin.net/uploads/20201027/0a480ece49c929e872a7ba49aef2da86.jpg#https://cdn.fastadmin.net/uploads/20201027/618cc37b23c3ff65c472017ce4fed5b5.jpg#https://cdn.fastadmin.net/uploads/20201027/a08c7b860f9d830a13545e7816da4eeb.jpg#https://cdn.fastadmin.net/uploads/20201027/fceead31556b34e67cf3c63b9548dbe9.jpg#https://cdn.fastadmin.net/uploads/20201027/69639bb132766f14361b1eece88ddfcb.jpg#https://cdn.fastadmin.net/uploads/20201027/f0af1b34fac1086f6c75ff83211fc09c.jpg', NULL, 'piupiu', 'https://www.fastadmin.net/store/ygame.html', 'https://www.fastadmin.net/preview/ygame.html', NULL, '', NULL, 4, '1.0.2', 99.00, NULL, 399.00, 3, 130, 1, 1603868473, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (19, 6, 'mindmap', '思维导图-树形图', '一套基于ThinkPHP5+FastAdmin的思维导图网站系统', '基于thinkPHP5+FastAdmin+Vue+Antv G6+iView开发，是一套完整可拓展性的思维导图制作网站', 'https://cdn.fastadmin.net/uploads/addons/mindmap.png', 'https://cdn.fastadmin.net/uploads/20201020/8c35c6d5e13e7b7923c355b95ce6ff72.png#https://cdn.fastadmin.net/uploads/20201020/72d1de8bf8984b6ab139fee8df941844.png#https://cdn.fastadmin.net/uploads/20201020/fc9a58cb12d9e0ebcccbb7d487b23767.png#https://cdn.fastadmin.net/uploads/20201020/73f41d3dc127ad9a76fd10c3346c45f0.png#https://cdn.fastadmin.net/uploads/20201020/6af196b31368b5f7ed73a99a620f819a.png#https://cdn.fastadmin.net/uploads/20201020/fcd6d2ab0af4203a5f5376fbeb6fa1ef.png#https://cdn.fastadmin.net/uploads/20201020/a3ec9481a6ca4d148f88c503d94200de.png#https://cdn.fastadmin.net/uploads/20201020/767d7262de013de89ae87dcb4e52089b.png#https://cdn.fastadmin.net/uploads/20201020/49427b94d00b3e53a6ed3a6737c0d9e1.png#https://cdn.fastadmin.net/uploads/20201020/373025f869cfc3aaf8cb256416bc7397.png#https://cdn.fastadmin.net/uploads/20201020/0a4c2c963911ebf5b916006fbe415997.png', NULL, '佐', 'https://www.fastadmin.net/store/mindmap.html', 'http://mboo.com.cn/addons/mindmap/index/index', NULL, '', NULL, 0, '1.0.0', 0.00, NULL, 0.00, 3, 804, 1, 1603117344, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (20, 2, 'yalimedia', '音视频课程点播系统', '基于阿里云视频点播服务的课程点播插件', '基于FastAdmin+Uniapp开发的课程点播插件，包含音视频、图文课程', 'https://cdn.fastadmin.net/uploads/addons/yalimedia.png', 'https://cdn.fastadmin.net/uploads/20210113/5921431323befd048a3daa3ffb9ac692.jpg#https://cdn.fastadmin.net/uploads/20210113/6ec68658c1485030c214e335c944c2b7.jpg#https://cdn.fastadmin.net/uploads/20210113/a52a453ce373205ce32d9695b67e35d2.jpg#https://cdn.fastadmin.net/uploads/20210113/e89bb277014e22e227732dd28a20b472.jpg#https://cdn.fastadmin.net/uploads/20210113/cb6815e656ddba4c830a08f97a3dfbdd.jpg#https://cdn.fastadmin.net/uploads/20210113/2598c39c9c6e4cde8037185bd546c42d.jpg#https://cdn.fastadmin.net/uploads/20210112/feeb35d51d4a6ace71e5f83ebaa20a51.jpg#https://cdn.fastadmin.net/uploads/20210112/c005b42809f1ed91f610a9d1b421c9d9.jpg#https://cdn.fastadmin.net/uploads/20210112/2abb1cabc1bb1686adb41bd21afc3047.jpg#https://cdn.fastadmin.net/uploads/20210112/6e758f9586bc0e56d112452767a6f9f3.jpg#https://cdn.fastadmin.net/uploads/20210112/8eb1220c1013da6497e5f9faf0680ec4.jpg#https://cdn.fastadmin.net/uploads/20210112/83ba3dc8739f4c7fd5ab4c9e91817dce.jpg#https://cdn.fastadmin.net/uploads/20210112/1233d052139f4a4eddd28e7f95683aa0.jpg#https://cdn.fastadmin.net/uploads/20210112/c5c67a9a6cf288b4dc3b47e5d4fd4c81.jpg', NULL, 'piupiu', 'https://www.fastadmin.net/store/yalimedia.html', 'https://www.fastadmin.net/preview/yalimedia.html', NULL, '', NULL, 5, '1.0.0', 99.00, NULL, 299.00, 7, 117, 1, 1610524340, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (21, 2, 'driverschool', '驾校管理系统', '基于ThinkPHP+FastAdmin搭建的安全智能驾校管理系统', '方便、安全、智能的驾校信息管理系统，让您的管理效率翻倍，管理工作不累', 'https://cdn.fastadmin.net/uploads/addons/driverschool.png', 'https://cdn.fastadmin.net/uploads/20201016/cb2a882c4354c95fd73bc1a80b57b5b3.jpg#https://cdn.fastadmin.net/uploads/20201016/97a7d5be4e62dc2e42153ba922e70e96.png#https://cdn.fastadmin.net/uploads/20201016/0b203697d7cf36f0aa5dfbe94a93bff6.png#https://cdn.fastadmin.net/uploads/20201016/10f68efcc1863544aef755e21cf18d12.png#https://cdn.fastadmin.net/uploads/20201016/af9bce16c5396b2af9d0df3ea26baf4a.png', NULL, 'wowkie', 'https://www.fastadmin.net/store/driverschool.html', 'http://driverschool.huopian.net/LUmYbdXEkg.php', NULL, '', NULL, 0, '1.0.1', 168.00, NULL, 468.00, 4, 598, 1, 1602812266, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (22, 4, 'yjqrcode', '二维码防伪追溯查询', '二维码扫码查询真伪', '基于FastAdmin+ThinkPHP开发的二维码扫码查询真伪', 'https://cdn.fastadmin.net/uploads/addons/yjqrcode.png', 'https://cdn.fastadmin.net/uploads/20201013/8231b4f1411c4df86ce977cb192e769b.png#https://cdn.fastadmin.net/uploads/20201013/f89503c012e0a467f3caa04ef2ce2ec7.png#https://cdn.fastadmin.net/uploads/20201013/4a808386e5b15d57dd5a77c7e2f82496.png#https://cdn.fastadmin.net/uploads/20201013/1085203b54c4f41a59d484107a29e6a9.png#https://cdn.fastadmin.net/uploads/20201013/93c24e492aab37afc4eebf1fafc64c2f.png#https://cdn.fastadmin.net/uploads/20201013/b5f441812db53b78b5e55cfcc15d02d2.png#https://cdn.fastadmin.net/uploads/20201013/78dc274a169b65dc58924cdd0c15ded5.png#https://cdn.fastadmin.net/uploads/20201013/4952f2c7171657507158fd0a1ba27bf9.png', NULL, '云极', 'https://www.fastadmin.net/store/yjqrcode.html', '', NULL, '', NULL, 0, '1.0.0', 99.00, NULL, 299.00, 5, 45, 1, 1602513005, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (23, 3, 'suisunwechat', '公众号管理插件', '微信菜单,公众号客服,素材管理,消息群发,粉丝数据等', '基于EasyWeChat4.x封装的公众号管理插件', 'https://cdn.fastadmin.net/uploads/addons/suisunwechat.png', 'https://cdn.fastadmin.net/uploads/20201013/12796c584f46dc32a27cf98719bdae57.png#https://cdn.fastadmin.net/uploads/20201013/9db39b9e9789951b1345f611a2ec3b06.png#https://cdn.fastadmin.net/uploads/20201013/bf718ffa210d4dd0295f8e419b7f6299.png#https://cdn.fastadmin.net/uploads/20201013/d0a4a7b5918ac64eb5e7b724c1b9dd92.png#https://cdn.fastadmin.net/uploads/20201013/d1c3bba3800d077a1cf811d94d685fa1.png#https://cdn.fastadmin.net/uploads/20201013/bc5ced78a480eac7ef6e203ac6eb43ef.png#https://cdn.fastadmin.net/uploads/20201013/8d18c231c843c715043bff2d85af1121.png', NULL, 'javes', 'https://www.fastadmin.net/store/suisunwechat.html', '', NULL, '', NULL, 0, '1.0.2', 59.00, NULL, 199.00, 3, 182, 1, 1602512174, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (24, 10, 'lodop', 'Lodop打印模板', '让Web打印易起来~~', '开发者绑定打印类名与内容,让用户自行设计打印模板...', 'https://cdn.fastadmin.net/uploads/addons/lodop.png', 'https://cdn.fastadmin.net/uploads/20200819/7c670294d026c130189a352cc2086304.png#https://cdn.fastadmin.net/uploads/20200819/2473c9c9c8db704da3753852101fffd4.png#https://cdn.fastadmin.net/uploads/20200819/806476599b9e5ca7fbac4353ee47b882.png#https://cdn.fastadmin.net/uploads/20200819/aa32027a4a2b1aa46b84714969803aa4.png', NULL, '杨清云', 'https://www.fastadmin.net/store/lodop.html', '', NULL, '', NULL, 4, '1.0.1', 29.00, NULL, 99.00, 2, 72, 1, 1603360164, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (25, 4, 'vipgroup', 'VIP会员组', '基于Fastadmin的会员分组的VIP会员组', '基于Fastadmin的会员分组的VIP会员组', 'https://cdn.fastadmin.net/uploads/addons/vipgroup.png', 'https://cdn.fastadmin.net/uploads/20200811/c33ad491653f835f7973dfb205c2489a.jpg#https://cdn.fastadmin.net/uploads/20200811/db881baf3839a1445c05da3a635bad4a.jpg#https://cdn.fastadmin.net/uploads/20200811/20c9008a972a6c9ac5b046e659352e31.jpg#https://cdn.fastadmin.net/uploads/20200811/f15d37a7cebcb1320d0d1ca1f833e2e2.jpg#https://cdn.fastadmin.net/uploads/20200906/3e60ec89bd5e3ad567065301472f2313.jpg#https://cdn.fastadmin.net/uploads/20200906/1095b43f952fe0f692c9cc3dfb1aeafc.png', NULL, 'CoderRay', 'https://www.fastadmin.net/store/vipgroup.html', '', NULL, '', NULL, 4, '1.0.1', 49.00, NULL, 129.00, 7, 104, 1, 1597158240, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (26, 4, 'distinct', '数据库数据查重工具', '数据库数据查重及去重工具', '可根据选择字段对数据表进行查重及去重', 'https://cdn.fastadmin.net/uploads/addons/distinct.png', 'https://cdn.fastadmin.net/uploads/20200821/c0836414cf8417b77a5218bb180555bf.png', NULL, 'xiaoyu5062', 'https://www.fastadmin.net/store/distinct.html', '', NULL, '', NULL, -3, '1.0.2', 9.90, NULL, 29.90, 1, 62, 1, 1596872591, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (27, 4, 'myblock', '自定义资料插件', '用于显示各种自定义数据信息', '定义并显示多种数据格式，如：文本、图片、文件、富文本内容、数据列表等', 'https://cdn.fastadmin.net/uploads/addons/myblock.png', 'https://cdn.fastadmin.net/uploads/20200807/fb029866e88af5d87359d78442cc0365.png#https://cdn.fastadmin.net/uploads/20200807/8336d073a5b4a34ac6582aa5e99e9658.png#https://cdn.fastadmin.net/uploads/20200807/01a5cdfa3c55f99bce9bbe95774c5138.png#https://cdn.fastadmin.net/uploads/20200807/5d7a6516ac6897db770cb2121c1a122b.png#https://cdn.fastadmin.net/uploads/20200807/27a9c3f95f32c7007b36f0b43dae2e2e.png#https://cdn.fastadmin.net/uploads/20200822/529f38b79452c823a31cc7ce69e52192.png', NULL, 'lotuscheng', 'https://www.fastadmin.net/store/myblock.html', '', NULL, '', NULL, 0, '1.0.1', 49.90, NULL, 150.00, 3, 26, 1, 1596811897, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (28, 4, 'qyexternal', '企业微信客户管理', '一款对用户友好的企业客户管理终端', '企业微信外部联系人管理，支持多个企业微信，新增客户、聊天数据、客户流失等数据统计功能。', 'https://cdn.fastadmin.net/uploads/addons/qyexternal.png', 'https://cdn.fastadmin.net/uploads/20200805/a18504aae8bf33489adc30aa872cda1e.png#https://cdn.fastadmin.net/uploads/20200805/ea98d96f22e5dfc9199f73f724b36f50.png#https://cdn.fastadmin.net/uploads/20200805/6c8d8b1c7c9e0340876ccd2944a4eb61.png#https://cdn.fastadmin.net/uploads/20200805/4f9064e46da8496f41ef61a6e130a0c5.png#https://cdn.fastadmin.net/uploads/20200805/b539cd6e867313c0f09020b26c700517.png#https://cdn.fastadmin.net/uploads/20200805/06136c12e6b6c2365f1ec197ba3e77cd.png', NULL, 'Ghaoo', 'https://www.fastadmin.net/store/qyexternal.html', '', NULL, '', NULL, 0, '1.0.1', 59.00, NULL, 299.00, 1, 88, 1, 1596618611, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (29, 2, 'customcharts', 'DIY图表统计工具', '图表统计工具，通过表单添加数据即可完成图表统计工作', '数据图表统计管理工具，通过表单添加数据即可完成图表统计工作。', 'https://cdn.fastadmin.net/uploads/addons/customcharts.png', 'https://cdn.fastadmin.net/uploads/20200806/0cf929e827a4c172bafe02e0060bb28b.png#https://cdn.fastadmin.net/uploads/20200806/e89734d65e763d3dfb89364e98ac0a24.png#https://cdn.fastadmin.net/uploads/20200806/481facafa3b4c4e3d410105fbc31d9d9.png#https://cdn.fastadmin.net/uploads/20200806/64a099d64b49d7b705b08643eb22c1d1.png#https://cdn.fastadmin.net/uploads/20200806/1b74d251ddbb730039bc20167168c6ed.png', NULL, 'Xing6', 'https://www.fastadmin.net/store/customcharts.html', 'https://www.fastadmin.net/preview/customcharts.html', NULL, '', NULL, 0, '1.0.3', 39.90, NULL, 99.90, 6, 612, 1, 1596549406, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (30, 1, 'mrbs', '会议室预约', '一款移动端会议室、房间预约插件', '移动端会议室、房间预约插件', 'https://cdn.fastadmin.net/uploads/addons/mrbs.png', 'https://cdn.fastadmin.net/uploads/20200719/01d8beeda997af3dce17e409c7000d06.png#https://cdn.fastadmin.net/uploads/20200719/419024532d354d4795c6dc1931cb8c9b.png#https://cdn.fastadmin.net/uploads/20200719/fa29fb650791ccab33aca91eea0594fd.png', NULL, 'lscho', 'https://www.fastadmin.net/store/mrbs.html', 'https://www.fastadmin.net/preview/mrbs.html', NULL, '', NULL, 0, '1.0.2', 49.90, NULL, 149.90, 1, 63, 1, 1595154296, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (31, 9, 'wwh', '企业官网（移动端自适应模板）', '含产品、新闻、HR等多个模块，支持作为网站首页', '含产品中心、解决方案、新闻中心、HR等多个模块，支持作为网站首页', 'https://cdn.fastadmin.net/uploads/addons/wwh.png', 'https://cdn.fastadmin.net/uploads/20210309/e16a0e8ff78e2351027ccb5a850c4437.png#https://cdn.fastadmin.net/uploads/20210309/a2a87144f740790d90479ddbbfef7704.png#https://cdn.fastadmin.net/uploads/20201013/a01ce28ed4fac2897a019e0d3ef97d00.png#https://cdn.fastadmin.net/uploads/20201023/5432f6960e2651c89a9261fb34786ad0.png#https://cdn.fastadmin.net/uploads/20201023/4b20db12de72a118450543c18e2a31ae.png#https://cdn.fastadmin.net/uploads/20201013/b87a7d85a6c8c552649f7aa078ca3d1a.png#https://cdn.fastadmin.net/uploads/20201013/57b0e877bd5265d3fa7d66908d535775.png#https://cdn.fastadmin.net/uploads/20201020/0a878ca0408376b5658947e3084c0bb6.png#https://cdn.fastadmin.net/uploads/20201020/5c9bd31c80b09277d57ad1a1a7227bf4.png', NULL, 'wwh', 'https://www.fastadmin.net/store/wwh.html', 'http://demo.wuwenhui.cn/wwh/', NULL, '', NULL, 0, '1.0.4', 89.00, NULL, 199.00, 6, 846, 1, 1594709574, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (32, 9, 'weblog', '网站日志分析助手', '分析服务器各站点蜘蛛占比,URL/IP统计,访问状态统计', '分析Apache/Ngnix响应日志文件，协助管理员分析服务器各站点蜘蛛占比、URL统计、IP统计、访问状态统计等', 'https://cdn.fastadmin.net/uploads/addons/weblog.png', 'https://cdn.fastadmin.net/uploads/20200720/b265e20bdd8e990ea1e58aa676b39f04.png#https://cdn.fastadmin.net/uploads/20200720/7b5f992df0e7c24031cf5aed5957d388.png#https://cdn.fastadmin.net/uploads/20200720/21fb8153d2ee5a218f72784d7a9aa1f8.png#https://cdn.fastadmin.net/uploads/20200720/d20bcaf112fa28d1ab34856c4a304689.png#https://cdn.fastadmin.net/uploads/20200720/ef05d99134a072f492b2229eda8b0471.png#https://cdn.fastadmin.net/uploads/20200720/246d6b5bd91c94ac6554e630d07e91a5.png', NULL, 'Xing6', 'https://www.fastadmin.net/store/weblog.html', '', NULL, '', NULL, 0, '1.0.0', 9.90, NULL, 39.90, 7, 93, 1, 1594654216, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (33, 4, 'apilog', 'API访问监测分析', 'API访问监测分析及预警，快速了解接口运行情况', 'API访问监测分析及预警，快速了解接口运行情况', 'https://cdn.fastadmin.net/uploads/addons/apilog.png', 'https://cdn.fastadmin.net/uploads/20200709/8352adabc043cb1ed93c2d2bf8e82ccf.png#https://cdn.fastadmin.net/uploads/20200709/25ed7d3eb87682223e2b9394a440868f.png#https://cdn.fastadmin.net/uploads/20200709/f9df4ded673275992c08b96408ae8136.png#https://cdn.fastadmin.net/uploads/20200709/3ff7bfbc25d4a52b51cc6a3f88311952.png#https://cdn.fastadmin.net/uploads/20200725/96fb1f80078d4e68abefdda880dc7ce6.png#https://cdn.fastadmin.net/uploads/20200725/63ba9c9a18c8da24e85c9b97fdc4b62c.png#https://cdn.fastadmin.net/uploads/20200709/e4f4c5bc334b5e146155a04ec5059e61.png#https://cdn.fastadmin.net/uploads/20200725/4832de411b7c3034f5d10df84b573659.png#https://cdn.fastadmin.net/uploads/20200725/e4edfd462359879f29e68d4391aafc19.png#https://cdn.fastadmin.net/uploads/20200725/3719f31f231782c3027fd456703a4777.png#https://cdn.fastadmin.net/uploads/20200725/404e85da6a44a1b3d3b4143da68f1c59.png#https://cdn.fastadmin.net/uploads/20200725/204ea4189223d157dc2eec9fdf6021c3.png', NULL, 'xiaoyu5062', 'https://www.fastadmin.net/store/apilog.html', '', NULL, '', NULL, 0, '1.0.2', 59.90, NULL, 199.90, 10, 294, 1, 1594189578, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (34, 3, 'ezprint', '模板打印插件', '通过后端配置打印模板实现前端打印', '通过后端配置打印模板实现前端打印', 'https://cdn.fastadmin.net/uploads/addons/ezprint.png', 'https://cdn.fastadmin.net/uploads/20200626/783d818bc0d60084639da3a541bcab7b.png#https://cdn.fastadmin.net/uploads/20200626/f085c11aad1982366ffdce55994ed9a7.png#https://cdn.fastadmin.net/uploads/20200626/a5ffd493841eff483ef86c05ce4dcc4e.png', NULL, 'anderson', 'https://www.fastadmin.net/store/ezprint.html', '', NULL, '', NULL, 4, '1.0.0', 39.90, NULL, 99.00, 3, 209, 1, 1593168986, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (35, 9, 'webim', 'WebIM在线聊天系统', 'WebIM即时通讯是一款在线聊天系统。', '基于FastAdmin+GatewayWorker+LayIM开发的一款在线聊天系统。', 'https://cdn.fastadmin.net/uploads/addons/webim.png', 'https://cdn.fastadmin.net/uploads/20200618/3989f24941ebc4d7b376206500efc269.png#https://cdn.fastadmin.net/uploads/20200618/a60e4da5361314d79f00a35977b4ab43.png#https://cdn.fastadmin.net/uploads/20200618/05f3979a3a5c73e10239ea16f3a178f4.png#https://cdn.fastadmin.net/uploads/20200618/c936474aed333ac70fab51ac84b0a3ef.png#https://cdn.fastadmin.net/uploads/20200618/5d96f07f7bd9759add6871d09fbb11a4.png#https://cdn.fastadmin.net/uploads/20200618/4df4d916590ed588bdb1ef2277bd2c3a.png#https://cdn.fastadmin.net/uploads/20200618/7b57432b55febbe0cd2d349cb830cbed.png#https://cdn.fastadmin.net/uploads/20200619/c6977afbf2b2413566375ce37745a968.png#https://cdn.fastadmin.net/uploads/20200619/5781b2c9aaa1a72dd76c65adf247ef91.png#https://cdn.fastadmin.net/uploads/20200618/89c7a0e8b1c693b6604cb779afd04068.png#https://cdn.fastadmin.net/uploads/20200618/2e40113ba10bd5f1d4a0f7a3aee3d015.png#https://cdn.fastadmin.net/uploads/20200618/b033ba360082367a479f8359155d3f41.png#https://cdn.fastadmin.net/uploads/20200618/2d47db37d79f4d6bc820efffaedba680.png#https://cdn.fastadmin.net/uploads/20200704/cdb859e780e288a9c062eebecfd19933.png#https://cdn.fastadmin.net/uploads/20200725/3d3d47f49be06d008de8900585176f9a.png#https://cdn.fastadmin.net/uploads/20200725/fa3d43220615d4a4df53395c330fe60c.png', NULL, 'Xing6', 'https://www.fastadmin.net/store/webim.html', 'https://www.fastadmin.net/preview/webim.html', NULL, '', NULL, 0, '1.0.5', 199.00, NULL, 499.00, 0, 396, 1, 1592469416, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (36, 3, 'alidns', '阿里云域名解析管理', '阿里云域名解析管理', '阿里云域名解析管理', 'https://cdn.fastadmin.net/uploads/addons/alidns.png', 'https://cdn.fastadmin.net/uploads/20200618/239b1dea25a045ece6246b4c606d5367.png#https://cdn.fastadmin.net/uploads/20200618/dbdd6e4862f13f190516093eefdb898a.png#https://cdn.fastadmin.net/uploads/20200618/4e8a3ca00dee551818c6e82584154bd6.png', NULL, 'xiaoyu5062', 'https://www.fastadmin.net/store/alidns.html', '', NULL, '', NULL, 4, '1.1.0', 19.90, NULL, 59.90, 1, 24, 1, 1592298562, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (37, 4, 'datatask', '数据表备份还原', '根据数据重要程度设置不同的备份频率', '根据数据重要程度设置不同的备份频率', 'https://cdn.fastadmin.net/uploads/addons/datatask.png', 'https://cdn.fastadmin.net/uploads/20200615/44724d7dfb50ac8c7a7f527ed4e3bd01.png#https://cdn.fastadmin.net/uploads/20200615/e9704fe2f59dde64428ac8a631b51e7e.png#https://cdn.fastadmin.net/uploads/20200615/c76815cae2035ea38a106a12b71bca79.png#https://cdn.fastadmin.net/uploads/20200615/c54ce2308e1dd27333f5eda4aad226ed.png', NULL, 'ACoder', 'https://www.fastadmin.net/store/datatask.html', '', NULL, '', NULL, 4, '1.0.0', 0.00, NULL, 0.00, 3, 1602, 1, 1592230610, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (38, 3, 'oauth', 'OAuth2 服务端', 'OAuth2.0 身份认证系统服务端的 thinkphp5 的完整实现', 'OAuth2.0 身份认证系统服务端的 thinkphp5 的完整实现，提供全部无加密源码及完整使用文档', 'https://cdn.fastadmin.net/uploads/addons/oauth.png', 'https://cdn.fastadmin.net/uploads/20200613/7da0ab15f23663dd1aa7087935f96ea5.png#https://cdn.fastadmin.net/uploads/20200613/95b02fff467c54c9ebaa4469a009a8dd.png#https://cdn.fastadmin.net/uploads/20200613/7715083ec1e8323e637db4451c1d0cf3.png#https://cdn.fastadmin.net/uploads/20200613/49b83a812b2004096a32d774bcce3f2c.png#https://cdn.fastadmin.net/uploads/20200613/69df101d71956959a35b9782f9f1739b.png#https://cdn.fastadmin.net/uploads/20200613/a6ad9588b1fa3d44366afe1099bd24f2.png#https://cdn.fastadmin.net/uploads/20200613/e6848e42a40606ea57db0ef5a3a9c9db.png#https://cdn.fastadmin.net/uploads/20200613/0bd257610f9a0b0b16cff5033543593f.png#https://cdn.fastadmin.net/uploads/20200613/7a3c533a64989af7e6d407f6c5b4997d.png', NULL, 'Ghaoo', 'https://www.fastadmin.net/store/oauth.html', '', NULL, '', NULL, 4, '1.0.1', 159.90, NULL, 299.90, 5, 126, 1, 1592036171, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (39, 5, 'rboot', 'Rboot机器人', 'rboot是一款可以工作在不同的聊天服务上的助手机器人', 'rboot是一款可以通过扩展实现本地或远程甚至硬件系统的运维办公自动化系统', 'https://cdn.fastadmin.net/uploads/addons/rboot.png', 'https://cdn.fastadmin.net/uploads/20200613/c82c244d85b0bfb086ab19328cb2be68.png#https://cdn.fastadmin.net/uploads/20200613/463b1bc0871a2ba9a6481e453c06611c.png#https://cdn.fastadmin.net/uploads/20200613/9dedd6b7e7fa224b31ae17b95172189d.png#https://cdn.fastadmin.net/uploads/20200613/a5d37d79ae5bd168c568b3a9888f8894.png#https://cdn.fastadmin.net/uploads/20200613/82165b2fc115950fc91a92f40799d4ce.png#https://cdn.fastadmin.net/uploads/20200613/f41336869a68a3b32dd8ad8b524ef30a.png', NULL, 'Ghaoo', 'https://www.fastadmin.net/store/rboot.html', '', NULL, '', NULL, 4, '1.1.0', 159.00, NULL, 299.00, 6, 55, 1, 1592017421, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (40, 4, 'faredis', 'Redis数据管理工具', 'Redis数据管理工具', 'Redis数据管理工具，支持Redis五种类型修改', 'https://cdn.fastadmin.net/uploads/addons/faredis.png', 'https://cdn.fastadmin.net/uploads/20200610/556b15670e6db611d6005f112d7ce2a4.png#https://cdn.fastadmin.net/uploads/20200610/d9be00c441e0fdeca5214b4048e6945d.png#https://cdn.fastadmin.net/uploads/20200610/13d1e73457fbef02430762412aa0e388.png#https://cdn.fastadmin.net/uploads/20200610/d0a37fd5f4298cb19cf25ae861ecd3cd.png#https://cdn.fastadmin.net/uploads/20200610/d6835fabe9299f774244e6c4b11a6f9d.png#https://cdn.fastadmin.net/uploads/20200610/9bc4d7d2afbf8eb531db447dd91b1750.png', NULL, 'xiaoyu5062', 'https://www.fastadmin.net/store/faredis.html', '', NULL, '', NULL, 4, '1.0.3', 9.90, NULL, 59.90, 7, 318, 1, 1591773156, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (41, 1, 'unilive', '微信小程序直播管理', '实时同步微信管理后台的直播数据，本地储存与管理直播信息', '实时同步微信管理后台的直播数据，本地储存与管理直播信息', 'https://cdn.fastadmin.net/uploads/addons/unilive.png', 'https://cdn.fastadmin.net/uploads/20200607/5681bf3d1931574d4f824e6538791088.png#https://cdn.fastadmin.net/uploads/20200607/8f8447c24f3768be98279abfba88196c.png#https://cdn.fastadmin.net/uploads/20200607/c8f465e1b4ceeaf8323d8fd4afe370b1.png', NULL, 'joelzheng', 'https://www.fastadmin.net/store/unilive.html', 'https://www.fastadmin.net/preview/unilive.html', NULL, '', NULL, 0, '1.0.0', 19.90, NULL, 99.90, 3, 133, 1, 1591532147, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (42, 4, 'lang', '语言文件管理', '管理lang目录下面语言文件', '可视化管理lang目录下面语言文件,添加修改语言文件字段', 'https://cdn.fastadmin.net/uploads/addons/lang.png', 'https://cdn.fastadmin.net/uploads/20200607/7ac17191159bb843db68c2ab06326d70.png#https://cdn.fastadmin.net/uploads/20200607/8e9f05e7a22783609d835abab8d70e51.png#https://cdn.fastadmin.net/uploads/20200607/04c8df89e5ec72fe9e8693b6f59edec4.png', NULL, 'NEKGod', 'https://www.fastadmin.net/store/lang.html', '', NULL, '', NULL, 4, '1.0.0', 0.00, NULL, 0.00, 7, 1668, 1, 1591526909, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (43, 1, 'csmvip', 'VIP会员包月套餐', '会员包月的服务,可用于官方CMS插件', '会员包月的服务,可用于官方CMS插件', 'https://cdn.fastadmin.net/uploads/addons/csmvip.png', 'https://cdn.fastadmin.net/uploads/20200604/7840c5904f4d57e0e2b07a0c0728e931.jpg#https://cdn.fastadmin.net/uploads/20200604/85cd888bd50eb9d33d5531e88eaf8fd9.jpg#https://cdn.fastadmin.net/uploads/20200604/81171ea6bafcd2ab3eb78fb131b707cc.jpg#https://cdn.fastadmin.net/uploads/20200604/8e69efa87ffcc96e806f546d052a2402.jpg#https://cdn.fastadmin.net/uploads/20200604/b77c69036788c37914b3413da60a48f1.jpg', NULL, 'chenshiming', 'https://www.fastadmin.net/store/csmvip.html', 'https://www.fastadmin.net/preview/csmvip.html', NULL, '', NULL, 4, '1.0.2', 49.90, NULL, 250.00, 2, 245, 1, 1591283704, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (44, 9, 'pointsmarket', '会员充值送积分营销插件', '会员充值送积分营销插件', '会员充值送积分营销插件、可用积分兑换相关会员组功能', 'https://cdn.fastadmin.net/uploads/addons/pointsmarket.png', 'https://cdn.fastadmin.net/uploads/20200602/25af2f6d7e51a8d1ab5ca75c601dde8b.png#https://cdn.fastadmin.net/uploads/20200918/4e63b72108e0233954dbf4c5b61cbd70.png', NULL, 'amplam', 'https://www.fastadmin.net/store/pointsmarket.html', '', NULL, '', NULL, 4, '1.0.0', 9.90, NULL, 19.90, 1, 29, 1, 1604042197, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (45, 5, 'git', 'git自动部署', 'git自动部署更新', 'git自动部署更新', 'https://cdn.fastadmin.net/uploads/addons/git.png', 'https://cdn.fastadmin.net/uploads/20200601/78e309cd5f91655c340e0fa814988f8f.jpg#https://cdn.fastadmin.net/uploads/20200601/a15ff613fd5ba988445820b9656c8adc.png', NULL, 'hnh000', 'https://www.fastadmin.net/store/git.html', '', NULL, '', NULL, 4, '1.0.0', 19.90, NULL, 99.00, 7, 130, 1, 1590976581, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (46, 5, 'wxdata', '微信公众号数据分析', '微信公众号运营数据分析', '包含数据同步，用户分析，图文分析及单篇群发的数据分析，全面了解公众号的运营情况', 'https://cdn.fastadmin.net/uploads/addons/wxdata.png', 'https://cdn.fastadmin.net/uploads/20200529/7f0f2dbe88e46d95fd45a436f36213ff.png#https://cdn.fastadmin.net/uploads/20200529/4cc0c7cf0df03f7ca6a5e651e897d28d.png#https://cdn.fastadmin.net/uploads/20200529/344c42f48c33807df098c842d2bdc59b.png#https://cdn.fastadmin.net/uploads/20200529/6ce25256d8bd4848b1eab32e416c1b68.png#https://cdn.fastadmin.net/uploads/20200529/dabb2e6d1966072a24505e6f64cb2dea.png#https://cdn.fastadmin.net/uploads/20200529/ee5622341e8cdefcdfc03318cd3eddfa.png', NULL, 'xiaoyu5062', 'https://www.fastadmin.net/store/wxdata.html', '', NULL, '', NULL, 4, '1.0.0', 39.90, NULL, 188.88, 0, 75, 1, 1590731632, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (47, 8, 'workwxbot', '企业微信机器人', '实现运维 或 办公 自动化的机器人', '利用企业微信自建应用实现的机器人助手，它可以通过扩展脚本以实现 运维 或 办公 自动化。', 'https://cdn.fastadmin.net/uploads/addons/workwxbot.png', 'https://cdn.fastadmin.net/uploads/20200528/0a9ed16800d5d2932e7077cf0a3a3ab5.png#https://cdn.fastadmin.net/uploads/20200528/c848e94e266f2e4e58d678a185e3b49b.png#https://cdn.fastadmin.net/uploads/20200528/e8f2063daefa4b03a21366f2e6e3ada4.png#https://cdn.fastadmin.net/uploads/20200528/3e8d6bc3579e54e9f9122c4a5e6b8e94.png#https://cdn.fastadmin.net/uploads/20200528/0d98081b845949a6c3e3812e3942768c.png#https://cdn.fastadmin.net/uploads/20200528/32a7d08e21ba7d135695a7b8668c6ef8.png', NULL, 'guhao', 'https://www.fastadmin.net/store/workwxbot.html', '', NULL, '', NULL, 4, '1.0.0', 89.90, NULL, 159.90, 3, 79, 1, 1590637179, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (48, 8, 'translate', '谷歌自动翻译', '可以帮您将任意语种翻译为任意语种', '谷歌翻译插件是一个可以自动调用谷歌翻译，帮您将任意语种的语言翻译为任意语种', 'https://cdn.fastadmin.net/uploads/addons/translate.png', 'https://cdn.fastadmin.net/uploads/20200525/4b84ec518939fbb7ad71ea8d0b09342a.png#https://cdn.fastadmin.net/uploads/20200525/1c3af7af8d249d2b99b8cbb95904695a.png', NULL, 'proxy', 'https://www.fastadmin.net/store/translate.html', '', NULL, '', NULL, 4, '1.0.0', 19.90, NULL, 199.00, 4, 36, 1, 1590417688, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (49, 2, 'csmhistory', '记录历史版本', '数据记录的历史版本保存,CMS插件的伴侣', '数据记录的历史版本保存和查询,支持CMS插件的内容历史记录', 'https://cdn.fastadmin.net/uploads/addons/csmhistory.png', 'https://cdn.fastadmin.net/uploads/20200524/dbee0184093d32b80f445208cc52d6d6.jpg#https://cdn.fastadmin.net/uploads/20200524/3d189bcdf6e14ee164751f39b174f8a2.jpg#https://cdn.fastadmin.net/uploads/20200524/2c281031d35132634067c1314ccc4ee5.jpg', NULL, 'chenshiming', 'https://www.fastadmin.net/store/csmhistory.html', 'https://www.fastadmin.net/preview/csmhistory.html', NULL, '', NULL, 4, '1.0.1', 39.90, NULL, 250.00, 2, 51, 1, 1590328279, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (50, 5, 'csmding', '钉钉对接套件', '包括sdk对接/pc和移动登录支持/推送消息等', '包括sdk对接/pc和移动登录支持/推送消息等', 'https://cdn.fastadmin.net/uploads/addons/csmding.png', 'https://cdn.fastadmin.net/uploads/20200522/49bccdc759de41c0db1a2af7aec20fe0.jpg#https://cdn.fastadmin.net/uploads/20200522/b32ba8eeb1980f4e5e3f2e4b723719fa.jpg#https://cdn.fastadmin.net/uploads/20200522/89f35c694e6a99c7747d2f04d72f5f1d.jpg', NULL, 'chenshiming', 'https://www.fastadmin.net/store/csmding.html', 'https://www.fastadmin.net/preview/csmding.html', NULL, '', NULL, 4, '1.0.7', 69.90, NULL, 499.00, 1, 131, 1, 1590160809, NULL, NULL);
INSERT INTO `sa_plugin` VALUES (51, 2, 'banip', '禁止IP访问', '禁止IP访问', '禁止IP访问', 'https://cdn.fastadmin.net/uploads/addons/banip.png', 'https://cdn.fastadmin.net/uploads/20200521/bd643607186e704fdd98f27612c48021.png#https://cdn.fastadmin.net/uploads/20200521/7f48672e8067cb2f8029e6d9287fa6c2.png#https://cdn.fastadmin.net/uploads/20200521/e812ffbc7d0edec2d126f871e7de8387.png', NULL, '27025011', 'https://www.fastadmin.net/store/banip.html', '', NULL, '', NULL, 4, '1.0.0', 0.00, NULL, 0.00, 6, 1732, 1, 1589939772, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '插件钩子管理' ROW_FORMAT = Dynamic;

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '产品模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_product
-- ----------------------------
INSERT INTO `sa_product` VALUES (1, 5, 5, 'vivo S9 5G手机 12GB+256GB 印象拾光 前置4400万超清双摄', 'bbce2345d7772b06', '', 'S', '', 'sjyxsgqzwcqss', '/upload/images/2021-04-23/thumb_608239811cb36.jpg', '/upload/images/2021-04-23/608239811cb36.jpg', 'a:3:{i:0;a:2:{s:3:\"src\";s:43:\"/upload/images/2021-04-23/6082318c74778.jpg\";s:5:\"title\";s:0:\"\";}i:1;a:2:{s:3:\"src\";s:43:\"/upload/images/2021-04-23/6082319041b9b.jpg\";s:5:\"title\";s:0:\"\";}i:2;a:2:{s:3:\"src\";s:43:\"/upload/images/2021-04-23/608232bbcaada.jpg\";s:5:\"title\";s:0:\"\";}}', '&lt;div id=&quot;J-detail-pop-tpl-top-new&quot; style=&quot;margin: 0px; padding: 0px; overflow: hidden; color: #666666; font-family: tahoma, arial, \'Microsoft YaHei\', \'Hiragino Sans GB\', u5b8bu4f53, sans-serif; font-size: 12px; background-color: #ffffff;&quot;&gt;\n&lt;div class=&quot;ssd-module-wrap ssd-format-wrap&quot; style=&quot;margin: 0px auto; padding: 0px; position: relative; width: 750px;&quot;&gt;\n&lt;div class=&quot;ssd-format-floor ssd-floor-activity&quot; style=&quot;margin: 0px; padding: 0px; max-height: 380px; overflow: hidden;&quot;&gt;&lt;img style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/608239811cb36.jpg&quot; usemap=&quot;#test6&quot; border=&quot;0&quot; /&gt;&lt;map name=&quot;test6&quot;&gt;\n&lt;area coords=&quot;15,3,739,337&quot; shape=&quot;rect&quot; href=&quot;https://item.jd.com/100018349362.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;/map&gt;&lt;/div&gt;\n&lt;/div&gt;\n&lt;div class=&quot;ssd-module-wrap ssd-format-wrap&quot; style=&quot;margin: 0px auto; padding: 0px; position: relative; width: 750px;&quot;&gt;\n&lt;div class=&quot;ssd-format-floor ssd-floor-shopPrior&quot; style=&quot;margin: 0px; padding: 0px; max-height: 900px; overflow: hidden;&quot;&gt;\n&lt;div class=&quot;ssd-floor-type&quot; style=&quot;margin: 0px; padding: 0px;&quot; data-type=&quot;shopPrior&quot;&gt;&amp;nbsp;&lt;/div&gt;\n&lt;div id=&quot;zbViewFloorHeight_shopPrior&quot; style=&quot;margin: 0px; padding: 0px;&quot;&gt;&lt;/div&gt;\n&lt;img style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/60823981365f8.jpg&quot; usemap=&quot;#test3&quot; border=&quot;0&quot; /&gt;&amp;nbsp;&lt;map name=&quot;test3&quot;&gt;\n&lt;area coords=&quot;256,11,489,264&quot; shape=&quot;rect&quot; href=&quot;https://item.jd.com/100018752514.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;504,10,740,266&quot; shape=&quot;rect&quot; href=&quot;https://item.jd.com/100009737523.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;14,11,245,267&quot; shape=&quot;rect&quot; href=&quot;https://item.jd.com/100017141382.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;/map&gt;&lt;img style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/608239814a678.jpg&quot; usemap=&quot;#test5&quot; border=&quot;0&quot; /&gt;&lt;map name=&quot;test5&quot;&gt;\n&lt;area coords=&quot;256,288,487,393&quot; shape=&quot;rect&quot; href=&quot;https://lzkj-isv.isvjcloud.com/lzclient/22bc80c21de345edbd2cc78062f692e8/cjwx/common/entry.html?activityId=22bc80c21de345edbd2cc78062f692e8&amp;amp;gameType=wxNineGrid&amp;amp;adsource=tg_storePage&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;503,290,735,393&quot; shape=&quot;rect&quot; href=&quot;https://pro.jd.com/mall/active/2NVU7CSzCbBmCxiwu36rXE7uU6mN/index.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;19,410,254,512&quot; shape=&quot;rect&quot; href=&quot;https://jdcs.jd.com/pop/chat?shopId=1000085868&amp;amp;code=1&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;257,406,488,508&quot; shape=&quot;rect&quot; href=&quot;https://pro.jd.com/mall/active/GRHVWBznL3hqtGz6aadAPuLMc8x/index.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;area coords=&quot;503,406,737,509&quot; shape=&quot;rect&quot; href=&quot;https://shopmember.m.jd.com/shopcard?venderId=1000085868&amp;amp;shopId=1000085868&amp;amp;venderType=5&amp;amp;channel=401&quot; target=&quot;_blank&quot; /&gt;\n&lt;/map&gt;&lt;/div&gt;\n&lt;/div&gt;\n&lt;div class=&quot;ssd-module-wrap ssd-format-wrap ssd-format-center&quot; style=&quot;margin: 0px auto; padding: 0px; position: relative; width: 750px; display: flex; -webkit-box-pack: center; justify-content: center;&quot;&gt;\n&lt;div class=&quot;ssd-format-floor ssd-floor-dynamic J_formatDynamic&quot; style=&quot;margin: 0px; padding: 0px;&quot;&gt;&amp;nbsp;&lt;/div&gt;\n&lt;/div&gt;\n&lt;/div&gt;\n&lt;div class=&quot;detail-content clearfix&quot; style=&quot;margin: 10px 0px; padding: 0px; position: relative; background: #f7f7f7; color: #666666; font-family: tahoma, arial, \'Microsoft YaHei\', \'Hiragino Sans GB\', u5b8bu4f53, sans-serif; font-size: 12px;&quot; data-name=&quot;z-have-detail-nav&quot;&gt;\n&lt;div class=&quot;detail-content-wrap&quot; style=&quot;margin: 0px; padding: 0px; width: 990px; float: left; background-color: #ffffff;&quot;&gt;\n&lt;div class=&quot;detail-content-item&quot; style=&quot;margin: 0px; padding: 0px; width: 990px;&quot;&gt;\n&lt;div id=&quot;J-detail-top&quot; style=&quot;margin: 0px; padding: 0px;&quot;&gt;&lt;/div&gt;\n&lt;div id=&quot;J-detail-content&quot; style=&quot;margin: 0px; padding: 0px;&quot;&gt;&lt;br /&gt;\n&lt;div style=&quot;margin: 0px; padding: 0px;&quot;&gt;&amp;nbsp;&lt;/div&gt;\n&lt;div style=&quot;margin: 0px; padding: 0px;&quot;&gt;&amp;nbsp;&lt;/div&gt;\n&lt;div style=&quot;margin: 0px; padding: 0px;&quot; align=&quot;center&quot;&gt;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/608239815d27c.jpg&quot; usemap=&quot;#Map91&quot; border=&quot;0&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/6082398176891.jpg&quot; usemap=&quot;#Map21&quot; border=&quot;0&quot; /&gt;&amp;nbsp;&lt;map name=&quot;Map21&quot;&gt;\n&lt;area coords=&quot;441,163,740,414&quot; shape=&quot;rect&quot; href=&quot;https://item.jd.com/100017255662.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;/map&gt;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/608239818b8ee.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/608239819fb06.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/60823981bb6c4.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/60823981d04cd.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/60823981e5d9e.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/6082398205b06.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/608239821c035.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/60823982306d4.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/6082398267c12.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/608239827af23.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/608239829289d.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/60823982a5ad0.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/60823982cd211.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/60823982dd1a1.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/6082398307d4e.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/6082398321724.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/6082398342ed5.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/6082398356786.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/608239836aadb.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/608239837d2d2.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/60823983914e6.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/60823983a83f5.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/60823983b8884.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/60823983ca191.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/60823983e3cbe.jpg&quot; /&gt;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/6082398405d0b.jpg&quot; /&gt;&amp;nbsp;&amp;nbsp;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/608239841b082.jpg&quot; usemap=&quot;#Map73&quot; border=&quot;0&quot; /&gt;&amp;nbsp;&lt;map name=&quot;Map73&quot;&gt;\n&lt;area coords=&quot;10,25,740,553&quot; shape=&quot;rect&quot; href=&quot;https://pro.jd.com/mall/active/3MqzEEMRDHiGEfcad1VjgHZ8X9nw/index.html&quot; target=&quot;_blank&quot; /&gt;\n&lt;/map&gt;&lt;img class=&quot;&quot; style=&quot;margin: 0px; padding: 0px; border: 0px; vertical-align: middle;&quot; src=&quot;/upload/images/2021-04-23/6082398430e2a.jpg&quot; /&gt;&lt;/div&gt;\n&lt;/div&gt;\n&lt;/div&gt;\n&lt;/div&gt;\n&lt;/div&gt;', 3299.00, 1800.00, 99999, '5', '', '', '', 0, 0, 0, 0, NULL, 1, 0, 0, 1, 0, 0, 0.0, 0, '', '', NULL, 'admin', 1, NULL, '', 1619312489, 1619145018, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '回收站数据表' ROW_FORMAT = Dynamic;

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
INSERT INTO `sa_systemlog` VALUES (1, 'admin', 'admin', 'system.systemlog', 'index', NULL, '\\www.swiftadmin.net\\app\\admin\\controller\\system\\Systemlog.php', 37, 'Call to a member function where() on null', 'a:2:{s:4:\"page\";s:1:\"1\";s:5:\"limit\";s:2:\"10\";}', 2130706433, 'GET', '1', 1, 1611569935);

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
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'SEO关键词库' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sa_tags
-- ----------------------------
INSERT INTO `sa_tags` VALUES (1, '你他妈1', 0, 0, 0, 1, 1619185861, 1611213045, NULL);
INSERT INTO `sa_tags` VALUES (2, '操你妈2', 0, 0, 0, 1, 1618924118, 1611227478, NULL);
INSERT INTO `sa_tags` VALUES (3, '谣言3', 0, 0, 1, 1, 1618926778, 1611228586, NULL);
INSERT INTO `sa_tags` VALUES (4, '百度4', 1, 0, 0, 1, 1618926778, 1611228626, NULL);
INSERT INTO `sa_tags` VALUES (5, '最新电影5', 1, 0, 0, 1, 1618926771, 1611228674, NULL);
INSERT INTO `sa_tags` VALUES (6, 'SEO6', 1, 0, 0, 1, 1618926774, 1618924018, NULL);
INSERT INTO `sa_tags` VALUES (7, '排名靠前7', 1, 0, 1, 1, 1618924030, 1618924030, NULL);
INSERT INTO `sa_tags` VALUES (8, '这里是优化词8', 1, 0, 0, 1, 1618926693, 1618926693, NULL);

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
INSERT INTO `sa_user` VALUES (1, 1, 'test', '测试用户', '32cba3145525fd3a736b4b01b278200c', '1', '/upload/avatar/a0b923820dcc509a_100x100.png?GS9U8WQvOBhk', 'ceshi@foxmail.com', NULL, 0, 100, '你叫什么？', '不告诉你', 1, 10001, 'qIsSBNpcOuJeyw8mb9KilQFLWX34GEg5', NULL, 2130706433, 1618118998, 96, 2130706433, 1597125391, 1619193638);

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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '第三方登录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_user_third
-- ----------------------------
INSERT INTO `sa_user_third` VALUES (1, 1, 'weixin', '', '', '', '', '', NULL, 0, NULL, NULL, NULL, NULL);
INSERT INTO `sa_user_third` VALUES (2, 1, 'weibo', '', '', '', '', '', NULL, 0, NULL, NULL, NULL, NULL);

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户验证码表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_user_validate
-- ----------------------------
INSERT INTO `sa_user_validate` VALUES (5, NULL, '15100038819', '5396', 'changer', 0, 1617337550, NULL);
INSERT INTO `sa_user_validate` VALUES (6, NULL, '15100038819', '7683', 'changer', 0, 1617632959, NULL);

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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '视频模型数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sa_video
-- ----------------------------
INSERT INTO `sa_video` VALUES (1, 3, 3, '有翡', '电视剧版有匪/有匪', 'asdas', '', 'Y', '#9d3636', NULL, '一句话简述', '台湾是中国的', 'BD高清', '赵丽颖 王一博 张慧雯 陈若轩 周洁琼 孙坚', '5', '/upload/images/2021-04-22/thumb_60811a355453c.jpeg', '/upload/images/2021-04-22/60811a355453c.jpeg', '吴锦源', '大陆', '国语', 2021, 13, '36', 'flv$$$ckplayer$$$video', 'server1$$$$$$server2', '11$$$呵呵~$$$2332323', '第01集$https://d.mhqiyi.com/20210224/LfNO3InW/index.m3u8#第02集$https://mhcdn.mhqiyi.com/20210303/QiLcl2jL/index.m3u8#第03集$https://mhcdn.mhqiyi.com/20210310/RQEIMFWB/index.m3u8#第04集$https://mhcdn.mhqiyi.com/20210317/ZMvPZ7j9/index.m3u8#第05集$https://mhcdn.mhqiyi.com/20210324/MCSw6HK7/index.m3u8#第06集$https://mhcdn.mhqiyi.com/20210331/UUblu301/index.m3u8#第07集$https://cdn3.mh-qiyi.com/20210407/Q5nlTQOH/index.m3u8#第08集$https://cdn4.mh-qiyi.com/20210414/2214_3dba4fa3/index.m3u8#第09集$https://cdn3.mh-qiyi.com/20210421/JmlUvicT/index.m3u8$$$第01集$https://d.mhqiyi.com/20210224/LfNO3InW/index.m3u8#第02集$https://mhcdn.mhqiyi.com/20210303/QiLcl2jL/index.m3u8#第03集$https://mhcdn.mhqiyi.com/20210310/RQEIMFWB/index.m3u8#第04集$https://mhcdn.mhqiyi.com/20210317/ZMvPZ7j9/index.m3u8#第05集$https://mhcdn.mhqiyi.com/20210324/MCSw6HK7/index.m3u8#第06集$https://mhcdn.mhqiyi.com/20210331/UUblu301/index.m3u8#第07集$https://cdn3.mh-qiyi.com/20210407/Q5nlTQOH/index.m3u8#第08集$https://cdn4.mh-qiyi.com/20210414/2214_3dba4fa3/index.m3u8#第09集$https://cdn3.mh-qiyi.com/20210421/JmlUvicT/index.m3u8$$$第02集$https://mhcdn.mhqiyi.com/20210303/QiLcl2jL/index.m3u8#第03集$https://mhcdn.mhqiyi.com/20210310/RQEIMFWB/index.m3u8', 1, 1619712000, 116, '周四', '', '江湖,李徵,年前,祸乱,一代,大侠,南刀', '多年前江湖祸乱，一代大侠南刀李徵奉旨围匪，从此便有了四十八寨。后李徵病逝，江湖名门也相继落败。李徵的女儿李瑾容接任大当家，与周以棠成婚。周家有女初成长，...', '&lt;p&gt;多年前江湖祸乱，一代大侠南刀李徵奉旨围匪，从此便有了四十八寨。后李徵病逝，江湖名门也相继落败。李徵的女儿李瑾容接任大当家，与周以棠成婚。周家有女初成长，周翡所生的朝代却是一个江湖没落的时候，前辈们的光辉与意气风发在南刀李徵逝去后逐渐都销声匿迹了。周翡十三岁那年离家出走，差点命丧洗墨江，被端王谢允救下，冥冥之中结下良缘。三年后，两位头角峥嵘的少年再次在霍家堡相遇，引出了多年前隐匿江湖的各类宗师高手。同时遭到曹贼手下北斗七位高手的追杀，令两位少年陷入了一场暗潮汹涌的阴谋。周翡以&amp;ldquo;破雪刀&amp;rdquo;之招数名震江湖，以浩然之姿，为这江湖名册再添上了浓墨重彩的一笔。&lt;img src=&quot;/upload/images/2021-04-22/60811a355453c.jpeg&quot; alt=&quot;&quot; width=&quot;600&quot; height=&quot;800&quot; /&gt;&lt;/p&gt;', 0, 0, 0, 0, NULL, 0, 3, 0, 1, 0, 0, 0.0, 0, '', '', NULL, '', NULL, NULL, '', 1619265092, 1617632959, NULL);

SET FOREIGN_KEY_CHECKS = 1;
