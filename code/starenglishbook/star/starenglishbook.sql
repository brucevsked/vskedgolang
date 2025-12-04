/*
 Navicat Premium Dump SQL

 Source Server         : 本地库_starenglishbook
 Source Server Type    : MySQL
 Source Server Version : 80407 (8.4.7)
 Source Host           : localhost:3306
 Source Schema         : starenglishbook

 Target Server Type    : MySQL
 Target Server Version : 80407 (8.4.7)
 File Encoding         : 65001

 Date: 04/12/2025 11:27:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` char(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'oldme', 'e10adc3949ba59abbe56e057f20f883e', 'tyyn1022@gmail.com', '2025-12-03 15:16:14', '2025-12-03 15:16:14');
INSERT INTO `users` VALUES (2, 'user1', 'e10adc3949ba59abbe56e057f20f883e', 'o97scp.skd@yahoo.cn', '2025-12-04 08:56:24', '2025-12-04 08:56:24');

-- ----------------------------
-- Table structure for words
-- ----------------------------
DROP TABLE IF EXISTS `words`;
CREATE TABLE `words`  (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` int UNSIGNED NOT NULL,
  `word` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `definition` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `example_sentence` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL,
  `chinese_translation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `pronunciation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `proficiency_level` smallint UNSIGNED NULL DEFAULT NULL,
  `created_at` datetime NULL DEFAULT NULL,
  `updated_at` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uid`(`uid` ASC, `word` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of words
-- ----------------------------
INSERT INTO `words` VALUES (1, 1, 'apple', 'A round fruit with red green or yellow skin', 'I eat an apple every morning', '苹果', 'ˈæp.əl', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (2, 2, 'book', 'A set of printed pages bound together', 'She is reading a book about history', '书', 'bʊk', 3, '2025-12-04 09:01:40', '2025-12-04 11:25:15');
INSERT INTO `words` VALUES (3, 1, 'cat', 'A small domesticated carnivorous mammal', 'The cat is sleeping on the sofa', '猫', 'kæt', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (4, 2, 'dog', 'A domesticated carnivorous mammal', 'My dog loves to play in the park', '狗', 'dɒɡ', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (5, 1, 'elephant', 'A very large plant eating mammal with a trunk', 'Elephants are known for their intelligence', '大象', 'ˈel.ɪ.fənt', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (6, 2, 'flower', 'The seed bearing part of a plant', 'She picked a red flower from the garden', '花', 'ˈflaʊ.ər', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (7, 1, 'guitar', 'A musical instrument with strings', 'He plays the guitar in a band', '吉他', 'ɡɪˈtɑːr', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (8, 2, 'happy', 'Feeling or showing pleasure', 'She felt happy after receiving the gift', '快乐的', 'ˈhæp.i', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (9, 1, 'internet', 'A global computer network', 'I use the internet to search for information', '互联网', 'ˈɪn.t̬ɚ.net', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (10, 2, 'juice', 'Liquid extracted from fruit', 'Would you like some orange juice', '果汁', 'dʒuːs', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (11, 1, 'kangaroo', 'A large Australian marsupial', 'The kangaroo carries its baby in a pouch', '袋鼠', 'ˌkæŋ.ɡəˈruː', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (12, 2, 'lemon', 'A yellow citrus fruit', 'Add some lemon to your tea', '柠檬', 'ˈlem.ən', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (13, 1, 'mountain', 'A large natural elevation of the earth', 'They climbed the highest mountain', '山', 'ˈmaʊn.tən', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (14, 2, 'notebook', 'A book for writing notes', 'I bought a new notebook for school', '笔记本', 'ˈnoʊt.bʊk', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (15, 1, 'orange', 'A round citrus fruit with orange skin', 'She peeled an orange for dessert', '橙子', 'ˈɔːr.ɪndʒ', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (16, 2, 'piano', 'A large keyboard musical instrument', 'She practices the piano every day', '钢琴', 'piˈæn.oʊ', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (17, 1, 'question', 'A sentence worded to elicit information', 'He asked a difficult question', '问题', 'ˈkwes.tʃən', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (18, 2, 'river', 'A large natural stream of water', 'The river flows through the city', '河', 'ˈrɪv.ər', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (19, 1, 'sun', 'The star at the center of our solar system', 'The sun rises in the east', '太阳', 'sʌn', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (20, 2, 'tree', 'A tall plant with a trunk and branches', 'Birds are singing in the tree', '树', 'triː', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (21, 1, 'umbrella', 'A device for protection against rain', 'Do not forget your umbrella it is raining', '雨伞', 'ʌmˈbrel.ə', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (22, 2, 'violin', 'A stringed musical instrument played with a bow', 'He plays the violin in an orchestra', '小提琴', 'ˌvaɪ.əˈlɪn', 4, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (23, 1, 'water', 'A clear liquid essential for life', 'Drink plenty of water every day', '水', 'ˈwɔː.t̬ɚ', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (24, 2, 'xylophone', 'A musical instrument with wooden bars', 'The child played a song on the xylophone', '木琴', 'ˈzaɪ.lə.foʊn', 5, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (25, 1, 'yellow', 'The color of gold or lemons', 'Her dress is bright yellow', '黄色的', 'ˈjel.oʊ', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (26, 2, 'zebra', 'An African wild horse with black and white stripes', 'The zebra runs fast on the savanna', '斑马', 'ˈziː.brə', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (27, 1, 'animal', 'A living organism that feeds on organic matter', 'Dogs and cats are common pets', '动物', 'ˈæn.ɪ.məl', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (28, 2, 'butterfly', 'An insect with large colorful wings', 'A butterfly landed on the flower', '蝴蝶', 'ˈbʌt̬.ɚ.flaɪ', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (29, 1, 'camera', 'A device for recording images', 'He took a photo with his camera', '相机', 'ˈkæm.ɚ.ə', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (30, 2, 'dolphin', 'A highly intelligent marine mammal', 'Dolphins are known for their playful behavior', '海豚', 'ˈdɑːl.fɪn', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (31, 1, 'engine', 'A machine for converting energy into motion', 'The car engine makes a loud noise', '引擎', 'ˈen.dʒɪn', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (32, 2, 'festival', 'A special time of celebration', 'We attended a music festival last summer', '节日', 'ˈfes.tɪ.vəl', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (33, 1, 'garden', 'A plot of ground for growing plants', 'She grows vegetables in her garden', '花园', 'ˈɡɑːr.dən', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (34, 2, 'hospital', 'A place where sick people are treated', 'He went to the hospital for a check up', '医院', 'ˈhɑːs.pɪ.t̬əl', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (35, 1, 'island', 'A piece of land surrounded by water', 'They visited a tropical island', '岛', 'ˈaɪ.lənd', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (36, 1, 'kitchen', 'A room where food is prepared', 'She cooked dinner in the kitchen', '厨房', 'ˈkɪtʃ.ən', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (37, 2, 'library', 'A place where books are kept', 'I borrowed a novel from the library', '图书馆', 'ˈlaɪ.brer.i', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (38, 1, 'music', 'Vocal or instrumental sounds combined', 'She listens to classical music', '音乐', 'ˈmjuː.zɪk', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (39, 2, 'ocean', 'A large body of salt water', 'The Pacific Ocean is the largest', '海洋', 'ˈoʊ.ʃən', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (40, 1, 'planet', 'A celestial body orbiting a star', 'Earth is the third planet from the sun', '行星', 'ˈplæn.ɪt', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (41, 2, 'queen', 'The female ruler of a kingdom', 'The queen lives in a palace', '女王', 'kwiːn', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (42, 1, 'robot', 'A machine that can perform tasks automatically', 'The robot cleaned the floor', '机器人', 'ˈroʊ.bɑːt', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (43, 2, 'school', 'An institution for educating children', 'He goes to school by bus', '学校', 'skuːl', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (44, 1, 'teacher', 'A person who teaches students', 'My teacher is very kind', '老师', 'ˈtiː.tʃər', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (45, 2, 'universe', 'All existing matter and space', 'The universe is vast and mysterious', '宇宙', 'ˈjuː.nɪ.vɝːs', 4, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (46, 1, 'vegetable', 'A plant used as food', 'Carrots and potatoes are vegetables', '蔬菜', 'ˈvedʒ.tə.bəl', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (47, 2, 'window', 'An opening in a wall for light and air', 'She looked out of the window', '窗户', 'ˈwɪn.doʊ', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (48, 1, 'yacht', 'A medium sized sailboat', 'They sailed on a yacht in the Mediterranean', '游艇', 'jɑːt', 5, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (49, 2, 'zoo', 'A place where animals are kept for display', 'We saw lions and tigers at the zoo', '动物园', 'zuː', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (50, 1, 'airplane', 'A powered flying vehicle with wings', 'The airplane flew over the clouds', '飞机', 'ˈer.plen', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (51, 2, 'bicycle', 'A vehicle with two wheels pedaled by the rider', 'He rides a bicycle to work', '自行车', 'ˈbaɪ.sɪ.kəl', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (52, 1, 'computer', 'An electronic device for processing data', 'I use a computer for work', '电脑', 'kəmˈpjuː.t̬ɚ', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (53, 2, 'doctor', 'A medical practitioner', 'She visited the doctor for a cold', '医生', 'ˈdɑːk.t̬ɚ', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (54, 1, 'energy', 'The capacity to do work', 'Solar panels convert sunlight into energy', '能量', 'ˈen.ɚ.dʒi', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (55, 2, 'famous', 'Known by many people', 'Shakespeare is a famous writer', '著名的', 'ˈfeɪ.məs', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (56, 1, 'globe', 'A spherical representation of the Earth', 'The classroom has a large globe', '地球仪', 'ɡloʊb', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (57, 2, 'history', 'The study of past events', 'We learned about ancient history', '历史', 'ˈhɪs.tə.ri', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (58, 1, 'ice', 'Water frozen into solid form', 'Children like to skate on ice', '冰', 'aɪs', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (59, 2, 'jacket', 'A short coat', 'He wore a leather jacket', '夹克', 'ˈdʒæk.ɪt', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (60, 1, 'key', 'A device for opening locks', 'She lost the key to her house', '钥匙', 'kiː', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (61, 2, 'language', 'A system of communication', 'English is an international language', '语言', 'ˈlæŋ.ɡwɪdʒ', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (62, 1, 'magic', 'The power of seemingly supernatural effects', 'The magician performed a magic trick', '魔法', 'ˈmædʒ.ɪk', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (63, 2, 'nature', 'The natural world', 'We went hiking to enjoy nature', '自然', 'ˈneɪ.tʃɚ', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (64, 1, 'oxygen', 'A gas essential for life', 'Plants produce oxygen', '氧气', 'ˈɑːk.sɪ.dʒən', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (65, 2, 'peace', 'Freedom from disturbance', 'We hope for world peace', '和平', 'piːs', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (66, 1, 'quiet', 'Making little or no noise', 'The library is a quiet place', '安静的', 'ˈkwaɪ.ət', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (67, 2, 'rainbow', 'A multicolored arc in the sky', 'We saw a beautiful rainbow after the rain', '彩虹', 'ˈreɪn.boʊ', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (68, 1, 'science', 'The study of the natural world', 'She studies science at university', '科学', 'ˈsaɪ.əns', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (69, 2, 'travel', 'To go from one place to another', 'They plan to travel to Japan', '旅行', 'ˈtræv.əl', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (70, 1, 'uniform', 'Special clothing worn by members of a group', 'Students wear a school uniform', '制服', 'ˈjuː.nə.fɔːrm', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (71, 2, 'village', 'A small community in a rural area', 'His grandparents live in a village', '村庄', 'ˈvɪl.ɪdʒ', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (72, 1, 'wisdom', 'The ability to make good decisions', 'Age brings wisdom', '智慧', 'ˈwɪz.dəm', 4, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (73, 2, 'xenon', 'A chemical element used in lights', 'Xenon is used in car headlights', '氙', 'ˈziː.nɑːn', 5, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (74, 1, 'youth', 'The period between childhood and adulthood', 'He spent his youth in Paris', '青年', 'juːθ', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (75, 2, 'zeal', 'Great enthusiasm', 'She works with great zeal', '热情', 'ziːl', 4, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (76, 1, 'abacus', 'An ancient calculating tool', 'Children learn math using an abacus', '算盘', 'ˈæb.ə.kəs', 4, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (77, 2, 'bamboo', 'A type of fast growing grass', 'Pandas eat bamboo', '竹子', 'bæmˈbuː', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (78, 1, 'cactus', 'A desert plant with spines', 'The cactus stores water in its stem', '仙人掌', 'ˈkæk.təs', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (79, 2, 'daisy', 'A small white flower with a yellow center', 'She made a daisy chain', '雏菊', 'ˈdeɪ.zi', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (80, 1, 'echo', 'A reflected sound', 'The shout produced an echo in the canyon', '回声', 'ˈek.oʊ', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (81, 2, 'falcon', 'A bird of prey', 'The falcon flew swiftly through the sky', '猎鹰', 'ˈfæl.kən', 4, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (82, 1, 'galaxy', 'A system of stars', 'The Milky Way is our galaxy', '星系', 'ˈɡæl.ək.si', 4, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (83, 2, 'harmony', 'Agreement or concord', 'The instruments played in harmony', '和谐', 'ˈhɑːr.mə.ni', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (84, 1, 'illusion', 'A false idea or belief', 'The magician created an illusion', '幻觉', 'ɪˈluː.ʒən', 4, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (85, 2, 'jungle', 'A dense forest in a tropical region', 'Explorers ventured into the jungle', '丛林', 'ˈdʒʌŋ.ɡəl', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (86, 1, 'koala', 'An Australian marsupial that eats eucalyptus', 'The koala sleeps most of the day', '考拉', 'koʊˈɑː.lə', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (87, 2, 'lizard', 'A reptile with four legs', 'The lizard crawled on the wall', '蜥蜴', 'ˈlɪz.ɚd', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (88, 1, 'mango', 'A tropical fruit with sweet flesh', 'She ate a ripe mango', '芒果', 'ˈmæŋ.ɡoʊ', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (89, 2, 'nirvana', 'A state of perfect happiness', 'Meditation leads to nirvana', '涅槃', 'nɪrˈvɑː.nə', 5, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (90, 1, 'oasis', 'A fertile spot in a desert', 'Travelers rested at the oasis', '绿洲', 'oʊˈeɪ.sɪs', 4, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (91, 2, 'penguin', 'A flightless bird that lives in cold regions', 'Penguins swim in the ocean', '企鹅', 'ˈpeŋ.ɡwɪn', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (92, 1, 'quartz', 'A hard mineral crystal', 'Quartz is used in watches', '石英', 'kwɔːrts', 4, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (93, 2, 'raccoon', 'A mammal with a masked face', 'The raccoon rummaged through the trash', '浣熊', 'ræˈkuːn', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (94, 1, 'sphinx', 'A mythical creature with a lion body and human head', 'The Sphinx is near the pyramids', '斯芬克斯', 'sfɪŋks', 5, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (95, 2, 'tulip', 'A spring flower with bright colors', 'The garden is full of tulips', '郁金香', 'ˈtuː.lɪp', 2, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (96, 1, 'unicorn', 'A mythical horse with a single horn', 'Children love unicorn stories', '独角兽', 'ˈjuː.nɪ.kɔːrn', 4, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (97, 2, 'volcano', 'A mountain that can erupt lava', 'Mount Fuji is a volcano', '火山', 'vɑːlˈkeɪ.noʊ', 3, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (98, 1, 'wombat', 'An Australian burrowing marsupial', 'The wombat digs deep holes', '袋熊', 'ˈwɑːm.bæt', 5, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (99, 2, 'xylem', 'Plant tissue that transports water', 'Xylem carries water from roots to leaves', '木质部', 'ˈzaɪ.ləm', 5, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (100, 1, 'yak', 'A long haired bovine animal', 'Yaks live in the Himalayas', '牦牛', 'jæk', 4, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (101, 2, 'zero', 'The numerical symbol 0', 'The temperature dropped to zero', '零', 'ˈzɪr.oʊ', 1, '2025-12-04 09:01:40', '2025-12-04 09:01:40');
INSERT INTO `words` VALUES (103, 2, 'example', 'A representative form or pattern.', 'This is an example sentence.', '例子', 'ɪɡˈzɑːmp(ə)l', 3, '2025-12-04 10:54:03', '2025-12-04 10:54:03');

SET FOREIGN_KEY_CHECKS = 1;
