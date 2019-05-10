--
-- 扩展字段添加默认值
--
ALTER TABLE `extends_field` ADD `default_value` VARCHAR(255) NOT NULL COMMENT '默认值' AFTER `show_type`;
ALTER TABLE waiting_checkout ADD `balance_start` INT(10) NOT NULL DEFAULT '0';
ALTER TABLE  `checkout_list` ADD  `rt_spend_num` FLOAT NOT NULL DEFAULT  '0' COMMENT  '产品实时消费金额' AFTER  `spend_num`;
ALTER TABLE  `users` ADD  `mobile_phone` CHAR( 16 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '手机号';
ALTER TABLE  `users` ADD  `mobile_password` CHAR( 64 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '手机密码';
RENAME TABLE `users_bak` TO `users_open_log`;
ALTER TABLE `users` DROP `mobile_phone`;
ALTER TABLE `users` DROP `mobile_password`;
ALTER TABLE  `refund_list` ADD  `is_refund_fee` TINYINT( 1 ) NOT NULL DEFAULT  '0' COMMENT  '产品退费是否退包月费0-不退1-退' AFTER  `product_id`;
ALTER TABLE `pay_list` ADD COLUMN `user_real_name`  varchar(64) NOT NULL AFTER `user_name`;
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
INSERT INTO `setting` (`key`, `value`) VALUES ('changeProDed', 'allfee');

CREATE TABLE IF NOT EXISTS `portal` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logo` text NOT NULL,
  `top_banner` text NOT NULL,
  `banner` text NOT NULL,
  `footer` text NOT NULL,
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型(1pc 2移动端)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='portal' AUTO_INCREMENT=10 ;

ALTER TABLE  `extends_field` ADD  `rule` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NULL DEFAULT NULL COMMENT  '规则' AFTER  `default_value`;

ALTER TABLE srun_detail
ADD class_name varchar(64) NOT NULL DEFAULT '' COMMENT '系统类型',
ADD os_name varchar(64) NOT NULL DEFAULT '' COMMENT '系统名称',
ADD pc_num int(8) NOT NULL DEFAULT 0 COMMENT 'PC数量',
ADD mobile_num int(8) NOT NULL DEFAULT 0 COMMENT '移动终端数量',
ADD sensitivity int(8) NOT NULL DEFAULT 0 COMMENT '可疑度',
ADD proxy_desc varchar(128) NOT NULL DEFAULT '' COMMENT '代理信息';
CREATE INDEX idx_class_name ON srun_detail (class_name);
CREATE INDEX idx_sensitivity ON srun_detail (sensitivity);
DROP INDEX `index` ON srun_detail;
CREATE INDEX idx_add_time ON srun_detail (add_time);
CREATE INDEX idx_user_name ON srun_detail (user_name);
CREATE INDEX idx_user_ip ON srun_detail (user_ip);
CREATE INDEX idx_user_mac ON srun_detail (user_mac);
CREATE INDEX idx_products_id ON srun_detail (products_id);
CREATE INDEX idx_billing_id ON srun_detail (billing_id);
CREATE INDEX idx_vlan_id ON srun_detail (vlan_id);
CREATE INDEX idx_nas_port_id ON srun_detail (nas_port_id);
CREATE INDEX idx_ip_type ON srun_detail (ip_type);
CREATE INDEX idx_drop_time ON srun_detail (drop_time);

ALTER TABLE  `pay_list` ADD  `bill_number` CHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT  '流水号' AFTER  `mgr_name`;
ALTER TABLE  `pay_list` ADD  `print_num` SMALLINT( 5 ) NOT NULL DEFAULT  '0' COMMENT  '打印次数' AFTER  `bill_number`;
--
-- 更新用户组的 主键 大小
--
ALTER TABLE `users_group` CHANGE `id` `id` SMALLINT NOT NULL AUTO_INCREMENT;
--
-- 更新用户组的 pid 大小
--
ALTER TABLE `users_group` CHANGE `pid` `pid` SMALLINT NOT NULL DEFAULT '1' COMMENT '父ID';

--
-- 表的结构 `register`
--

CREATE TABLE IF NOT EXISTS `register` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_password` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `user_real_name` varchar(20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  `group_id` smallint(6) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '0:待审核1:审核不通过',
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `tip_message` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_name` (`user_name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;
ALTER TABLE `srun4k`.`register` ADD `product` INT NOT NULL AFTER `user_real_name`;

ALTER TABLE  `services_group_setting` ADD  `short_visitor_setting` VARCHAR(256) NULL DEFAULT NULL COMMENT  '短期访客配置';
ALTER TABLE  `services_group_setting` ADD  `long_visitor_setting` VARCHAR(256) NULL DEFAULT NULL COMMENT  '长期访客配置';

--
-- 表的结构 `online_summary_report`
--
CREATE TABLE IF NOT EXISTS `online_summary_report` (
  `time` int(11) unsigned NOT NULL,
  `online_number` int(11) NOT NULL,
  PRIMARY KEY (`time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
ALTER TABLE  `extends_field` ADD  `field_type` TINYINT( 1 ) NOT NULL DEFAULT  '0' COMMENT  '字段类型0：普通字段1：内置字段2：隐藏字段（如密保）' AFTER  `sort`;
ALTER TABLE  `pay_type` ADD  `is_del` TINYINT( 1 ) NOT NULL DEFAULT  '0' COMMENT  '是否删除0：未删除1：删除' AFTER  `mgr_name`;


--
-- 设备状态表
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
  KEY `index` (`device_ip`, `eth_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;


--
-- 分区状态表
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
  KEY `index` (`device_ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1;

--
-- 服务连接状态
-- 所有数据均为5分钟内数据量,建议曲线方式展现
--
CREATE TABLE IF NOT EXISTS `net_connections_status` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `device_ip` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '设备主IP',
  `time` bigint(20) NOT NULL COMMENT '数据更新时间，unix时间',
  `port80` int(11) NOT NULL DEFAULT '0' COMMENT '80端口总连接数',
  `port80-est` int(11) NOT NULL DEFAULT '0' COMMENT '80端口活动连接数',
  `port8080` int(11) NOT NULL DEFAULT '0',
  `port8080-est` int(11) NOT NULL DEFAULT '0',
  `port8081` int(11) NOT NULL DEFAULT '0',
  `port8081-est` int(11) NOT NULL DEFAULT '0',
  `port8800` int(11) NOT NULL DEFAULT '0',
  `port8800-est` int(11) NOT NULL DEFAULT '0',
  `port69` int(11) NOT NULL DEFAULT '0',
  `port69-est` int(11) NOT NULL DEFAULT '0',
  `port8069` int(11) NOT NULL DEFAULT '0',
  `port8069-est` int(11) NOT NULL DEFAULT '0',
  `port3306` int(11) NOT NULL DEFAULT '0',
  `port3306-est` int(11) NOT NULL DEFAULT '0',
  `port16380` int(11) NOT NULL DEFAULT '0',
  `port16380-est` int(11) NOT NULL DEFAULT '0',
  `port16381` int(11) NOT NULL DEFAULT '0',
  `port16381-est` int(11) NOT NULL DEFAULT '0',
  `port16382` int(11) NOT NULL DEFAULT '0',
  `port16382-est` int(11) NOT NULL DEFAULT '0',
  `port16383` int(11) NOT NULL DEFAULT '0',
  `port16383-est` int(11) NOT NULL DEFAULT '0',
  `port16384` int(11) NOT NULL DEFAULT '0',
  `port16384-est` int(11) NOT NULL DEFAULT '0',
  `port16385` int(11) NOT NULL DEFAULT '0',
  `port16385-est` int(11) NOT NULL DEFAULT '0',
  `port16386` int(11) NOT NULL DEFAULT '0',
  `port16386-est` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `index` (`device_ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

--
-- 系统状态
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
  `manager` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- 更新 send_message表结构
--
ALTER TABLE `send_message` ADD `create_time` int(11) NOT NULL DEFAULT '0' AFTER `subject`;

--
-- 增加管理员对 portal 模板的管理
--
ALTER TABLE `manager` ADD `mgr_portal` VARCHAR(255) NOT NULL COMMENT '可管理的portal 页面' AFTER `mgr_admin`;
ALTER TABLE `portal` ADD `portal_name` VARCHAR(50) NOT NULL COMMENT '模板名称' AFTER `id`;
ALTER TABLE `portal` ADD `examples_name` varchar(50) NOT NULL COMMENT '实例名称' AFTER `portal_name`;
ALTER TABLE `portal` ADD `pid` mediumint(9) NOT NULL COMMENT '创建人' AFTER `examples_name`;

--
-- 增加扩展字段提示语字段
--
ALTER TABLE  `extends_field` ADD  `field_hint` VARCHAR( 255 ) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT  '扩展字段提示内容' AFTER  `field_type`;

--
-- 用户产品实例
-- 表的结构 `user_products`
--
CREATE TABLE IF NOT EXISTS `user_products` (
  `user_products_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(64) NOT NULL,
  `user_id` bigint(20) NOT NULL DEFAULT 0,
  `products_id` bigint(20) NOT NULL DEFAULT 0,
  `mobile_phone` varchar(64) NOT NULL,
  `user_available` tinyint(1),
  PRIMARY KEY (`user_products_id`),
  KEY `user_name` (`user_name`),
  KEY `user_id` (`user_id`),
  KEY `products_id` (`products_id`),
  KEY `mobile_phone` (`mobile_phone`),
  KEY `user_available` (`user_available`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
ALTER TABLE `user_products` ADD `user_balance` FLOAT (8,2);

--
-- 删除旧的在线表,采用新的
--
DROP TABLE IF EXISTS `online_summary_report`;

--
-- 用于在线统计的表
--
CREATE TABLE IF NOT EXISTS `online_report_point` (
	`time_point` int(11) NOT NULL,
	`count` int(11) NOT NULL,
	PRIMARY KEY (`time_point`)
)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- online_report_products
--
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

--
-- online_report_billing
--
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

--
-- online_report_control
--
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

--
-- online_report_group
--
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

--
-- online_report_class_name
--
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

--
-- online_report_os_name
--
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

--
-- online_report_nas_ip
--
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

--
-- srun_detail_day
--
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
-- 认证日志，系统日志增加时间索引
--
ALTER TABLE `srun_login_log` ADD INDEX user_name ( `user_name` );
ALTER TABLE `srun_login_log` ADD INDEX user_ip ( `user_ip` );
ALTER TABLE `srun_login_log` ADD INDEX user_mac ( `user_mac` );
ALTER TABLE `srun_login_log` ADD INDEX nas_port_id ( `nas_port_id` );
ALTER TABLE `srun_login_log` ADD INDEX log_time ( `log_time` );

ALTER TABLE `srun_system_log` ADD INDEX user_name ( `user_name` );
ALTER TABLE `srun_system_log` ADD INDEX user_ip ( `user_ip` );
ALTER TABLE `srun_system_log` ADD INDEX user_mac ( `user_mac` );
ALTER TABLE `srun_system_log` ADD INDEX nas_port_id ( `nas_port_id` );
ALTER TABLE `srun_system_log` ADD INDEX log_time ( `log_time` );
ALTER TABLE `srun_system_log` ADD INDEX proc ( `proc` );
ALTER TABLE `srun_system_log` ADD INDEX nas_ip ( `nas_ip` );
ALTER TABLE `srun_system_log` ADD INDEX my_ip ( `my_ip` );

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

--
-- 管理员表增加手机号字段
--
ALTER TABLE `manager` ADD `mobile_phone` varchar (20) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '手机号' AFTER `email`;

--
-- 业务监控及性能报告
--
CREATE TABLE IF NOT EXISTS `efficiency_report_point` (
	`time_point` int(11) NOT NULL,
	PRIMARY KEY (`time_point`)
)ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 业务监控表
--
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
-- 充值卡卡号设置唯一索引
--
ALTER TABLE `srun4k`.`saving_card` ADD UNIQUE(`ka_card_num`);

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

--
-- 中间表 `ly_im_news_outsideorg`
--
 CREATE TABLE  IF NOT EXISTS `ly_im_news_outsideorg` (
  `xlh` varchar(160) COLLATE utf8_unicode_ci NOT NULL,
  `jrd_dm` varchar(160) COLLATE utf8_unicode_ci NOT NULL COMMENT '接入端代码',
  `jrd_mm` varchar(160) COLLATE utf8_unicode_ci NOT NULL COMMENT '接入端密码',
  `fsr` varchar(50) COLLATE utf8_unicode_ci NOT NULL COMMENT '发送人id',
  `jsr` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '接收人手机、邮件、IM',
  `bt` varchar(255) COLLATE utf8_unicode_ci NOT NULL COMMENT '标题',
  `nr`  TEXT  COLLATE utf8_unicode_ci NOT NULL COMMENT '内容',
  `jsqd` varchar(160) COLLATE utf8_unicode_ci NOT NULL COMMENT '接入渠道 mail电子邮件ocs表示即时通讯swpuSms表示西南石油大学短信',
  `mp_zt` varchar(160) COLLATE utf8_unicode_ci NOT NULL DEFAULT '-1' COMMENT '移动校园发送状态0发送-1未发送',
  `im_zt` varchar(160) COLLATE utf8_unicode_ci DEFAULT '-1' COMMENT '即时通渠道的发送状态0发送-1未发送',
  `sms_zt` varchar(160) COLLATE utf8_unicode_ci DEFAULT '-1' COMMENT '即短信渠道的发送状态0发送-1未发送',
  `mail_zt` varchar(160) COLLATE utf8_unicode_ci DEFAULT '-1' COMMENT '即邮件渠道的发送状态0发送-1未发送',
  `jsrxm` varchar(512) COLLATE utf8_unicode_ci NOT NULL COMMENT '接收人信息',
  `cjsj` varchar(19) COLLATE utf8_unicode_ci NOT NULL DEFAULT '' COMMENT '创建时间',
  PRIMARY KEY (`xlh`),
  KEY `ly_im_news_outsideorg_fsr` (`fsr`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='业务系统信息中间表';

--
-- 修改ip区域管理表 ip_area
--
ALTER TABLE  `ip_area` MODIFY `area_ip_end` BIGINT NOT NULL DEFAULT 0;
ALTER TABLE  `ip_area` MODIFY `area_ip_start` BIGINT NOT NULL DEFAULT 0;

--
-- 修改区域列表 rad_user_area
--
ALTER TABLE   `rad_user_area` MODIFY `vlan_id` VARCHAR(50) NOT NULL DEFAULT '';

--
-- 修改manager表 ip区域限制 格式为192.168.1.1-255， 127.0.0.1
--
ALTER TABLE `manager` ADD `ip_area` VARCHAR(255) NOT NULL DEFAULT  '';

--
-- 表的结构 `ipBindingToken`
--
ALTER TABLE `ipBindingToken`  ADD `name` VARCHAR(64) NOT NULL ,  ADD `api_action` TEXT NULL DEFAULT NULL ,  ADD `app_action` TEXT NULL DEFAULT NULL ;

--
-- 创建云端监控表`clound_monitor`
--
CREATE TABLE IF NOT EXISTS `clound_monitor`(
  `report_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time_point` int(11) NOT NULL,
  `my_ip` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `proc` varchar(32) COLLATE utf8_unicode_ci NOT NULL COMMENT '进程名称',
  `start_count` bigint(20) NOT NULL,
  `start_response_time` float(8,4) NOT NULL COMMENT '开始响应时间',
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
  `products_key` VARCHAR(30) NOT NULL DEFAULT '' COMMENT '云端账号鉴别',
  PRIMARY KEY (`report_id`),
  KEY `time_point` (`time_point`),
  KEY `my_ip` (`my_ip`),
  KEY `proc` (`proc`),
  KEY `products_key`(`products_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='云端监控表';

CREATE TABLE IF NOT EXISTS  `clound_efficiency_report_point` (
  `time_point` int(11) NOT NULL,
   `products_key` VARCHAR(30) NOT NULL DEFAULT '' COMMENT '云端账号鉴别',
   UNIQUE KEY `points`(`time_point`, `products_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
  `products_key` VARCHAR(30) NOT NULL DEFAULT '' COMMENT '云端账号鉴别',
  KEY `user_clound_interaction_bug_type`(`bug_type`),
  KEY `user_clound_complaints_bug_pub`(`bug_pub_at`),
  KEY `products_key`(`products_key`),
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='用户投诉表';

--
-- 用户交流表添加字段user_clound_interaction
--
ALTER TABLE `user_clound_interaction` DROP `user_id`;
ALTER TABLE `user_clound_interaction` ADD `question_state` ENUM('0', '1') NOT NULL DEFAULT '0' COMMENT '问题状态是否解决0未解决1解决' AFTER `question_pub_at` ;
ALTER TABLE `user_clound_interaction` ADD `question_content` TEXT NOT NULL COMMENT '投诉内容' AFTER `question_title`;
ALTER TABLE `user_clound_interaction` ADD `question_solution_time` INT UNSIGNED NOT NULL COMMENT '投诉解决时间' AFTER `question_state`;

--
-- 用户投诉表添加字段user_clound_complaints
--
ALTER TABLE `user_clound_complaints` DROP `user_id`;
ALTER TABLE `user_clound_complaints` ADD `bug_state` ENUM('0', '1') NOT NULL DEFAULT '0' COMMENT 'bug状态是否解决0未解决1解决' AFTER `hope_process_time`;
ALTER TABLE `user_clound_complaints` ADD `bug_solution` TEXT NOT NULL DEFAULT '' COMMENT 'bug解决办法' AFTER `bug_state`;
ALTER TABLE `user_clound_complaints` ADD `bug_solution_time` int(11) NOT NULL  COMMENT 'bug处理时间' AFTER `bug_solution`;
ALTER TABLE `user_clound_complaints` MODIFY `bug_attach` VARCHAR(255) NOT NULL COMMENT 'bug附件' AFTER `bug_target`;

--
-- 退费表增加备注字段
--
ALTER TABLE `refund_list` ADD `remarks` VARCHAR(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL COMMENT '退费备注';

--
-- 修改srun_detail表中total_bytes类型
--
ALTER TABLE `srun_detail` MODIFY `total_bytes` BIGINT(20) NOT NULL COMMENT '总流量';
ALTER TABLE `srun_detail` MODIFY  `user_ip6` varchar(64) COLLATE utf8_unicode_ci NOT NULL COMMENT 'IPV6地址';

--
-- 缴费清单加缴费前电子钱包余额字段
--
ALTER TABLE `pay_list` ADD `balance_pre` float NOT NULL COMMENT '缴费前电子钱包余额' AFTER `pay_num`;

--
-- 修改管理员表手机号的字段类型由char改为varchar
--
ALTER TABLE `manager` MODIFY `mobile_phone` varchar (20) not null NOT NULL COMMENT '手机号';

--
-- 明细表增加group_id用户组ID
--
ALTER TABLE srun_detail ADD group_id int(10) NOT NULL DEFAULT 0 COMMENT '用户组ID';
CREATE INDEX idx_group_id ON srun_detail (group_id);

--
-- 创建云端在线统计表
--

CREATE TABLE IF NOT EXISTS `clound_online_report` (
 `time_point` int(11) NOT NULL,
 `count` int(11) NOT NULL,
 `products_key` VARCHAR(30) NOT NULL DEFAULT '' COMMENT '云端账号鉴别',
 UNIQUE KEY `points`(`time_point`, `products_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- 用户表添加状态字段
--
ALTER TABLE `users` ADD  `user_available` TINYINT  NOT NULL DEFAULT 0 COMMENT '0正常1禁用2停机保号3暂停4未开通';;
ALTER TABLE `users` ADD  KEY  `user_available`(`user_available`);


--
-- pay_list添加字段`is_refund`
--
ALTER TABLE `pay_list` ADD  `is_refund` ENUM('0','1') COLLATE utf8_unicode_ci NOT NULL DEFAULT '0' COMMENT '0未退1已退';
ALTER TABLE `pay_list` ADD  KEY  `pay_list_is_refund`(`is_refund`);


--
-- 创建管理远登录表`manager_login_log`
--
CREATE TABLE IF NOT EXISTS `manager_login_log`(
  `id` INT UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '主键id',
  `user_id` INT NOT NULL DEFAULT 0 COMMENT '管理员登录id',
  `manager_name` VARCHAR(64) COLLATE utf8_unicode_ci NOT NULL DEFAULT  '' COMMENT '管理员名称',
  `ip` VARCHAR(64)  COLLATE utf8_unicode_ci  NOT NULL DEFAULT '' COMMENT '登录ip',
  `login_time` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '登录时间',
  KEY `manager_name`(`manager_name`),
  KEY `login_time`(`login_time`),
  KEY `user_id`(`user_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  COMMENT='管理员登录日志表';

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
CREATE TABLE IF NOT EXISTS `clound_srun_login_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `product_key` VARCHAR(64) COLLATE utf8_unicode_ci NOT NULL COMMENT '云端账号鉴别',
  `error_count` INT  UNSIGNED NOT NULL DEFAULT 0 COMMENT '错误总数',
  `error_count1` INT  UNSIGNED NOT NULL DEFAULT 0 COMMENT '账户不存在错误总数',
  `error_count2` INT  UNSIGNED NOT NULL DEFAULT 0 COMMENT '密码错误总数',
  `error_count3` INT  UNSIGNED NOT NULL DEFAULT 0 COMMENT '计费策略错误总数',
  `error_count4` INT  UNSIGNED NOT NULL DEFAULT 0 COMMENT '控制策略错误总数',
  `statistics_time` int(11) NOT NULL COMMENT '统计时间',
  PRIMARY KEY (`id`),
  KEY `products_key`(`product_key`),
  UNIQUE KEY `product_key_time`(`product_key`, `statistics_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='云端认证日志表';
