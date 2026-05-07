/*
 Navicat Premium Dump SQL

 Source Server         : 本地MySql服务器
 Source Server Type    : MySQL
 Source Server Version : 80012 (8.0.12)
 Source Host           : localhost:3306
 Source Schema         : family

 Target Server Type    : MySQL
 Target Server Version : 80012 (8.0.12)
 File Encoding         : 65001

 Date: 07/05/2026 15:35:33
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for kp_activity
-- ----------------------------
DROP TABLE IF EXISTS `kp_activity`;
CREATE TABLE `kp_activity`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `activity_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `enterprise_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `lang_key` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh_CN',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '活动简介',
  `location` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '活动地点',
  `organizer` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '主办方',
  `sponsor` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '赞助商',
  `start_date` datetime NULL DEFAULT NULL COMMENT '开始时间',
  `end_date` datetime NULL DEFAULT NULL COMMENT '结束时间',
  `registration_deadline` datetime NULL DEFAULT NULL COMMENT '报名截止时间',
  `max_participants` int(10) UNSIGNED NULL DEFAULT NULL COMMENT '最大参与人数',
  `participant_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '当前参与人数',
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '活动费用',
  `thumbnail` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '缩略图',
  `images` json NULL COMMENT '活动图片',
  `ref_product` json NULL COMMENT '关联产品',
  `metadata` json NULL COMMENT '扩展元数据',
  `meta_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `meta_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `meta_keywords` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `view_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览次数',
  `like_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞次数',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_public` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否公开',
  `status` enum('draft','published','ongoing','completed','cancelled') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `activity_activity_uuid_unique`(`activity_uuid` ASC) USING BTREE,
  UNIQUE INDEX `activity_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `activity_user_id_is_active_index`(`user_id` ASC, `is_active` ASC) USING BTREE,
  INDEX `activity_enterprise_id_is_active_index`(`enterprise_id` ASC, `is_active` ASC) USING BTREE,
  INDEX `activity_lang_key_is_active_index`(`lang_key` ASC, `is_active` ASC) USING BTREE,
  INDEX `activity_status_start_date_index`(`status` ASC, `start_date` ASC) USING BTREE,
  INDEX `activity_is_featured_published_at_index`(`is_featured` ASC, `published_at` ASC) USING BTREE,
  INDEX `activity_start_date_end_date_index`(`start_date` ASC, `end_date` ASC) USING BTREE,
  INDEX `activity_lang_key_index`(`lang_key` ASC) USING BTREE,
  INDEX `activity_is_active_index`(`is_active` ASC) USING BTREE,
  INDEX `activity_is_featured_index`(`is_featured` ASC) USING BTREE,
  INDEX `activity_status_index`(`status` ASC) USING BTREE,
  FULLTEXT INDEX `ft_activity_title_content`(`title`, `content`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '活动管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_activity
-- ----------------------------

-- ----------------------------
-- Table structure for kp_ads
-- ----------------------------
DROP TABLE IF EXISTS `kp_ads`;
CREATE TABLE `kp_ads`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ad_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告唯一标识',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告标题',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '广告描述',
  `content` json NULL COMMENT '广告内容 (图片、文字、HTML等)',
  `image` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '广告图片',
  `link_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '跳转链接',
  `link_target` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_blank' COMMENT '链接打开方式',
  `position` enum('header','sidebar','footer','content','popup','banner') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告位置',
  `weight` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '权重 (数值越大优先级越高)',
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  `view_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '展示次数',
  `click_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点击次数',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `ads_ad_uuid_unique`(`ad_uuid` ASC) USING BTREE,
  INDEX `idx_position_active_weight`(`position` ASC, `is_active` ASC, `weight` ASC) USING BTREE,
  INDEX `idx_time_range`(`start_time` ASC, `end_time` ASC) USING BTREE,
  INDEX `ads_position_index`(`position` ASC) USING BTREE,
  INDEX `ads_is_active_index`(`is_active` ASC) USING BTREE,
  FULLTEXT INDEX `ft_ads_title_desc`(`title`, `description`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '广告表 - 网站广告位管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_ads
-- ----------------------------

-- ----------------------------
-- Table structure for kp_announce
-- ----------------------------
DROP TABLE IF EXISTS `kp_announce`;
CREATE TABLE `kp_announce`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `announce_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告唯一标识',
  `admin_id` bigint(20) UNSIGNED NOT NULL,
  `lang_key` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh_CN' COMMENT '语言标识',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告标题',
  `slug` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'URL别名',
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '公告摘要',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '公告内容',
  `type` enum('system','maintenance','feature','security','general') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general' COMMENT '公告类型',
  `priority` enum('low','normal','high','urgent') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'normal' COMMENT '优先级',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  `is_pinned` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶',
  `is_popup` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否弹窗显示',
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `published_at` timestamp NULL DEFAULT NULL COMMENT '发布时间',
  `expires_at` timestamp NULL DEFAULT NULL COMMENT '过期时间',
  `view_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '查看次数',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `announce_announce_uuid_unique`(`announce_uuid` ASC) USING BTREE,
  UNIQUE INDEX `announce_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `announce_admin_id_foreign`(`admin_id` ASC) USING BTREE,
  INDEX `idx_type_active_published`(`type` ASC, `is_active` ASC, `published_at` ASC) USING BTREE,
  INDEX `idx_pinned_priority_sort`(`is_pinned` ASC, `priority` ASC, `sort_order` ASC) USING BTREE,
  INDEX `idx_lang_active`(`lang_key` ASC, `is_active` ASC) USING BTREE,
  INDEX `announce_lang_key_index`(`lang_key` ASC) USING BTREE,
  INDEX `announce_type_index`(`type` ASC) USING BTREE,
  INDEX `announce_priority_index`(`priority` ASC) USING BTREE,
  INDEX `announce_is_active_index`(`is_active` ASC) USING BTREE,
  INDEX `announce_is_pinned_index`(`is_pinned` ASC) USING BTREE,
  FULLTEXT INDEX `ft_announce_title_content`(`title`, `content`),
  FULLTEXT INDEX `ft_announce_summary`(`summary`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '网站公告表 - 系统公告通知管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_announce
-- ----------------------------

-- ----------------------------
-- Table structure for kp_app_ali
-- ----------------------------
DROP TABLE IF EXISTS `kp_app_ali`;
CREATE TABLE `kp_app_ali`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_app_ali
-- ----------------------------

-- ----------------------------
-- Table structure for kp_app_wx
-- ----------------------------
DROP TABLE IF EXISTS `kp_app_wx`;
CREATE TABLE `kp_app_wx`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `wx_key` varchar(125) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `grant_type` varchar(125) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '获取access_token填写client_credential',
  `appid` varchar(125) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '第三方用户唯一凭证',
  `secret` varchar(125) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '第三方用户唯一凭证密钥，即appsecret',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `app_wx_wx_key_unique`(`wx_key` ASC) USING BTREE,
  INDEX `app_wx_wx_key_index`(`wx_key` ASC) USING BTREE,
  INDEX `app_wx_appid_index`(`appid` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '微信公众号表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_app_wx
-- ----------------------------

-- ----------------------------
-- Table structure for kp_applet_ali
-- ----------------------------
DROP TABLE IF EXISTS `kp_applet_ali`;
CREATE TABLE `kp_applet_ali`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '支付宝小程序表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_applet_ali
-- ----------------------------

-- ----------------------------
-- Table structure for kp_applet_wx
-- ----------------------------
DROP TABLE IF EXISTS `kp_applet_wx`;
CREATE TABLE `kp_applet_wx`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `wx_key` varchar(125) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `applet_wx_wx_key_unique`(`wx_key` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '微信小程序表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_applet_wx
-- ----------------------------

-- ----------------------------
-- Table structure for kp_appt
-- ----------------------------
DROP TABLE IF EXISTS `kp_appt`;
CREATE TABLE `kp_appt`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `a_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '预约人姓名',
  `tel_phone` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '手机号码',
  `email` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `login_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_read` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '是否阅读，1：已读，0：未读',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `appt_a_id_unique`(`a_id` ASC) USING BTREE,
  INDEX `appt_name_index`(`name` ASC) USING BTREE,
  INDEX `appt_tel_phone_index`(`tel_phone` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '线上预约表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_appt
-- ----------------------------

-- ----------------------------
-- Table structure for kp_area
-- ----------------------------
DROP TABLE IF EXISTS `kp_area`;
CREATE TABLE `kp_area`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '区号',
  `name` varchar(35) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `parent_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '0' COMMENT '父级',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `area_name_index`(`name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '中国地区表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_area
-- ----------------------------

-- ----------------------------
-- Table structure for kp_back_up
-- ----------------------------
DROP TABLE IF EXISTS `kp_back_up`;
CREATE TABLE `kp_back_up`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `back_up_id` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `filename` varchar(125) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(155) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `back_up_back_up_id_unique`(`back_up_id` ASC) USING BTREE,
  UNIQUE INDEX `back_up_filename_unique`(`filename` ASC) USING BTREE,
  INDEX `back_up_back_up_id_filename_index`(`back_up_id` ASC, `filename` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci COMMENT = '数据备份表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_back_up
-- ----------------------------

-- ----------------------------
-- Table structure for kp_cases
-- ----------------------------
DROP TABLE IF EXISTS `kp_cases`;
CREATE TABLE `kp_cases`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `case_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `enterprise_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `lang_key` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh_CN',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '案例简介',
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '案例分类',
  `tags` json NULL COMMENT '案例标签',
  `thumbnail` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '缩略图',
  `images` json NULL COMMENT '案例图片',
  `meta_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `meta_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `meta_keywords` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `view_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览次数',
  `like_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞次数',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶',
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `client_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '客户名称',
  `project_date` date NULL DEFAULT NULL COMMENT '项目日期',
  `project_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '项目链接',
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `cases_case_uuid_unique`(`case_uuid` ASC) USING BTREE,
  UNIQUE INDEX `cases_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `cases_user_id_is_active_index`(`user_id` ASC, `is_active` ASC) USING BTREE,
  INDEX `cases_enterprise_id_is_active_index`(`enterprise_id` ASC, `is_active` ASC) USING BTREE,
  INDEX `cases_lang_key_is_active_index`(`lang_key` ASC, `is_active` ASC) USING BTREE,
  INDEX `cases_category_is_active_index`(`category` ASC, `is_active` ASC) USING BTREE,
  INDEX `cases_is_featured_published_at_index`(`is_featured` ASC, `published_at` ASC) USING BTREE,
  INDEX `cases_is_top_sort_order_index`(`is_top` ASC, `sort_order` ASC) USING BTREE,
  INDEX `cases_lang_key_index`(`lang_key` ASC) USING BTREE,
  INDEX `cases_is_active_index`(`is_active` ASC) USING BTREE,
  INDEX `cases_is_featured_index`(`is_featured` ASC) USING BTREE,
  FULLTEXT INDEX `ft_cases_title_content`(`title`, `content`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '案例管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_cases
-- ----------------------------

-- ----------------------------
-- Table structure for kp_conf
-- ----------------------------
DROP TABLE IF EXISTS `kp_conf`;
CREATE TABLE `kp_conf`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '配置自增主键ID',
  `config_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置全局唯一标识符',
  `key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置键名(唯一标识)',
  `name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置显示名称',
  `group` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'system' COMMENT '配置分组(system,contact,upload等)',
  `type` enum('text','textarea','number','boolean','select','radio','checkbox','json','image','file','datetime','color') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text' COMMENT '配置输入类型',
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '当前配置值',
  `default_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '配置默认值',
  `allowed_values` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '允许的选择值(JSON数组格式)',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '配置详细描述说明',
  `is_public` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否允许前端公开访问',
  `is_required` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否为必填配置项',
  `is_locked` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否锁定不允许修改',
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '显示排序权重',
  `validation_rules` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '数据验证规则',
  `metadata` json NULL COMMENT '配置额外元数据',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `conf_config_uuid_unique`(`config_uuid` ASC) USING BTREE,
  UNIQUE INDEX `conf_key_unique`(`key` ASC) USING BTREE,
  INDEX `idx_group_public`(`group` ASC, `is_public` ASC) USING BTREE,
  INDEX `idx_type_group`(`type` ASC, `group` ASC) USING BTREE,
  INDEX `idx_sort_group`(`sort_order` ASC, `group` ASC) USING BTREE,
  INDEX `idx_key`(`key` ASC) USING BTREE,
  INDEX `idx_sort_order`(`sort_order` ASC) USING BTREE,
  INDEX `idx_is_locked`(`is_locked` ASC) USING BTREE,
  INDEX `idx_group`(`group` ASC) USING BTREE,
  INDEX `idx_is_public`(`is_public` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统配置表 - 网站各项配置参数管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_conf
-- ----------------------------
INSERT INTO `kp_conf` VALUES (1, '96bde55c-0dbd-489e-b8d0-7c4bdf5bda58', 'SITE_NAME', '网站名称', 'system', 'text', 'KP企业服务网 - 专业企业解决方案提供商', 'Family企业服务网', NULL, '网站显示名称', 1, 1, 0, 1, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (2, 'e3b21d6d-1aae-422b-a4b3-7ea2180d0d70', 'SITE_TITLE', '网站标题', 'system', 'text', 'KP企业服务网 - 专业建站服务与多元化企业解决方案', 'Family企业服务网 - 专业企业服务解决方案', NULL, '浏览器标题栏显示的网站标题', 1, 1, 0, 2, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (3, 'd673e989-4a45-46cc-ac76-ae2b264bd4d3', 'SITE_DESCRIPTION', '网站描述', 'system', 'textarea', 'KP企业服务网致力于为企业提供专业的建站服务、营销推广、数字化转型等多元化解决方案。我们专注于企业成长需求，提供一站式企业服务支持，助力企业实现数字化升级和业务增长。', 'Family企业服务网致力于为企业提供专业的建站服务、营销推广、数字化转型等多元化解决方案。', NULL, '网站SEO描述信息', 1, 0, 0, 3, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (4, 'b2cf0791-58ab-467d-a358-5d9b7881b565', 'SITE_KEYWORDS', '网站关键词', 'system', 'text', '企业建站服务,企业解决方案,企业网站建设,企业数字化转型,企业营销推广,中小企业服务,企业咨询,企业管理系统,KP企业网', '企业建站,企业服务,网站建设,数字化转型', NULL, '网站SEO关键词，用逗号分隔', 1, 0, 0, 4, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (5, 'eeb8bfd1-addc-44ff-b64f-c981b3744543', 'SITE_URL', '网站域名', 'system', 'text', 'https://www.xxxxxx.com', 'https://www.family-example.com', NULL, '网站完整访问地址', 1, 1, 0, 5, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (6, 'f20c324d-5a0c-4468-9408-75d9fb35583b', 'SITE_LOGO', '网站Logo', 'system', 'image', '', '', NULL, '网站Logo图片地址', 1, 0, 0, 6, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (7, 'fdf15fe6-2227-4aa0-ac03-09954a964efb', 'SITE_FAVICON', '网站Favicon', 'system', 'image', '', '', NULL, '网站Favicon图标地址', 1, 0, 0, 7, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (8, 'de0043f7-0ca4-4ef3-b96c-d5ef6f056184', 'CONTACT_PHONE', '联系电话', 'contact', 'text', '+8613922078347', '+86-138-0000-0000', NULL, '客服联系电话', 1, 0, 0, 10, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (9, '17ec1e3e-f294-4a90-9e8b-17d202a11f38', 'CONTACT_EMAIL', '联系邮箱', 'contact', 'text', 'zccem@163.com', 'contact@family-example.com', NULL, '官方联系邮箱', 1, 0, 0, 11, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (10, 'ac8cc534-ea77-44c7-870b-0d76490bd032', 'CONTACT_ADDRESS', '公司地址', 'contact', 'text', '中国广东省湛江市霞山区观海长廊 - 解放西路22号', '北京市朝阳区某某大厦', NULL, '公司详细办公地址', 1, 0, 0, 12, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (11, 'c8f6627d-8b48-4418-b9a8-f282a46d592c', 'CONTACT_WECHAT', '官方微信', 'contact', 'text', '', '', NULL, '官方微信公众号', 1, 0, 0, 13, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (12, 'fc61e221-ef79-46b0-976f-7da817fbef41', 'CONTACT_QQ', '客服QQ', 'contact', 'text', '', '', NULL, '在线客服QQ号', 1, 0, 0, 14, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (13, '83ee748d-678f-4fd4-9863-2616d639634d', 'USER_LOGIN_ENABLED', '用户登录功能', 'system', 'boolean', '1', '1', NULL, '是否开启用户登录功能', 0, 1, 0, 20, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (14, '6d49dfc8-a42b-4e72-8228-b0477199e85e', 'USER_REGISTRATION_ENABLED', '用户注册功能', 'system', 'boolean', '1', '1', NULL, '是否开启用户自助注册', 0, 1, 0, 21, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (15, '13b5a161-4554-4418-9f99-8fa767679748', 'CAPTCHA_ENABLED', '验证码功能', 'system', 'boolean', '1', '1', NULL, '是否开启验证码保护', 0, 1, 0, 22, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (16, '438fe1a1-929c-4c8c-8e97-22a9228b34af', 'MAINTENANCE_MODE', '维护模式', 'system', 'boolean', '0', '0', NULL, '是否开启网站维护模式', 0, 1, 0, 23, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (17, '4dbfbf05-5490-4027-a032-1dfb571b841f', 'DEBUG_MODE', '调试模式', 'system', 'boolean', '1', 'false', NULL, '是否开启调试模式(生产环境请关闭)', 0, 1, 0, 24, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (18, 'bf55bb11-956e-4075-81eb-d7c9175bbecc', 'FILE_UPLOAD_TYPES', '允许文件类型', 'upload', 'text', 'zip,gz,rar,iso,doc,docx,xls,xlsx,ppt,pptx,wps,pdf', 'zip,gz,rar,iso,doc,docx,xls,xlsx,ppt,pptx,wps,pdf', NULL, '允许上传的文件类型(英文逗号分隔)', 0, 1, 0, 30, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (19, 'c8fbebe1-30c9-4241-bd1a-11adfe345e77', 'IMAGE_UPLOAD_TYPES', '允许图片类型', 'upload', 'text', 'jpg,jpeg,png,gif,webp,bmp', 'jpg,jpeg,png,gif,webp,bmp', NULL, '允许上传的图片类型(英文逗号分隔)', 0, 1, 0, 31, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (20, '2c7f4ff6-f860-4904-ad26-848facb1ae62', 'MAX_FILE_SIZE', '最大文件大小', 'upload', 'number', '10485760', '10485760', NULL, '单个文件最大上传大小(字节)', 0, 1, 0, 32, NULL, NULL, '2026-02-21 16:33:45', '2026-02-21 16:33:45');
INSERT INTO `kp_conf` VALUES (21, '33d11894-e655-4059-9600-2e5959770b5c', 'MAX_IMAGE_SIZE', '最大图片大小', 'upload', 'number', '5242880', '5242880', NULL, '单张图片最大上传大小(字节)', 0, 1, 0, 33, NULL, NULL, '2026-02-21 16:33:46', '2026-02-21 16:33:46');
INSERT INTO `kp_conf` VALUES (22, 'fac9ea39-d3d3-4267-b2fc-06c6892a4441', 'UPLOAD_PATH', '上传路径', 'upload', 'text', 'uploads', 'uploads', NULL, '文件上传存储相对路径', 0, 1, 0, 34, NULL, NULL, '2026-02-21 16:33:46', '2026-02-21 16:33:46');
INSERT INTO `kp_conf` VALUES (23, '3209df50-ef31-4aa3-9c30-3c062feb6f05', 'SEO_ROBOTS', 'Robots协议', 'seo', 'textarea', 'User-agent: *\nDisallow: /admin/\nDisallow: /storage/\nAllow: /', 'User-agent: *\nDisallow: /admin/\nDisallow: /storage/\nAllow: /', NULL, 'robots.txt内容配置', 0, 0, 0, 40, NULL, NULL, '2026-02-21 16:33:46', '2026-02-21 16:33:46');
INSERT INTO `kp_conf` VALUES (24, 'b4578cff-88c9-4727-b383-931dbe9dccae', 'ANALYTICS_CODE', '统计代码', 'seo', 'textarea', '', '', NULL, '网站统计分析代码(Google Analytics等)', 0, 0, 0, 41, NULL, NULL, '2026-02-21 16:33:46', '2026-02-21 16:33:46');

-- ----------------------------
-- Table structure for kp_enterprise
-- ----------------------------
DROP TABLE IF EXISTS `kp_enterprise`;
CREATE TABLE `kp_enterprise`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `enterprise_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang_key` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh_CN',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '企业介绍',
  `purpose` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '企业宗旨',
  `develop` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '企业发展',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '企业简介',
  `logo` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '企业logo',
  `images` json NULL COMMENT '企业图片',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `website` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `metadata` json NULL COMMENT '扩展元数据',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `view_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `enterprise_enterprise_uuid_unique`(`enterprise_uuid` ASC) USING BTREE,
  UNIQUE INDEX `enterprise_title_unique`(`title` ASC) USING BTREE,
  UNIQUE INDEX `enterprise_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `enterprise_lang_key_is_active_index`(`lang_key` ASC, `is_active` ASC) USING BTREE,
  INDEX `enterprise_is_featured_sort_order_index`(`is_featured` ASC, `sort_order` ASC) USING BTREE,
  INDEX `enterprise_title_index`(`title` ASC) USING BTREE,
  INDEX `enterprise_lang_key_index`(`lang_key` ASC) USING BTREE,
  INDEX `enterprise_is_active_index`(`is_active` ASC) USING BTREE,
  FULLTEXT INDEX `ft_enterprise_title_content`(`title`, `content`),
  FULLTEXT INDEX `ft_enterprise_description`(`description`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '企业信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_enterprise
-- ----------------------------

-- ----------------------------
-- Table structure for kp_hire
-- ----------------------------
DROP TABLE IF EXISTS `kp_hire`;
CREATE TABLE `kp_hire`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `hire_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `enterprise_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `lang_key` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh_CN',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '职位详细描述',
  `introduction` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '职位简介',
  `position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '职位名称',
  `department` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '所属部门',
  `salary_range` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '薪资范围',
  `employment_type` enum('full_time','part_time','contract','internship') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'full_time' COMMENT '雇佣类型',
  `requirements` json NULL COMMENT '职位要求',
  `benefits` json NULL COMMENT '职位福利',
  `thumbnail` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '缩略图',
  `images` json NULL COMMENT '相关图片',
  `meta_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `meta_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `meta_keywords` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `view_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '浏览次数',
  `application_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '申请次数',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_urgent` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否紧急招聘',
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `deadline` date NULL DEFAULT NULL COMMENT '申请截止日期',
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `hire_hire_uuid_unique`(`hire_uuid` ASC) USING BTREE,
  UNIQUE INDEX `hire_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `hire_user_id_is_active_index`(`user_id` ASC, `is_active` ASC) USING BTREE,
  INDEX `hire_enterprise_id_is_active_index`(`enterprise_id` ASC, `is_active` ASC) USING BTREE,
  INDEX `hire_lang_key_is_active_index`(`lang_key` ASC, `is_active` ASC) USING BTREE,
  INDEX `hire_position_department_index`(`position` ASC, `department` ASC) USING BTREE,
  INDEX `hire_is_featured_published_at_index`(`is_featured` ASC, `published_at` ASC) USING BTREE,
  INDEX `hire_employment_type_is_active_index`(`employment_type` ASC, `is_active` ASC) USING BTREE,
  INDEX `hire_lang_key_index`(`lang_key` ASC) USING BTREE,
  INDEX `hire_is_active_index`(`is_active` ASC) USING BTREE,
  FULLTEXT INDEX `ft_hire_title_content`(`title`, `content`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '企业招聘表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_hire
-- ----------------------------

-- ----------------------------
-- Table structure for kp_history
-- ----------------------------
DROP TABLE IF EXISTS `kp_history`;
CREATE TABLE `kp_history`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `resource_id` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `movie_id` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `viewing_time` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `is_using` smallint(5) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态，0禁用，1启用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `history_resource_id_unique`(`resource_id` ASC) USING BTREE,
  INDEX `history_resource_id_user_id_index`(`resource_id` ASC, `user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '历史记录表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_history
-- ----------------------------

-- ----------------------------
-- Table structure for kp_jobs
-- ----------------------------
DROP TABLE IF EXISTS `kp_jobs`;
CREATE TABLE `kp_jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED NULL DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for kp_member_oauth
-- ----------------------------
DROP TABLE IF EXISTS `kp_member_oauth`;
CREATE TABLE `kp_member_oauth`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `member_user_id` bigint(20) UNSIGNED NOT NULL COMMENT '用户ID',
  `type` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '类型',
  `open_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'OpenId',
  `info_nick` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '昵称',
  `info_avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '头像',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_member_oauth
-- ----------------------------

-- ----------------------------
-- Table structure for kp_menu
-- ----------------------------
DROP TABLE IF EXISTS `kp_menu`;
CREATE TABLE `kp_menu`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `menu_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单唯一标识',
  `parent_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `lang_key` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh_CN' COMMENT '语言标识',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '菜单标题',
  `urls` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '地址',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '菜单图标',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '菜单描述',
  `order_column` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  `is_visible` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否显示',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `menu_menu_uuid_unique`(`menu_uuid` ASC) USING BTREE,
  INDEX `idx_parent_order`(`parent_id` ASC, `order_column` ASC) USING BTREE,
  INDEX `idx_lang_active`(`lang_key` ASC, `is_active` ASC) USING BTREE,
  INDEX `idx_visible_order`(`is_visible` ASC, `order_column` ASC) USING BTREE,
  INDEX `menu_lang_key_index`(`lang_key` ASC) USING BTREE,
  INDEX `menu_is_active_index`(`is_active` ASC) USING BTREE,
  INDEX `menu_is_visible_index`(`is_visible` ASC) USING BTREE,
  FULLTEXT INDEX `ft_menu_title_desc`(`title`, `description`),
  CONSTRAINT `menu_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `kp_menu` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 62 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '菜单表 - 系统导航菜单管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_menu
-- ----------------------------
INSERT INTO `kp_menu` VALUES (26, 'c3abf9e5-0211-4498-9b2d-57cff6c52429', NULL, 'zh_CN', '首页', 'center', NULL, NULL, 1, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (27, '1704c475-a1a6-4e65-b1fb-755047fe653d', NULL, 'zh_CN', '企业产品', 'product', NULL, NULL, 2, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (28, '4e8e29b4-b8f3-47b6-985b-c92f11796c91', NULL, 'zh_CN', '企业文章', 'post', NULL, NULL, 3, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (29, 'f26d7d9e-c2ca-4f77-8685-0248dea50366', NULL, 'zh_CN', '企业招聘', 'hire', NULL, NULL, 4, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (30, '6bef13fa-c43c-45e1-ba0c-21c9214e491e', NULL, 'zh_CN', '企业案例', 'cases', NULL, NULL, 5, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (31, 'c153aff2-ac00-4e3d-b2f7-bdc835b4ce96', NULL, 'zh_CN', '企业门店', 'store', NULL, NULL, 6, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (32, '97736e7e-a00e-4651-a788-63868fefc23f', NULL, 'zh_CN', '企业活动', 'activity', NULL, NULL, 7, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (33, '85cd2317-9f82-4f34-9257-74f4405c856f', NULL, 'zh_CN', '企业公告', 'announce', NULL, NULL, 8, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (35, '34abbd4d-0260-43c4-b4dd-926655bd9ae7', NULL, 'zh_TW', '首页', 'center', NULL, NULL, 1, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (36, '485361c3-792c-4924-bd7e-985c568a3361', NULL, 'zh_TW', '企業產品', 'product', NULL, NULL, 2, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (37, 'c40f1185-f74c-4845-a422-e3a200bd811c', NULL, 'zh_TW', '企業文章', 'post', NULL, NULL, 3, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (38, 'ddc0295b-4826-4ae2-bc11-0391d02f47c3', NULL, 'zh_TW', '企業招聘', 'hire', NULL, NULL, 4, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (39, '359c3fb3-edeb-414a-b23f-8cc1403eedab', NULL, 'zh_TW', '企業案例', 'cases', NULL, NULL, 5, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (40, 'eaa54e41-3cd5-4e6b-80fd-65cdc69ec756', NULL, 'zh_TW', '企業公告', 'announce', NULL, NULL, 6, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (41, '5c671413-cf6a-4f77-82eb-6d21b90e2acb', NULL, 'zh_TW', '企業活动', 'activity', NULL, NULL, 7, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (42, '3b91f1fb-a6aa-48a0-93a1-3ae0ab9619d6', NULL, 'zh_TW', '企業門店', 'store', NULL, NULL, 8, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (44, '059bc5a8-d1de-4a47-a30e-0ff2a4753842', NULL, 'en', 'Home', 'center', NULL, NULL, 1, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (45, 'a8206a3d-e140-4f6d-859c-917e7995ea1c', NULL, 'en', 'Product', 'product', NULL, NULL, 2, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (46, 'f973dfaa-4271-46e5-8e16-cc623ce2c101', NULL, 'en', 'Post', 'post', NULL, NULL, 3, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (47, '6cf5c29b-16fc-4b25-b1bb-76b1c16b8d21', NULL, 'en', 'Jobs', 'hire', NULL, NULL, 4, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (48, 'f8b196c4-bda7-483c-ac97-3541623d338f', NULL, 'en', 'Case', 'cases', NULL, NULL, 5, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (49, '82ca1bdf-bb85-4ab0-b928-b41157643f10', NULL, 'en', 'About', 'about', NULL, NULL, 6, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (50, '27746252-d641-4fd5-895b-383b0fbf7e90', NULL, 'en', 'Store', 'store', NULL, NULL, 7, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (51, '06730317-5873-47bf-abfe-1651739dc318', NULL, 'en', 'Activity', 'activity', NULL, NULL, 8, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (53, '1804a4e5-3334-4a68-a2c7-d183a6f84d07', NULL, 'es', 'Casa', 'center', NULL, NULL, 1, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (54, 'a0875fa7-6e34-4054-b126-d045791a987c', NULL, 'es', 'Productos', 'product', NULL, NULL, 2, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (55, '9795d398-c797-49bb-bcac-6a4d602a5d33', NULL, 'es', 'Correo', 'post', NULL, NULL, 3, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (56, 'c1f217c2-9552-4300-bd7f-fc1b85175ea3', NULL, 'es', 'Trabajo', 'hire', NULL, NULL, 4, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (57, 'c6c7ca78-97f0-48c6-b045-7151ed3f8e18', NULL, 'es', 'Contacto', 'about', NULL, NULL, 5, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (58, 'f9f7e738-e04f-4a92-9b5e-38d1a11a2b4d', NULL, 'es', 'Tienda', 'store', NULL, NULL, 6, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (59, 'db2f54e8-2d40-434d-bfc2-7f5a7d4ebe0f', NULL, 'es', 'Actividad', 'activity', NULL, NULL, 7, 1, 1, NULL, NULL);
INSERT INTO `kp_menu` VALUES (60, '025262ca-8a28-4b29-8158-bd3a60f1e145', NULL, 'es', 'Anuncio', 'announce', NULL, NULL, 8, 1, 1, NULL, NULL);

-- ----------------------------
-- Table structure for kp_orders
-- ----------------------------
DROP TABLE IF EXISTS `kp_orders`;
CREATE TABLE `kp_orders`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '订单自增主键ID',
  `order_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '订单全局唯一标识符',
  `order_number` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '订单编号(业务主键)',
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `payment_method_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `items` json NOT NULL COMMENT '订单商品详情(JSON格式)',
  `subtotal` decimal(12, 2) NOT NULL DEFAULT 0.00 COMMENT '商品总价小计',
  `shipping_fee` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '配送费用',
  `tax_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '税费金额',
  `discount_amount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '优惠抵扣金额',
  `total_amount` decimal(12, 2) NOT NULL COMMENT '订单应付总金额',
  `recipient_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收货人姓名',
  `recipient_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收货人联系电话',
  `recipient_address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '详细收货地址',
  `recipient_province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货省份',
  `recipient_city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货城市',
  `recipient_district` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '收货区县',
  `recipient_zipcode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '邮政编码',
  `shipping_company` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '物流公司名称',
  `tracking_number` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '快递运单号码',
  `estimated_delivery_at` timestamp NULL DEFAULT NULL COMMENT '预计送达时间',
  `delivered_at` timestamp NULL DEFAULT NULL COMMENT '实际送达时间',
  `status` enum('pending','paid','processing','shipped','delivered','completed','cancelled','refunded') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending' COMMENT '订单状态',
  `payment_status` enum('unpaid','paid','partial_paid','refunding','refunded') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'unpaid' COMMENT '支付状态',
  `shipping_status` enum('pending','shipped','in_transit','delivered','returned') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending' COMMENT '配送状态',
  `paid_at` timestamp NULL DEFAULT NULL COMMENT '订单支付完成时间',
  `processed_at` timestamp NULL DEFAULT NULL COMMENT '订单开始处理时间',
  `shipped_at` timestamp NULL DEFAULT NULL COMMENT '订单发货时间',
  `completed_at` timestamp NULL DEFAULT NULL COMMENT '订单完成时间',
  `cancelled_at` timestamp NULL DEFAULT NULL COMMENT '订单取消时间',
  `customer_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '客户下单备注',
  `admin_note` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '管理员操作备注',
  `metadata` json NULL COMMENT '订单额外元数据',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '软删除时间戳',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `orders_order_uuid_unique`(`order_uuid` ASC) USING BTREE,
  UNIQUE INDEX `orders_order_number_unique`(`order_number` ASC) USING BTREE,
  INDEX `orders_payment_method_id_foreign`(`payment_method_id` ASC) USING BTREE,
  INDEX `idx_user_status`(`user_id` ASC, `status` ASC) USING BTREE,
  INDEX `idx_status_created`(`status` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_payment_created`(`payment_status` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_shipping_created`(`shipping_status` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_order_number`(`order_number` ASC) USING BTREE,
  INDEX `idx_payment_status`(`payment_status` ASC) USING BTREE,
  INDEX `idx_shipping_status`(`shipping_status` ASC) USING BTREE,
  INDEX `idx_created_at`(`created_at` ASC) USING BTREE,
  INDEX `idx_paid_at`(`paid_at` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '订单主表 - 存储所有订单核心信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_orders
-- ----------------------------

-- ----------------------------
-- Table structure for kp_pay_ali_config
-- ----------------------------
DROP TABLE IF EXISTS `kp_pay_ali_config`;
CREATE TABLE `kp_pay_ali_config`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `config_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置UUID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置名称',
  `app_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付宝app_id',
  `app_secret_cert` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用私钥',
  `app_public_cert_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '应用公钥证书路径',
  `alipay_public_cert_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付宝公钥证书路径',
  `alipay_root_cert_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付宝根证书路径',
  `return_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '同步回调URL',
  `notify_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异步回调URL',
  `app_auth_token` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '第三方应用授权token',
  `service_provider_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '服务商ID',
  `mode` enum('MODE_NORMAL','MODE_SANDBOX','MODE_SERVICE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MODE_NORMAL' COMMENT '运行模式',
  `environment` enum('sandbox','production') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'production' COMMENT '运行环境',
  `is_active` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否启用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `pay_ali_config_config_uuid_unique`(`config_uuid` ASC) USING BTREE,
  UNIQUE INDEX `pay_ali_config_app_id_unique`(`app_id` ASC) USING BTREE,
  INDEX `idx_app_id`(`app_id` ASC) USING BTREE,
  INDEX `idx_is_active`(`is_active` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '支付宝支付配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_pay_ali_config
-- ----------------------------

-- ----------------------------
-- Table structure for kp_pay_bank_config
-- ----------------------------
DROP TABLE IF EXISTS `kp_pay_bank_config`;
CREATE TABLE `kp_pay_bank_config`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `config_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置UUID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置名称',
  `mch_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户号',
  `mch_secret_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '商户密钥',
  `mch_cert_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户公私钥路径',
  `mch_cert_password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户公私钥密码',
  `unipay_public_cert_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '银联公钥证书路径',
  `return_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '同步回调URL',
  `notify_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '异步回调URL',
  `mode` enum('MODE_NORMAL','MODE_SERVICE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MODE_NORMAL' COMMENT '运行模式',
  `environment` enum('sandbox','production') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'production' COMMENT '运行环境',
  `is_active` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否启用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `pay_bank_config_config_uuid_unique`(`config_uuid` ASC) USING BTREE,
  INDEX `idx_mch_id`(`mch_id` ASC) USING BTREE,
  INDEX `idx_is_active`(`is_active` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '银联支付配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_pay_bank_config
-- ----------------------------

-- ----------------------------
-- Table structure for kp_pay_wx_config
-- ----------------------------
DROP TABLE IF EXISTS `kp_pay_wx_config`;
CREATE TABLE `kp_pay_wx_config`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `config_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置UUID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '配置名称',
  `mch_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户号',
  `mch_secret_key_v2` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT 'v2商户私钥',
  `mch_secret_key` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'v3商户秘钥',
  `mch_secret_cert` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户私钥证书',
  `mch_public_cert_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '商户公钥证书路径',
  `notify_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '微信回调URL',
  `mp_app_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '公众号app_id',
  `mini_app_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '小程序app_id',
  `app_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'APP的app_id',
  `sub_mp_app_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '子公众号app_id',
  `sub_app_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '子APP的app_id',
  `sub_mini_app_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '子小程序app_id',
  `sub_mch_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '子商户ID',
  `wechat_public_cert_path` json NULL COMMENT '微信平台公钥证书路径',
  `mode` enum('MODE_NORMAL','MODE_SERVICE') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'MODE_NORMAL' COMMENT '运行模式',
  `environment` enum('sandbox','production') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'production' COMMENT '运行环境',
  `is_active` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否启用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `pay_wx_config_config_uuid_unique`(`config_uuid` ASC) USING BTREE,
  INDEX `idx_mch_id`(`mch_id` ASC) USING BTREE,
  INDEX `idx_is_active`(`is_active` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '微信支付配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_pay_wx_config
-- ----------------------------

-- ----------------------------
-- Table structure for kp_payment_methods
-- ----------------------------
DROP TABLE IF EXISTS `kp_payment_methods`;
CREATE TABLE `kp_payment_methods`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `method_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付方式UUID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付方式名称',
  `code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付方式代码',
  `payment_type` enum('alipay','wechat','bank','cash','transfer','other') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '支付类型',
  `template` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '对应的模板文件',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '支付方式描述',
  `config` json NULL COMMENT '支付配置信息',
  `icon` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '支付图标',
  `images` json NULL COMMENT '支付二维码等图片',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序顺序',
  `fee_rate` decimal(5, 4) NOT NULL DEFAULT 0.0000 COMMENT '手续费率',
  `fee_fixed` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '固定手续费',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `payment_methods_method_uuid_unique`(`method_uuid` ASC) USING BTREE,
  UNIQUE INDEX `payment_methods_code_unique`(`code` ASC) USING BTREE,
  INDEX `idx_code`(`code` ASC) USING BTREE,
  INDEX `idx_payment_type`(`payment_type` ASC) USING BTREE,
  INDEX `idx_active_sort`(`is_active` ASC, `sort_order` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '支付方式表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_payment_methods
-- ----------------------------

-- ----------------------------
-- Table structure for kp_personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `kp_personal_access_tokens`;
CREATE TABLE `kp_personal_access_tokens`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `personal_access_tokens_token_unique`(`token` ASC) USING BTREE,
  INDEX `personal_access_tokens_tokenable_type_tokenable_id_index`(`tokenable_type` ASC, `tokenable_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_personal_access_tokens
-- ----------------------------
INSERT INTO `kp_personal_access_tokens` VALUES (1, 'App\\Models\\Users', 1, '2a658946-c7e5-4db0-8d8c-b8fdf61bc068', 'e39e74eebaa819dd2c17456e3ba4522e18e2d446e5a97a71426f63cbb23c1ad7', '[\"*\"]', NULL, NULL, '2026-03-09 19:14:41', '2026-03-09 19:14:41');
INSERT INTO `kp_personal_access_tokens` VALUES (2, 'App\\Models\\Users', 1, '2a658946-c7e5-4db0-8d8c-b8fdf61bc068', '68d453d30edc410c112493902fed08f882599a782483213412b1dac68036dcab', '[\"*\"]', NULL, NULL, '2026-03-09 19:26:07', '2026-03-09 19:26:07');

-- ----------------------------
-- Table structure for kp_post_categories
-- ----------------------------
DROP TABLE IF EXISTS `kp_post_categories`;
CREATE TABLE `kp_post_categories`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `lang_key` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh_CN',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `order_column` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `post_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '帖子数量',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `meta_data` json NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `post_categories_category_uuid_unique`(`category_uuid` ASC) USING BTREE,
  UNIQUE INDEX `post_categories_title_unique`(`title` ASC) USING BTREE,
  UNIQUE INDEX `post_categories_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `idx_parent_active`(`parent_id` ASC, `is_active` ASC) USING BTREE,
  INDEX `idx_lang_active`(`lang_key` ASC, `is_active` ASC) USING BTREE,
  INDEX `post_categories_order_column_index`(`order_column` ASC) USING BTREE,
  INDEX `idx_slug_active`(`slug` ASC, `is_active` ASC) USING BTREE,
  INDEX `post_categories_lang_key_index`(`lang_key` ASC) USING BTREE,
  INDEX `post_categories_is_active_index`(`is_active` ASC) USING BTREE,
  FULLTEXT INDEX `ft_post_categories_title_content`(`title`, `content`),
  CONSTRAINT `post_categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `kp_post_categories` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_post_categories
-- ----------------------------
INSERT INTO `kp_post_categories` VALUES (1, 'ba9785d1-87ef-449e-9f57-7dc9a8430bd1', NULL, 'zh_CN', '国内新闻', 'guo-nei-xin-wen', NULL, 1, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (2, '98d44676-6442-4642-8176-b485111a05fc', NULL, 'zh_CN', '国际新闻', 'guo-ji-xin-wen', NULL, 2, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (3, '64de2b84-afbb-430c-aaa5-49a8557de712', NULL, 'zh_CN', '足球', 'zu-qiu', NULL, 3, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (4, '7214bcaa-02b4-4269-8da4-87b7f4af83f4', NULL, 'zh_CN', '篮球', 'lan-qiu', NULL, 4, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (5, '1faf6802-ce8e-4e01-8fc2-5c2d888c9322', NULL, 'zh_CN', '历史', 'li-shi', NULL, 5, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (6, '367f9247-e349-4d31-bc70-7e67bd4491c5', NULL, 'zh_CN', '军事', 'jun-shi', NULL, 6, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (7, 'c73f731f-ac2f-444f-ba31-a5ec401c6b42', NULL, 'zh_CN', '社会新闻', 'she-hui-xin-wen', NULL, 7, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (8, '44f0c05e-7595-4c48-aeef-668bbae5c109', NULL, 'zh_CN', '音乐', 'yin-yue', NULL, 8, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (9, 'be30f087-ff64-4398-aeb8-00f85427b341', NULL, 'zh_CN', '娱乐', 'yu-le', NULL, 9, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (10, 'dde0b2a9-f4d1-4dc6-a23f-5ae1b3ec0f1c', NULL, 'zh_CN', '科技', 'ke-ji', NULL, 10, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (11, 'aebe7db9-4a92-4f7d-ad7c-84cefafbd607', NULL, 'zh_CN', '教育', 'jiao-yu', NULL, 11, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (12, '4a247e2d-9d8e-443f-a808-b808fd9c9fb1', NULL, 'zh_CN', '健康', 'jian-kang', NULL, 12, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (13, '186d75cf-9260-45f9-9f90-71928ad178f3', NULL, 'zh_CN', '财经', 'cai-jing', NULL, 13, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (14, '4986fa0f-33be-49e8-8c8b-d2d95832bf42', NULL, 'zh_CN', '体育', 'ti-yu', NULL, 14, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (15, '9284dec9-e117-4d7a-aec3-35d608587c33', NULL, 'zh_CN', '汽车', 'qi-che', NULL, 15, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (16, '8df17e1b-5a4f-409c-a356-a684e0e79fdb', NULL, 'zh_CN', '旅游', 'lyu-you', NULL, 16, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (17, 'ceca798a-14f3-4206-a6b7-71d13d25460b', NULL, 'zh_CN', '美食', 'mei-shi', NULL, 17, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (18, '0ba1fe2d-0f54-40ed-92f3-f7964ec38e8a', NULL, 'zh_CN', '时尚', 'shi-shang', NULL, 18, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (19, '35db5549-d1c1-4086-9ae8-f1058bdc7680', NULL, 'zh_CN', '艺术', 'yi-shu', NULL, 19, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_post_categories` VALUES (20, '0f972540-393b-43b3-a27d-57fe38557579', NULL, 'zh_CN', '游戏', 'you-xi', NULL, 20, 0, 1, NULL, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);

-- ----------------------------
-- Table structure for kp_post_comments
-- ----------------------------
DROP TABLE IF EXISTS `kp_post_comments`;
CREATE TABLE `kp_post_comments`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论自增主键ID',
  `comment_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论UUID唯一标识',
  `post_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `parent_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `like_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `is_approved` tinyint(1) NOT NULL DEFAULT 1 COMMENT '审核状态',
  `is_pinned` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶',
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论者IP地址',
  `user_agent` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户代理信息',
  `original_id` int(11) NULL DEFAULT NULL COMMENT '原始评论ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '软删除时间戳',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `post_comments_comment_id_unique`(`comment_id` ASC) USING BTREE,
  INDEX `idx_post_approved`(`post_id` ASC, `is_approved` ASC) USING BTREE,
  INDEX `idx_user_created`(`user_id` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_parent_created`(`parent_id` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_created`(`created_at` ASC) USING BTREE,
  FULLTEXT INDEX `ft_comments_content`(`content`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '文章评论表 - 存储所有文章评论信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_post_comments
-- ----------------------------

-- ----------------------------
-- Table structure for kp_post_tags
-- ----------------------------
DROP TABLE IF EXISTS `kp_post_tags`;
CREATE TABLE `kp_post_tags`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `usage_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `color` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#007bff',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `lang_key` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh_CN',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `meta_data` json NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `post_tags_tag_uuid_unique`(`tag_uuid` ASC) USING BTREE,
  UNIQUE INDEX `post_tags_name_unique`(`name` ASC) USING BTREE,
  UNIQUE INDEX `post_tags_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `idx_slug_active`(`slug` ASC, `is_active` ASC) USING BTREE,
  INDEX `idx_usage_active`(`usage_count` ASC, `is_active` ASC) USING BTREE,
  INDEX `idx_active_created`(`is_active` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_lang_active`(`lang_key` ASC, `is_active` ASC) USING BTREE,
  INDEX `post_tags_sort_order_index`(`sort_order` ASC) USING BTREE,
  INDEX `post_tags_lang_key_index`(`lang_key` ASC) USING BTREE,
  INDEX `post_tags_is_active_index`(`is_active` ASC) USING BTREE,
  FULLTEXT INDEX `ft_post_tags_name_description`(`name`, `description`)
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_post_tags
-- ----------------------------
INSERT INTO `kp_post_tags` VALUES (1, '69b15b3a-8fd1-42cf-a3c7-8e9edce323f7', '普信男', 'pu-xin-nan', NULL, 0, 0, '#007bff', NULL, 'zh_CN', 1, NULL, NULL, NULL, NULL);
INSERT INTO `kp_post_tags` VALUES (2, '84f7188b-d4ba-423b-9e7c-c27454f1443e', '广东人标配', 'guang-dong-ren-biao-pei', NULL, 0, 0, '#007bff', NULL, 'zh_CN', 1, NULL, NULL, NULL, NULL);
INSERT INTO `kp_post_tags` VALUES (3, '6a88e26a-f44c-483e-b2ef-5b6f2c37f6ad', '绝绝子', 'jue-jue-zi', NULL, 0, 0, '#007bff', NULL, 'zh_CN', 1, NULL, NULL, NULL, NULL);
INSERT INTO `kp_post_tags` VALUES (4, '7f47ccae-85c1-4e05-be5a-ba2038441b69', '干饭人', 'gan-fan-ren', NULL, 0, 0, '#007bff', NULL, 'zh_CN', 1, NULL, NULL, NULL, NULL);
INSERT INTO `kp_post_tags` VALUES (5, 'b4a69450-2ee6-4f68-b71f-14b5fc4641d1', '凡尔赛', 'fan-er-sai', NULL, 0, 0, '#007bff', NULL, 'zh_CN', 1, NULL, NULL, NULL, NULL);
INSERT INTO `kp_post_tags` VALUES (6, '8a7dcdc4-9a61-4173-9d90-44ac2eb6b9be', '爷青回', 'ye-qing-hui', NULL, 0, 0, '#007bff', NULL, 'zh_CN', 1, NULL, NULL, NULL, NULL);
INSERT INTO `kp_post_tags` VALUES (7, '9361bf49-d610-423e-aec4-45f277dfd0d7', '芭比Q', 'ba-bi-Q', NULL, 0, 0, '#007bff', NULL, 'zh_CN', 1, NULL, NULL, NULL, NULL);
INSERT INTO `kp_post_tags` VALUES (8, '10266e4b-82c7-4d83-8235-4eb960aaa78d', '野性消费', 'ye-xing-xiao-fei', NULL, 0, 0, '#007bff', NULL, 'zh_CN', 1, NULL, NULL, NULL, NULL);
INSERT INTO `kp_post_tags` VALUES (9, '84d0ad2d-5e84-4a26-9b45-6f85ad073787', '杀伤力不大，侮辱性极强', 'sha-shang-li-bu-da-wu-ru-xing-ji-qiang', NULL, 0, 0, '#007bff', NULL, 'zh_CN', 1, NULL, NULL, NULL, NULL);
INSERT INTO `kp_post_tags` VALUES (10, '69b5017d-a70e-4b50-9007-120f45eec1bc', '一起苗苗苗苗苗', 'yi-qi-miao-miao-miao-miao-miao', NULL, 0, 0, '#007bff', NULL, 'zh_CN', 1, NULL, NULL, NULL, NULL);
INSERT INTO `kp_post_tags` VALUES (11, 'ab6c6547-da76-4493-995c-be99124eab76', '更新后的测试标签', 'updated-test-tag', '这是更新后的测试标签简介', 5, 0, '#00ff00', 'updated-test-icon', 'zh_CN', 0, NULL, '2026-02-22 00:04:32', '2026-02-22 00:04:32', '2026-02-22 00:04:32');
INSERT INTO `kp_post_tags` VALUES (12, 'ea03b9d2-a555-43f3-b3bc-97d84d807203', '排序测试标签1', 'sort-test-tag1', NULL, 10, 0, '#007bff', NULL, 'zh_CN', 1, NULL, '2026-02-22 00:04:32', '2026-02-22 00:04:32', '2026-02-22 00:04:32');
INSERT INTO `kp_post_tags` VALUES (13, '6079ca54-fe5b-4fb8-865e-f89c0f44c0e4', '排序测试标签2', 'sort-test-tag2', NULL, 20, 0, '#007bff', NULL, 'zh_CN', 1, NULL, '2026-02-22 00:04:32', '2026-02-22 00:04:32', '2026-02-22 00:04:32');
INSERT INTO `kp_post_tags` VALUES (14, '1461949f-854c-40bf-98da-a7745be2933d', '排序测试标签3', 'sort-test-tag3', NULL, 30, 0, '#007bff', NULL, 'zh_CN', 1, NULL, '2026-02-22 00:04:32', '2026-02-22 00:04:32', '2026-02-22 00:04:32');
INSERT INTO `kp_post_tags` VALUES (15, '838441fe-7a5d-4ebd-abad-09ecb287cd05', 'Test Tag', 'test-tag-en', 'This is an English test tag', 0, 0, '#007bff', NULL, 'en', 1, NULL, '2026-02-22 00:04:32', '2026-02-22 00:04:32', '2026-02-22 00:04:32');

-- ----------------------------
-- Table structure for kp_posts
-- ----------------------------
DROP TABLE IF EXISTS `kp_posts`;
CREATE TABLE `kp_posts`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `post_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `author_id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `lang_key` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh_CN',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `thumbnail` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tag_ids` json NULL,
  `images` json NULL,
  `meta_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `meta_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `meta_keywords` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `view_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `like_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `comment_count` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `status` enum('draft','published','archived') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `is_active` tinyint(1) NOT NULL DEFAULT 0,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `is_pinned` tinyint(1) NOT NULL DEFAULT 0,
  `allow_comments` tinyint(1) NOT NULL DEFAULT 1,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `published_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `posts_post_uuid_unique`(`post_uuid` ASC) USING BTREE,
  UNIQUE INDEX `posts_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `idx_category_status`(`category_id` ASC, `status` ASC) USING BTREE,
  INDEX `idx_status_published`(`status` ASC, `published_at` ASC) USING BTREE,
  INDEX `idx_author_status`(`author_id` ASC, `status` ASC) USING BTREE,
  INDEX `idx_featured_created`(`is_featured` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_lang_status`(`lang_key` ASC, `status` ASC) USING BTREE,
  INDEX `idx_view_status`(`view_count` ASC, `status` ASC) USING BTREE,
  INDEX `idx_comment_status`(`comment_count` ASC, `status` ASC) USING BTREE,
  INDEX `idx_like_status`(`like_count` ASC, `status` ASC) USING BTREE,
  INDEX `idx_pinned_created`(`is_pinned` ASC, `created_at` ASC) USING BTREE,
  INDEX `posts_lang_key_index`(`lang_key` ASC) USING BTREE,
  INDEX `posts_status_index`(`status` ASC) USING BTREE,
  INDEX `posts_is_active_index`(`is_active` ASC) USING BTREE,
  INDEX `posts_is_featured_index`(`is_featured` ASC) USING BTREE,
  FULLTEXT INDEX `ft_title_content`(`title`, `content`),
  FULLTEXT INDEX `ft_excerpt`(`excerpt`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '帖子表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_posts
-- ----------------------------

-- ----------------------------
-- Table structure for kp_product_categories
-- ----------------------------
DROP TABLE IF EXISTS `kp_product_categories`;
CREATE TABLE `kp_product_categories`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `lang_key` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh_CN',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `order_column` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `product_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '产品数量',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `product_categories_category_uuid_unique`(`category_uuid` ASC) USING BTREE,
  UNIQUE INDEX `product_categories_title_unique`(`title` ASC) USING BTREE,
  UNIQUE INDEX `product_categories_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `idx_parent_active`(`parent_id` ASC, `is_active` ASC) USING BTREE,
  INDEX `idx_lang_active`(`lang_key` ASC, `is_active` ASC) USING BTREE,
  INDEX `product_categories_order_column_index`(`order_column` ASC) USING BTREE,
  INDEX `product_categories_lang_key_index`(`lang_key` ASC) USING BTREE,
  INDEX `product_categories_is_active_index`(`is_active` ASC) USING BTREE,
  FULLTEXT INDEX `ft_product_categories_title_content`(`title`, `content`),
  CONSTRAINT `product_categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `kp_product_categories` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '产品分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_product_categories
-- ----------------------------
INSERT INTO `kp_product_categories` VALUES (1, 'd511d67b-9a78-4bbe-afaa-d41d7f51a0d0', NULL, 'zh_CN', '男装女装', 'nan-zhuang-nyu-zhuang', NULL, 1, 0, 1, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_product_categories` VALUES (2, '741cd4a1-00c5-4a8c-b807-5ef644503803', NULL, 'zh_CN', '3C数码', '3C-shu-ma', NULL, 2, 0, 1, '2026-02-21 17:16:31', '2026-02-21 17:16:31', NULL);
INSERT INTO `kp_product_categories` VALUES (3, '7d88f6b7-123d-454d-98b6-73e1b1e53ebf', NULL, 'zh_CN', '厨卫电器', 'chu-wei-dian-qi', NULL, 3, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (4, '88e68d32-aa96-4447-a010-eed977e36b70', NULL, 'zh_CN', '酒水', 'jiu-shui', NULL, 4, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (5, '5c6ea0c1-6c50-4ffd-8ce8-7ad85f8111dd', NULL, 'zh_CN', '运动户外', 'yun-dong-hu-wai', NULL, 5, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (6, 'cebe03bf-df93-4a27-bc0d-6997ae2de75e', NULL, 'zh_CN', '服装', 'fu-zhuang', NULL, 6, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (7, '40a2fbec-7784-46c6-a015-fdb8001f2f90', NULL, 'zh_CN', '化妆品', 'hua-zhuang-pin', NULL, 7, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (8, '0b8d96b8-a30d-427a-9d4b-8f66d87b847b', NULL, 'zh_CN', '珠宝礼品', 'zhu-bao-li-pin', NULL, 8, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (9, '38d59435-e7c7-428b-9328-4475bfce8b23', NULL, 'zh_CN', '钟表', 'zhong-biao', NULL, 9, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (10, 'd7aaf698-7d96-4814-83ee-0e2b51d9c02d', NULL, 'zh_CN', '母婴用品', 'mu-ying-yong-pin', NULL, 10, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (11, '09044dc0-6f2e-493d-bd9e-7ba94d03e4f3', NULL, 'zh_CN', '家居家装', 'jia-ju-jia-zhuang', NULL, 11, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (12, '9f41ddb9-71e9-4fef-ab5e-affc8f2c8a3b', NULL, 'zh_CN', '食品生鲜', 'shi-pin-sheng-xian', NULL, 12, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (13, '98ce0b58-051f-4de4-ad9d-c15201fff2f9', NULL, 'zh_CN', '图书音像', 'tu-shu-yin-xiang', NULL, 13, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (14, 'd6989405-4181-45ae-a4a8-24b5a287e691', NULL, 'zh_CN', '汽车用品', 'qi-che-yong-pin', NULL, 14, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (15, '81a9c21a-c44e-4830-b413-a8b88bdd5bb8', NULL, 'zh_CN', '办公用品', 'ban-gong-yong-pin', NULL, 15, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (16, '9847bf32-19de-4001-b8be-dadb20940a92', NULL, 'zh_CN', '宠物用品', 'chong-wu-yong-pin', NULL, 16, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (17, 'e86e5c98-3e8d-42c2-a7e7-8e25ee2dec9f', NULL, 'zh_CN', '五金工具', 'wu-jin-gong-ju', NULL, 17, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (18, 'da31f520-a63f-444d-aa34-217f468a58ee', NULL, 'zh_CN', '乐器', 'yue-qi', NULL, 18, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (19, '69b1cf20-b2ad-4e5a-80c3-72d51598d40b', NULL, 'zh_CN', '收藏品', 'shou-cang-pin', NULL, 19, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);
INSERT INTO `kp_product_categories` VALUES (20, '568f194a-223f-4d0b-98c6-2c8e4f7957ad', NULL, 'zh_CN', '农资用品', 'nong-zi-yong-pin', NULL, 20, 0, 1, '2026-02-21 17:16:32', '2026-02-21 17:16:32', NULL);

-- ----------------------------
-- Table structure for kp_product_comments
-- ----------------------------
DROP TABLE IF EXISTS `kp_product_comments`;
CREATE TABLE `kp_product_comments`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '评论自增主键ID',
  `comment_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论ID唯一标识',
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '评论内容',
  `like_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '点赞数',
  `dislike_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '踩数',
  `is_approved` tinyint(1) NOT NULL DEFAULT 0 COMMENT '审核状态',
  `is_pinned` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶',
  `is_using` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '评论者IP地址',
  `user_agent` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '用户代理信息',
  `original_id` int(11) NULL DEFAULT NULL COMMENT '原始评论ID',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '软删除时间戳',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `product_comments_comment_id_unique`(`comment_id` ASC) USING BTREE,
  INDEX `idx_product_approved`(`product_id` ASC, `is_approved` ASC) USING BTREE,
  INDEX `idx_user_created`(`user_id` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_parent_created`(`parent_id` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_created`(`created_at` ASC) USING BTREE,
  FULLTEXT INDEX `ft_comments_content`(`content`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '产品评论表 - 存储所有产品评论信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_product_comments
-- ----------------------------

-- ----------------------------
-- Table structure for kp_product_options
-- ----------------------------
DROP TABLE IF EXISTS `kp_product_options`;
CREATE TABLE `kp_product_options`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `option_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '选项名称',
  `type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text' COMMENT '选项类型',
  `values` json NULL COMMENT '选项值',
  `price_adjustment` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '价格调整',
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `is_required` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否必填',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `product_options_option_uuid_unique`(`option_uuid` ASC) USING BTREE,
  INDEX `idx_product_active`(`product_id` ASC, `is_active` ASC) USING BTREE,
  INDEX `product_options_sort_order_index`(`sort_order` ASC) USING BTREE,
  INDEX `product_options_is_active_index`(`is_active` ASC) USING BTREE,
  CONSTRAINT `product_options_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `kp_products` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '产品选项表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_product_options
-- ----------------------------

-- ----------------------------
-- Table structure for kp_product_tags
-- ----------------------------
DROP TABLE IF EXISTS `kp_product_tags`;
CREATE TABLE `kp_product_tags`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `tag_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `lang_key` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh_CN',
  `name` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序',
  `usage_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用次数',
  `color` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '#007bff',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `meta_data` json NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `product_tags_tag_uuid_unique`(`tag_uuid` ASC) USING BTREE,
  UNIQUE INDEX `product_tags_name_unique`(`name` ASC) USING BTREE,
  UNIQUE INDEX `product_tags_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `idx_lang_active`(`lang_key` ASC, `is_active` ASC) USING BTREE,
  INDEX `product_tags_usage_count_index`(`usage_count` ASC) USING BTREE,
  INDEX `product_tags_sort_order_index`(`sort_order` ASC) USING BTREE,
  INDEX `idx_slug_active`(`slug` ASC, `is_active` ASC) USING BTREE,
  INDEX `idx_usage_active`(`usage_count` ASC, `is_active` ASC) USING BTREE,
  INDEX `idx_active_created`(`is_active` ASC, `created_at` ASC) USING BTREE,
  INDEX `product_tags_lang_key_index`(`lang_key` ASC) USING BTREE,
  INDEX `product_tags_is_active_index`(`is_active` ASC) USING BTREE,
  FULLTEXT INDEX `ft_product_tags_name_description`(`name`, `description`)
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '产品标签表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_product_tags
-- ----------------------------
INSERT INTO `kp_product_tags` VALUES (1, '888babd3-3d0f-4f0c-ada2-480c28ed9cad', 'zh_CN', '饮品类', 'yin-pin-lei', NULL, 1, 0, '#007bff', NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `kp_product_tags` VALUES (2, '1e66b045-2430-4763-ae9e-842cf8d734d9', 'zh_CN', '机械设备', 'ji-xie-she-bei', NULL, 2, 0, '#007bff', NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `kp_product_tags` VALUES (3, 'c995c702-0c72-4626-9411-71975a49c9cf', 'zh_CN', '厨具用品', 'chu-ju-yong-pin', NULL, 3, 0, '#007bff', NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `kp_product_tags` VALUES (4, '884a48f7-a18b-4939-b6f3-f9c8e6d6d035', 'zh_CN', '家用电器', 'jia-yong-dian-qi', NULL, 4, 0, '#007bff', NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `kp_product_tags` VALUES (5, '0f87a959-ae72-4fc9-9545-5fd7ffda85ee', 'zh_CN', '酒水类', 'jiu-shui-lei', NULL, 5, 0, '#007bff', NULL, NULL, 1, NULL, NULL, NULL);
INSERT INTO `kp_product_tags` VALUES (6, '75c7558f-0201-4d1b-be87-07cc0c63471a', 'zh_CN', '医药类', 'yi-yao-lei', NULL, 6, 0, '#007bff', NULL, NULL, 1, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for kp_products
-- ----------------------------
DROP TABLE IF EXISTS `kp_products`;
CREATE TABLE `kp_products`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '产品自增主键ID',
  `product_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '产品全局唯一标识符',
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `lang_key` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'zh_CN' COMMENT '语言标识(en,zh-CN等)',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '产品标题',
  `slug` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'URL友好的别名',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '产品简短描述',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '产品详细介绍内容',
  `price` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '当前销售价格',
  `original_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '原始价格',
  `discount_price` decimal(10, 2) NULL DEFAULT NULL COMMENT '折扣后价格',
  `discount` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '折扣百分比(0-100)',
  `thumbnail` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '产品缩略图URL',
  `cover_img` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '产品封面大图URL',
  `images` json NULL COMMENT '产品相册图片集合(JSON数组)',
  `meta_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'SEO Meta标题',
  `meta_description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'SEO Meta描述',
  `meta_keywords` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'SEO Meta关键词',
  `keywords` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '产品关键词标签',
  `tb_shop_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '淘宝店铺链接',
  `jd_shop_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '京东店铺链接',
  `shop_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '自营商城链接',
  `options` json NULL COMMENT '产品规格选项(JSON格式)',
  `metadata` json NULL COMMENT '产品额外元数据(JSON格式)',
  `view_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '产品浏览次数',
  `like_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '产品点赞数量',
  `comment_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '产品评论数量',
  `sales_count` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '产品销售数量',
  `praise` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户赞成票数',
  `ridicule` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '用户反对票数',
  `grade` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '产品平均评分',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '产品是否上架显示',
  `is_featured` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否为推荐产品',
  `is_hot` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否为热门产品',
  `is_top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶显示',
  `allow_comments` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否允许用户评论',
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '显示排序权重',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL COMMENT '软删除时间戳',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `products_product_uuid_unique`(`product_uuid` ASC) USING BTREE,
  UNIQUE INDEX `products_slug_unique`(`slug` ASC) USING BTREE,
  INDEX `products_user_id_foreign`(`user_id` ASC) USING BTREE,
  INDEX `idx_category_active`(`category_id` ASC, `is_active` ASC) USING BTREE,
  INDEX `idx_featured_created`(`is_featured` ASC, `created_at` ASC) USING BTREE,
  INDEX `idx_hot_active`(`is_hot` ASC, `is_active` ASC) USING BTREE,
  INDEX `idx_price_active`(`price` ASC, `is_active` ASC) USING BTREE,
  INDEX `idx_sales_active`(`sales_count` ASC, `is_active` ASC) USING BTREE,
  INDEX `idx_grade_active`(`grade` ASC, `is_active` ASC) USING BTREE,
  INDEX `idx_created_at`(`created_at` ASC) USING BTREE,
  INDEX `idx_updated_at`(`updated_at` ASC) USING BTREE,
  INDEX `idx_lang_key`(`lang_key` ASC) USING BTREE,
  INDEX `idx_is_active`(`is_active` ASC) USING BTREE,
  INDEX `idx_is_featured`(`is_featured` ASC) USING BTREE,
  FULLTEXT INDEX `ft_title_content`(`title`, `content`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '产品主表 - 存储所有产品核心信息' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_products
-- ----------------------------

-- ----------------------------
-- Table structure for kp_role
-- ----------------------------
DROP TABLE IF EXISTS `kp_role`;
CREATE TABLE `kp_role`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `r_key` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(85) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `sort_id` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '排序',
  `exp` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '经验值',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `is_using` enum('On','Off') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `role_r_key_unique`(`r_key` ASC) USING BTREE,
  UNIQUE INDEX `role_name_unique`(`name` ASC) USING BTREE,
  INDEX `role_r_key_name_index`(`r_key` ASC, `name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户角色表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_role
-- ----------------------------

-- ----------------------------
-- Table structure for kp_site_comment
-- ----------------------------
DROP TABLE IF EXISTS `kp_site_comment`;
CREATE TABLE `kp_site_comment`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `site_key` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '邮箱',
  `full_name` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '名称',
  `tel_phone` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '手机号码',
  `ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT 'IP地址',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `is_using` smallint(5) UNSIGNED NOT NULL DEFAULT 0 COMMENT '状态，0禁用，1启用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `site_comment_site_key_unique`(`site_key` ASC) USING BTREE,
  INDEX `site_comment_email_index`(`email` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '网站留言表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_site_comment
-- ----------------------------

-- ----------------------------
-- Table structure for kp_sku_attribute
-- ----------------------------
DROP TABLE IF EXISTS `kp_sku_attribute`;
CREATE TABLE `kp_sku_attribute`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `app_name` varchar(50) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL,
  `admin_id` int(11) NULL DEFAULT NULL,
  `attr_name` varchar(128) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '规格名称',
  `attr_type` enum('checkbox','radio') CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '规格类型',
  `attr_value` json NULL COMMENT '规格值',
  `sort` tinyint(4) NOT NULL DEFAULT 0 COMMENT '排序',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_sku_attribute
-- ----------------------------

-- ----------------------------
-- Table structure for kp_sql_config
-- ----------------------------
DROP TABLE IF EXISTS `kp_sql_config`;
CREATE TABLE `kp_sql_config`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `sql_key` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `host` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `port` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `database` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `prefix` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `username` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `charset` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `sort_id` int(10) UNSIGNED NULL DEFAULT 1 COMMENT '排序',
  `is_using` smallint(5) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `sql_config_sql_key_unique`(`sql_key` ASC) USING BTREE,
  INDEX `sql_config_sql_key_index`(`sql_key` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '数据库设置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_sql_config
-- ----------------------------

-- ----------------------------
-- Table structure for kp_store
-- ----------------------------
DROP TABLE IF EXISTS `kp_store`;
CREATE TABLE `kp_store`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `store_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '门店名称',
  `name` varchar(85) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '门店名称',
  `address` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '门店地址',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '门店电话',
  `lat` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '纬度',
  `lng` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '经度',
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `thumbnail` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '缩略图',
  `images` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '图片',
  `admin_id` int(11) NOT NULL COMMENT '创建人',
  `lang_key` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT 'zh_CN' COMMENT 'message.choose_lang',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '备注',
  `is_using` smallint(5) UNSIGNED NULL DEFAULT 1 COMMENT '状态',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `store_store_id_unique`(`store_id` ASC) USING BTREE,
  INDEX `store_name_admin_id_index`(`name` ASC, `admin_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '企业门店表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_store
-- ----------------------------

-- ----------------------------
-- Table structure for kp_template
-- ----------------------------
DROP TABLE IF EXISTS `kp_template`;
CREATE TABLE `kp_template`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `template_key` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(85) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `folder` varchar(125) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '文件夹名称',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `description` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `is_using` smallint(5) UNSIGNED NULL DEFAULT 1 COMMENT '状态，0禁用，1启用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `template_template_key_unique`(`template_key` ASC) USING BTREE,
  INDEX `template_template_key_name_index`(`template_key` ASC, `name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '网站模板表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_template
-- ----------------------------
INSERT INTO `kp_template` VALUES (1, '8b9c28bb-7108-4e9e-9402-0ab9898b27da', '1号模板', 'template_01', NULL, NULL, 0, NULL, NULL);
INSERT INTO `kp_template` VALUES (2, 'f568719b-0e33-48a4-a233-d391e9d544f5', '2号模板', 'template_02', NULL, NULL, 1, NULL, NULL);

-- ----------------------------
-- Table structure for kp_users_ref_address
-- ----------------------------
DROP TABLE IF EXISTS `kp_users_ref_address`;
CREATE TABLE `kp_users_ref_address`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `address_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '地址UUID',
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `province` varchar(85) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '省',
  `city` varchar(85) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '市',
  `district` varchar(85) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '县/区',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '详细地址',
  `full_address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '完整地址',
  `tel_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '联系电话',
  `full_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '收货人姓名',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否默认地址',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_ref_address_address_uuid_unique`(`address_uuid` ASC) USING BTREE,
  INDEX `idx_user_default`(`user_id` ASC, `is_default` ASC) USING BTREE,
  INDEX `idx_tel_phone`(`tel_phone` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户地址管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_users_ref_address
-- ----------------------------

-- ----------------------------
-- Table structure for kp_users_ref_cart
-- ----------------------------
DROP TABLE IF EXISTS `kp_users_ref_cart`;
CREATE TABLE `kp_users_ref_cart`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `cart_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '购物车项UUID',
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '购买数量',
  `price_snapshot` decimal(10, 2) NULL DEFAULT NULL COMMENT '添加时的价格快照',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_ref_cart_cart_uuid_unique`(`cart_uuid` ASC) USING BTREE,
  INDEX `users_ref_cart_product_id_foreign`(`product_id` ASC) USING BTREE,
  INDEX `idx_user_product`(`user_id` ASC, `product_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户购物车表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_users_ref_cart
-- ----------------------------

-- ----------------------------
-- Table structure for kp_users_ref_job
-- ----------------------------
DROP TABLE IF EXISTS `kp_users_ref_job`;
CREATE TABLE `kp_users_ref_job`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `u_j_key` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '关键KEY',
  `jobs_key` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_using` smallint(5) UNSIGNED NOT NULL DEFAULT 1 COMMENT '状态，0禁用，1启用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_ref_job_u_j_key_unique`(`u_j_key` ASC) USING BTREE,
  INDEX `users_ref_job_user_id_index`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '用户招聘管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_users_ref_job
-- ----------------------------

-- ----------------------------
-- Table structure for kp_web_lang
-- ----------------------------
DROP TABLE IF EXISTS `kp_web_lang`;
CREATE TABLE `kp_web_lang`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `language_uuid` char(36) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '语言唯一标识',
  `locale_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '语言代码 (如: zh_CN, en_US)',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '语言名称 (如: 中文简体)',
  `native_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '本地语言名称 (如: 简体中文)',
  `flag_icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '国旗图标路径',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL COMMENT '语言描述',
  `is_active` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否启用',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否为默认语言',
  `sort_order` int(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '排序权重',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `web_lang_language_uuid_unique`(`language_uuid` ASC) USING BTREE,
  UNIQUE INDEX `web_lang_locale_code_unique`(`locale_code` ASC) USING BTREE,
  INDEX `idx_active_sort`(`is_active` ASC, `sort_order` ASC) USING BTREE,
  INDEX `idx_default`(`is_default` ASC) USING BTREE,
  INDEX `web_lang_is_active_index`(`is_active` ASC) USING BTREE,
  INDEX `web_lang_is_default_index`(`is_default` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '网站语言表 - 多语言配置管理' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of kp_web_lang
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
