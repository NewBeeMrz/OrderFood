/*
 Navicat Premium Data Transfer

 Source Server         : my
 Source Server Type    : MySQL
 Source Server Version : 50715
 Source Host           : localhost:3306
 Source Schema         : mealsystem

 Target Server Type    : MySQL
 Target Server Version : 50715
 File Encoding         : 65001

 Date: 14/03/2018 09:13:17
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for diningcar
-- ----------------------------
DROP TABLE IF EXISTS `diningcar`;
CREATE TABLE `diningcar`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) NOT NULL,
  `foodid` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `dingingcar-user`(`userid`) USING BTREE,
  INDEX `diningcar-food`(`foodid`) USING BTREE,
  CONSTRAINT `dingingcar-user` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `diningcar-food` FOREIGN KEY (`foodid`) REFERENCES `food` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of diningcar
-- ----------------------------
INSERT INTO `diningcar` VALUES (1, 3, 7);
INSERT INTO `diningcar` VALUES (2, 4, 1);
INSERT INTO `diningcar` VALUES (3, 4, 2);
INSERT INTO `diningcar` VALUES (4, 4, 3);
INSERT INTO `diningcar` VALUES (5, 3, 38);
INSERT INTO `diningcar` VALUES (6, 3, 40);
INSERT INTO `diningcar` VALUES (7, 3, 10);
INSERT INTO `diningcar` VALUES (8, 3, 11);
INSERT INTO `diningcar` VALUES (9, 2, 2);
INSERT INTO `diningcar` VALUES (10, 2, 11);
INSERT INTO `diningcar` VALUES (11, 2, 21);

-- ----------------------------
-- Table structure for food
-- ----------------------------
DROP TABLE IF EXISTS `food`;
CREATE TABLE `food`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `foodname` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `feature` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT '暂无',
  `material` varchar(100) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT '暂无',
  `price` int(11) NOT NULL,
  `type` int(1) NOT NULL,
  `picture` varchar(40) CHARACTER SET gbk COLLATE gbk_chinese_ci DEFAULT NULL,
  `hits` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `comment` int(11) NOT NULL DEFAULT -1 COMMENT '整数代表特价菜的价格，0代表厨师推荐，-1表示为正常菜品。',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `food-foodtype`(`type`) USING BTREE,
  UNIQUE INDEX `unique-foodname`(`foodname`) USING BTREE,
  CONSTRAINT `food-foodtype` FOREIGN KEY (`type`) REFERENCES `foodtype` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of food
-- ----------------------------
INSERT INTO `food` VALUES (1, '菠菜炒鸡蛋', '暂无', '主料：菠菜300克，鸡蛋3个，盐、料酒、葱末、姜末、味精、香油各适量。', 9, 1, 'images/jiachang/01.jpg', 3, 0);
INSERT INTO `food` VALUES (2, '韭菜炒鸡蛋', '工艺：炒    口味：清香味', '主料：韭菜4两（约160克），大鸡蛋3只。\r\n', 8, 1, 'images/jiachang/02.jpg', 2, -1);
INSERT INTO `food` VALUES (3, '渝味辣白菜', '特色：色泽红亮、酸甜微辣，脆爽可口。', '主料：娃娃菜200克。', 6, 1, 'images/jiachang/03.jpg', 3, -1);
INSERT INTO `food` VALUES (4, '爆炒腰花', '特色：腰花鲜嫩，造形美观，味道醇厚，滑润不腻。', '主料：猪腰子200克。辅料： 冬笋片、水发木耳各50克；酱油10克、精盐3克、味精1克、绍酒20克、湿粉15克。', 12, 1, 'images/jiachang/04.jpg', 0, -1);
INSERT INTO `food` VALUES (5, '韩国泡菜汤', '暂无', '主料：韩国辣白菜1碗，洗米水一大碗（约500毫升），中型土豆1个，小型洋葱1个，黄豆芽1把，金针菇1把，豆腐1块，五花肉1小块（牛肉亦可）。', 16, 1, 'images/jiachang/05.jpg', 0, 0);
INSERT INTO `food` VALUES (6, '清蒸桂鱼', '特色：色泽淡稚悦目，味似蟹肉，鲜香馥郁。\r\n辅料：熟火腿3片（25克）， 熟笋6片（60克），水发大香菇3朵，姜片2.5克、葱结1个\r\n', '主料：桂鱼一条（约重750克）。', 25, 1, 'images/jiachang/06.jpg', 6, -1);
INSERT INTO `food` VALUES (7, '酸辣白菜', '口味：酸辣味。', '主料：大白菜 1/4棵（约400g）。', 14, 1, 'images/jiachang/07.jpg', 1, -1);
INSERT INTO `food` VALUES (8, '醋溜白菜', '特色：特点：色泽银红，酸甜辣香。功效：润肠通便。', '主料：卷心菜750 克\r\n辅料：葱花3 克，干辣椒节4 克，花椒2 克。\r\n', 14, 1, 'images/jiachang/08.jpg', 0, -1);
INSERT INTO `food` VALUES (9, '木须肉', '暂无', '主料：猪肉、鸡蛋、木耳、黄瓜\r\n辅料：葱姜、盐、酱油、料酒、香油。', 8, 1, 'images/jiachang/09.jpg', 0, -1);
INSERT INTO `food` VALUES (10, '肉末豆腐', '特色：鲜嫩可口。功效：强壮身体，改善体质。', '暂无主料：嫩豆腐600 克，肉末150 克，酱油10 克，细盐3 克，味精3 克，黄酒5克，姜末5 克，葱花3 克，胡椒粉1 克，鲜汤300 克。', 7, 1, 'images/jiachang/10.jpg', 1, -1);
INSERT INTO `food` VALUES (11, '小葱拌豆腐', '特色：清香爽口，一清二白。', '暂无', 22, 2, 'images/liangcai/1.jpg', 2, 18);
INSERT INTO `food` VALUES (12, '泡椒鸡爪', '暂无', '主料：凤爪1000克，野山椒50克。\r\n辅料：泡菜酸水一些，芹菜、花椒、味精、鸡精、盐、胡椒少许。\r\n主料：凤爪1000克，野山椒50克。\r\n辅料：泡菜酸水一些，芹菜、花椒、味精、鸡精、盐、胡椒少许。', 12, 2, 'images/liangcai/2.jpg', 0, -1);
INSERT INTO `food` VALUES (13, '泡椒凤爪', '暂无', '主料：鸡爪，花椒,盐（最好当然是专门的泡菜盐，如果没有也没关系,用一般的盐也可以), 八角,桂皮,少许糖,少许白酒。', 12, 2, 'images/liangcai/3.jpg', 0, -1);
INSERT INTO `food` VALUES (14, '凉拌海带丝', '特色：海带是一种海洋蔬菜，含碘、藻胶酸和甘露醇等，可防治甲状腺肿大、克汀病、软骨病、佝偻病。现代药理学研究表明，吃海带可增加单核巨噬细胞活性，增强机体免疫力和抗辐射', '主料：海带300克、蒜茸、香油、醋、味精等。', 8, 2, 'images/liangcai/4.jpg', 3, -1);
INSERT INTO `food` VALUES (15, '老醋花生米', '特色：爽、脆可口。', '主料：花生米\r\n辅料：生菜、香干。', 14, 2, 'images/liangcai/5.jpg', 0, 0);
INSERT INTO `food` VALUES (16, '凉拌黄瓜', '暂无', '主料：黄瓜3根 （切成条长5―6厘米、宽1―1.5厘米）\r\n辅料：辣椒少许，大蒜1瓣，色拉油、盐、白醋、糖、味精、麻油少许。\r\n', 6, 2, 'images/liangcai/6.jpg', 0, -1);
INSERT INTO `food` VALUES (17, '老虎菜', '特色：新疆的一道吃肉、抓饭用的菜，喜欢大口吃肉、大口喝酒的朋友，我推荐给你！', '主料：辣椒、洋葱、西红柿。醋、酱油、辣椒油、味精。', 7, 2, 'images/liangcai/7.jpg', 0, -1);
INSERT INTO `food` VALUES (18, '肉皮冻', '特色：透明、味鲜。', '主料：猪肉片500克，盐、味精、葱段、姜块(拍楹)花椒粒、大料瓣知适量。\r\n', 9, 2, 'images/liangcai/8.jpg', 1, -1);
INSERT INTO `food` VALUES (19, '凉拌藕片', '特色：爽口解腻、开胃下酒。', '主料：莲藕500克、酱油15克、精盐6克、味精2克、葱花3克、姜丝3克、蒜片3克。', 12, 2, 'images/liangcai/9.jpg', 0, -1);
INSERT INTO `food` VALUES (20, '蒜泥白肉', '暂无', '主料：猪臀肉500克。 大蒜50克、上等酱油50克、红油10克、盐2克、冷汤50克、红糖10克、香料3克、味精1克。', 20, 2, 'images/liangcai/10.jpg', 0, 15);
INSERT INTO `food` VALUES (21, '四川酸辣粉', '暂无', '粉条,葱末,姜末,蒜泥等', 28, 3, 'images/zhushi/1.jpg', 5, -1);
INSERT INTO `food` VALUES (22, '蛋包饭', '暂无', '蛋一个，炒饭6两', 6, 3, 'images/zhushi/2.jpg', 1, -1);
INSERT INTO `food` VALUES (23, '海南鸡饭', '暂无', '鸡一只，白米,姜，香兰叶，辣椒等', 22, 3, 'images/zhushi/3.jpg', 0, -1);
INSERT INTO `food` VALUES (24, '皮蛋粥', '口味：清香味。', '稻米100克，松花蛋50克', 5, 3, 'images/zhushi/4.jpg', 0, -1);
INSERT INTO `food` VALUES (25, '红豆粥', '口味：甜味', '赤小豆20克，稻米100克', 5, 3, 'images/zhushi/5.jpg', 0, 0);
INSERT INTO `food` VALUES (26, '玉米饼', '饼表面软，饼底脆脆的，口感香甜', '玉米面粉200克 面粉100克 甜玉米粒一碗 酵母粉5克(1小勺) 白糖适量 鸡蛋。', 16, 3, 'images/zhushi/6.jpg', 0, -1);
INSERT INTO `food` VALUES (27, '猫耳朵', '暂无', '面粉.鸡蛋,菠菜,酱油,盐和水', 5, 3, 'images/zhushi/7.jpg', 0, -1);
INSERT INTO `food` VALUES (28, '羊肉泡馍', '\r\n工艺：煮    \r\n口味：咸鲜味', '\r\n烙饼(标准粉)200克\r\n。辅料：黄花菜（干）50克,木耳(水发)50克,粉丝50克,青蒜10克,香菜10克,羊肉（熟）100克.\r\n', 5, 3, 'images/zhushi/8.jpg', 0, -1);
INSERT INTO `food` VALUES (29, '扬州炒饭', '暂无', '米饭250克，火腿30克，鸡蛋1个，豌豆20克，黄瓜、虾各25克，油30克，味精1克，葱花5克，精盐3克。', 7, 3, 'images/zhushi/9.jpg', 0, -1);
INSERT INTO `food` VALUES (30, '驴打滚', '暂无', '糯米粉100克、澄粉25克\r\n辅料：油35毫升、豆沙50克、水150毫升\r\n糯米粉100克、澄粉25克\r\n辅料：油35毫升、豆沙50克、水150毫升\r\n糯米粉100克、澄粉25克\r\n辅料：油35毫升.', 12, 3, 'images/zhushi/10.jpg', 0, 10);
INSERT INTO `food` VALUES (31, '甘蔗马蹄糖水', '暂无', '主料：甘蔗200克，马蹄150克，红枣50克，红糖50克，桂圆肉10克\r\n', 8, 4, 'images/yinpin/01.jpg', 0, -1);
INSERT INTO `food` VALUES (32, '抹茶慕司', '暂无', '主料：吉利丁片9片、红腰豆1瓶、淡奶油130g、白砂糖80g、鲜牛奶400g、蛋黄2个、抹茶粉4g。', 8, 4, 'images/yinpin/02.jpg', 1, -1);
INSERT INTO `food` VALUES (33, '瘦身苹果牛奶饮', '特色：苹果有安眠养神、补中益气、消食化积之特长。瘦身苹果牛奶饮让你首先感觉到的是苹果的甜香，然后是牛奶的浓郁、香滑。临睡前喝一碗，不但可以帮助睡眠，也不会长胖。', '主料：苹果250g,牛奶200g。', 11, 4, 'images/yinpin/03.jpg', 0, -1);
INSERT INTO `food` VALUES (34, 'QQ西瓜西米露', '特色：利用西瓜本身的糖分使西米露变得甜美可口，一口入嘴，只说得出“好吃”两个字，水果的芬芳甜美中带有西米的软韧，最后吞下去后，还会觉得唇齿留香。', '主料：西米250g,西瓜200g', 11, 4, 'images/yinpin/04.jpg', 0, 9);
INSERT INTO `food` VALUES (35, '杏仁草莓奶拌早餐', '特色：牛奶是早餐必不可少的一份子，无论是西式还是中式早餐，都别忘记喝牛奶。提高钙的摄取可以减少脂肪的沉积，而钙的最好来源正是牛奶。所以，就让早晨从一杯甜美可口的草莓牛奶开始吧', '主料：草莓口味奶拌 20g,牛奶 1杯\r\n辅料：大杏仁 适量', 12, 4, 'images/yinpin/05.jpg', 0, -1);
INSERT INTO `food` VALUES (36, '腐竹鹑蛋糖水', '暂无', '主料：腐竹约100克，鹌鹑蛋8只，雪耳约30克，冰糖约350克，清水6杯。', 9, 4, 'images/yinpin/06.jpg', 0, -1);
INSERT INTO `food` VALUES (37, '红豆相思茶', '特色：奶香浓郁，茶味清香。', '主料：红茶、红豆汤、面粉 黄油、白糖、鸡蛋黄 炼乳、牛奶.', 5, 4, 'images/yinpin/07.jpg', 0, -1);
INSERT INTO `food` VALUES (38, '布丁', '暂无', '主料：鲜牛奶、ＱＱ糖、苹果（你爱吃那种水果就用那种，但最好跟ＱＱ糖口味一致，我觉得这样会比较好', 6, 4, 'images/yinpin/08.jpg', 1, 0);
INSERT INTO `food` VALUES (39, '极度诱惑的果冻', '暂无', '主料：薰衣草适量，紫罗兰适量，椰丝适量\r\n辅料：罗拔臣纯鱼胶粉一盒（50克），开水两碗，花型冰格（要奈高温100度以上），不锈钢容器（大碗2个）。', 8, 4, 'images/yinpin/09.jpg', 0, -1);
INSERT INTO `food` VALUES (40, '姜撞奶', '暂无', '主料：鲜姜一大块，牛奶一袋，白糖，捣蒜缸', 17, 4, 'images/yinpin/10.jpg', 1, -1);

-- ----------------------------
-- Table structure for foodtype
-- ----------------------------
DROP TABLE IF EXISTS `foodtype`;
CREATE TABLE `foodtype`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `typename` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique-typename`(`typename`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of foodtype
-- ----------------------------
INSERT INTO `foodtype` VALUES (1, '家常');
INSERT INTO `foodtype` VALUES (2, '凉菜');
INSERT INTO `foodtype` VALUES (3, '主食');
INSERT INTO `foodtype` VALUES (4, '饮品');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `password` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `ident` char(1) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `telephone` varchar(20) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  `address` varchar(50) CHARACTER SET gbk COLLATE gbk_chinese_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique-username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = gbk COLLATE = gbk_chinese_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', '123', '1', '0', '0');
INSERT INTO `user` VALUES (2, 'user1', '123', '0', '041184835202', '大连东软信息学院A3座117室');
INSERT INTO `user` VALUES (3, 'user2', '123', '0', '041184835207', '大连理工大学计算机系');
INSERT INTO `user` VALUES (4, 'user3', '123', '0', '041184832264', '新新园100号2门103');

SET FOREIGN_KEY_CHECKS = 1;
