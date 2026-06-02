use expense_tracker;
-- MySQL dump 10.13  Distrib 8.0.45, for Win64 (x86_64)
--
-- Host: localhost    Database: expense_tracker
-- ------------------------------------------------------
-- Server version	8.0.45

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add category',7,'add_category'),(26,'Can change category',7,'change_category'),(27,'Can delete category',7,'delete_category'),(28,'Can view category',7,'view_category'),(29,'Can add expense',8,'add_expense'),(30,'Can change expense',8,'change_expense'),(31,'Can delete expense',8,'delete_expense'),(32,'Can view expense',8,'view_expense'),(33,'Can add user settings',9,'add_usersettings'),(34,'Can change user settings',9,'change_usersettings'),(35,'Can delete user settings',9,'delete_usersettings'),(36,'Can view user settings',9,'view_usersettings');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$1200000$LEdGmo0cMcmP7VIiVem0Fg$uJ/VhS7LMc7UtXRP3VAjXGZo+BZa9OQuU4gq2cBC8X8=','2026-03-05 14:30:20.004302',1,'admin','','','',1,1,'2026-01-20 00:47:23.078019');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(7,'expenses','category'),(8,'expenses','expense'),(9,'expenses','usersettings'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-01-20 00:46:49.951020'),(2,'auth','0001_initial','2026-01-20 00:46:50.374221'),(3,'admin','0001_initial','2026-01-20 00:46:50.471808'),(4,'admin','0002_logentry_remove_auto_add','2026-01-20 00:46:50.480470'),(5,'admin','0003_logentry_add_action_flag_choices','2026-01-20 00:46:50.489496'),(6,'contenttypes','0002_remove_content_type_name','2026-01-20 00:46:50.532247'),(7,'auth','0002_alter_permission_name_max_length','2026-01-20 00:46:50.568732'),(8,'auth','0003_alter_user_email_max_length','2026-01-20 00:46:50.581910'),(9,'auth','0004_alter_user_username_opts','2026-01-20 00:46:50.589203'),(10,'auth','0005_alter_user_last_login_null','2026-01-20 00:46:50.627782'),(11,'auth','0006_require_contenttypes_0002','2026-01-20 00:46:50.630616'),(12,'auth','0007_alter_validators_add_error_messages','2026-01-20 00:46:50.637569'),(13,'auth','0008_alter_user_username_max_length','2026-01-20 00:46:50.648778'),(14,'auth','0009_alter_user_last_name_max_length','2026-01-20 00:46:50.660407'),(15,'auth','0010_alter_group_name_max_length','2026-01-20 00:46:50.671826'),(16,'auth','0011_update_proxy_permissions','2026-01-20 00:46:50.679388'),(17,'auth','0012_alter_user_first_name_max_length','2026-01-20 00:46:50.689429'),(18,'expenses','0001_initial','2026-01-20 00:46:50.815828'),(19,'sessions','0001_initial','2026-01-20 00:46:50.845423'),(20,'expenses','0002_expense_currency','2026-01-20 01:17:01.324494'),(21,'expenses','0003_usersettings','2026-03-05 14:30:00.915370');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('3nkoj9yzd0djywsycjbaf27jp2lcet7r','.eJxVjE0OwiAYBe_C2hChtAWX7j0D-f6QqoGktCvj3W2TLnT7Zua9VYR1yXFtMseJ1UUZdfrdEOgpZQf8gHKvmmpZ5gn1ruiDNn2rLK_r4f4dZGh5qy2ys9KhhzCCNUMQSB0GQhqkD0LAo_WJena9obNxxlMiSxtNyXIS9fkCDOM5gw:1vy9iW:DC2q-JoxbqHOeNI0ED4CvsF95IHB4KZSiJFFgXb8ewY','2026-03-19 14:30:20.013644'),('mzryk5yxtphanpjd6wkfv3tzsv0koyx8','.eJxVjEEOwiAQRe_C2hBaGGFcuvcMZJhBqRpISrsy3l2bdKHb_977LxVpXUpce57jJOqkBnX43RLxI9cNyJ3qrWludZmnpDdF77TrS5P8PO_u30GhXr41ILhrsIEsBTJi0-DBWyb0AY9isiBYYh4TIKP4xIyAzokImCRmVO8P26s4FA:1vi7XN:nMShjjbq9DxMr0nYQRE8Atuhz59_JwF9VB59-HEv3sk','2026-02-03 08:56:33.519844');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_category`
--

DROP TABLE IF EXISTS `expenses_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expenses_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_category_user_id_9d8b51ca_fk_auth_user_id` (`user_id`),
  CONSTRAINT `expenses_category_user_id_9d8b51ca_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_category`
--

LOCK TABLES `expenses_category` WRITE;
/*!40000 ALTER TABLE `expenses_category` DISABLE KEYS */;
INSERT INTO `expenses_category` VALUES
(1,'Thực phẩm - Đồ uống - Nguyên liệu thực phẩm',1),
(2,'Thực phẩm - Đồ uống - Bánh và đồ uống',1),
(3,'Thực phẩm - Đồ uống - Nhà hàng quán ăn',1),
(4,'Sinh hoạt - Tiện ích - Điện',1),
(5,'Sinh hoạt - Tiện ích - Nước',1),
(6,'Sinh hoạt - Tiện ích - Xăng dầu',1),
(7,'Sinh hoạt - Tiện ích - Truyền hình - Viễn thông',1),
(8,'Sinh hoạt - Tiện ích - Tạp hoá',1),
(9,'Sinh hoạt - Tiện ích - Phí dịch vụ căn hộ',1),
(10,'Sinh hoạt - Tiện ích - Thuê nhà',1),
(11,'Sinh hoạt - Tiện ích - Tiện ích khác',1),
(12,'Con cái - Gia đình - Trẻ em & người lớn tuổi',1),
(13,'Con cái - Gia đình - Vật nuôi',1),
(14,'Con cái - Gia đình - Tiêu vặt',1),
(15,'Con cái - Gia đình - Học phí',1),
(16,'Con cái - Gia đình - Hỗ trợ giáo dục',1),
(17,'Con cái - Gia đình - Nội thất & thiết bị',1),
(18,'Con cái - Gia đình - Tôn giáo & tâm linh',1),
(19,'Mua sắm - Quần áo & phụ kiện',1),
(20,'Mua sắm - Đồ gia dụng',1),
(21,'Mua sắm - Mua sắm trực tiếp',1),
(22,'Mua sắm - Siêu thị/TTTM',1),
(23,'Mua sắm - Sản phẩm cao cấp',1),
(24,'Mua sắm - Thiết bị điện tử',1),
(25,'Mua sắm - Hoa tươi & quà tặng',1),
(26,'Mua sắm - Mua sắm khác',1),
(27,'Sức khoẻ & Làm đẹp - Dược phẩm & y tế',1),
(28,'Sức khoẻ & Làm đẹp - Thể dục thể thao',1),
(29,'Sức khoẻ & Làm đẹp - Làm đẹp & Spa',1),
(30,'Sức khoẻ & Làm đẹp - Khám chữa bệnh',1),
(31,'Đi lại & Giao thông - Phí giao thông & chuyển phát',1),
(32,'Đi lại & Giao thông - Phương tiện đi lại',1),
(33,'Giải trí & Du lịch - Dịch vụ lưu trú',1),
(34,'Giải trí & Du lịch - Du lịch & điểm vui chơi',1),
(35,'Giải trí & Du lịch - Phim ảnh & sự kiện',1),
(36,'Giải trí & Du lịch - Trò chơi',1),
(37,'Chi phí tài chính - Trả nợ thẻ tín dụng',1),
(38,'Chi phí tài chính - Trả nợ vay',1),
(39,'Chi phí tài chính - Tài chính khác',1),
(40,'Tặng quà & Từ thiện - Thiện nguyện',1),
(41,'Tặng quà & Từ thiện - Cho tặng',1),
(42,'Tặng quà & Từ thiện - Hiếu hỉ',1),
(43,'Tiết kiệm & Đầu tư - Tiết kiệm',1),
(44,'Tiết kiệm & Đầu tư - Đầu tư',1),
(45,'Tiết kiệm & Đầu tư - Cho vay',1),
(46,'Tiết kiệm & Đầu tư - Bảo hiểm nhân thọ',1),
(47,'Khác - Chi phí khác',1),
(48,'Khác - Chưa phân loại',1),
(49,'Khác - Dịch vụ công',1),
(50,'Khác - Hỗ trợ kinh doanh',1),
(51,'Khác - Phí thường niên',1);
/*!40000 ALTER TABLE `expenses_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_expense`
--

DROP TABLE IF EXISTS `expenses_expense`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expenses_expense` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `category_id` bigint DEFAULT NULL,
  `user_id` int NOT NULL,
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `expenses_expense_category_id_aa33bbdd_fk_expenses_category_id` (`category_id`),
  KEY `expenses_expense_user_id_ab1aae2b_fk_auth_user_id` (`user_id`),
  CONSTRAINT `expenses_expense_category_id_aa33bbdd_fk_expenses_category_id` FOREIGN KEY (`category_id`) REFERENCES `expenses_category` (`id`),
  CONSTRAINT `expenses_expense_user_id_ab1aae2b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=765 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_expense`
--

LOCK TABLES `expenses_expense` WRITE;
/*!40000 ALTER TABLE `expenses_expense` DISABLE KEYS */;
INSERT INTO `expenses_expense` VALUES
(1001,45000.00,'2026-04-03','Cà phê buổi sáng với đối tác',2,1,'VND'),
(1002,98000.00,'2026-04-03','Bữa trưa văn phòng, ghi chú: họp team sprint',3,1,'VND'),
(1003,265000.00,'2026-04-04','Mua thực phẩm cuối tuần tại siêu thị',22,1,'VND'),
(1004,75000.00,'2026-04-04','Đồ tạp hoá bổ sung gia vị và đồ dùng nhỏ',8,1,'VND'),
(1005,120000.00,'2026-04-05','Đổ xăng cho xe máy đi làm cả tuần',6,1,'VND'),
(1006,180000.00,'2026-04-06','Hoá đơn internet và điện thoại tháng 4',7,1,'VND'),
(1007,320000.00,'2026-04-07','Thanh toán một phần tiền điện đầu tháng',4,1,'VND'),
(1008,145000.00,'2026-04-08','Khám tổng quát và mua vitamin',30,1,'VND'),
(1009,89000.00,'2026-04-09','Mua thuốc cảm và vật tư y tế gia đình',27,1,'VND'),
(1010,210000.00,'2026-04-10','Đóng phí phòng gym theo tháng',28,1,'VND'),
(1011,165000.00,'2026-04-12','Mua quần áo công sở, ghi chú: sale cuối mùa',19,1,'VND'),
(1012,240000.00,'2026-04-14','Bảo dưỡng xe máy định kỳ',32,1,'VND'),
(1013,125000.00,'2026-04-16','Xem phim cuối tuần và ăn nhẹ',35,1,'VND'),
(1014,350000.00,'2026-04-18','Mua đồ gia dụng cho bếp',20,1,'VND'),
(1015,420000.00,'2026-04-20','Tiệc sinh nhật bạn, quà tặng và bánh',25,1,'VND'),
(1016,280000.00,'2026-04-22','Đặt lịch chăm sóc da tại spa',29,1,'VND'),
(1017,96000.00,'2026-04-24','Ăn tối với gia đình tại quán gần nhà',3,1,'VND'),
(1018,500000.00,'2026-04-26','Đóng phí dịch vụ căn hộ tháng 4',9,1,'VND'),
(1019,2500000.00,'2026-04-27','Thanh toán tiền thuê nhà tháng 4',10,1,'VND'),
(1020,300000.00,'2026-04-29','Chuyển vào tài khoản tiết kiệm cuối tháng',43,1,'VND'),
(1021,55000.00,'2026-05-01','Cà phê sách ngày nghỉ lễ',2,1,'VND'),
(1022,275000.00,'2026-05-02','Mua sắm online đồ dùng cá nhân',21,1,'VND'),
(1023,315000.00,'2026-05-03','Mua thực phẩm tươi và trái cây cho tuần mới',1,1,'VND'),
(1024,135000.00,'2026-05-04','Đồ dây pin và phụ kiện điện tử nhỏ',24,1,'VND'),
(1025,118000.00,'2026-05-05','Tiền nước tháng 5',5,1,'VND'),
(1026,325000.00,'2026-05-06','Tiền điện tháng 5',4,1,'VND'),
(1027,92000.00,'2026-05-07','Phí cầu đường và gửi xe trong tuần',31,1,'VND'),
(1028,250000.00,'2026-05-09','Mua quà cho người thân ở xa',41,1,'VND'),
(1029,400000.00,'2026-05-10','Hỗ trợ học phí khoá kỹ năng cho em',16,1,'VND'),
(1030,185000.00,'2026-05-12','Hẹn bác sĩ răng hàm mặt và vệ sinh răng',30,1,'VND'),
(1031,145000.00,'2026-05-14','Mua đồ cho thú cưng: thức ăn và cát',13,1,'VND'),
(1032,230000.00,'2026-05-16','Đi chơi cuối tuần khu vui chơi ngoài trời',34,1,'VND'),
(1033,175000.00,'2026-05-18','Mua đồ nội thất nhỏ cho phòng làm việc',17,1,'VND'),
(1034,99000.00,'2026-05-20','Bữa trưa cùng khách hàng, ghi chú: tiếp khách',3,1,'VND'),
(1035,260000.00,'2026-05-22','Mua giày thể thao phục vụ tập luyện',19,1,'VND'),
(1036,215000.00,'2026-05-24','Nạp nhiên liệu và bảo dưỡng nhẹ xe máy',6,1,'VND'),
(1037,150000.00,'2026-05-26','Mua thuốc bổ và thực phẩm chức năng',27,1,'VND'),
(1038,1250000.00,'2026-05-28','Trả nợ thẻ tín dụng kỳ sao kê tháng 5',37,1,'VND'),
(1039,450000.00,'2026-05-30','Đóng góp từ thiện cho chương trình mùa hè',40,1,'VND'),
(1040,80000.00,'2026-05-31','Ăn sáng cuối tháng với gia đình',3,1,'VND'),
(1041,62000.00,'2026-06-01','Cà phê và bánh ngọt đầu tháng',2,1,'VND'),
(1042,340000.00,'2026-06-01','Mua sắm siêu thị: sữa, trứng, rau củ',22,1,'VND'),
(1043,510000.00,'2026-06-02','Đóng phí dịch vụ căn hộ tháng 6',9,1,'VND'),
(1044,2520000.00,'2026-06-02','Thanh toán tiền thuê nhà tháng 6',10,1,'VND'),
(1045,132000.00,'2026-06-02','Tiền internet và truyền hình cáp',7,1,'VND'),
(1046,180000.00,'2026-06-03','Mua hoa quả và quà nhỏ thăm người thân',25,1,'VND'),
(1047,700000.00,'2026-06-03','Nộp thêm vào quỹ đầu tư định kỳ',44,1,'VND'),
(1048,95000.00,'2026-06-03','Bữa tối nhẹ kết thúc ngày, ghi chú: tổng kết tuần',3,1,'VND');
/*!40000 ALTER TABLE `expenses_expense` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expenses_usersettings`
--

DROP TABLE IF EXISTS `expenses_usersettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `expenses_usersettings` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `budget_warning` tinyint(1) NOT NULL,
  `insight_reminders` tinyint(1) NOT NULL,
  `monthly_budget` decimal(12,2) NOT NULL,
  `week_start` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ai_auto_categorization` tinyint(1) NOT NULL,
  `insight_strictness` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `theme` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `language` varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `expenses_usersettings_user_id_1dd3f5db_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expenses_usersettings`
--

LOCK TABLES `expenses_usersettings` WRITE;
/*!40000 ALTER TABLE `expenses_usersettings` DISABLE KEYS */;
INSERT INTO `expenses_usersettings` VALUES (1,1,1,0.00,'monday',1,'balanced','system','en',1);
/*!40000 ALTER TABLE `expenses_usersettings` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-05 21:36:44
