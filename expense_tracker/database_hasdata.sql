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
INSERT INTO `expenses_category` VALUES (1,'Thực phẩm - Đồ uống - Nguyên liệu thực phẩm',1),(2,'Thực phẩm - Đồ uống - Bánh và đồ uống',1),(3,'Thực phẩm - Đồ uống - Nhà hàng quán ăn',1),(4,'Sinh hoạt - Tiện ích - Điện',1),(5,'Sinh hoạt - Tiện ích - Nước',1),(6,'Sinh hoạt - Tiện ích - Xăng dầu',1),(7,'Sinh hoạt - Tiện ích - Truyền hình - Viễn thông',1),(8,'Sinh hoạt - Tiện ích - Tạp hoá',1),(9,'Sinh hoạt - Tiện ích - Phí dịch vụ căn hộ',1),(10,'Sinh hoạt - Tiện ích - Thuê nhà',1),(11,'Sinh hoạt - Tiện ích - Tiện ích khác',1),(12,'Con cái - Gia đình - Trẻ em & người lớn tuổi',1),(13,'Con cái - Gia đình - Vật nuôi',1),(14,'Con cái - Gia đình - Tiêu vặt',1),(15,'Con cái - Gia đình - Học phí',1),(16,'Con cái - Gia đình - Hỗ trợ giáo dục',1),(17,'Con cái - Gia đình - Nội thất & thiết bị',1),(18,'Con cái - Gia đình - Tôn giáo & tâm linh',1),(19,'Mua sắm - Quần áo & phụ kiện',1),(20,'Mua sắm - Đồ gia dụng',1),(21,'Mua sắm - Mua sắm trực tiếp',1),(22,'Mua sắm - Siêu thị/TTTM',1),(23,'Mua sắm - Sản phẩm cao cấp',1),(24,'Mua sắm - Thiết bị điện tử',1),(25,'Mua sắm - Hoa tươi & quà tặng',1),(26,'Mua sắm - Mua sẵm khác',1),(27,'Sức khoẻ & Làm đẹp - Dược phẩm & y tế',1),(28,'Sức khoẻ & Làm đẹp - Thể dục thể thao',1),(29,'Sức khoẻ & Làm đẹp - Làm đẹp & Spa',1),(30,'Sức khoẻ & Làm đẹp - Khám chữa bệnh',1),(31,'Đi lại & Giao thông - Phí giao thông & chuyển phát',1),(32,'Đi lại & Giao thông - Phương tiện đi lại',1),(33,'Giải trí & Du lịch - Dịch vụ lưu trú',1),(34,'Giải trí & Du lịch - Du lịch & điểm vui chơi',1),(35,'Giải trí & Du lịch - Phim ảnh & sự kiện',1),(36,'Giải trí & Du lịch - Trò chơi',1),(37,'Chi phí tài chỉnh - Trả nợ thẻ tín dụng',1),(38,'Chi phí tài chỉnh - Trả nợ vay',1),(39,'Chi phí tài chỉnh - Tài chỉnh khác',1),(40,'Tăng quà & Từ thiện - Thiện nguyện',1),(41,'Tăng quà & Từ thiện - Cho tặng',1),(42,'Tăng quà & Từ thiện - Hiếu hỉ',1),(43,'Tiết kiệm & Đầu tư - Tiết kiệm',1),(44,'Tiết kiệm & Đầu tư - Đầu tư',1),(45,'Tiết kiệm & Đầu tư - Cho vay',1),(46,'Tiết kiệm & Đầu tư - Bảo hiểm nhân thọ',1),(47,'Khác - Chi phí khác',1),(48,'Khác - Chưa phân loại',1),(49,'Khác - Dịch vụ công',1),(50,'Khác - Hỗ trợ kinh doanh',1),(51,'Khác - Phí thường niên',1);
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
INSERT INTO `expenses_expense` VALUES (401,30000.00,'2025-12-03','ca phe',2,1,'VND'),(402,80000.00,'2025-12-03','an ngoai',3,1,'VND'),(403,120000.00,'2025-12-03','sieu thi',22,1,'VND'),(404,60000.00,'2025-12-03','tap hoa',8,1,'VND'),(405,80000.00,'2025-12-04','an ngoai',3,1,'VND'),(406,120000.00,'2025-12-04','sieu thi',22,1,'VND'),(407,60000.00,'2025-12-04','tap hoa',8,1,'VND'),(408,120000.00,'2025-12-04','xang xe',6,1,'VND'),(409,301000.00,'2025-12-04','tien dien',4,1,'VND'),(410,120000.00,'2025-12-05','sieu thi',22,1,'VND'),(411,60000.00,'2025-12-05','tap hoa',8,1,'VND'),(412,120000.00,'2025-12-05','xang xe',6,1,'VND'),(413,60000.00,'2025-12-06','tap hoa',8,1,'VND'),(414,120000.00,'2025-12-06','xang xe',6,1,'VND'),(415,300000.00,'2025-12-06','tien dien',4,1,'VND'),(416,121000.00,'2025-12-06','tien nuoc',5,1,'VND'),(417,120000.00,'2025-12-07','xang xe',6,1,'VND'),(418,300000.00,'2025-12-07','tien dien',4,1,'VND'),(419,120000.00,'2025-12-07','tien nuoc',5,1,'VND'),(420,501000.00,'2025-12-07','phi dich vu can ho',9,1,'VND'),(421,2501000.00,'2025-12-07','thue nha',10,1,'VND'),(422,300000.00,'2025-12-08','tien dien',4,1,'VND'),(423,120000.00,'2025-12-08','tien nuoc',5,1,'VND'),(424,501000.00,'2025-12-08','phi dich vu can ho',9,1,'VND'),(425,120000.00,'2025-12-09','tien nuoc',5,1,'VND'),(426,501000.00,'2025-12-09','phi dich vu can ho',9,1,'VND'),(427,2501000.00,'2025-12-09','thue nha',10,1,'VND'),(428,201000.00,'2025-12-09','gym',28,1,'VND'),(429,500000.00,'2025-12-10','phi dich vu can ho',9,1,'VND'),(430,2501000.00,'2025-12-10','thue nha',10,1,'VND'),(431,201000.00,'2025-12-10','gym',28,1,'VND'),(432,301000.00,'2025-12-10','spa',29,1,'VND'),(433,51000.00,'2025-12-10','mua thuoc',27,1,'VND'),(434,2501000.00,'2025-12-11','thue nha',10,1,'VND'),(435,201000.00,'2025-12-11','gym',28,1,'VND'),(436,301000.00,'2025-12-11','spa',29,1,'VND'),(437,201000.00,'2025-12-12','gym',28,1,'VND'),(438,301000.00,'2025-12-12','spa',29,1,'VND'),(439,51000.00,'2025-12-12','mua thuoc',27,1,'VND'),(440,501000.00,'2025-12-12','kham benh',30,1,'VND'),(441,301000.00,'2025-12-13','spa',29,1,'VND'),(442,51000.00,'2025-12-13','mua thuoc',27,1,'VND'),(443,501000.00,'2025-12-13','kham benh',30,1,'VND'),(444,301000.00,'2025-12-13','mua quan ao',19,1,'VND'),(445,201000.00,'2025-12-13','do gia dung',20,1,'VND'),(446,51000.00,'2025-12-14','mua thuoc',27,1,'VND'),(447,501000.00,'2025-12-14','kham benh',30,1,'VND'),(448,301000.00,'2025-12-14','mua quan ao',19,1,'VND'),(449,501000.00,'2025-12-15','kham benh',30,1,'VND'),(450,301000.00,'2025-12-15','mua quan ao',19,1,'VND'),(451,201000.00,'2025-12-15','do gia dung',20,1,'VND'),(452,801000.00,'2025-12-15','thiet bi dien tu',24,1,'VND'),(453,301000.00,'2025-12-16','mua quan ao',19,1,'VND'),(454,201000.00,'2025-12-16','do gia dung',20,1,'VND'),(455,801000.00,'2025-12-16','thiet bi dien tu',24,1,'VND'),(456,151000.00,'2025-12-16','hoa & qua',25,1,'VND'),(457,301000.00,'2025-12-16','mua sam truc tiep',21,1,'VND'),(458,201000.00,'2025-12-17','do gia dung',20,1,'VND'),(459,801000.00,'2025-12-17','thiet bi dien tu',24,1,'VND'),(460,151000.00,'2025-12-17','hoa & qua',25,1,'VND'),(461,801000.00,'2025-12-18','thiet bi dien tu',24,1,'VND'),(462,151000.00,'2025-12-18','hoa & qua',25,1,'VND'),(463,301000.00,'2025-12-18','mua sam truc tiep',21,1,'VND'),(464,61000.00,'2025-12-18','taxi',32,1,'VND'),(465,151000.00,'2025-12-19','hoa & qua',25,1,'VND'),(466,301000.00,'2025-12-19','mua sam truc tiep',21,1,'VND'),(467,61000.00,'2025-12-19','taxi',32,1,'VND'),(468,51000.00,'2025-12-19','phi giao thong',31,1,'VND'),(469,801000.00,'2025-12-19','tra no the',37,1,'VND'),(470,301000.00,'2025-12-20','mua sam truc tiep',21,1,'VND'),(471,61000.00,'2025-12-20','taxi',32,1,'VND'),(472,51000.00,'2025-12-20','phi giao thong',31,1,'VND'),(473,61000.00,'2025-12-21','taxi',32,1,'VND'),(474,51000.00,'2025-12-21','phi giao thong',31,1,'VND'),(475,801000.00,'2025-12-21','tra no the',37,1,'VND'),(476,1501000.00,'2025-12-21','tra no vay',38,1,'VND'),(477,51000.00,'2025-12-22','phi giao thong',31,1,'VND'),(478,801000.00,'2025-12-22','tra no the',37,1,'VND'),(479,1501000.00,'2025-12-22','tra no vay',38,1,'VND'),(480,501000.00,'2025-12-22','tiet kiem',43,1,'VND'),(481,801000.00,'2025-12-22','dau tu',44,1,'VND'),(482,801000.00,'2025-12-23','tra no the',37,1,'VND'),(483,1501000.00,'2025-12-23','tra no vay',38,1,'VND'),(484,501000.00,'2025-12-23','tiet kiem',43,1,'VND'),(485,1501000.00,'2025-12-24','tra no vay',38,1,'VND'),(486,501000.00,'2025-12-24','tiet kiem',43,1,'VND'),(487,801000.00,'2025-12-24','dau tu',44,1,'VND'),(488,301000.00,'2025-12-24','phi thuong nien',51,1,'VND'),(489,501000.00,'2025-12-25','tiet kiem',43,1,'VND'),(490,801000.00,'2025-12-25','dau tu',44,1,'VND'),(491,301000.00,'2025-12-25','phi thuong nien',51,1,'VND'),(492,201000.00,'2025-12-25','dich vu cong',49,1,'VND'),(493,32000.00,'2025-12-25','ca phe',2,1,'VND'),(494,801000.00,'2025-12-26','dau tu',44,1,'VND'),(495,301000.00,'2025-12-26','phi thuong nien',51,1,'VND'),(496,201000.00,'2025-12-26','dich vu cong',49,1,'VND'),(497,301000.00,'2025-12-27','phi thuong nien',51,1,'VND'),(498,201000.00,'2025-12-27','dich vu cong',49,1,'VND'),(499,31000.00,'2025-12-27','ca phe',2,1,'VND'),(500,82000.00,'2025-12-27','an ngoai',3,1,'VND'),(501,201000.00,'2025-12-28','dich vu cong',49,1,'VND'),(502,31000.00,'2025-12-28','ca phe',2,1,'VND'),(503,82000.00,'2025-12-28','an ngoai',3,1,'VND'),(504,122000.00,'2025-12-28','sieu thi',22,1,'VND'),(505,62000.00,'2025-12-28','tap hoa',8,1,'VND'),(506,31000.00,'2025-12-29','ca phe',2,1,'VND'),(507,82000.00,'2025-12-29','an ngoai',3,1,'VND'),(508,122000.00,'2025-12-29','sieu thi',22,1,'VND'),(509,81000.00,'2025-12-30','an ngoai',3,1,'VND'),(510,122000.00,'2025-12-30','sieu thi',22,1,'VND'),(511,62000.00,'2025-12-30','tap hoa',8,1,'VND'),(512,122000.00,'2025-12-30','xang xe',6,1,'VND'),(513,122000.00,'2025-12-31','sieu thi',22,1,'VND'),(514,62000.00,'2025-12-31','tap hoa',8,1,'VND'),(515,122000.00,'2025-12-31','xang xe',6,1,'VND'),(516,302000.00,'2025-12-31','tien dien',4,1,'VND'),(517,122000.00,'2025-12-31','tien nuoc',5,1,'VND'),(518,60000.00,'2026-01-01','tap hoa',8,1,'VND'),(519,121000.00,'2026-01-01','xang xe',6,1,'VND'),(520,301000.00,'2026-01-01','tien dien',4,1,'VND'),(521,120000.00,'2026-01-02','xang xe',6,1,'VND'),(522,301000.00,'2026-01-02','tien dien',4,1,'VND'),(523,121000.00,'2026-01-02','tien nuoc',5,1,'VND'),(524,501000.00,'2026-01-02','phi dich vu can ho',9,1,'VND'),(525,301000.00,'2026-01-03','tien dien',4,1,'VND'),(526,121000.00,'2026-01-03','tien nuoc',5,1,'VND'),(527,501000.00,'2026-01-03','phi dich vu can ho',9,1,'VND'),(528,2501000.00,'2026-01-03','thue nha',10,1,'VND'),(529,201000.00,'2026-01-03','gym',28,1,'VND'),(530,121000.00,'2026-01-04','tien nuoc',5,1,'VND'),(531,501000.00,'2026-01-04','phi dich vu can ho',9,1,'VND'),(532,2501000.00,'2026-01-04','thue nha',10,1,'VND'),(533,501000.00,'2026-01-05','phi dich vu can ho',9,1,'VND'),(534,2501000.00,'2026-01-05','thue nha',10,1,'VND'),(535,201000.00,'2026-01-05','gym',28,1,'VND'),(536,301000.00,'2026-01-05','spa',29,1,'VND'),(537,2501000.00,'2026-01-06','thue nha',10,1,'VND'),(538,201000.00,'2026-01-06','gym',28,1,'VND'),(539,301000.00,'2026-01-06','spa',29,1,'VND'),(540,51000.00,'2026-01-06','mua thuoc',27,1,'VND'),(541,501000.00,'2026-01-06','kham benh',30,1,'VND'),(542,201000.00,'2026-01-07','gym',28,1,'VND'),(543,301000.00,'2026-01-07','spa',29,1,'VND'),(544,51000.00,'2026-01-07','mua thuoc',27,1,'VND'),(545,301000.00,'2026-01-08','spa',29,1,'VND'),(546,51000.00,'2026-01-08','mua thuoc',27,1,'VND'),(547,501000.00,'2026-01-08','kham benh',30,1,'VND'),(548,301000.00,'2026-01-08','mua quan ao',19,1,'VND'),(549,51000.00,'2026-01-09','mua thuoc',27,1,'VND'),(550,501000.00,'2026-01-09','kham benh',30,1,'VND'),(551,301000.00,'2026-01-09','mua quan ao',19,1,'VND'),(552,201000.00,'2026-01-09','do gia dung',20,1,'VND'),(553,801000.00,'2026-01-09','thiet bi dien tu',24,1,'VND'),(554,501000.00,'2026-01-10','kham benh',30,1,'VND'),(555,301000.00,'2026-01-10','mua quan ao',19,1,'VND'),(556,201000.00,'2026-01-10','do gia dung',20,1,'VND'),(557,301000.00,'2026-01-11','mua quan ao',19,1,'VND'),(558,201000.00,'2026-01-11','do gia dung',20,1,'VND'),(559,801000.00,'2026-01-11','thiet bi dien tu',24,1,'VND'),(560,151000.00,'2026-01-11','hoa & qua',25,1,'VND'),(561,201000.00,'2026-01-12','do gia dung',20,1,'VND'),(562,801000.00,'2026-01-12','thiet bi dien tu',24,1,'VND'),(563,151000.00,'2026-01-12','hoa & qua',25,1,'VND'),(564,301000.00,'2026-01-12','mua sam truc tiep',21,1,'VND'),(565,61000.00,'2026-01-12','taxi',32,1,'VND'),(566,801000.00,'2026-01-13','thiet bi dien tu',24,1,'VND'),(567,151000.00,'2026-01-13','hoa & qua',25,1,'VND'),(568,301000.00,'2026-01-13','mua sam truc tiep',21,1,'VND'),(569,151000.00,'2026-01-14','hoa & qua',25,1,'VND'),(570,301000.00,'2026-01-14','mua sam truc tiep',21,1,'VND'),(571,61000.00,'2026-01-14','taxi',32,1,'VND'),(572,51000.00,'2026-01-14','phi giao thong',31,1,'VND'),(573,301000.00,'2026-01-15','mua sam truc tiep',21,1,'VND'),(574,61000.00,'2026-01-15','taxi',32,1,'VND'),(575,51000.00,'2026-01-15','phi giao thong',31,1,'VND'),(576,801000.00,'2026-01-15','tra no the',37,1,'VND'),(577,1501000.00,'2026-01-15','tra no vay',38,1,'VND'),(578,61000.00,'2026-01-16','taxi',32,1,'VND'),(579,51000.00,'2026-01-16','phi giao thong',31,1,'VND'),(580,801000.00,'2026-01-16','tra no the',37,1,'VND'),(581,51000.00,'2026-01-17','phi giao thong',31,1,'VND'),(582,801000.00,'2026-01-17','tra no the',37,1,'VND'),(583,1501000.00,'2026-01-17','tra no vay',38,1,'VND'),(584,501000.00,'2026-01-17','tiet kiem',43,1,'VND'),(585,801000.00,'2026-01-18','tra no the',37,1,'VND'),(586,1501000.00,'2026-01-18','tra no vay',38,1,'VND'),(587,501000.00,'2026-01-18','tiet kiem',43,1,'VND'),(588,802000.00,'2026-01-18','dau tu',44,1,'VND'),(589,302000.00,'2026-01-18','phi thuong nien',51,1,'VND'),(590,1501000.00,'2026-01-19','tra no vay',38,1,'VND'),(591,501000.00,'2026-01-19','tiet kiem',43,1,'VND'),(592,801000.00,'2026-01-19','dau tu',44,1,'VND'),(593,501000.00,'2026-01-20','tiet kiem',43,1,'VND'),(594,801000.00,'2026-01-20','dau tu',44,1,'VND'),(595,302000.00,'2026-01-20','phi thuong nien',51,1,'VND'),(596,202000.00,'2026-01-20','dich vu cong',49,1,'VND'),(597,801000.00,'2026-01-21','dau tu',44,1,'VND'),(598,302000.00,'2026-01-21','phi thuong nien',51,1,'VND'),(599,202000.00,'2026-01-21','dich vu cong',49,1,'VND'),(600,32000.00,'2026-01-21','ca phe',2,1,'VND'),(601,82000.00,'2026-01-21','an ngoai',3,1,'VND'),(602,301000.00,'2026-01-22','phi thuong nien',51,1,'VND'),(603,202000.00,'2026-01-22','dich vu cong',49,1,'VND'),(604,32000.00,'2026-01-22','ca phe',2,1,'VND'),(605,202000.00,'2026-01-23','dich vu cong',49,1,'VND'),(606,32000.00,'2026-01-23','ca phe',2,1,'VND'),(607,82000.00,'2026-01-23','an ngoai',3,1,'VND'),(608,122000.00,'2026-01-23','sieu thi',22,1,'VND'),(609,32000.00,'2026-01-24','ca phe',2,1,'VND'),(610,82000.00,'2026-01-24','an ngoai',3,1,'VND'),(611,122000.00,'2026-01-24','sieu thi',22,1,'VND'),(612,62000.00,'2026-01-24','tap hoa',8,1,'VND'),(613,122000.00,'2026-01-24','xang xe',6,1,'VND'),(614,82000.00,'2026-01-25','an ngoai',3,1,'VND'),(615,122000.00,'2026-01-25','sieu thi',22,1,'VND'),(616,62000.00,'2026-01-25','tap hoa',8,1,'VND'),(617,122000.00,'2026-01-26','sieu thi',22,1,'VND'),(618,62000.00,'2026-01-26','tap hoa',8,1,'VND'),(619,122000.00,'2026-01-26','xang xe',6,1,'VND'),(620,302000.00,'2026-01-26','tien dien',4,1,'VND'),(621,62000.00,'2026-01-27','tap hoa',8,1,'VND'),(622,122000.00,'2026-01-27','xang xe',6,1,'VND'),(623,302000.00,'2026-01-27','tien dien',4,1,'VND'),(624,122000.00,'2026-01-27','tien nuoc',5,1,'VND'),(625,502000.00,'2026-01-27','phi dich vu can ho',9,1,'VND'),(626,122000.00,'2026-01-28','xang xe',6,1,'VND'),(627,302000.00,'2026-01-28','tien dien',4,1,'VND'),(628,122000.00,'2026-01-28','tien nuoc',5,1,'VND'),(629,302000.00,'2026-01-29','tien dien',4,1,'VND'),(630,122000.00,'2026-01-29','tien nuoc',5,1,'VND'),(631,502000.00,'2026-01-29','phi dich vu can ho',9,1,'VND'),(632,2502000.00,'2026-01-29','thue nha',10,1,'VND'),(633,122000.00,'2026-01-30','tien nuoc',5,1,'VND'),(634,502000.00,'2026-01-30','phi dich vu can ho',9,1,'VND'),(635,2502000.00,'2026-01-30','thue nha',10,1,'VND'),(636,202000.00,'2026-01-30','gym',28,1,'VND'),(637,302000.00,'2026-01-30','spa',29,1,'VND'),(638,502000.00,'2026-01-31','phi dich vu can ho',9,1,'VND'),(639,2502000.00,'2026-01-31','thue nha',10,1,'VND'),(640,202000.00,'2026-01-31','gym',28,1,'VND'),(641,2501000.00,'2026-02-01','thue nha',10,1,'VND'),(642,201000.00,'2026-02-01','gym',28,1,'VND'),(643,301000.00,'2026-02-01','spa',29,1,'VND'),(644,51000.00,'2026-02-01','mua thuoc',27,1,'VND'),(645,201000.00,'2026-02-02','gym',28,1,'VND'),(646,301000.00,'2026-02-02','spa',29,1,'VND'),(647,51000.00,'2026-02-02','mua thuoc',27,1,'VND'),(648,501000.00,'2026-02-02','kham benh',30,1,'VND'),(649,301000.00,'2026-02-02','mua quan ao',19,1,'VND'),(650,301000.00,'2026-02-03','spa',29,1,'VND'),(651,51000.00,'2026-02-03','mua thuoc',27,1,'VND'),(652,501000.00,'2026-02-03','kham benh',30,1,'VND'),(653,51000.00,'2026-02-04','mua thuoc',27,1,'VND'),(654,501000.00,'2026-02-04','kham benh',30,1,'VND'),(655,301000.00,'2026-02-04','mua quan ao',19,1,'VND'),(656,201000.00,'2026-02-04','do gia dung',20,1,'VND'),(657,501000.00,'2026-02-05','kham benh',30,1,'VND'),(658,301000.00,'2026-02-05','mua quan ao',19,1,'VND'),(659,201000.00,'2026-02-05','do gia dung',20,1,'VND'),(660,801000.00,'2026-02-05','thiet bi dien tu',24,1,'VND'),(661,151000.00,'2026-02-05','hoa & qua',25,1,'VND'),(662,301000.00,'2026-02-06','mua quan ao',19,1,'VND'),(663,201000.00,'2026-02-06','do gia dung',20,1,'VND'),(664,801000.00,'2026-02-06','thiet bi dien tu',24,1,'VND'),(665,201000.00,'2026-02-07','do gia dung',20,1,'VND'),(666,801000.00,'2026-02-07','thiet bi dien tu',24,1,'VND'),(667,151000.00,'2026-02-07','hoa & qua',25,1,'VND'),(668,301000.00,'2026-02-07','mua sam truc tiep',21,1,'VND'),(669,801000.00,'2026-02-08','thiet bi dien tu',24,1,'VND'),(670,151000.00,'2026-02-08','hoa & qua',25,1,'VND'),(671,301000.00,'2026-02-08','mua sam truc tiep',21,1,'VND'),(672,61000.00,'2026-02-08','taxi',32,1,'VND'),(673,52000.00,'2026-02-08','phi giao thong',31,1,'VND'),(674,151000.00,'2026-02-09','hoa & qua',25,1,'VND'),(675,301000.00,'2026-02-09','mua sam truc tiep',21,1,'VND'),(676,61000.00,'2026-02-09','taxi',32,1,'VND'),(677,301000.00,'2026-02-10','mua sam truc tiep',21,1,'VND'),(678,61000.00,'2026-02-10','taxi',32,1,'VND'),(679,51000.00,'2026-02-10','phi giao thong',31,1,'VND'),(680,802000.00,'2026-02-10','tra no the',37,1,'VND'),(681,61000.00,'2026-02-11','taxi',32,1,'VND'),(682,51000.00,'2026-02-11','phi giao thong',31,1,'VND'),(683,801000.00,'2026-02-11','tra no the',37,1,'VND'),(684,1502000.00,'2026-02-11','tra no vay',38,1,'VND'),(685,502000.00,'2026-02-11','tiet kiem',43,1,'VND'),(686,51000.00,'2026-02-12','phi giao thong',31,1,'VND'),(687,801000.00,'2026-02-12','tra no the',37,1,'VND'),(688,1502000.00,'2026-02-12','tra no vay',38,1,'VND'),(689,801000.00,'2026-02-13','tra no the',37,1,'VND'),(690,1502000.00,'2026-02-13','tra no vay',38,1,'VND'),(691,502000.00,'2026-02-13','tiet kiem',43,1,'VND'),(692,802000.00,'2026-02-13','dau tu',44,1,'VND'),(693,1501000.00,'2026-02-14','tra no vay',38,1,'VND'),(694,502000.00,'2026-02-14','tiet kiem',43,1,'VND'),(695,802000.00,'2026-02-14','dau tu',44,1,'VND'),(696,302000.00,'2026-02-14','phi thuong nien',51,1,'VND'),(697,202000.00,'2026-02-14','dich vu cong',49,1,'VND'),(698,502000.00,'2026-02-15','tiet kiem',43,1,'VND'),(699,802000.00,'2026-02-15','dau tu',44,1,'VND'),(700,302000.00,'2026-02-15','phi thuong nien',51,1,'VND'),(701,802000.00,'2026-02-16','dau tu',44,1,'VND'),(702,302000.00,'2026-02-16','phi thuong nien',51,1,'VND'),(703,202000.00,'2026-02-16','dich vu cong',49,1,'VND'),(704,32000.00,'2026-02-16','ca phe',2,1,'VND'),(705,302000.00,'2026-02-17','phi thuong nien',51,1,'VND'),(706,202000.00,'2026-02-17','dich vu cong',49,1,'VND'),(707,32000.00,'2026-02-17','ca phe',2,1,'VND'),(708,82000.00,'2026-02-17','an ngoai',3,1,'VND'),(709,122000.00,'2026-02-17','sieu thi',22,1,'VND'),(710,202000.00,'2026-02-18','dich vu cong',49,1,'VND'),(711,32000.00,'2026-02-18','ca phe',2,1,'VND'),(712,82000.00,'2026-02-18','an ngoai',3,1,'VND'),(713,32000.00,'2026-02-19','ca phe',2,1,'VND'),(714,82000.00,'2026-02-19','an ngoai',3,1,'VND'),(715,122000.00,'2026-02-19','sieu thi',22,1,'VND'),(716,62000.00,'2026-02-19','tap hoa',8,1,'VND'),(717,82000.00,'2026-02-20','an ngoai',3,1,'VND'),(718,122000.00,'2026-02-20','sieu thi',22,1,'VND'),(719,62000.00,'2026-02-20','tap hoa',8,1,'VND'),(720,122000.00,'2026-02-20','xang xe',6,1,'VND'),(721,302000.00,'2026-02-20','tien dien',4,1,'VND'),(722,122000.00,'2026-02-21','sieu thi',22,1,'VND'),(723,62000.00,'2026-02-21','tap hoa',8,1,'VND'),(724,122000.00,'2026-02-21','xang xe',6,1,'VND'),(725,62000.00,'2026-02-22','tap hoa',8,1,'VND'),(726,122000.00,'2026-02-22','xang xe',6,1,'VND'),(727,302000.00,'2026-02-22','tien dien',4,1,'VND'),(728,122000.00,'2026-02-22','tien nuoc',5,1,'VND'),(729,122000.00,'2026-02-23','xang xe',6,1,'VND'),(730,302000.00,'2026-02-23','tien dien',4,1,'VND'),(731,122000.00,'2026-02-23','tien nuoc',5,1,'VND'),(732,502000.00,'2026-02-23','phi dich vu can ho',9,1,'VND'),(733,2502000.00,'2026-02-23','thue nha',10,1,'VND'),(734,302000.00,'2026-02-24','tien dien',4,1,'VND'),(735,122000.00,'2026-02-24','tien nuoc',5,1,'VND'),(736,502000.00,'2026-02-24','phi dich vu can ho',9,1,'VND'),(737,122000.00,'2026-02-25','tien nuoc',5,1,'VND'),(738,502000.00,'2026-02-25','phi dich vu can ho',9,1,'VND'),(739,2502000.00,'2026-02-25','thue nha',10,1,'VND'),(740,202000.00,'2026-02-25','gym',28,1,'VND'),(741,502000.00,'2026-02-26','phi dich vu can ho',9,1,'VND'),(742,2502000.00,'2026-02-26','thue nha',10,1,'VND'),(743,202000.00,'2026-02-26','gym',28,1,'VND'),(744,302000.00,'2026-02-26','spa',29,1,'VND'),(745,52000.00,'2026-02-26','mua thuoc',27,1,'VND'),(746,2502000.00,'2026-02-27','thue nha',10,1,'VND'),(747,202000.00,'2026-02-27','gym',28,1,'VND'),(748,302000.00,'2026-02-27','spa',29,1,'VND'),(749,202000.00,'2026-02-28','gym',28,1,'VND'),(750,302000.00,'2026-02-28','spa',29,1,'VND'),(751,52000.00,'2026-02-28','mua thuoc',27,1,'VND'),(752,502000.00,'2026-02-28','kham benh',30,1,'VND'),(753,301000.00,'2026-03-01','spa',29,1,'VND'),(754,51000.00,'2026-03-01','mua thuoc',27,1,'VND'),(755,501000.00,'2026-03-01','kham benh',30,1,'VND'),(756,301000.00,'2026-03-01','mua quan ao',19,1,'VND'),(757,202000.00,'2026-03-01','do gia dung',20,1,'VND'),(758,51000.00,'2026-03-02','mua thuoc',27,1,'VND'),(759,501000.00,'2026-03-02','kham benh',30,1,'VND'),(760,301000.00,'2026-03-02','mua quan ao',19,1,'VND'),(761,501000.00,'2026-03-03','kham benh',30,1,'VND'),(762,301000.00,'2026-03-03','mua quan ao',19,1,'VND'),(763,201000.00,'2026-03-03','do gia dung',20,1,'VND'),(764,802000.00,'2026-03-03','thiet bi dien tu',24,1,'VND');
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
