-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 2015-04-16 08:40:07
-- 服务器版本： 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `srun` 
--

-- --------------------------------------------------------

--
-- 表的结构 `auth_assignment`
--

DROP TABLE IF EXISTS `auth_assignment`;
CREATE TABLE IF NOT EXISTS `auth_assignment` (
  `item_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`item_name`,`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `auth_assignment`
--

INSERT INTO `auth_assignment` (`item_name`, `user_id`, `created_at`) VALUES
('root', '1', 1428575108);

-- --------------------------------------------------------

--
-- 表的结构 `auth_item`
--

DROP TABLE IF EXISTS `auth_item`;
CREATE TABLE IF NOT EXISTS `auth_item` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `type` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `rule_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '角色层级',
  `p_id` int(11) DEFAULT NULL COMMENT '上级ID',
  `by_id` int(11) DEFAULT NULL COMMENT '创建人',
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=2 ;

--
-- 转存表中的数据 `auth_item`
--

INSERT INTO `auth_item` (`id`, `name`, `type`, `description`, `rule_name`, `data`, `path`, `p_id`, `by_id`, `created_at`, `updated_at`) VALUES
(1, 'root', 1, '超级管理员', NULL, NULL, '0', 0, NULL, 1428575108, 1428575108);

-- --------------------------------------------------------

--
-- 表的结构 `auth_item_child`
--

DROP TABLE IF EXISTS `auth_item_child`;
CREATE TABLE IF NOT EXISTS `auth_item_child` (
  `parent` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `child` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `auth_rule`
--

DROP TABLE IF EXISTS `auth_rule`;
CREATE TABLE IF NOT EXISTS `auth_rule` (
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `data` text COLLATE utf8_unicode_ci,
  `created_at` int(11) DEFAULT NULL,
  `updated_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- 表的结构 `checkout_list`
--

DROP TABLE IF EXISTS `checkout_list`;
CREATE TABLE IF NOT EXISTS `checkout_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT  '账号',
  `spend_num` float NOT NULL DEFAULT '0' COMMENT  '结算金额',
  `rt_spend_num` float NOT NULL DEFAULT '0' COMMENT  '实时结算金额',
  `product_id` smallint(6) NOT NULL COMMENT  '产品id',
  `buy_id` smallint(6) NOT NULL COMMENT  '套餐id',
  `flux` float NOT NULL COMMENT  '消费流量',
  `minutes` bigint(20) NOT NULL COMMENT  '消费时长',
  `sum_times` int(11) NOT NULL COMMENT  '上网次数',
  `create_at` int(11) NOT NULL COMMENT  '结算时间',
  `type` TINYINT( 1 ) NOT NULL DEFAULT  '0' COMMENT  '0:产品结算1:购买套餐的消费2:其他',
  `remark` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT  '备注',
  PRIMARY KEY (`id`),
  KEY `index` (`user_name`,`product_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `direct_ip`
--

DROP TABLE IF EXISTS `direct_ip`;
CREATE TABLE IF NOT EXISTS `direct_ip` (
  `dip_id` int(4) NOT NULL AUTO_INCREMENT,
  `dip` varchar(65) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mask` tinyint(4) NOT NULL,
  `flg` tinyint(1) NOT NULL DEFAULT '1',
  `desc` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`dip_id`),
  UNIQUE KEY `dip` (`dip`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `extends_field`
--

DROP TABLE IF EXISTS `extends_field`;
CREATE TABLE IF NOT EXISTS `extends_field` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '流水',
  `table_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'users' COMMENT '表名',
  `field_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '字段名',
  `field_desc` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '字段展示名',
  `is_must` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否必须',
  `can_search` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否作为搜索项',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '配置类型',
  `value` text COLLATE utf8_unicode_ci NOT NULL COMMENT '配置值',
  `show_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '展示方式',
  `default_value` VARCHAR(255) NOT NULL COMMENT '默认值',
  `rule` VARCHAR(255) DEFAULT NULL COMMENT '规则',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `field_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '字段类型0：内置字段1：普通字段2：隐藏字段（如密保）',
  `field_hint` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '扩展字段提示内容',
  PRIMARY KEY (`id`),
  KEY `table_name` (`table_name`),
  UNIQUE KEY `table_field` (`table_name`,`field_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `extends_field`
--

INSERT INTO `extends_field` (`id`, `table_name`, `field_name`, `field_desc`, `is_must`, `can_search`, `type`, `value`, `show_type`, `default_value`, `sort`, `field_type`) VALUES
(1, 'users', 'cert_type', '证件类型', 0, 1, 1, '1:身份证\r\n2:学生证', 0, '0', 10, 1),
(2, 'users', 'cert_num', '证件号码', 0, 1, 0, '', 0, '', 9, 1),
(3, 'users', 'phone', '手机号', 0, 0, 0, '', 0, '', 0, 1),
(4, 'users', 'email', '邮件', 0, 0, 0, '', 0, '', 0, 1),
(5, 'users', 'user_type', '用户类型', 0, 0, 1, '0:普通用户\r\n1:访客', 0, '0', 0, 1);


-- --------------------------------------------------------

--
-- 表的结构 `extra_pay`
--

DROP TABLE IF EXISTS `extra_pay`;
CREATE TABLE IF NOT EXISTS `extra_pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pay_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `pay_num` float NOT NULL DEFAULT '0',
  `description` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `create_at` int(11) NOT NULL,
  `mgr_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `is_must` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `pay_name` (`pay_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `ip_area`
--

DROP TABLE IF EXISTS `ip_area`;
CREATE TABLE IF NOT EXISTS `ip_area` (
  `area_id` int(8) NOT NULL AUTO_INCREMENT,
  `area_name` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `area_ip_start` BIGINT NOT NULL DEFAULT '0',
  `area_ip_end` BIGINT NOT NULL DEFAULT '0',
  `area_desc` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`area_id`),
  KEY `area_name` (`area_name`,`area_ip_start`,`area_ip_end`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `log_operate`
--

DROP TABLE IF EXISTS `log_operate`;
CREATE TABLE IF NOT EXISTS `log_operate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `operator` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '操作人',
  `target` varchar(128) COLLATE utf8_unicode_ci NOT NULL COMMENT '操作目标',
  `action` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '操作动作',
  `action_type` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '动作类型',
  `content` text COLLATE utf8_unicode_ci NOT NULL COMMENT '操作内容',
  `opt_ip` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '操作人ip',
  `opt_time` int(11) NOT NULL COMMENT '操作时间',
  `class` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '本日志的类，主要用户解析日志中的字段和值',
  `type` TINYINT(1) NOT NULL DEFAULT '0' COMMENT '日志类型：默认0格式化数据，1描述性日志',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
--
-- 表的结构 `message`
--

DROP TABLE IF EXISTS `message`;
CREATE TABLE IF NOT EXISTS `message` (
  `msg_id` int(4) NOT NULL AUTO_INCREMENT,
  `msg_head` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `msg_con` text COLLATE utf8_unicode_ci NOT NULL,
  `sysmgr_user_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  PRIMARY KEY (`msg_id`),
  KEY `msg_time` (`created_at`),
  KEY `sysmgr_user_name` (`sysmgr_user_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `migration`
--

DROP TABLE IF EXISTS `migration`;
CREATE TABLE IF NOT EXISTS `migration` (
  `version` varchar(180) COLLATE utf8_unicode_ci NOT NULL,
  `apply_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `migration`
--

INSERT INTO `migration` (`version`, `apply_time`) VALUES
('m000000_000000_base', 1413883501);

-- --------------------------------------------------------

--
-- 表的结构 `online_portal`
--

DROP TABLE IF EXISTS `online_portal`;
CREATE TABLE IF NOT EXISTS `online_portal` (
  `auth_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_password` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `user_ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_ip6` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_mac` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `nas_ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `ac_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `ac_type` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `add_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `session_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `bandwidth_up` tinyint(1) NOT NULL,
  `bandwidth_down` tinyint(1) NOT NULL,
  `vrf_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `bytes_in` bigint(20) NOT NULL,
  `bytes_out` bigint(20) NOT NULL,
  `bytes_in6` bigint(20) NOT NULL,
  `bytes_out6` bigint(20) NOT NULL,
  PRIMARY KEY (`auth_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `online_portal`
--


-- --------------------------------------------------------

--
-- 表的结构 `online_radius`
--

DROP TABLE IF EXISTS `online_radius`;
CREATE TABLE IF NOT EXISTS `online_radius` (
  `rad_online_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID号',
  `session_id` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '会话ID',
  `user_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '用户名',
  `domain` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '域名',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'IPV4地址',
  `ip6` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'IPV6地址',
  `user_mac` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'MAC地址',
  `nas_ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '设备IP',
  `nas_ip1` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '代理设备的IP',
  `nas_port` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '设备端口',
  `nas_port_id` varchar(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '端口标识',
  `station_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '一般存放AP的MAC',
  `filter_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '一个RADIUS属性',
  `pbhk` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '思科的属性',
  `vlan_id1` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '外层VLAN',
  `vlan_id2` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '内层VLAN',
  `vlan_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '双层VLAN 外4位+内4位',
  `line_type` tinyint(1) NOT NULL COMMENT '线路类型',
  `login_mode` tinyint(1) NOT NULL COMMENT '登录类型1-PPPOE 2-IPOE 0-无法识别',
  `nas_type` tinyint(1) NOT NULL COMMENT '设备类型 厂商',
  `products_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '产品ID',
  `control_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '控制策略ID',
  `billing_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '计费策略ID',
  `condition_mode` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '目前没有用',
  `condition` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '计费策略的条件',
  `control_condition` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '控制策略的条件',
  `bytes_in` bigint(20) NOT NULL COMMENT '入流量 IPV4',
  `bytes_out` bigint(20) NOT NULL COMMENT '出流量 IPV4',
  `bytes_in1` bigint(20) NOT NULL COMMENT '入流量的暂存',
  `bytes_out1` bigint(20) NOT NULL COMMENT '出流量的暂存',
  `bytes_in6` bigint(20) NOT NULL COMMENT '入流量 IPV6',
  `bytes_out6` bigint(20) NOT NULL COMMENT '出流量 IPV6',
  `add_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '登录时间',
  `drop_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '下线时间',
  `update_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近一次UPDATE时间',
  `session_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '本次会话时长',
  `keepalive_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '最近一次心跳包到达时间',
  `drop_cause` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '下线原因',
  `my_ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT 'AAA地址',
  `sum_bytes` bigint(20) NOT NULL COMMENT '已用流量',
  `sum_seconds` bigint(20) NOT NULL COMMENT '已用时长',
  `sum_times` bigint(20) NOT NULL COMMENT '登录的次数',
  `remain_bytes` bigint(20) NOT NULL COMMENT '可用流量',
  `remain_seconds` bigint(20) NOT NULL COMMENT '可用时长',
  `traffic_down_ratio` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '下行流量加权',
  `traffic_up_ratio` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '上行流量加权',
  `billing_rate` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '费率',
  `billing_units` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '计费单位',
  `billing_mode` tinyint(1) NOT NULL COMMENT '计费模式 0-实时计费立即扣除费用 1-后付费 2-预付费',
  `billing_top` float unsigned NOT NULL DEFAULT '0' COMMENT '消费封顶',
  `user_balance` float unsigned NOT NULL DEFAULT '0' COMMENT '当前余额',
  `user_charge` float unsigned NOT NULL DEFAULT '0' COMMENT '本帐期消费累计',
  `bandwidth_up` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '上行带宽',
  `bandwidth_down` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '下行带宽',
  `os_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '终端操作系统',
  `class_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '终端系统类型',
  `client_type` tinyint(1) NOT NULL COMMENT '终端类型 1-PC 2-移动设备或其它 3-无法识别',
  `allow_arrears` tinyint(1) NOT NULL COMMENT '是否允许欠费',
  `change_mode_control` tinyint(1) NOT NULL COMMENT '控制策略变更模式',
  `change_mode_billing` tinyint(4) NOT NULL COMMENT '计费策略变更模式',
  PRIMARY KEY (`rad_online_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `online_radius`
--


--
-- 表的结构 `online_radius_dhcp`
--

DROP TABLE IF EXISTS `online_radius_dhcp`;
CREATE TABLE IF NOT EXISTS `online_radius_dhcp` (
  `rad_online_id` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `domain` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `uid` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `ip6` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_mac` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `nas_ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `nas_ip1` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `nas_port` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `nas_port_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `station_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `filter_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `pbhk` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `vlan_id1` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `vlan_id2` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `vlan_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `line_type` tinyint(1) NOT NULL,
  PRIMARY KEY (`rad_online_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `online_radius_proxy`
--

DROP TABLE IF EXISTS `online_radius_proxy`;
CREATE TABLE IF NOT EXISTS `online_radius_proxy` (
  `rad_online_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID号',
  `session_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '会话ID',
  `user_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `domain` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '域名',
  `uid` int(11) NOT NULL COMMENT '用户ID',
  `ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'IPV4地址',
  `ip6` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'IPV6地址',
  `user_mac` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'MAC地址',
  `nas_ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '设备IP',
  `nas_ip1` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '代理设备的IP',
  `nas_port` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '设备端口',
  `nas_port_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '端口标识',
  `station_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '一般存放AP的MAC',
  `filter_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '一个RADIUS属性',
  `pbhk` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '思科的属性',
  `vlan_id1` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '外层VLAN',
  `vlan_id2` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '内层VLAN',
  `vlan_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '双层VLAN 外4位+内4位',
  PRIMARY KEY (`rad_online_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `pay_list`
--

DROP TABLE IF EXISTS `pay_list`;
CREATE TABLE IF NOT EXISTS `pay_list` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '缴费记录ID',
  `user_name` varchar(64) NOT NULL COMMENT '用户名',
  `user_real_name` varchar(64) NOT NULL COMMENT '用户姓名',
  `pay_num` float (8,2) NOT NULL DEFAULT '0' COMMENT '缴费金额',
  `balance_pre` float NOT NULL COMMENT '缴费前电子钱包余额',
  `type` smallint(6) NOT NULL DEFAULT '0' COMMENT '缴费类型0：电子钱包1：产品2：附加费用3：电子钱包+产品4：电子钱包+产品+附加费用',
  `pay_type_id` smallint(6) NOT NULL DEFAULT '1' COMMENT '缴费方式',
  `product_id` smallint(6) NOT NULL DEFAULT '0' COMMENT '产品id',
  `package_id` int(11) NOT NULL COMMENT '套餐id',
  `extra_pay_id` smallint(6) NOT NULL DEFAULT '0' COMMENT '附加费用id',
  `order_no` varchar(255) NOT NULL COMMENT '订单号',
  `create_at` int(11) NOT NULL COMMENT '缴费时间',
  `mgr_name` varchar(64) NOT NULL COMMENT '缴费人',
  `bill_number`CHAR( 255 ) NOT NULL COMMENT  '流水号',
  `print_num` SMALLINT( 5 ) NOT NULL DEFAULT  '0' COMMENT  '打印次数',
  `is_refund` ENUM('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '一卡通是否退费0未退1已退',
  PRIMARY KEY (`id`),
  KEY `user_name` (`user_name`),
  KEY `pay_num` (`pay_num`),
  KEY `create_at` (`create_at`),
  KEY `pay_list_is_refund` (`is_refund`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;



--
-- 表的结构 `pay_type`
--

DROP TABLE IF EXISTS `pay_type`;
CREATE TABLE IF NOT EXISTS `pay_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(64) NOT NULL,
  `default` smallint(6) NOT NULL DEFAULT '0',
  `create_at` int(11) NOT NULL,
  `mgr_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `is_del` tinyint(1) NOT NULL DEFAULT  '0' COMMENT  '是否删除0：未删除1：删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=7 ;

--
-- 转存表中的数据 `pay_type`
--

INSERT INTO `pay_type` (`id`, `type_name`, `default`, `create_at`, `mgr_name`) VALUES
(1, '现金(cash)', 1, 1425523881, 'srun'),
(2, '一卡通(card)', 0, 1425523888, 'srun'),
(3, '其他(other)', 0, 1425523888, 'srun'),
(4, '电子钱包(electronic wallet)', 0, 1425523888, 'srun'),
(5, '充值卡(rechargeable card)', 0, 1425523888, 'srun'),
(6, '支付宝(alipay)', 0, 1425547440, 'srun');

-- --------------------------------------------------------

--
-- 表的结构 `rad_user_area`
--

DROP TABLE IF EXISTS `rad_user_area`;
CREATE TABLE IF NOT EXISTS `rad_user_area` (
  `userarea_id` int(10) NOT NULL AUTO_INCREMENT,
  `user_area` varchar(65) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vlan_id` VARCHAR(50) NOT NULL,
  `sub_ip` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`userarea_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- 转存表中的数据 `rad_user_area`
--

-- --------------------------------------------------------

--
-- 表的结构 `refund_list`
--

DROP TABLE IF EXISTS `refund_list`;
CREATE TABLE IF NOT EXISTS `refund_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '退费清单id',
  `user_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `refund_num` float NOT NULL DEFAULT '0',
  `type` TINYINT( 1 ) NOT NULL DEFAULT '0' COMMENT '退费类型0:退电子钱包1:退产品余额',
  `product_id` SMALLINT( 6 ) NOT NULL DEFAULT '0' COMMENT '退费产品id',
  `is_refund_fee` TINYINT( 1 ) NOT NULL DEFAULT '0' COMMENT '产品退费是否退包月费0:不退1:退',
  `create_at` int(11) NOT NULL COMMENT '退费时间',
  `mgr_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '退费管理员',
  `remarks` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '退费备注',
  PRIMARY KEY (`id`),
  KEY `user_name` (`user_name`),
  KEY `refund_num` (`refund_num`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;


--
-- 表的结构 `saving_card`
--

DROP TABLE IF EXISTS `saving_card`;
CREATE TABLE IF NOT EXISTS `saving_card` (
  `ka_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '充值卡ID',
  `ka_type` varchar(8) NOT NULL DEFAULT '' COMMENT '充值卡创建类型create:手动创建import:导入生成',
  `ka_sn` varchar(16) NOT NULL DEFAULT '' COMMENT '批次',
  `ka_card_num` varchar(32) NOT NULL DEFAULT '' COMMENT '充值卡号',
  `pw_type` tinyint(1) NOT NULL DEFAULT '2' COMMENT '卡密码类型1:纯数字2:字母数字混合型',
  `ka_passwd` varchar(16) NOT NULL DEFAULT '' COMMENT '卡密码',
  `ka_create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `ka_chongzhi_time` int(11) NOT NULL DEFAULT '0' COMMENT '充值时间',
  `ka_end_date` int(11) NOT NULL DEFAULT '0' COMMENT '截止时间',
  `ka_is_used` int(1) NOT NULL DEFAULT '0' COMMENT '是否已充值0:未充值1:已充值2:未充值',
  `ka_balance` int(8) NOT NULL DEFAULT '0' COMMENT '卡面额',
  `sysmgr_user_name` varchar(16) NOT NULL DEFAULT '' COMMENT '创建卡管理员',
  `ka_res1` int(11) DEFAULT NULL COMMENT '备用字段1',
  `ka_res2` varchar(16) DEFAULT NULL COMMENT '备用字段2',
  `ka_res3` varchar(32) DEFAULT NULL COMMENT '备用字段3',
  `user_charge_to` varchar(33) DEFAULT NULL COMMENT '充值用户',
  PRIMARY KEY (`ka_id`),
  UNIQUE KEY `ka_card_num` (`ka_card_num`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `services_group_setting`
--

DROP TABLE IF EXISTS `services_group_setting`;
CREATE TABLE IF NOT EXISTS `services_group_setting` (
  `id` smallint(4) NOT NULL AUTO_INCREMENT,
  `user_group_id` smallint(4) DEFAULT '0',
  `zone_group_id` smallint(4) DEFAULT '0',
  `visitor_num` int(11) NOT NULL DEFAULT '0' COMMENT '访客生成最大数量',
  `visitor_time` int(11) NOT NULL DEFAULT '0' COMMENT '访客有效期',
  `edit` text COLLATE utf8_unicode_ci NULL,
  `access` text COLLATE utf8_unicode_ci NULL,
  `short_visitor_setting` VARCHAR(256) NULL DEFAULT NULL COMMENT  '短期访客配置',
  `long_visitor_setting` VARCHAR(256) NULL DEFAULT NULL COMMENT  '长期访客配置',
  PRIMARY KEY (`id`),
  KEY `user_group_id` (`user_group_id`,`zone_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `setting`
--

DROP TABLE IF EXISTS `setting`;
CREATE TABLE IF NOT EXISTS `setting` (
  `key` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  UNIQUE KEY `key` (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `setting`
--

INSERT INTO `setting` (`key`, `value`) VALUES
('sms', '{"name":"\\u6df1\\u6f9c\\u77ed\\u4fe1\\u7f51\\u5173","class":"common\\\\models\\\\SrunSms","setting":"name=srun\\r\\ntoken=123456"}');

INSERT INTO `setting` (`key`, `value`) VALUES ('changeProDed', 'allfee');
-- --------------------------------------------------------

--
-- 表的结构 `soap_center`
--

DROP TABLE IF EXISTS `soap_center`;
CREATE TABLE IF NOT EXISTS `soap_center` (
  `center_id` smallint(3) NOT NULL AUTO_INCREMENT,
  `center_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `center_key` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `soap_model` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `product` text COLLATE utf8_unicode_ci COMMENT '产品',
  `users_group` text COLLATE utf8_unicode_ci COMMENT '用户组',
  `manager_group_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '管理组类型(1勾选 2 全部)',
  `manager_product_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '管理产品类型(1勾选 2 全部)',
  `pay_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '缴费方式',
  `pay_where` TINYINT NOT NULL DEFAULT '1' COMMENT '缴费到哪里(1缴到用户第一个产品,2缴到账号余额)',
  PRIMARY KEY (`center_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `srun_arrears_log`
--
DROP TABLE IF EXISTS `srun_arrears_log`;
CREATE TABLE IF NOT EXISTS `srun_arrears_log` (
  `arrears_log_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL,
  `products_id` int(8) DEFAULT NULL,
  `billing_id` int(8) DEFAULT NULL,
  `user_charge` float(8,4) DEFAULT NULL,
  `user_balance` float(8,4) DEFAULT NULL,
  `log_time` int(11) NOT NULL,
  `log_status` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`arrears_log_id`),
  KEY `user_name` (`user_name`),
  KEY `products_id` (`products_id`),
  KEY `billing_id` (`billing_id`),
  KEY `log_time` (`log_time`),
  KEY `log_status` (`log_status`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

-- --------------------------------------------------------

--
-- 表的结构 `users_group`
--

DROP TABLE IF EXISTS `users_group`;
CREATE TABLE IF NOT EXISTS `users_group` (
  `id` smallint (6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '组织结构名称',
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '结构路径',
  `pid` smallint (6) NOT NULL DEFAULT '1' COMMENT '父ID',
  `level` tinyint(3) NOT NULL DEFAULT '1' COMMENT '组织递进',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `tid` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- 转存表中的数据 `users_group`
--

INSERT INTO `users_group` (`id`, `name`, `path`, `pid`, `level`, `status`, `tid`) VALUES
(1, '/', '0', 0, 1, 1, '');

-- --------------------------------------------------------

--
-- 表的结构 `srun_login_log`
--

DROP TABLE IF EXISTS `srun_login_log`;
CREATE TABLE IF NOT EXISTS `srun_login_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_ip` varchar(64) COLLATE utf8_unicode_ci DEFAULT '0',
  `nas_ip` varchar(64) COLLATE utf8_unicode_ci DEFAULT '0',
  `user_mac` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `nas_port_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `err_msg` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `log_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY user_name ( `user_name` ),
  KEY user_ip ( `user_ip` ),
  KEY user_mac ( `user_mac` ),
  KEY nas_port_id ( `nas_port_id` ),
  KEY log_time ( `log_time` )
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `srun_system_log`
--

DROP TABLE IF EXISTS `srun_system_log`;
CREATE TABLE IF NOT EXISTS `srun_system_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `proc` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `nas_ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `my_ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `user_mac` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `nas_port_id` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `err_msg` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `log_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY user_name ( `user_name` ),
  KEY user_ip ( `user_ip` ),
  KEY user_mac ( `user_mac` ),
  KEY nas_port_id ( `nas_port_id` ),
  KEY log_time ( `log_time` ),
  KEY proc ( `proc` ),
  KEY nas_ip ( `nas_ip` ),
  KEY my_ip ( `my_ip` )
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `tokens`
--

CREATE TABLE IF NOT EXISTS `tokens` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `token` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `center_id` int(3) NOT NULL,
  `expires` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;


--
-- 表的结构 `trouble`
--
DROP TABLE IF EXISTS `trouble`;
CREATE TABLE IF NOT EXISTS `trouble` (
  `trouble_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_login_name` varchar(64) DEFAULT NULL,
  `user_real_name` varchar(16) NOT NULL,
  `user_phone` varchar(20) NOT NULL,
  `mobile_phone` varchar(16) NOT NULL,
  `user_cert_num` varchar(30) NOT NULL,
  `user_address` varchar(64) NOT NULL,
  `user_email` varchar(64) NOT NULL,
  `user_available` int(1) NOT NULL DEFAULT '0',
  `user_status` tinyint(1) NOT NULL DEFAULT '0',
  `login_status` tinyint(1) NOT NULL DEFAULT '0',
  `room_status` tinyint(1) NOT NULL DEFAULT '0',
  `former_status` tinyint(1) NOT NULL DEFAULT '0',
  `login_info` varchar(255) NOT NULL,
  `user_ip` varchar(64) NOT NULL,
  `user_mask` varchar(64) NOT NULL,
  `user_mac` varchar(64) NOT NULL,
  `user_gateway` varchar(64) NOT NULL,
  `network_speed` tinyint(1) NOT NULL DEFAULT '0',
  `card_light` tinyint(1) NOT NULL DEFAULT '0',
  `ping_status` tinyint(1) NOT NULL DEFAULT '0',
  `trouble_desc` text NOT NULL,
  `report_time` datetime NOT NULL,
  `transact_time` datetime NOT NULL,
  `transact_result` text NOT NULL,
  `sysmgr_user_name` varchar(16) NOT NULL,
  `is_transact` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`trouble_id`),
  KEY `user_login_name` (`user_login_name`,`is_transact`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `manager`
--

DROP TABLE IF EXISTS `manager`;
CREATE TABLE IF NOT EXISTS `manager` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `auth_key` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password_reset_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mobile_phone` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `role` smallint(6) NOT NULL DEFAULT '10',
  `status` smallint(6) NOT NULL DEFAULT '10',
  `mgr_org` text COLLATE utf8_unicode_ci COMMENT '可以管理的组织',
  `mgr_region` text COLLATE utf8_unicode_ci COMMENT '可以管理的区域',
  `mgr_product` text COLLATE utf8_unicode_ci NOT NULL COMMENT '可以管理的产品',
  `mgr_admin` text COLLATE utf8_unicode_ci NOT NULL COMMENT '可以管理的管理员',
  `mgr_portal` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '可管理的portal 页面',
  `tid` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT '保存ztree默认生成的tid值',
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '结构路径',
  `pid` int(11) DEFAULT NULL COMMENT '父ID',
  `mgr_admin_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '[1=>不管理其他人，2=>只管理所勾选管理员，3=>管理勾选管理员及自己创建的管理员，4=>管理自己创建的管理员]',
  `created_at` int(11) NOT NULL,
  `updated_at` int(11) NOT NULL,
  `ip_area` VARCHAR(255) NOT NULL DEFAULT '' COMMENT '允许管理员登录的ip段',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- 转存表中的数据 `manager`
--

INSERT INTO `manager` (`id`, `username`, `auth_key`, `password_hash`, `password_reset_token`, `email`, `role`, `status`, `mgr_org`, `mgr_product`, `mgr_admin`, `tid`, `path`, `pid`, `created_at`, `updated_at`, `mgr_admin_type`) VALUES
(1, 'srun', 'wgsmx0m7uSQ98aBEJ8W-OBowbwqozctq', '$2y$13$2xW..AD7LnU6vG7mZm6sneWuQw5x5P8vu7eE30JS/NVWpI3/JroEG', NULL, 'srun@srun.com', 10, 10, '103', '', '', '', NULL, NULL, 1429592064, 1429592064, 1);


-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `user_real_name` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '真实姓名',
  `group_id` smallint(6) NOT NULL DEFAULT '0' COMMENT '所属用户组id',
  `region_id` smallint(6) NOT NULL DEFAULT '0' COMMENT '所属区域组id',
  `user_create_time` int(11) NOT NULL COMMENT '账号创建日期',
  `user_update_time` int(11) NOT NULL COMMENT '账号更新日期',
  `user_expire_time` int(11) NOT NULL COMMENT '账号过期日期',
  `user_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否欠费',
  `balance` float NOT NULL DEFAULT '0' COMMENT '账号余额',
  `mgr_name_create` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '创建此用户的管理员',
  `mgr_name_update` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '最后操作的管理员',
  `user_start_time` int(11) NOT NULL DEFAULT '0' COMMENT '账户开始时间',
  `user_stop_time` int(11) NOT NULL DEFAULT '0' COMMENT '账户停用时间',
  `user_allow_chgpass` tinyint(1) NOT NULL DEFAULT '1',
  `cert_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '证件类型' ,
  `cert_num` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '证件号码',
  `phone` varchar(64) NOT NULL COMMENT '手机号',
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT  'email',
  `user_type` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '用户类型',
  `can_create_visitor` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '允许创建访客',
  `create_visitor_num` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '创建访客数量',
  `user_available` TINYINT NOT NULL DEFAULT 0 COMMENT '0正常1禁用2停机保号3暂停4未开通',
  `question1` TINYINT(1) COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '密保问题1',
  `answer1` VARCHAR(255) COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '密保答案1',
  `question2` TINYINT(1) COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '密保问题2',
  `answer2` VARCHAR(255) COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '密保答案2',
  `question3` TINYINT(1) COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '密保问题3',
  `answer3` VARCHAR(255) COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT '密保答案3',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_name` (`user_name`),
  KEY `user_real_name` (`user_real_name`),
  KEY `group_id` (`group_id`),
  KEY `mgr_name` (`mgr_name_create`),
  KEY `user_available`(`user_available`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `users_open_log`
--

DROP TABLE IF EXISTS `users_open_log`;
CREATE TABLE IF NOT EXISTS `users_open_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `user_real_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '姓名',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '类型,0开户1销户',
  `operate_time` int(11) NOT NULL COMMENT '操作时间',
  `operate_ip` varchar(15) COLLATE utf8_unicode_ci NOT NULL COMMENT '操作人ip',
  `mgr_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '操作人',
  `detail` text COLLATE utf8_unicode_ci NOT NULL COMMENT '详细内容',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户开户销户备份表' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `waiting_checkout`
--

DROP TABLE IF EXISTS `waiting_checkout`;
CREATE TABLE IF NOT EXISTS `waiting_checkout` (
  `checkout_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  `products_id` int(11) NOT NULL DEFAULT '0',
  `checkout_date` int(11) NOT NULL DEFAULT '0',
  `balance_start` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`checkout_id`),
  UNIQUE KEY `index` (`user_id`,`products_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;


--
-- 表的结构 `srun_ip_tab` IP表管理
--
DROP TABLE IF EXISTS `srun_ip_tab`;
CREATE TABLE IF NOT EXISTS `srun_ip_tab` (
  `ip_id` int(10) NOT NULL AUTO_INCREMENT,
  `ipaddr` varchar(128) NOT NULL,
  `type` int(10) NOT NULL DEFAULT '0',
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  `nas_ip` varchar(16) NOT NULL DEFAULT '',
  `ip_desc` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`ip_id`),
  KEY `user_id` (`user_id`),
  KEY `type` (`type`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


-- 
-- 表的结构 `products_change`
--

DROP TABLE IF EXISTS `products_change`;
CREATE TABLE IF NOT EXISTS `products_change` (
  `change_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL DEFAULT '0',
  `products_id_from` int(11) NOT NULL DEFAULT '0',
  `products_id_to` int(11) NOT NULL DEFAULT '0',
  `operating_date` int(11) NOT NULL DEFAULT '0',
  `change_status` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`change_id`),
  KEY `user_id` (`user_id`),
  KEY `products_id_from` (`products_id_from`),
  KEY `change_status`(`change_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;


--
-- 表的结构 `portal`
--

DROP TABLE IF EXISTS `portal`;
CREATE TABLE IF NOT EXISTS `portal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `portal_name` varchar(50) NOT NULL COMMENT '模板名称',
  `examples_name` varchar(50) NOT NULL COMMENT '实例名称',
  `pid` mediumint(9) NOT NULL COMMENT '创建人',
  `logo` text NOT NULL,
  `top_banner` text NOT NULL,
  `banner` text,
  `footer` text NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型(1pc 2移动端)',
  PRIMARY KEY (`id`),
  UNIQUE KEY `examples_name` (`examples_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='portal' AUTO_INCREMENT=1 ;

--
-- 表的结构 `register`
--
DROP TABLE IF EXISTS `register`;
CREATE TABLE IF NOT EXISTS `register` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `user_password` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `group_id` smallint(6) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '0:待审核1:审核不通过',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `tip_message` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `user_real_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '真实姓名',
  `product` int(11) NOT NULL,
  `user_email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '邮箱',
  `user_cert_num` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '证件号码',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- 转存表中的数据 `register`
--

INSERT INTO `register` (`id`, `user_name`, `user_password`, `user_real_name`, `group_id`, `status`, `create_time`, `update_time`, `tip_message`) VALUES
(3, 'user01', '111111', 'user01', 2, 0, 1, 1, '');


--
-- 产品实例中的用户与手机号对应关系
--
DROP TABLE IF EXISTS `user_products`;
CREATE TABLE IF NOT EXISTS `user_products` (
  `user_products_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL,
  `user_id` bigint(20) NOT NULL DEFAULT 0,
  `products_id` bigint(20) NOT NULL DEFAULT 0,
  `mobile_phone` varchar(64) NOT NULL,
  `user_available` tinyint(1),
  `user_balance` float(8,4),
  PRIMARY KEY (`user_products_id`),
  KEY `user_name` (`user_name`),
  KEY `user_id` (`user_id`),
  KEY `products_id` (`products_id`),
  KEY `mobile_phone` (`mobile_phone`),
  KEY `user_available` (`user_available`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 表的结构 `ipBindingToken`
--
DROP TABLE IF EXISTS `ipBindingToken`;
CREATE TABLE IF NOT EXISTS `ipBindingToken` (
  `ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `token` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `api_action` text COLLATE utf8_unicode_ci,
  `app_action` text COLLATE utf8_unicode_ci,
  UNIQUE KEY `ip` (`ip`),
  UNIQUE KEY `token` (`token`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='ip绑定固定token';

--
-- 用于在线统计的表
--
CREATE TABLE IF NOT EXISTS `online_report_point` (
	`time_point` int(11) NOT NULL,
	`count` int(11) NOT NULL,
	PRIMARY KEY (`time_point`)
)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `online_report_products` (
  `report_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time_point` int(11) NOT NULL,
  `products_id` bigint(20) NOT NULL,
  `count` int(11) NOT NULL,
  `bytes_in` bigint(20) NOT NULL,
  `bytes_out` bigint(20) NOT NULL,
  `time_long` int(11) NOT NULL,
  PRIMARY KEY (`report_id`),
  KEY `time_point` (`time_point`),
  KEY `products_id` (`products_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `online_report_billing` (
  `report_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time_point` int(11) NOT NULL,
  `billing_id` bigint(20) NOT NULL,
  `count` int(11) NOT NULL,
  `bytes_in` bigint(20) NOT NULL,
  `bytes_out` bigint(20) NOT NULL,
  `time_long` int(11) NOT NULL,
  PRIMARY KEY (`report_id`),
  KEY `time_point` (`time_point`),
  KEY `billing_id` (`billing_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `online_report_control` (
  `report_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time_point` int(11) NOT NULL,
  `control_id` bigint(20) NOT NULL,
  `count` int(11) NOT NULL,
  `bytes_in` bigint(20) NOT NULL,
  `bytes_out` bigint(20) NOT NULL,
  `time_long` int(11) NOT NULL,
  PRIMARY KEY (`report_id`),
  KEY `time_point` (`time_point`),
  KEY `control_id` (`control_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `online_report_group` (
  `report_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time_point` int(11) NOT NULL,
  `group_id` bigint(20) NOT NULL,
  `count` int(11) NOT NULL,
  `bytes_in` bigint(20) NOT NULL,
  `bytes_out` bigint(20) NOT NULL,
  `time_long` int(11) NOT NULL,
  PRIMARY KEY (`report_id`),
  KEY `time_point` (`time_point`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `online_report_class_name` (
  `report_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time_point` int(11) NOT NULL,
  `class_name` varchar(64) NOT NULL,
  `count` int(11) NOT NULL,
  `bytes_in` bigint(20) NOT NULL,
  `bytes_out` bigint(20) NOT NULL,
  `time_long` int(11) NOT NULL,
  PRIMARY KEY (`report_id`),
  KEY `time_point` (`time_point`),
  KEY `class_name` (`class_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `online_report_os_name` (
  `report_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time_point` int(11) NOT NULL,
  `os_name` varchar(64) NOT NULL,
  `count` int(11) NOT NULL,
  `bytes_in` bigint(20) NOT NULL,
  `bytes_out` bigint(20) NOT NULL,
  `time_long` int(11) NOT NULL,
  PRIMARY KEY (`report_id`),
  KEY `time_point` (`time_point`),
  KEY `os_name` (`os_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


CREATE TABLE IF NOT EXISTS `online_report_nas_ip` (
  `report_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time_point` int(11) NOT NULL,
  `nas_ip` varchar(16) NOT NULL,
  `count` int(11) NOT NULL,
  `bytes_in` bigint(20) NOT NULL,
  `bytes_out` bigint(20) NOT NULL,
  `time_long` int(11) NOT NULL,
  PRIMARY KEY (`report_id`),
  KEY `time_point` (`time_point`),
  KEY `nas_ip` (`nas_ip`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `srun_detail_day` (
  `detail_day_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '用户名',
  `record_day` int(11) NOT NULL COMMENT '记录日期',
  `bytes_in` bigint(20) NOT NULL COMMENT '入流量',
  `bytes_out` bigint(20) NOT NULL COMMENT '出流量',
  `bytes_in6` bigint(20) NOT NULL COMMENT 'V6入流量',
  `bytes_out6` bigint(20) NOT NULL COMMENT 'V6出流量',
  `products_id` smallint(6) NOT NULL COMMENT '产品id',
  `billing_id` smallint(6) NOT NULL COMMENT '计费策略id',
  `control_id` smallint(6) NOT NULL COMMENT '控制策略id',
  `user_balance` float DEFAULT NULL COMMENT '当前余额',
  `total_bytes` bigint(20) NOT NULL COMMENT '总流量',
  `time_long` int(11) NOT NULL COMMENT '总时长',
  `user_login_count` tinyint(4) NOT NULL COMMENT '本日上网总次数',
  `user_group_id` smallint(6) DEFAULT NULL COMMENT '用户组ID',
  PRIMARY KEY (`detail_day_id`),
  KEY `record_day` (`record_day`),
  KEY `total_bytes` (`total_bytes`),
  KEY `user_name` (`user_name`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='日表';

--
-- 记录销户用户的产品实例
--
CREATE TABLE IF NOT EXISTS `user_products_deleted` (
  `products_deleted_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL,
  `user_id` bigint(20) NOT NULL DEFAULT 0,
  `products_id` bigint(20) NOT NULL DEFAULT 0,
  `mobile_phone` varchar(64) NOT NULL,
  `user_available` tinyint(1),
  `user_balance` float(8,4),
  `sum_bytes` bigint(20),
  `sum_seconds` int(11),
  `sum_times` int(11),
  `saving_amount` float(8,4),
  `user_charge` float(8,4),
  `checkout_amount` float(8,4),
  `cur_time` int(11),
  PRIMARY KEY (`products_deleted_id`),
  KEY `user_name` (`user_name`),
  KEY `user_id` (`user_id`),
  KEY `products_id` (`products_id`),
  KEY `mobile_phone` (`mobile_phone`),
  KEY `user_available` (`user_available`),
  KEY `cur_time` (`cur_time`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 记录销户用户的套餐实例
--
CREATE TABLE IF NOT EXISTS `user_package_deleted` (
  `package_delete_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL,
  `user_id` bigint(20) NOT NULL DEFAULT 0,
  `products_id` bigint(20) NOT NULL DEFAULT 0,
  `package_id` bigint(20) NOT NULL DEFAULT 0,
  `billing_id` bigint(20) NOT NULL DEFAULT 0,
  `user_package_id` bigint(20) NOT NULL DEFAULT 0,
  `bytes` bigint(20),
  `seconds` int(11),
  `remain_bytes` bigint(20),
  `remain_seconds` int(11),
  `add_time` int(11),
  `expire_time` int(11),
  `cur_time` int(11),
  PRIMARY KEY (`package_delete_id`),
  KEY `user_name` (`user_name`),
  KEY `user_id` (`user_id`),
  KEY `products_id` (`products_id`),
  KEY `cur_time` (`cur_time`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 上网明细月表
--
CREATE TABLE IF NOT EXISTS `srun_detail_month` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL COMMENT '用户名',
  `record_day` int(11) NOT NULL COMMENT '记录日期',
  `bytes_in` bigint(20) NOT NULL COMMENT '入流量',
  `bytes_out` bigint(20) NOT NULL COMMENT '出流量',
  `bytes_in6` bigint(20) NOT NULL COMMENT 'V6入流量',
  `bytes_out6` bigint(20) NOT NULL COMMENT 'V6出流量',
  `products_id` smallint(6) NOT NULL COMMENT '产品id',
  `billing_id` smallint(6) NOT NULL COMMENT '计费策略id',
  `control_id` smallint(6) NOT NULL COMMENT '控制策略id',
  `user_balance` float DEFAULT NULL COMMENT '当前余额',
  `total_bytes` bigint(20) NOT NULL COMMENT '总流量',
  `time_long` int(11) NOT NULL COMMENT '总时长',
  `user_login_count` tinyint(4) NOT NULL COMMENT '本日上网总次数',
  `user_group_id` smallint(6) DEFAULT NULL COMMENT '用户组ID',
  PRIMARY KEY (`id`),
  KEY `record_day` (`record_day`),
  KEY `total_bytes` (`total_bytes`),
  KEY `user_name` (`user_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='月表' AUTO_INCREMENT=1 ;

--
-- 区域对应表
--
CREATE TABLE IF NOT EXISTS `ip_corresponding` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT '区域对应ID',
  `login_user` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '最近登陆用户账号',
  `user_mac` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '用户MAC地址',
  `device_ip` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '接入设备管理ip',
  `switch_port` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '接入交换机端口',
  `device_type` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT '接入设备类型',
  `in_vlan` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '内vlan',
  `out_vlan` varchar(20) COLLATE utf8_unicode_ci NOT NULL COMMENT '外vlan',
  `qinq` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT 'qinq（内外vlan）',
  `cdevice_ip` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT '汇聚设备管理ip',
  `cdevice_type` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '汇聚设备类型',
  `power` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '配电间',
  `locations` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '物理位置',
  `install` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '设备安装位置',
  `created_at` int(11) NOT NULL COMMENT '创建时间',
  `updated_at` int(11) NOT NULL COMMENT '修改时间',
  PRIMARY KEY (`cid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- 转账表
--
CREATE TABLE `transfer_balance` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `transfer_num` float(8,2) NOT NULL COMMENT '转账金额',
  `user_name_from` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '源用户名',
  `user_name_to` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '目的用户名',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '转账类型：0：电子钱包转产品',
  `product_id` smallint(6) NOT NULL DEFAULT '0' COMMENT '产品id',
  `package_id` smallint(6) NOT NULL DEFAULT '0' COMMENT '套餐id',
  `create_at` int(11) NOT NULL DEFAULT '0' COMMENT '操作时间',
  `mgr_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '管理员',
  `operator_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '操作员用户名（用户自己操作）',
  PRIMARY KEY (`id`),
  KEY `index` (`user_name_from`,`user_name_to`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `efficiency_report_point` (
	`time_point` int(11) NOT NULL,
	PRIMARY KEY (`time_point`)
)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE IF NOT EXISTS `efficiency_report` (
  `report_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time_point` int(11) NOT NULL,
  `my_ip` varchar(16) NOT NULL,
  `proc` varchar(32) NOT NULL,
  `start_count` bigint(20) NOT NULL,
  `start_response_time` float(8,4) NOT NULL,
  `update_count` bigint(20) NOT NULL,
  `update_response_time` float(8,4) NOT NULL,
  `stop_count` bigint(20) NOT NULL,
  `stop_response_time` float(8,4) NOT NULL,
  `auth_count` bigint(20) NOT NULL,
  `auth_response_time` float(8,4) NOT NULL,
  `coa_count` bigint(20) NOT NULL,
  `coa_response_time` float(8,4) NOT NULL,
  `dm_count` bigint(20) NOT NULL,
  `dm_response_time` float(8,4) NOT NULL,
  PRIMARY KEY (`report_id`),
  KEY `time_point` (`time_point`),
  KEY `my_ip` (`my_ip`),
  KEY `proc` (`proc`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 服务器设置表的结构 `setting_server`
--
CREATE TABLE IF NOT EXISTS `setting_server` (
`id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `ip` varchar(30) COLLATE utf8_unicode_ci NOT NULL COMMENT '服务器IP地址',
  `devicename` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '设备名称',
  `type` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '设备类型',
  `admin` int(11) NOT NULL COMMENT '管理员',
  `region` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '区域',
  `fault` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '故障',
  `configure` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '配置',
  `addtime` int(11) NOT NULL COMMENT '添加时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- 区域结构 `region_group`
--

DROP TABLE IF EXISTS `region_group`;
CREATE TABLE IF NOT EXISTS `region_group` (
  `id` smallint (6) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_unicode_ci NOT NULL COMMENT '结构名称',
  `path` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '结构路径',
  `pid` smallint (6) NOT NULL DEFAULT '1' COMMENT '父ID',
  `level` tinyint(3) NOT NULL DEFAULT '1' COMMENT '组织递进',
  `status` tinyint(2) NOT NULL DEFAULT '1' COMMENT '状态',
  `tid` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '节点Tid',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- 区域结构表中的数据 `region_group`
--

INSERT INTO `region_group` (`id`, `name`, `path`, `pid`, `level`, `status`, `tid`) VALUES
(1, '/', '0', 0, 1, 1, '');

--
-- 移动支付表的结构 `alipay_8001`
--

CREATE TABLE IF NOT EXISTS `alipay_8001` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `notify_time` int(11) NOT NULL,
  `trade_no` varchar(64) COLLATE utf8_unicode_ci NOT NULL,
  `trade_status` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `seller_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `seller_email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `buyer_id` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `buyer_email` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `total_fee` float NOT NULL DEFAULT '0',
  `body` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='支付宝移动支付返回数据' AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

--
-- 创建用户互动表`user_clound_interaction`
--
CREATE TABLE IF NOT EXISTS `user_clound_interaction`(
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY  KEY,
  `question_type` ENUM('1', '2', '3', '4') NOT NULL DEFAULT '1' COMMENT '问题类型1系统使用，2系统BUG，3功能改进，4需求建议',
  `question_title` VARCHAR(32) NOT NULL COMMENT '问题标题',
  `question_content` TEXT NOT NULL COMMENT '投诉内容',
  `question_description` TEXT NOT NULL COMMENT '问题描述',
  `question_answer` TEXT NOT NULL DEFAULT '' COMMENT '问题答案',
  `question_pub_at` INT UNSIGNED NOT NULL COMMENT '问题发布时间',
  `question_state` ENUM('0', '1') NOT NULL DEFAULT '0' COMMENT '问题状态是否解决0未解决1解决',
  `question_solution_time` INT UNSIGNED NOT NULL COMMENT '投诉解决时间',
  `products_key` VARCHAR(30) NOT NULL DEFAULT '' COMMENT '云端账号鉴别',
   KEY `user_clound_interaction_question_type`(`question_type`),
   KEY `user_clound_interaction_question_pub`(`question_pub_at`),
   KEY `products_key`(`products_key`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户互动表';

--
-- 创建用户投诉表`user_clound_complaints`
--
CREATE TABLE IF NOT EXISTS `user_clound_complaints`(
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY  KEY,
  `bug_type` ENUM('1','2','3','4','5') NOT NULL DEFAULT '5' COMMENT '投诉类型1问题长时间没处理2电话未接3现场工程师怠工4产品功能不完善5BUG未解决',
  `bug_title` VARCHAR(32) NOT NULL COMMENT '投诉标题',
  `bug_content` TEXT NOT NULL COMMENT '投诉内容',
  `bug_pub_at` INT UNSIGNED NOT NULL COMMENT '投诉发布时间',
  `bug_target` VARCHAR(32) NOT NULL DEFAULT '' COMMENT '投诉目标',
  `bug_attach` VARCHAR(255) NOT NULL DEFAULT '' COMMENT 'bug附件',
  `hope_process_time` VARCHAR(20) NOT NULL DEFAULT '' COMMENT '希望处理时间',
  `bug_state` ENUM('0', '1') NOT NULL DEFAULT '0' COMMENT 'bug状态是否解决0未解决1解决',
  `bug_solution` TEXT NOT NULL DEFAULT '' COMMENT 'bug解决办法',
  `bug_solution_time` int(11) NOT NULL  COMMENT 'bug处理时间',
  `products_key` VARCHAR(30) NOT NULL DEFAULT '' COMMENT '云端账号鉴别',
  KEY `user_clound_interaction_bug_type`(`bug_type`),
  KEY `user_clound_complaints_bug_pub`(`bug_pub_at`),
  KEY `products_key`(`products_key`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户投诉表';

--
-- 创建key批次表`key_batch`
--
CREATE TABLE IF NOT EXISTS `key_batch`(
  `key_id` VARCHAR(64) NOT NULL PRIMARY KEY COMMENT '批次主键',
  `module_id` VARCHAR(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '模板id',
  `file_address` VARCHAR(255)  COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '批次文件地址',
  `used_number` SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '使用个数',
  `unused_number` SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '未使用个数',
  `expire_number` SMALLINT UNSIGNED NOT NULL DEFAULT 0 COMMENT  '过期个数',
  `create_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '批次创建时间',
  `update_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '批次更新时间',
  `mgr_name` VARCHAR(32) COLLATE utf8_unicode_ci NOT NULL DEFAULT  '' COMMENT '操作人',
  KEY `module_id`(`module_id`),
  KEY  `used_number`(`used_number`),
  KEY  `unused_number`(`unused_number`),
  KEY  `expire_number`(`expire_number`),
  KEY  `create_time`(`used_number`),
  KEY  `update_time`(`update_time`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  COMMENT='key批量生成表';


--
-- 创建管理远登录表`manager_login_log`
--
DROP TABLE  IF EXISTS  `manager_login_log`;
CREATE TABLE IF NOT EXISTS `manager_login_log`(
  `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '主键id',
  `user_id` INT NOT NULL DEFAULT 0 COMMENT '管理员登录id',
  `manager_name` VARCHAR(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT  '' COMMENT '管理员名称',
  `ip` VARCHAR(64)  COLLATE utf8_unicode_ci  NOT NULL DEFAULT '' COMMENT '登录ip',
  `login_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录时间',
  KEY `manager_name`(`manager_name`),
  KEY `login_time`(`login_time`),
  KEY `user_id`(`user_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  AUTO_INCREMENT = 1 COMMENT='管理员登录日志表';

--
-- 动态条件
--
CREATE TABLE IF NOT EXISTS `condition` (
  `id` smallint(6) NOT NULL AUTO_INCREMENT COMMENT '动态条件keyid',
  `condition_name` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '条件名称',
  `condition_key` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'key',
  PRIMARY KEY (`id`),
  UNIQUE KEY `condition_key` (`condition_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 创建云端认证日志表`clound_srun_login_log`
--
DROP  TABLE IF EXISTS  `clound_srun_login_log`;
CREATE TABLE `clound_srun_login_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_key` VARCHAR(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '云端账号鉴别',
  `error_count` INT  UNSIGNED NOT NULL DEFAULT 0 COMMENT '错误总数',
  `error_count1` INT  UNSIGNED NOT NULL DEFAULT 0 COMMENT '账户不存在错误总数',
  `error_count2` INT  UNSIGNED NOT NULL DEFAULT 0 COMMENT '密码错误总数',
  `error_count3` INT  UNSIGNED NOT NULL DEFAULT 0 COMMENT '计费策略错误总数',
  `error_count4` INT  UNSIGNED NOT NULL DEFAULT 0 COMMENT '控制策略错误总数',
  `statistics_time` int(11) NOT NULL COMMENT '统计时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `product_key_time`(`product_key`, `statistics_time`),
  KEY `products_key`(`product_key`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='云端认证日志表';

--
-- 创建支付宝表
--

CREATE TABLE IF NOT EXISTS `alipay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `out_trade_no` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '订单号',
  `money` float(8,2) NOT NULL,
  `type` int(11) NOT NULL COMMENT '0:余额,其余为产品ID',
  `buy_time` int(11) NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0：失败,1：成功',
  `payment` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `trade_no` varchar(32) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '支付宝交易号',
  `remark` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `trade_unique` (`out_trade_no`),
  KEY `user_name` (`user_name`),
  KEY `type` (`type`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 表的结构 `security_questions`
--

CREATE TABLE IF NOT EXISTS `security_questions` (
	`id` int(11) NOT NULL AUTO_INCREMENT,
	`question_name` varchar(255) NOT NULL,
	PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 转存表中的数据 `security_questions`
--

INSERT INTO `security_questions` (`id`, `question_name`) VALUES
(1, '你父亲的名字是?'),
(2, '你母亲的名字是?'),
(3, '你父亲的生日是?'),
(4, '你母亲的生日是?'),
(5, '你小学的班主任是?'),
(6, '你初中的班主任是?'),
(7, '你高中的班主任是?'),
(8, '你的童年好友是?'),
(9, '对你影响最大的一个人是?');

--
-- 表的结构 `register`
--

CREATE TABLE IF NOT EXISTS `register` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_password` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_real_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `product` int(11) NOT NULL,
  `group_id` smallint(6) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '0:待审核1:审核不通过',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `tip_message` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1;

--
-- 表的结构 `visitors`
-- 针对关联访客和批量导入访客
--

CREATE TABLE IF NOT EXISTS `visitors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL,
  `teacher_num` varchar(32) NOT NULL,
  `cert_num` varchar(32) NOT NULL,
  `real_name` varchar(32) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `start_time` int(11) NOT NULL DEFAULT '0',
  `end_time` int(11) DEFAULT '0',
  `creat_time` int(11) NOT NULL,
  `import` tinyint(1) NOT NULL DEFAULT '0',
  `worked` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `worked` (`worked`),
  KEY `import` (`import`),
  KEY `start_time` (`start_time`),
  KEY `teacher_num` (`teacher_num`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 表的结构 `pause_checkout`
--

CREATE TABLE IF NOT EXISTS `pause_checkout` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `user_id` int(20) NOT NULL,
  `products_id` int(11) NOT NULL,
  `checkout_date` int(11) NOT NULL,
  `balance_start` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `products_id` (`products_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 管理发送消息存储
-- 表的结构 `send_message`
--

CREATE TABLE IF NOT EXISTS `send_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` varchar(32) NOT NULL COMMENT '接收账号,{SRUN_ALL_REGISTER_USERS}:所有注册账号,{SRUN_ALL_ONLINE_USERS}:所有在线账号，单个账号名字',
  `receiver` tinyint(1) NOT NULL COMMENT '接收者,1:所有在线用户，2:所有注册用户,3:单个用户',
  `targets` varchar(256) DEFAULT NULL COMMENT '接收组，单个账号无效',
  `receive_type` varchar(24) DEFAULT NULL COMMENT '接收方式:weixin,client,',
  `subject` varchar(256) DEFAULT NULL COMMENT '消息内容',
  `create_time` int(11) NOT NULL DEFAULT '0',
  `manager` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 所有数据均为5分钟内数据量,建议曲线方式展现
--
CREATE TABLE IF NOT EXISTS `net_status` (
  `id` 				int NOT NULL AUTO_INCREMENT,
  `device_ip` 		varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '设备主ip',
  `eth_name` 		varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '网卡名称',
  `recv_bytes` 		bigint NOT NULL DEFAULT '0' COMMENT '接收字节数',
  `send_bytes` 		bigint NOT NULL DEFAULT '0' COMMENT '发送字节数',
  `recv_ptks` 		bigint NOT NULL DEFAULT '0' COMMENT '接收数据包数',
  `send_ptks` 		bigint NOT NULL DEFAULT '0' COMMENT '发送数据包数',
  `error_in_ptks` 	bigint NOT NULL DEFAULT '0' COMMENT '接收出错数',
  `error_out_ptks` 	bigint NOT NULL DEFAULT '0' COMMENT '发送出错数',
  `drop_in_ptks` 	bigint NOT NULL DEFAULT '0' COMMENT '接收丢包数',
  `drop_out_ptks` 	bigint NOT NULL DEFAULT '0' COMMENT '发送丢包数',
  `time` 			bigint NOT NULL COMMENT '数据更新时间，unix时间',
  PRIMARY KEY (`id`),
  KEY `index` (`device_ip`, `eth_name`),
  KEY `idx_eth_name` (`eth_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- 所有数据为当前状态，建议进度条或者饼图方式展现
--
CREATE TABLE IF NOT EXISTS `partitions_status` (
  `id` 				int NOT NULL AUTO_INCREMENT,
  `device_ip` 		varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '设备主IP',
  `partition_name` 	varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '分区名称',
  `mount_point` 	varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '挂载目录',
  `total_bytes` 	bigint NOT NULL DEFAULT '0' COMMENT '分区大小，字节数',
  `free_bytes` 		bigint NOT NULL DEFAULT '0' COMMENT '分区剩余空间，字节数',
  `used_percent` 	double NOT NULL DEFAULT '0' COMMENT '使用百分百，已经x100了',
  `time` 			bigint NOT NULL COMMENT '数据更新时间，unix时间',
  PRIMARY KEY (`id`),
  KEY `index` (`device_ip`),
  KEY `idx_partition_name` (`partition_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;


--
-- 所有数据均为5分钟内数据量,建议曲线方式展现
--
CREATE TABLE IF NOT EXISTS `net_connections_status` (
  `id` 				int NOT NULL AUTO_INCREMENT,
  `device_ip` 		varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '设备主IP',
  `time` 			bigint NOT NULL COMMENT '数据更新时间，unix时间',
  `port80` 			int NOT NULL DEFAULT '0' COMMENT '80端口总连接数',
  `port80-est` 		int NOT NULL DEFAULT '0' COMMENT '80端口活动连接数',
  `port8080` 		int NOT NULL DEFAULT '0',
  `port8080-est` 	int NOT NULL DEFAULT '0',
  `port8081` 		int NOT NULL DEFAULT '0',
  `port8081-est` 	int NOT NULL DEFAULT '0',
  `port8800` 		int NOT NULL DEFAULT '0',
  `port8800-est` 	int NOT NULL DEFAULT '0',
  `port69` 			int NOT NULL DEFAULT '0',
  `port69-est` 		int NOT NULL DEFAULT '0',
  `port8069` 		int NOT NULL DEFAULT '0',
  `port8069-est` 	int NOT NULL DEFAULT '0',
  `port3306` 		int NOT NULL DEFAULT '0',
  `port3306-est` 	int NOT NULL DEFAULT '0',
  `port16380` 		int NOT NULL DEFAULT '0',
  `port16380-est` 	int NOT NULL DEFAULT '0',
  `port16381` 		int NOT NULL DEFAULT '0',
  `port16381-est` 	int NOT NULL DEFAULT '0',
  `port16382` 		int NOT NULL DEFAULT '0',
  `port16382-est` 	int NOT NULL DEFAULT '0',
  `port16383` 		int NOT NULL DEFAULT '0',
  `port16383-est` 	int NOT NULL DEFAULT '0',
  `port16384` 		int NOT NULL DEFAULT '0',
  `port16384-est` 	int NOT NULL DEFAULT '0',
  `port16385` 		int NOT NULL DEFAULT '0',
  `port16385-est` 	int NOT NULL DEFAULT '0',
  `port16386` 		int NOT NULL DEFAULT '0',
  `port16386-est` 	int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index` (`device_ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;


--
-- 所有数据均为5分钟内数据量,建议曲线方式展现
--
CREATE TABLE IF NOT EXISTS `system_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `device_ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '设备主IP',
  `time` 		bigint NOT NULL COMMENT '数据更新时间，unix时间',
  `cpu` 		double NOT NULL DEFAULT '0' COMMENT 'cpu占用百分比，已经x100了',
  `mem` 		double NOT NULL DEFAULT '0' COMMENT '内存占用百分比，已经x100了',
  `mem-cahced` 	double NOT NULL DEFAULT '0' COMMENT '缓存占用内存百分比，已经x100了',
  `loads` 		double NOT NULL DEFAULT '0' COMMENT '系统负载',
  `proccess` 	double NOT NULL DEFAULT '0' COMMENT '系统总进程数量',
  `httpd` 		double NOT NULL DEFAULT '0' COMMENT 'httpd进程数量',
  `stat2` 		double NOT NULL DEFAULT '0',
  `stat3` 		double NOT NULL DEFAULT '0',
  `stat4` 		double NOT NULL DEFAULT '0',
  `stat5` 		double NOT NULL DEFAULT '0',
  `stat6` 		double NOT NULL DEFAULT '0',
  `stat7` 		double NOT NULL DEFAULT '0',
  `stat8` 		double NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index` (`device_ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;


--
-- 所有数据均为5分钟内数据量,建议曲线方式展现
--

CREATE TABLE IF NOT EXISTS `disk_io_counters` (
  `id` 				int NOT NULL AUTO_INCREMENT,
  `device_ip` 		varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '设备主IP',
  `device_name` 	varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '设备名称',
  `read_count` 		bigint NOT NULL DEFAULT '0' COMMENT '读取次数',
  `write_count` 	bigint NOT NULL DEFAULT '0' COMMENT '写入次数',
  `read_bytes` 		bigint NOT NULL DEFAULT '0' COMMENT '读取字节数',
  `write_bytes` 	bigint NOT NULL DEFAULT '0' COMMENT '写入字节数',
  `read_time` 		bigint NOT NULL DEFAULT '0' COMMENT '读取耗时，毫秒',
  `write_time` 		bigint NOT NULL DEFAULT '0' COMMENT '写入耗时，毫秒',
  `io_time` 		bigint NOT NULL DEFAULT '0' COMMENT 'I/O操作耗时，毫秒',
  `time` 			bigint NOT NULL COMMENT '数据更新时间，unix时间',
  PRIMARY KEY (`id`),
  KEY `index` (`device_ip`),
  KEY `idx_device_name` (`device_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;


--
-- 所有数据均为5分钟内数据量,建议曲线方式展现
--

CREATE TABLE IF NOT EXISTS `process_io_counters` (
  `id` 				int NOT NULL AUTO_INCREMENT,
  `device_ip` 		varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '设备主IP',
  `process_name` 	varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '进程名称',
  `read_count` 		bigint NOT NULL DEFAULT '0' COMMENT '读取次数',
  `write_count` 	bigint NOT NULL DEFAULT '0' COMMENT '写入次数',
  `read_bytes` 		bigint NOT NULL DEFAULT '0' COMMENT '读取字节数',
  `write_bytes` 	bigint NOT NULL DEFAULT '0' COMMENT '写入字节数',
  `cpu_perncent` 	double NOT NULL DEFAULT '0' COMMENT 'CPU占用百分比',
  `mem_percent` 	double NOT NULL DEFAULT '0' COMMENT '内存占用百分比',
  `iowait` 			double NOT NULL DEFAULT '0' COMMENT 'IOWait占用百分比',
  `time` 			bigint NOT NULL COMMENT '数据更新时间，unix时间',
  PRIMARY KEY (`id`),
  KEY `index` (`device_ip`),
  KEY `idx_process_name` (`process_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;