-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 20, 2026 at 10:15 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `expense_tracker`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add category', 7, 'add_category'),
(26, 'Can change category', 7, 'change_category'),
(27, 'Can delete category', 7, 'delete_category'),
(28, 'Can view category', 7, 'view_category'),
(29, 'Can add expense', 8, 'add_expense'),
(30, 'Can change expense', 8, 'change_expense'),
(31, 'Can delete expense', 8, 'delete_expense'),
(32, 'Can view expense', 8, 'view_expense');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$600000$zfTX3Fbaym0lZ3UE9YTFI6$gRjW2lOop1atyn9CVozAGITC8rKfYghwH58G3iOq264=', '2026-01-20 08:56:33.517297', 1, 'admin', '', '', '', 1, 1, '2026-01-20 00:47:23.078019');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(7, 'expenses', 'category'),
(8, 'expenses', 'expense'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-01-20 00:46:49.951020'),
(2, 'auth', '0001_initial', '2026-01-20 00:46:50.374221'),
(3, 'admin', '0001_initial', '2026-01-20 00:46:50.471808'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-01-20 00:46:50.480470'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-01-20 00:46:50.489496'),
(6, 'contenttypes', '0002_remove_content_type_name', '2026-01-20 00:46:50.532247'),
(7, 'auth', '0002_alter_permission_name_max_length', '2026-01-20 00:46:50.568732'),
(8, 'auth', '0003_alter_user_email_max_length', '2026-01-20 00:46:50.581910'),
(9, 'auth', '0004_alter_user_username_opts', '2026-01-20 00:46:50.589203'),
(10, 'auth', '0005_alter_user_last_login_null', '2026-01-20 00:46:50.627782'),
(11, 'auth', '0006_require_contenttypes_0002', '2026-01-20 00:46:50.630616'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2026-01-20 00:46:50.637569'),
(13, 'auth', '0008_alter_user_username_max_length', '2026-01-20 00:46:50.648778'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2026-01-20 00:46:50.660407'),
(15, 'auth', '0010_alter_group_name_max_length', '2026-01-20 00:46:50.671826'),
(16, 'auth', '0011_update_proxy_permissions', '2026-01-20 00:46:50.679388'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2026-01-20 00:46:50.689429'),
(18, 'expenses', '0001_initial', '2026-01-20 00:46:50.815828'),
(19, 'sessions', '0001_initial', '2026-01-20 00:46:50.845423'),
(20, 'expenses', '0002_expense_currency', '2026-01-20 01:17:01.324494');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('mzryk5yxtphanpjd6wkfv3tzsv0koyx8', '.eJxVjEEOwiAQRe_C2hBaGGFcuvcMZJhBqRpISrsy3l2bdKHb_977LxVpXUpce57jJOqkBnX43RLxI9cNyJ3qrWludZmnpDdF77TrS5P8PO_u30GhXr41ILhrsIEsBTJi0-DBWyb0AY9isiBYYh4TIKP4xIyAzokImCRmVO8P26s4FA:1vi7XN:nMShjjbq9DxMr0nYQRE8Atuhz59_JwF9VB59-HEv3sk', '2026-02-03 08:56:33.519844');

-- --------------------------------------------------------

--
-- Table structure for table `expenses_category`
--

CREATE TABLE `expenses_category` (
  `id` bigint(20) NOT NULL,
  `name` varchar(100) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses_category`
--

INSERT INTO `expenses_category` (`id`, `name`, `user_id`) VALUES
(1, 'Thực phẩm - Đồ uống - Nguyên liệu thực phẩm', 1),
(2, 'Thực phẩm - Đồ uống - Bánh và đồ uống', 1),
(3, 'Thực phẩm - Đồ uống - Nhà hàng quán ăn', 1),
(4, 'Sinh hoạt - Tiện ích - Điện', 1),
(5, 'Sinh hoạt - Tiện ích - Nước', 1),
(6, 'Sinh hoạt - Tiện ích - Xăng dầu', 1),
(7, 'Sinh hoạt - Tiện ích - Truyền hình - Viễn thông', 1),
(8, 'Sinh hoạt - Tiện ích - Tạp hoá', 1),
(9, 'Sinh hoạt - Tiện ích - Phí dịch vụ căn hộ', 1),
(10, 'Sinh hoạt - Tiện ích - Thuê nhà', 1),
(11, 'Sinh hoạt - Tiện ích - Tiện ích khác', 1),
(12, 'Con cái - Gia đình - Trẻ em & người lớn tuổi', 1),
(13, 'Con cái - Gia đình - Vật nuôi', 1),
(14, 'Con cái - Gia đình - Tiêu vặt', 1),
(15, 'Con cái - Gia đình - Học phí', 1),
(16, 'Con cái - Gia đình - Hỗ trợ giáo dục', 1),
(17, 'Con cái - Gia đình - Nội thất & thiết bị', 1),
(18, 'Con cái - Gia đình - Tôn giáo & tâm linh', 1),
(19, 'Mua sắm - Quần áo & phụ kiện', 1),
(20, 'Mua sắm - Đồ gia dụng', 1),
(21, 'Mua sắm - Mua sắm trực tiếp', 1),
(22, 'Mua sắm - Siêu thị/TTTM', 1),
(23, 'Mua sắm - Sản phẩm cao cấp', 1),
(24, 'Mua sắm - Thiết bị điện tử', 1),
(25, 'Mua sắm - Hoa tươi & quà tặng', 1),
(26, 'Mua sắm - Mua sẵm khác', 1),
(27, 'Sức khoẻ & Làm đẹp - Dược phẩm & y tế', 1),
(28, 'Sức khoẻ & Làm đẹp - Thể dục thể thao', 1),
(29, 'Sức khoẻ & Làm đẹp - Làm đẹp & Spa', 1),
(30, 'Sức khoẻ & Làm đẹp - Khám chữa bệnh', 1),
(31, 'Đi lại & Giao thông - Phí giao thông & chuyển phát', 1),
(32, 'Đi lại & Giao thông - Phương tiện đi lại', 1),
(33, 'Giải trí & Du lịch - Dịch vụ lưu trú', 1),
(34, 'Giải trí & Du lịch - Du lịch & điểm vui chơi', 1),
(35, 'Giải trí & Du lịch - Phim ảnh & sự kiện', 1),
(36, 'Giải trí & Du lịch - Trò chơi', 1),
(37, 'Chi phí tài chỉnh - Trả nợ thẻ tín dụng', 1),
(38, 'Chi phí tài chỉnh - Trả nợ vay', 1),
(39, 'Chi phí tài chỉnh - Tài chỉnh khác', 1),
(40, 'Tăng quà & Từ thiện - Thiện nguyện', 1),
(41, 'Tăng quà & Từ thiện - Cho tặng', 1),
(42, 'Tăng quà & Từ thiện - Hiếu hỉ', 1),
(43, 'Tiết kiệm & Đầu tư - Tiết kiệm', 1),
(44, 'Tiết kiệm & Đầu tư - Đầu tư', 1),
(45, 'Tiết kiệm & Đầu tư - Cho vay', 1),
(46, 'Tiết kiệm & Đầu tư - Bảo hiểm nhân thọ', 1),
(47, 'Khác - Chi phí khác', 1),
(48, 'Khác - Chưa phân loại', 1),
(49, 'Khác - Dịch vụ công', 1),
(50, 'Khác - Hỗ trợ kinh doanh', 1),
(51, 'Khác - Phí thường niên', 1);

-- --------------------------------------------------------

--
-- Table structure for table `expenses_expense`
--

CREATE TABLE `expenses_expense` (
  `id` bigint(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `date` date NOT NULL,
  `description` longtext NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `currency` varchar(3) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses_expense`
--

INSERT INTO `expenses_expense` (`id`, `amount`, `date`, `description`, `category_id`, `user_id`, `currency`) VALUES
(179, 2350000.00, '2025-12-19', 'phí thường niên', 49, 1, 'VND'),
(180, 1620000.00, '2025-08-11', 'phí thường niên', 47, 1, 'VND'),
(181, 3340000.00, '2026-01-01', 'trò chơi', 33, 1, 'VND'),
(182, 3780000.00, '2026-01-11', 'hoa & quà', 23, 1, 'VND'),
(183, 380000.00, '2025-11-22', 'đầu tư', 43, 1, 'VND'),
(184, 2720000.00, '2025-11-05', 'chi phí khác', 12, 1, 'VND'),
(185, 650000.00, '2025-12-29', 'dịch vụ công', 49, 1, 'VND'),
(186, 2060000.00, '2025-10-18', 'trả nợ thẻ', 37, 1, 'VND'),
(187, 1320000.00, '2025-11-04', 'trả nợ vay', 38, 1, 'VND'),
(188, 2690000.00, '2025-12-12', 'phí thường niên', 49, 1, 'VND'),
(189, 2270000.00, '2025-12-09', 'chi phí khác', 4, 1, 'VND'),
(190, 30000.00, '2025-07-30', 'mua thuốc', 30, 1, 'VND'),
(191, 20000.00, '2026-01-18', 'mua thuốc', 29, 1, 'VND'),
(192, 3500000.00, '2025-11-07', 'khám bệnh', 27, 1, 'VND'),
(193, 4500000.00, '2025-10-30', 'mua online', 25, 1, 'VND'),
(194, 1750000.00, '2025-12-23', 'bảo hiểm', 46, 1, 'VND'),
(195, 610000.00, '2025-10-26', 'spa', 28, 1, 'VND'),
(196, 1120000.00, '2025-10-11', 'hoa & quà', 21, 1, 'VND'),
(197, 4590000.00, '2025-08-29', 'chi phí khác', 17, 1, 'VND'),
(198, 4060000.00, '2025-09-16', 'chi phí khác', 14, 1, 'VND'),
(199, 2390000.00, '2025-10-10', 'phí thường niên', 49, 1, 'VND'),
(200, 4280000.00, '2025-08-10', 'spa', 28, 1, 'VND'),
(201, 2350000.00, '2025-10-26', 'chi phí khác', 18, 1, 'VND'),
(202, 3310000.00, '2025-09-05', 'hoa & quà', 21, 1, 'VND'),
(203, 2920000.00, '2025-10-01', 'mua thuốc', 29, 1, 'VND'),
(204, 310000.00, '2025-09-01', 'gym', 27, 1, 'VND'),
(205, 650000.00, '2025-12-09', 'bảo hiểm', 43, 1, 'VND'),
(206, 500000.00, '2025-07-28', 'chi phí khác', 5, 1, 'VND'),
(207, 2690000.00, '2025-12-11', 'phí ngân hàng', 38, 1, 'VND'),
(208, 4240000.00, '2025-10-24', 'chi phí khác', 14, 1, 'VND'),
(209, 630000.00, '2025-10-02', 'chi phí khác', 6, 1, 'VND'),
(210, 2110000.00, '2025-12-20', 'chi phí khác', 15, 1, 'VND'),
(211, 2270000.00, '2025-08-08', 'dịch vụ công', 47, 1, 'VND'),
(212, 2820000.00, '2025-09-09', 'chi phí khác', 8, 1, 'VND'),
(213, 3970000.00, '2025-12-15', 'chi phí khác', 8, 1, 'VND'),
(214, 3450000.00, '2025-10-26', 'thiết bị điện tử', 19, 1, 'VND'),
(215, 2920000.00, '2025-11-14', 'chi phí khác', 16, 1, 'VND'),
(216, 2180000.00, '2025-09-04', 'chi phí khác', 5, 1, 'VND'),
(217, 1940000.00, '2025-08-07', 'gym', 27, 1, 'VND'),
(218, 4800000.00, '2025-11-20', 'chi phí khác', 9, 1, 'VND'),
(219, 2390000.00, '2025-10-25', 'chi phí khác', 10, 1, 'VND'),
(220, 4960000.00, '2025-10-01', 'chi phí khác', 6, 1, 'VND'),
(221, 3720000.00, '2025-09-21', 'spa', 27, 1, 'VND'),
(222, 290000.00, '2025-11-25', 'trả nợ thẻ', 39, 1, 'VND'),
(223, 190000.00, '2025-12-06', 'chi phí khác', 47, 1, 'VND'),
(224, 1670000.00, '2025-08-07', 'taxi', 32, 1, 'VND'),
(225, 4390000.00, '2025-12-06', 'chi phí khác', 10, 1, 'VND'),
(226, 860000.00, '2025-12-19', 'gửi tiết kiệm', 45, 1, 'VND'),
(227, 800000.00, '2025-10-27', 'vé xe buýt', 32, 1, 'VND'),
(228, 1280000.00, '2025-11-14', 'chi phí khác', 16, 1, 'VND'),
(229, 4800000.00, '2025-08-26', 'chi phí khác', 1, 1, 'VND'),
(230, 2370000.00, '2025-10-23', 'khách sạn', 33, 1, 'VND'),
(231, 4090000.00, '2025-12-27', 'chi phí khác', 10, 1, 'VND'),
(232, 170000.00, '2025-09-08', 'chi phí khác', 6, 1, 'VND'),
(233, 1050000.00, '2025-09-19', 'gym', 28, 1, 'VND'),
(234, 1920000.00, '2025-07-29', 'thiết bị điện tử', 21, 1, 'VND'),
(235, 4400000.00, '2025-10-24', 'trả nợ thẻ', 37, 1, 'VND'),
(236, 1280000.00, '2025-11-27', 'siêu thị', 19, 1, 'VND'),
(237, 3900000.00, '2025-12-20', 'du lịch', 36, 1, 'VND'),
(238, 3490000.00, '2026-01-09', 'sự kiện', 36, 1, 'VND'),
(239, 730000.00, '2025-09-08', 'sự kiện', 36, 1, 'VND'),
(240, 1030000.00, '2025-11-20', 'mua thuốc', 30, 1, 'VND'),
(241, 1690000.00, '2025-08-19', 'đồ gia dụng', 25, 1, 'VND'),
(242, 1720000.00, '2025-12-19', 'trò chơi', 36, 1, 'VND'),
(243, 430000.00, '2025-10-21', 'siêu thị', 26, 1, 'VND'),
(244, 2530000.00, '2025-10-09', 'đầu tư', 44, 1, 'VND'),
(245, 4410000.00, '2025-08-17', 'khám bệnh', 29, 1, 'VND'),
(246, 1370000.00, '2025-11-21', 'từ thiện', 40, 1, 'VND'),
(247, 2990000.00, '2025-11-18', 'chi phí khác', 2, 1, 'VND'),
(248, 1190000.00, '2025-08-21', 'đầu tư', 44, 1, 'VND'),
(249, 4300000.00, '2025-09-19', 'trả nợ vay', 37, 1, 'VND'),
(250, 660000.00, '2025-08-23', 'thiết bị điện tử', 26, 1, 'VND'),
(251, 520000.00, '2025-11-28', 'đầu tư', 44, 1, 'VND'),
(252, 4100000.00, '2026-01-15', 'du lịch', 36, 1, 'VND'),
(253, 4390000.00, '2025-10-20', 'dịch vụ công', 50, 1, 'VND'),
(254, 2380000.00, '2025-09-26', 'trả nợ thẻ', 37, 1, 'VND'),
(255, 4800000.00, '2025-12-11', 'chi phí khác', 3, 1, 'VND'),
(256, 1720000.00, '2025-08-04', 'trả nợ thẻ', 37, 1, 'VND'),
(257, 2830000.00, '2025-10-30', 'khách sạn', 34, 1, 'VND'),
(258, 3180000.00, '2025-09-08', 'vé xe buýt', 32, 1, 'VND');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `expenses_category`
--
ALTER TABLE `expenses_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expenses_category_user_id_9d8b51ca_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `expenses_expense`
--
ALTER TABLE `expenses_expense`
  ADD PRIMARY KEY (`id`),
  ADD KEY `expenses_expense_category_id_aa33bbdd_fk_expenses_category_id` (`category_id`),
  ADD KEY `expenses_expense_user_id_ab1aae2b_fk_auth_user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `expenses_category`
--
ALTER TABLE `expenses_category`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `expenses_expense`
--
ALTER TABLE `expenses_expense`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=259;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `expenses_category`
--
ALTER TABLE `expenses_category`
  ADD CONSTRAINT `expenses_category_user_id_9d8b51ca_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `expenses_expense`
--
ALTER TABLE `expenses_expense`
  ADD CONSTRAINT `expenses_expense_category_id_aa33bbdd_fk_expenses_category_id` FOREIGN KEY (`category_id`) REFERENCES `expenses_category` (`id`),
  ADD CONSTRAINT `expenses_expense_user_id_ab1aae2b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
