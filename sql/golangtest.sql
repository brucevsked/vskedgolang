/*
 Navicat Premium Data Transfer

 Source Server         : 本地库_golangtest
 Source Server Type    : MySQL
 Source Server Version : 80407
 Source Host           : localhost:3306
 Source Schema         : golangtest

 Target Server Type    : MySQL
 Target Server Version : 80407
 File Encoding         : 65001

 Date: 03/12/2025 09:57:58
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for device
-- ----------------------------
DROP TABLE IF EXISTS `device`;
CREATE TABLE `device`  (
  `id` int NOT NULL COMMENT '设备编号',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '设备名称',
  `addtime` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '添加时间',
  `parentid` int NULL DEFAULT NULL COMMENT '上级设备',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '设备备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `baseinfoindex1`(`id` ASC, `name` ASC, `addtime` ASC, `parentid` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of device
-- ----------------------------
INSERT INTO `device` VALUES (1, '温湿度传感器-001', '2025-12-03 09:45:57', NULL, '部署于1号楼1层');
INSERT INTO `device` VALUES (2, '烟雾探测器-001', '2025-12-03 09:45:57', NULL, '部署于1号楼走廊');
INSERT INTO `device` VALUES (3, '智能电表-001', '2025-12-03 09:45:57', NULL, '1号楼总电表');
INSERT INTO `device` VALUES (4, '水浸传感器-001', '2025-12-03 09:45:57', NULL, '地下室水泵房');
INSERT INTO `device` VALUES (5, '门磁传感器-001', '2025-12-03 09:45:57', NULL, '1号楼主入口');
INSERT INTO `device` VALUES (6, '红外人体感应-001', '2025-12-03 09:45:57', NULL, '1号楼大厅');
INSERT INTO `device` VALUES (7, '空气质量监测仪-001', '2025-12-03 09:45:57', NULL, '1号楼会议室');
INSERT INTO `device` VALUES (8, '智能摄像头-001', '2025-12-03 09:45:57', NULL, '1号楼大门');
INSERT INTO `device` VALUES (9, '智能路灯-001', '2025-12-03 09:45:57', NULL, '园区主干道1号');
INSERT INTO `device` VALUES (10, 'GPS 定位终端-001', '2025-12-03 09:45:57', NULL, '物流车辆A001');
INSERT INTO `device` VALUES (11, '智能门锁-001', '2025-12-03 09:45:57', NULL, '1号楼101室');
INSERT INTO `device` VALUES (12, 'LoRa 网关-001', '2025-12-03 09:45:57', NULL, '1号楼机房');
INSERT INTO `device` VALUES (13, 'NB-IoT 模块-001', '2025-12-03 09:45:57', 12, '子设备，挂载于LoRa网关');
INSERT INTO `device` VALUES (14, 'Zigbee 协调器-001', '2025-12-03 09:45:57', NULL, '2号楼智能家居中心');
INSERT INTO `device` VALUES (15, '蓝牙信标-001', '2025-12-03 09:45:57', 14, '2号楼1层定位点');
INSERT INTO `device` VALUES (16, '压力传感器-001', '2025-12-03 09:45:57', NULL, '工业区管道A');
INSERT INTO `device` VALUES (17, '液位传感器-001', '2025-12-03 09:45:57', NULL, '水箱1号');
INSERT INTO `device` VALUES (18, '光照度传感器-001', '2025-12-03 09:45:57', NULL, '温室大棚1');
INSERT INTO `device` VALUES (19, '风速传感器-001', '2025-12-03 09:45:57', NULL, '气象站1');
INSERT INTO `device` VALUES (20, '雨量计-001', '2025-12-03 09:45:57', NULL, '气象站1');
INSERT INTO `device` VALUES (21, '土壤湿度传感器-001', '2025-12-03 09:45:57', NULL, '农田区块A');
INSERT INTO `device` VALUES (22, '智能灌溉控制器-001', '2025-12-03 09:45:57', NULL, '农田区块A');
INSERT INTO `device` VALUES (23, '光伏逆变器-001', '2025-12-03 09:45:57', NULL, '屋顶光伏1');
INSERT INTO `device` VALUES (24, '充电桩-001', '2025-12-03 09:45:57', NULL, '停车场P1');
INSERT INTO `device` VALUES (25, '智能垃圾桶-001', '2025-12-03 09:45:57', NULL, '园区东门');
INSERT INTO `device` VALUES (26, '电梯运行监测-001', '2025-12-03 09:45:57', NULL, '1号楼电梯1');
INSERT INTO `device` VALUES (27, '消防栓压力监测-001', '2025-12-03 09:45:57', NULL, '园区消防栓1');
INSERT INTO `device` VALUES (28, '智能井盖-001', '2025-12-03 09:45:57', NULL, '道路井盖1');
INSERT INTO `device` VALUES (29, '噪音传感器-001', '2025-12-03 09:45:57', NULL, '主干道监测点1');
INSERT INTO `device` VALUES (30, '水质监测仪-001', '2025-12-03 09:45:57', NULL, '河流监测点1');
INSERT INTO `device` VALUES (31, '冷链温度记录仪-001', '2025-12-03 09:45:57', NULL, '冷链车C001');
INSERT INTO `device` VALUES (32, 'RFID 读写器-001', '2025-12-03 09:45:57', NULL, '仓库入口1');
INSERT INTO `device` VALUES (33, '智能插座-001', '2025-12-03 09:45:57', NULL, '办公室A');
INSERT INTO `device` VALUES (34, '智能窗帘电机-001', '2025-12-03 09:45:57', NULL, '会议室A');
INSERT INTO `device` VALUES (35, '燃气泄漏报警器-001', '2025-12-03 09:45:57', NULL, '食堂厨房');
INSERT INTO `device` VALUES (36, '智能水表-001', '2025-12-03 09:45:57', NULL, '1号楼总水表');
INSERT INTO `device` VALUES (37, '智能燃气表-001', '2025-12-03 09:45:57', NULL, '1号楼总燃气表');
INSERT INTO `device` VALUES (38, '超声波流量计-001', '2025-12-03 09:45:57', NULL, '工业水管1');
INSERT INTO `device` VALUES (39, '振动传感器-001', '2025-12-03 09:45:57', NULL, '电机M001');
INSERT INTO `device` VALUES (40, '倾角传感器-001', '2025-12-03 09:45:57', NULL, '桥梁监测点1');
INSERT INTO `device` VALUES (41, '智能配电箱-001', '2025-12-03 09:45:57', NULL, '1号楼电井');
INSERT INTO `device` VALUES (42, '边缘计算网关-001', '2025-12-03 09:45:57', NULL, '数据中心1');
INSERT INTO `device` VALUES (43, 'AI 视频分析盒-001', '2025-12-03 09:45:57', 8, '关联摄像头001');
INSERT INTO `device` VALUES (44, '智能停车地磁-001', '2025-12-03 09:45:57', NULL, '车位P101');
INSERT INTO `device` VALUES (45, 'UWB 定位基站-001', '2025-12-03 09:45:57', NULL, '仓库定位区1');
INSERT INTO `device` VALUES (46, 'LoRa 水表-001', '2025-12-03 09:45:57', NULL, '园区外围水表');
INSERT INTO `device` VALUES (47, '智能路灯控制器-001', '2025-12-03 09:45:57', 9, '控制路灯001');
INSERT INTO `device` VALUES (48, '环境噪声监测站-001', '2025-12-03 09:45:57', NULL, '城市监测点1');
INSERT INTO `device` VALUES (49, '智能消防主机-001', '2025-12-03 09:45:57', NULL, '1号楼消防室');
INSERT INTO `device` VALUES (50, '工业PLC控制器-001', '2025-12-03 09:45:57', NULL, '生产线Line1');

-- ----------------------------
-- Table structure for deviceandtype
-- ----------------------------
DROP TABLE IF EXISTS `deviceandtype`;
CREATE TABLE `deviceandtype`  (
  `deviceid` int NOT NULL,
  `devicetypeid` int NOT NULL,
  PRIMARY KEY (`deviceid`, `devicetypeid`) USING BTREE,
  INDEX `devicetypeFK1`(`devicetypeid` ASC) USING BTREE,
  CONSTRAINT `deviceidFK1` FOREIGN KEY (`deviceid`) REFERENCES `device` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `devicetypeFK1` FOREIGN KEY (`devicetypeid`) REFERENCES `devicetype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of deviceandtype
-- ----------------------------
INSERT INTO `deviceandtype` VALUES (1, 1);
INSERT INTO `deviceandtype` VALUES (2, 2);
INSERT INTO `deviceandtype` VALUES (3, 3);
INSERT INTO `deviceandtype` VALUES (4, 4);
INSERT INTO `deviceandtype` VALUES (5, 5);
INSERT INTO `deviceandtype` VALUES (6, 6);
INSERT INTO `deviceandtype` VALUES (7, 7);
INSERT INTO `deviceandtype` VALUES (8, 8);
INSERT INTO `deviceandtype` VALUES (9, 9);
INSERT INTO `deviceandtype` VALUES (10, 10);
INSERT INTO `deviceandtype` VALUES (11, 11);
INSERT INTO `deviceandtype` VALUES (12, 12);
INSERT INTO `deviceandtype` VALUES (13, 13);
INSERT INTO `deviceandtype` VALUES (14, 14);
INSERT INTO `deviceandtype` VALUES (15, 15);
INSERT INTO `deviceandtype` VALUES (16, 16);
INSERT INTO `deviceandtype` VALUES (17, 17);
INSERT INTO `deviceandtype` VALUES (18, 18);
INSERT INTO `deviceandtype` VALUES (19, 19);
INSERT INTO `deviceandtype` VALUES (20, 20);
INSERT INTO `deviceandtype` VALUES (21, 21);
INSERT INTO `deviceandtype` VALUES (22, 22);
INSERT INTO `deviceandtype` VALUES (23, 23);
INSERT INTO `deviceandtype` VALUES (24, 24);
INSERT INTO `deviceandtype` VALUES (25, 25);
INSERT INTO `deviceandtype` VALUES (26, 26);
INSERT INTO `deviceandtype` VALUES (27, 27);
INSERT INTO `deviceandtype` VALUES (28, 28);
INSERT INTO `deviceandtype` VALUES (29, 29);
INSERT INTO `deviceandtype` VALUES (30, 30);
INSERT INTO `deviceandtype` VALUES (31, 31);
INSERT INTO `deviceandtype` VALUES (32, 32);
INSERT INTO `deviceandtype` VALUES (33, 33);
INSERT INTO `deviceandtype` VALUES (34, 34);
INSERT INTO `deviceandtype` VALUES (35, 35);
INSERT INTO `deviceandtype` VALUES (36, 36);
INSERT INTO `deviceandtype` VALUES (37, 37);
INSERT INTO `deviceandtype` VALUES (38, 38);
INSERT INTO `deviceandtype` VALUES (39, 39);
INSERT INTO `deviceandtype` VALUES (40, 40);
INSERT INTO `deviceandtype` VALUES (41, 41);
INSERT INTO `deviceandtype` VALUES (42, 42);
INSERT INTO `deviceandtype` VALUES (43, 43);
INSERT INTO `deviceandtype` VALUES (44, 44);
INSERT INTO `deviceandtype` VALUES (45, 45);
INSERT INTO `deviceandtype` VALUES (46, 46);
INSERT INTO `deviceandtype` VALUES (47, 47);
INSERT INTO `deviceandtype` VALUES (48, 48);
INSERT INTO `deviceandtype` VALUES (49, 49);
INSERT INTO `deviceandtype` VALUES (50, 50);

-- ----------------------------
-- Table structure for devicetype
-- ----------------------------
DROP TABLE IF EXISTS `devicetype`;
CREATE TABLE `devicetype`  (
  `id` int NOT NULL COMMENT '设备类型编号',
  `name` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '设备类型名称',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL COMMENT '设备类型备注',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `baseinfoindex1`(`id` ASC, `name` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of devicetype
-- ----------------------------
INSERT INTO `devicetype` VALUES (1, '温湿度传感器', '用于监测环境温湿度');
INSERT INTO `devicetype` VALUES (2, '烟雾探测器', '火灾预警设备');
INSERT INTO `devicetype` VALUES (3, '智能电表', '用电量实时监测');
INSERT INTO `devicetype` VALUES (4, '水浸传感器', '检测漏水或积水');
INSERT INTO `devicetype` VALUES (5, '门磁传感器', '门窗开关状态监测');
INSERT INTO `devicetype` VALUES (6, '红外人体感应', '检测人员活动');
INSERT INTO `devicetype` VALUES (7, '空气质量监测仪', 'PM2.5/CO2 检测');
INSERT INTO `devicetype` VALUES (8, '智能摄像头', '视频监控设备');
INSERT INTO `devicetype` VALUES (9, '智能路灯', '远程控制照明');
INSERT INTO `devicetype` VALUES (10, 'GPS 定位终端', '车辆/资产定位');
INSERT INTO `devicetype` VALUES (11, '智能门锁', '远程开锁与权限管理');
INSERT INTO `devicetype` VALUES (12, 'LoRa 网关', '低功耗广域网数据汇聚');
INSERT INTO `devicetype` VALUES (13, 'NB-IoT 模块', '窄带物联网通信设备');
INSERT INTO `devicetype` VALUES (14, 'Zigbee 协调器', 'Zigbee 网络中心节点');
INSERT INTO `devicetype` VALUES (15, '蓝牙信标', '室内定位与推送');
INSERT INTO `devicetype` VALUES (16, '压力传感器', '工业管道压力监测');
INSERT INTO `devicetype` VALUES (17, '液位传感器', '水箱/油箱液位检测');
INSERT INTO `devicetype` VALUES (18, '光照度传感器', '环境光照强度检测');
INSERT INTO `devicetype` VALUES (19, '风速传感器', '气象站风速监测');
INSERT INTO `devicetype` VALUES (20, '雨量计', '降雨量监测');
INSERT INTO `devicetype` VALUES (21, '土壤湿度传感器', '农业灌溉控制');
INSERT INTO `devicetype` VALUES (22, '智能灌溉控制器', '自动浇水系统');
INSERT INTO `devicetype` VALUES (23, '光伏逆变器', '太阳能发电监控');
INSERT INTO `devicetype` VALUES (24, '充电桩', '电动车充电管理');
INSERT INTO `devicetype` VALUES (25, '智能垃圾桶', '满溢检测与压缩');
INSERT INTO `devicetype` VALUES (26, '电梯运行监测', '电梯状态与故障预警');
INSERT INTO `devicetype` VALUES (27, '消防栓压力监测', '消防设施状态监控');
INSERT INTO `devicetype` VALUES (28, '智能井盖', '位移/倾斜报警');
INSERT INTO `devicetype` VALUES (29, '噪音传感器', '环境噪音监测');
INSERT INTO `devicetype` VALUES (30, '水质监测仪', 'pH/浊度/溶解氧检测');
INSERT INTO `devicetype` VALUES (31, '冷链温度记录仪', '运输温控');
INSERT INTO `devicetype` VALUES (32, 'RFID 读写器', '资产追踪');
INSERT INTO `devicetype` VALUES (33, '智能插座', '远程电源控制');
INSERT INTO `devicetype` VALUES (34, '智能窗帘电机', '光照/定时控制');
INSERT INTO `devicetype` VALUES (35, '燃气泄漏报警器', '甲烷/丙烷检测');
INSERT INTO `devicetype` VALUES (36, '智能水表', '用水量远程抄表');
INSERT INTO `devicetype` VALUES (37, '智能燃气表', '燃气用量监测');
INSERT INTO `devicetype` VALUES (38, '超声波流量计', '液体流量测量');
INSERT INTO `devicetype` VALUES (39, '振动传感器', '设备健康监测');
INSERT INTO `devicetype` VALUES (40, '倾角传感器', '结构安全监测');
INSERT INTO `devicetype` VALUES (41, '智能配电箱', '电力分配与监控');
INSERT INTO `devicetype` VALUES (42, '边缘计算网关', '本地数据处理');
INSERT INTO `devicetype` VALUES (43, 'AI 视频分析盒', '人脸识别/行为分析');
INSERT INTO `devicetype` VALUES (44, '智能停车地磁', '车位占用检测');
INSERT INTO `devicetype` VALUES (45, 'UWB 定位基站', '高精度室内定位');
INSERT INTO `devicetype` VALUES (46, 'LoRa 水表', '无线远程抄表');
INSERT INTO `devicetype` VALUES (47, '智能路灯控制器', '按需调光与节能');
INSERT INTO `devicetype` VALUES (48, '环境噪声监测站', '城市噪音地图');
INSERT INTO `devicetype` VALUES (49, '智能消防主机', '消防系统集成');
INSERT INTO `devicetype` VALUES (50, '工业PLC控制器', '生产线自动化控制');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL,
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `pass` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `email` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `phone` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `addtime` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '张三', '123456', 'zhangsan@example.com', '13800138001', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (2, '李四', '123456', 'lisi@example.com', '13800138002', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (3, '王五', '123456', 'wangwu@example.com', '13800138003', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (4, '赵六', '123456', 'zhaoliu@example.com', '13800138004', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (5, '钱七', '123456', 'qianqi@example.com', '13800138005', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (6, '孙八', '123456', 'sunba@example.com', '13800138006', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (7, '周九', '123456', 'zhoujiu@example.com', '13800138007', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (8, '吴十', '123456', 'wushi@example.com', '13800138008', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (9, '郑一', '123456', 'zhengyi@example.com', '13800138009', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (10, '黄二', '123456', 'huang2@example.com', '13800138010', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (11, 'admin1', 'admin123', 'admin1@iot.com', '13900139001', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (12, 'admin2', 'admin123', 'admin2@iot.com', '13900139002', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (13, 'operator1', 'op123456', 'op1@iot.com', '13900139003', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (14, 'operator2', 'op123456', 'op2@iot.com', '13900139004', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (15, 'maintainer1', 'mt123456', 'mt1@iot.com', '13900139005', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (16, '刘工', '123456', 'liugong@example.com', '13800138011', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (17, '陈工', '123456', 'chegong@example.com', '13800138012', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (18, '杨工', '123456', 'yanggong@example.com', '13800138013', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (19, '朱工', '123456', 'zhugong@example.com', '13800138014', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (20, '秦工', '123456', 'qigong@example.com', '13800138015', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (21, '许工', '123456', 'xugong@example.com', '13800138016', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (22, '何工', '123456', 'hegong@example.com', '13800138017', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (23, '吕工', '123456', 'lugong@example.com', '13800138018', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (24, '施工', '123456', 'shigong@example.com', '13800138019', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (25, '张工', '123456', 'zhanggong@example.com', '13800138020', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (26, '孔工', '123456', 'konggong@example.com', '13800138021', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (27, '曹工', '123456', 'caogong@example.com', '13800138022', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (28, '严工', '123456', 'yangong@example.com', '13800138023', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (29, '华工', '123456', 'huagong@example.com', '13800138024', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (30, '金工', '123456', 'jingong@example.com', '13800138025', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (31, '魏工', '123456', 'weigong@example.com', '13800138026', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (32, '陶工', '123456', 'taogong@example.com', '13800138027', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (33, '姜工', '123456', 'jianggong@example.com', '13800138028', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (34, '戚工', '123456', 'qigong2@example.com', '13800138029', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (35, '谢工', '123456', 'xiegong@example.com', '13800138030', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (36, '邹工', '123456', 'zougong@example.com', '13800138031', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (37, '喻工', '123456', 'yugong@example.com', '13800138032', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (38, '柏工', '123456', 'baigong@example.com', '13800138033', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (39, '水工', '123456', 'shuigong@example.com', '13800138034', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (40, '窦工', '123456', 'dougong@example.com', '13800138035', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (41, '章工', '123456', 'zhanggong2@example.com', '13800138036', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (42, '云工', '123456', 'yungong@example.com', '13800138037', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (43, '苏工', '123456', 'sugong@example.com', '13800138038', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (44, '潘工', '123456', 'pangong@example.com', '13800138039', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (45, '葛工', '123456', 'gegong@example.com', '13800138040', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (46, '奚工', '123456', 'xigong@example.com', '13800138041', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (47, '范工', '123456', 'fangong@example.com', '13800138042', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (48, '彭工', '123456', 'penggong@example.com', '13800138043', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (49, '郎工', '123456', 'langgong@example.com', '13800138044', '2025-12-03 09:46:08');
INSERT INTO `user` VALUES (50, '鲁工', '123456', 'lugong2@example.com', '13800138045', '2025-12-03 09:46:08');

-- ----------------------------
-- Table structure for useranddevice
-- ----------------------------
DROP TABLE IF EXISTS `useranddevice`;
CREATE TABLE `useranddevice`  (
  `userid` int NOT NULL,
  `deviceid` int NOT NULL,
  PRIMARY KEY (`userid`, `deviceid`) USING BTREE,
  INDEX `deviceidFK`(`deviceid` ASC) USING BTREE,
  CONSTRAINT `deviceidFK` FOREIGN KEY (`deviceid`) REFERENCES `device` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `useridFK1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of useranddevice
-- ----------------------------
INSERT INTO `useranddevice` VALUES (1, 1);
INSERT INTO `useranddevice` VALUES (2, 2);
INSERT INTO `useranddevice` VALUES (3, 3);
INSERT INTO `useranddevice` VALUES (4, 4);
INSERT INTO `useranddevice` VALUES (5, 5);
INSERT INTO `useranddevice` VALUES (6, 6);
INSERT INTO `useranddevice` VALUES (7, 7);
INSERT INTO `useranddevice` VALUES (8, 8);
INSERT INTO `useranddevice` VALUES (9, 9);
INSERT INTO `useranddevice` VALUES (10, 10);
INSERT INTO `useranddevice` VALUES (11, 11);
INSERT INTO `useranddevice` VALUES (12, 12);
INSERT INTO `useranddevice` VALUES (13, 13);
INSERT INTO `useranddevice` VALUES (14, 14);
INSERT INTO `useranddevice` VALUES (15, 15);
INSERT INTO `useranddevice` VALUES (16, 16);
INSERT INTO `useranddevice` VALUES (17, 17);
INSERT INTO `useranddevice` VALUES (18, 18);
INSERT INTO `useranddevice` VALUES (19, 19);
INSERT INTO `useranddevice` VALUES (20, 20);
INSERT INTO `useranddevice` VALUES (21, 21);
INSERT INTO `useranddevice` VALUES (22, 22);
INSERT INTO `useranddevice` VALUES (23, 23);
INSERT INTO `useranddevice` VALUES (24, 24);
INSERT INTO `useranddevice` VALUES (25, 25);
INSERT INTO `useranddevice` VALUES (26, 26);
INSERT INTO `useranddevice` VALUES (27, 27);
INSERT INTO `useranddevice` VALUES (28, 28);
INSERT INTO `useranddevice` VALUES (29, 29);
INSERT INTO `useranddevice` VALUES (30, 30);
INSERT INTO `useranddevice` VALUES (31, 31);
INSERT INTO `useranddevice` VALUES (32, 32);
INSERT INTO `useranddevice` VALUES (33, 33);
INSERT INTO `useranddevice` VALUES (34, 34);
INSERT INTO `useranddevice` VALUES (35, 35);
INSERT INTO `useranddevice` VALUES (36, 36);
INSERT INTO `useranddevice` VALUES (37, 37);
INSERT INTO `useranddevice` VALUES (38, 38);
INSERT INTO `useranddevice` VALUES (39, 39);
INSERT INTO `useranddevice` VALUES (40, 40);
INSERT INTO `useranddevice` VALUES (41, 41);
INSERT INTO `useranddevice` VALUES (42, 42);
INSERT INTO `useranddevice` VALUES (43, 43);
INSERT INTO `useranddevice` VALUES (44, 44);
INSERT INTO `useranddevice` VALUES (45, 45);
INSERT INTO `useranddevice` VALUES (46, 46);
INSERT INTO `useranddevice` VALUES (47, 47);
INSERT INTO `useranddevice` VALUES (48, 48);
INSERT INTO `useranddevice` VALUES (49, 49);
INSERT INTO `useranddevice` VALUES (50, 50);

SET FOREIGN_KEY_CHECKS = 1;
