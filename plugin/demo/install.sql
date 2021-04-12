/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 50726
 Source Host           : localhost:3306
 Source Schema         : swiftadmin

 Target Server Type    : MySQL
 Target Server Version : 50726
 File Encoding         : 65001

 Date: 23/03/2021 20:44:01
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for __PREFIX__demo
-- ----------------------------
DROP TABLE IF EXISTS `__PREFIX__demo`;
CREATE TABLE `__PREFIX__demo`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标题',
  `updatetime` int(11) NULL DEFAULT NULL COMMENT '更新时间',
  `createtime` int(11) NULL DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'demo插件数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of __PREFIX__demo
-- ----------------------------
INSERT INTO `__PREFIX__demo` VALUES (1, 'demo插件', 1602812266, 1602812266);

SET FOREIGN_KEY_CHECKS = 1;
