-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               5.7.33 - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for vue_hotel
CREATE DATABASE IF NOT EXISTS `vue_hotel` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `vue_hotel`;

-- Dumping structure for table vue_hotel.failed_jobs
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.failed_jobs: ~0 rows (approximately)
DELETE FROM `failed_jobs`;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.floors
CREATE TABLE IF NOT EXISTS `floors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.floors: ~2 rows (approximately)
DELETE FROM `floors`;
/*!40000 ALTER TABLE `floors` DISABLE KEYS */;
INSERT INTO `floors` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Floor 1', '2023-05-28 11:14:11', '2023-05-28 11:14:18', NULL),
	(2, 'Floor 2', '2023-05-28 11:14:16', '2023-05-28 11:14:18', NULL),
	(3, 'Floor 3', '2023-05-28 11:14:24', '2023-05-28 11:14:25', NULL);
/*!40000 ALTER TABLE `floors` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.guests
CREATE TABLE IF NOT EXISTS `guests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lname` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `guests_email_unique` (`email`),
  KEY `guests_fname_lname_index` (`fname`,`lname`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.guests: ~9 rows (approximately)
DELETE FROM `guests`;
/*!40000 ALTER TABLE `guests` DISABLE KEYS */;
INSERT INTO `guests` (`id`, `title`, `fname`, `lname`, `phone`, `email`, `address`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(8, 'Dr', 'Cheng', 'Sang', '0906222555', NULL, NULL, NULL, '2023-06-14 11:50:16', '2023-06-14 11:50:16', NULL),
	(9, 'Mr', 'Hong', 'Nhung', '0906333555', NULL, NULL, NULL, '2023-06-14 11:51:52', '2023-06-14 11:51:52', NULL),
	(10, 'Mrs', 'Sang', 'Mon', '0777333222', NULL, NULL, NULL, '2023-06-14 11:52:13', '2023-06-14 11:52:13', NULL),
	(11, 'Mr', 'Cao', 'Lam', '0906222444', NULL, NULL, NULL, '2023-06-14 11:52:26', '2023-06-14 11:52:26', NULL),
	(12, 'Prof', 'Jack', 'Son', '0222333444', NULL, NULL, NULL, '2023-06-14 11:52:52', '2023-06-14 11:52:52', NULL),
	(13, 'Mr', 'Louis', 'Ng', '0112333444', 'louis@gmail.com', '626 Foster Street Middle Village, NY 11379', NULL, '2023-06-14 11:53:38', '2023-06-14 11:53:38', NULL),
	(14, 'Mr', 'Soma', 'Kaguchi', '0723845623', 'soma@gmail.com', '86 W. Ocean St. Rego Park, NY 11374', 'VIP', '2023-06-14 11:54:14', '2023-06-14 11:54:14', NULL),
	(15, 'Mrs', 'Alice', 'San', '0222333444', NULL, '626 Foster Street Middle Village, NY 11379', NULL, '2023-06-14 11:54:52', '2023-06-14 11:54:52', NULL),
	(16, 'Mrs', 'Mille', 'Tin', '0902223331', NULL, NULL, NULL, '2023-06-14 11:55:15', '2023-06-14 11:55:15', NULL),
	(17, 'Dr', 'Sockr', 'Zzi', '0333444555', NULL, NULL, NULL, '2023-06-14 11:55:36', '2023-06-14 11:55:36', NULL),
	(18, 'Mrs', 'Mento', 'Sikr', '0777634607', NULL, '7062 East Lexington Ave. Westbury, NY 11590', NULL, '2023-06-14 11:56:19', '2023-06-14 11:56:19', NULL);
/*!40000 ALTER TABLE `guests` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.images
CREATE TABLE IF NOT EXISTS `images` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `room_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `images_room_id_foreign` (`room_id`),
  KEY `images_name_index` (`name`),
  CONSTRAINT `images_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.images: ~78 rows (approximately)
DELETE FROM `images`;
/*!40000 ALTER TABLE `images` DISABLE KEYS */;
INSERT INTO `images` (`id`, `name`, `room_id`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(41, 'room-4.jpg', 23, '2023-05-28 07:59:54', '2023-06-13 11:38:00', '2023-06-13 11:38:00'),
	(42, 'room-5.jpg', 24, '2023-05-28 08:08:10', '2023-05-28 09:44:47', '2023-05-28 09:44:47'),
	(43, 'room-6.jpg', 25, '2023-05-28 08:09:03', '2023-05-28 08:09:42', '2023-05-28 08:09:42'),
	(44, 'room-5.jpg', 26, '2023-05-28 08:09:21', '2023-06-13 11:48:53', '2023-06-13 11:48:53'),
	(45, 'room-6.jpg', 25, '2023-05-28 08:09:42', '2023-05-28 08:09:51', '2023-05-28 08:09:51'),
	(46, 'room-6.jpg', 25, '2023-05-28 08:09:51', '2023-05-28 08:13:45', '2023-05-28 08:13:45'),
	(47, 'room-6.jpg', 25, '2023-05-28 08:13:45', '2023-06-13 11:53:48', '2023-06-13 11:53:48'),
	(48, 'room-5.jpg', 24, '2023-05-28 09:44:47', '2023-05-28 09:45:01', '2023-05-28 09:45:01'),
	(49, 'room-5.jpg', 24, '2023-05-28 09:45:01', '2023-05-28 09:45:35', '2023-05-28 09:45:35'),
	(50, 'room-5.jpg', 24, '2023-05-28 09:45:36', '2023-05-28 09:46:42', '2023-05-28 09:46:42'),
	(51, 'room-5.jpg', 24, '2023-05-28 09:46:42', '2023-05-28 09:47:14', '2023-05-28 09:47:14'),
	(52, 'room-5.jpg', 24, '2023-05-28 09:47:14', '2023-05-28 09:47:22', '2023-05-28 09:47:22'),
	(53, 'room-5.jpg', 24, '2023-05-28 09:47:22', '2023-06-13 11:51:51', '2023-06-13 11:51:51'),
	(54, 'room-4.jpg', 23, '2023-06-13 11:38:00', '2023-06-13 11:39:00', '2023-06-13 11:39:00'),
	(55, 'room-4.jpg', 23, '2023-06-13 11:39:00', '2023-06-13 11:39:27', '2023-06-13 11:39:27'),
	(56, 'room-4.jpg', 23, '2023-06-13 11:39:27', '2023-06-13 11:39:56', '2023-06-13 11:39:56'),
	(57, 'room-4.jpg', 23, '2023-06-13 11:39:56', '2023-06-13 11:40:44', '2023-06-13 11:40:44'),
	(58, 'room-5.jpg', 23, '2023-06-13 11:40:44', '2023-06-13 11:40:44', NULL),
	(59, 'room-4.jpg', 23, '2023-06-13 11:40:44', '2023-06-13 11:40:44', NULL),
	(60, 'alen-kajtezovic-d5aIXRApA4k-unsplash.jpg', 27, '2023-06-13 11:43:30', '2023-06-13 11:57:25', '2023-06-13 11:57:25'),
	(61, 'hans-eiskonen-PotGJdsW06k-unsplash.jpg', 27, '2023-06-13 11:43:30', '2023-06-13 11:57:25', '2023-06-13 11:57:25'),
	(62, 'kam-idris-kyt0PkBSCNQ-unsplash.jpg', 27, '2023-06-13 11:43:30', '2023-06-13 11:57:25', '2023-06-13 11:57:25'),
	(63, 'cat-han-VgyN_CWXQVM-unsplash.jpg', 28, '2023-06-13 11:45:05', '2023-06-13 11:58:10', '2023-06-13 11:58:10'),
	(64, 'kyoshi-reyes-Ps_ujcY0oT8-unsplash.jpg', 28, '2023-06-13 11:45:05', '2023-06-13 11:58:10', '2023-06-13 11:58:10'),
	(65, '058a7e33c46044be18e4e51a21655cc6.jpg', 26, '2023-06-13 11:48:53', '2023-06-13 11:48:53', NULL),
	(66, 'a0e2cae85841e5c877b1af8cd43132bf.jpg', 26, '2023-06-13 11:48:53', '2023-06-13 11:48:53', NULL),
	(67, '464012b5e49fdad08602263041109931.jpg', 24, '2023-06-13 11:51:51', '2023-06-13 11:52:59', '2023-06-13 11:52:59'),
	(68, 'best-stargazing-places-Sossusvlei-desert-lodge.jpeg', 24, '2023-06-13 11:51:51', '2023-06-13 11:52:59', '2023-06-13 11:52:59'),
	(69, '464012b5e49fdad08602263041109931.jpg', 24, '2023-06-13 11:52:59', '2023-06-13 11:53:06', '2023-06-13 11:53:06'),
	(70, 'best-stargazing-places-Sossusvlei-desert-lodge.jpeg', 24, '2023-06-13 11:52:59', '2023-06-13 11:53:06', '2023-06-13 11:53:06'),
	(71, '464012b5e49fdad08602263041109931.jpg', 24, '2023-06-13 11:53:06', '2023-06-13 11:53:06', NULL),
	(72, 'best-stargazing-places-Sossusvlei-desert-lodge.jpeg', 24, '2023-06-13 11:53:06', '2023-06-13 11:53:06', NULL),
	(73, 'room-6.jpg', 25, '2023-06-13 11:53:48', '2023-06-13 11:56:52', '2023-06-13 11:56:52'),
	(74, '3f2f60f3e7c8e378ac10aa8d4d9ecf2687482e5d.47.9.26.3.jpg', 25, '2023-06-13 11:56:52', '2023-06-13 12:00:55', '2023-06-13 12:00:55'),
	(75, 'HOSHINOYA+Fuji+Review-.jpg', 25, '2023-06-13 11:56:52', '2023-06-13 12:00:55', '2023-06-13 12:00:55'),
	(76, 'alen-kajtezovic-d5aIXRApA4k-unsplash.jpg', 27, '2023-06-13 11:57:26', '2023-06-13 11:57:26', NULL),
	(77, 'kam-idris-kyt0PkBSCNQ-unsplash.jpg', 27, '2023-06-13 11:57:26', '2023-06-13 11:57:26', NULL),
	(78, 'cat-han-VgyN_CWXQVM-unsplash.jpg', 28, '2023-06-13 11:58:10', '2023-06-13 11:58:10', NULL),
	(79, 'kyoshi-reyes-Ps_ujcY0oT8-unsplash.jpg', 28, '2023-06-13 11:58:10', '2023-06-13 11:58:10', NULL),
	(80, '3f2f60f3e7c8e378ac10aa8d4d9ecf2687482e5d.47.9.26.3.jpg', 25, '2023-06-13 12:00:55', '2023-06-13 12:01:24', '2023-06-13 12:01:24'),
	(81, 'HOSHINOYA+Fuji+Review-.jpg', 25, '2023-06-13 12:00:55', '2023-06-13 12:01:24', '2023-06-13 12:01:24'),
	(82, '3f2f60f3e7c8e378ac10aa8d4d9ecf2687482e5d.47.9.26.3.jpg', 25, '2023-06-13 12:01:24', '2023-06-13 12:01:49', '2023-06-13 12:01:49'),
	(83, 'HOSHINOYA+Fuji+Review-.jpg', 25, '2023-06-13 12:01:24', '2023-06-13 12:01:49', '2023-06-13 12:01:49'),
	(84, '3f2f60f3e7c8e378ac10aa8d4d9ecf2687482e5d.47.9.26.3.jpg', 25, '2023-06-13 12:01:49', '2023-06-13 12:02:17', '2023-06-13 12:02:17'),
	(85, 'HOSHINOYA+Fuji+Review-.jpg', 25, '2023-06-13 12:01:49', '2023-06-13 12:02:17', '2023-06-13 12:02:17'),
	(86, '3f2f60f3e7c8e378ac10aa8d4d9ecf2687482e5d.47.9.26.3.jpg', 25, '2023-06-13 12:02:17', '2023-06-13 12:02:40', '2023-06-13 12:02:40'),
	(87, 'HOSHINOYA+Fuji+Review-.jpg', 25, '2023-06-13 12:02:17', '2023-06-13 12:02:40', '2023-06-13 12:02:40'),
	(88, '3f2f60f3e7c8e378ac10aa8d4d9ecf2687482e5d.47.9.26.3.jpg', 25, '2023-06-13 12:02:41', '2023-06-13 12:03:48', '2023-06-13 12:03:48'),
	(89, 'HOSHINOYA+Fuji+Review-.jpg', 25, '2023-06-13 12:02:41', '2023-06-13 12:03:48', '2023-06-13 12:03:48'),
	(90, '3f2f60f3e7c8e378ac10aa8d4d9ecf2687482e5d.47.9.26.3.jpg', 25, '2023-06-13 12:03:48', '2023-06-13 12:04:22', '2023-06-13 12:04:22'),
	(91, 'HOSHINOYA+Fuji+Review-.jpg', 25, '2023-06-13 12:03:48', '2023-06-13 12:04:22', '2023-06-13 12:04:22'),
	(92, '3f2f60f3e7c8e378ac10aa8d4d9ecf2687482e5d.47.9.26.3.jpg', 25, '2023-06-13 12:04:22', '2023-06-13 12:05:31', '2023-06-13 12:05:31'),
	(93, 'HOSHINOYA+Fuji+Review-.jpg', 25, '2023-06-13 12:04:22', '2023-06-13 12:05:31', '2023-06-13 12:05:31'),
	(94, '3f2f60f3e7c8e378ac10aa8d4d9ecf2687482e5d.47.9.26.3.jpg', 25, '2023-06-13 12:05:31', '2023-06-13 12:07:37', '2023-06-13 12:07:37'),
	(95, 'HOSHINOYA+Fuji+Review-.jpg', 25, '2023-06-13 12:05:31', '2023-06-13 12:07:37', '2023-06-13 12:07:37'),
	(96, '3f2f60f3e7c8e378ac10aa8d4d9ecf2687482e5d.47.9.26.3.jpg', 25, '2023-06-13 12:07:37', '2023-06-13 12:09:00', '2023-06-13 12:09:00'),
	(97, 'HOSHINOYA+Fuji+Review-.jpg', 25, '2023-06-13 12:07:37', '2023-06-13 12:09:00', '2023-06-13 12:09:00'),
	(98, '3f2f60f3e7c8e378ac10aa8d4d9ecf2687482e5d.47.9.26.3.jpg', 25, '2023-06-13 12:09:00', '2023-06-13 12:09:21', '2023-06-13 12:09:21'),
	(99, 'HOSHINOYA+Fuji+Review-.jpg', 25, '2023-06-13 12:09:00', '2023-06-13 12:09:21', '2023-06-13 12:09:21'),
	(100, '3f2f60f3e7c8e378ac10aa8d4d9ecf2687482e5d.47.9.26.3.jpg', 25, '2023-06-13 12:09:22', '2023-06-13 12:09:22', NULL),
	(101, 'HOSHINOYA+Fuji+Review-.jpg', 25, '2023-06-13 12:09:22', '2023-06-13 12:09:22', NULL),
	(102, 'roberto-nickson-rEJxpBskj3Q-unsplash.jpg', 29, '2023-06-14 11:58:51', '2023-06-14 12:00:28', '2023-06-14 12:00:28'),
	(103, 'michael-oxendine-GHCVUtBECuY-unsplash.jpg', 29, '2023-06-14 11:58:51', '2023-06-14 12:00:28', '2023-06-14 12:00:28'),
	(104, 'michael-oxendine-GHCVUtBECuY-unsplash.jpg', 30, '2023-06-14 11:59:57', '2023-06-14 12:00:15', '2023-06-14 12:00:15'),
	(105, 'roberto-nickson-rEJxpBskj3Q-unsplash.jpg', 30, '2023-06-14 11:59:57', '2023-06-14 12:00:15', '2023-06-14 12:00:15'),
	(106, 'michael-oxendine-GHCVUtBECuY-unsplash.jpg', 30, '2023-06-14 12:00:15', '2023-06-14 12:00:15', NULL),
	(107, 'roberto-nickson-rEJxpBskj3Q-unsplash.jpg', 30, '2023-06-14 12:00:15', '2023-06-14 12:00:15', NULL),
	(108, 'roberto-nickson-rEJxpBskj3Q-unsplash.jpg', 29, '2023-06-14 12:00:28', '2023-06-14 12:00:28', NULL),
	(109, 'michael-oxendine-GHCVUtBECuY-unsplash.jpg', 29, '2023-06-14 12:00:28', '2023-06-14 12:00:28', NULL),
	(110, 'michael-oxendine-GHCVUtBECuY-unsplash.jpg', 31, '2023-06-14 12:01:02', '2023-06-14 12:01:02', NULL),
	(111, 'roberto-nickson-rEJxpBskj3Q-unsplash.jpg', 31, '2023-06-14 12:01:02', '2023-06-14 12:01:02', NULL),
	(112, 'michael-oxendine-GHCVUtBECuY-unsplash.jpg', 32, '2023-06-14 12:01:47', '2023-06-14 12:01:47', NULL),
	(113, 'roberto-nickson-rEJxpBskj3Q-unsplash.jpg', 32, '2023-06-14 12:01:47', '2023-06-14 12:01:47', NULL),
	(114, 'cat-han-VgyN_CWXQVM-unsplash.jpg', 33, '2023-06-14 12:02:43', '2023-06-14 12:02:43', NULL),
	(115, 'christopher-jolly-GqbU78bdJFM-unsplash.jpg', 33, '2023-06-14 12:02:43', '2023-06-14 12:02:43', NULL),
	(116, 'kyoshi-reyes-Ps_ujcY0oT8-unsplash.jpg', 33, '2023-06-14 12:02:43', '2023-06-14 12:02:43', NULL),
	(117, 'cat-han-VgyN_CWXQVM-unsplash.jpg', 34, '2023-06-14 12:03:54', '2023-06-14 12:03:54', NULL),
	(118, 'christopher-jolly-GqbU78bdJFM-unsplash.jpg', 34, '2023-06-14 12:03:54', '2023-06-14 12:03:54', NULL),
	(119, 'alen-kajtezovic-d5aIXRApA4k-unsplash.jpg', 35, '2023-06-14 12:04:58', '2023-06-14 12:04:58', NULL),
	(120, 'kam-idris-kyt0PkBSCNQ-unsplash.jpg', 35, '2023-06-14 12:04:58', '2023-06-14 12:04:58', NULL),
	(121, 'kyoshi-reyes-Ps_ujcY0oT8-unsplash.jpg', 35, '2023-06-14 12:04:58', '2023-06-14 12:04:58', NULL);
/*!40000 ALTER TABLE `images` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.migrations: ~20 rows (approximately)
DELETE FROM `migrations`;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
	(1, '2014_10_12_100000_create_password_reset_tokens_table', 1),
	(2, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
	(3, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
	(4, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
	(5, '2016_06_01_000004_create_oauth_clients_table', 1),
	(6, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
	(7, '2019_08_19_000000_create_failed_jobs_table', 1),
	(8, '2019_12_14_000001_create_personal_access_tokens_table', 1),
	(9, '2023_04_03_110999_create_sizes_table', 1),
	(10, '2023_04_03_111000_create_guests_table', 1),
	(11, '2023_04_03_111001_create_types_table', 1),
	(12, '2023_04_03_111003_create_roles_table', 1),
	(13, '2023_04_03_111004_create_users_table', 1),
	(14, '2023_04_03_111005_create_floors_table', 1),
	(15, '2023_04_03_111005_create_rooms_table', 1),
	(16, '2023_04_03_111358_create_reservations_table', 1),
	(17, '2023_04_03_113251_create_reservation_room_table', 1),
	(18, '2023_04_06_105649_create_services_table', 1),
	(19, '2023_04_06_105653_create_room_service_table', 1),
	(20, '2023_04_10_044147_create_images_table', 1);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.oauth_access_tokens
CREATE TABLE IF NOT EXISTS `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.oauth_access_tokens: ~22 rows (approximately)
DELETE FROM `oauth_access_tokens`;
/*!40000 ALTER TABLE `oauth_access_tokens` DISABLE KEYS */;
INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
	('18730cd4f99e53b76ae7684f0578f0c9da9eddbcb7b0b5f1c60b5c020a86ab90ac68d385841c08d5', 1, 3, 'api_token', '[]', 0, '2023-06-14 12:20:32', '2023-06-14 12:20:32', '2023-07-14 12:20:32'),
	('1d149b2c50f32b44db5bcd16be2eac832141bf4996b94dda78aaaf35de15101fe234c35e2b048873', 1, 3, 'api_token', '[]', 1, '2023-06-14 11:40:34', '2023-06-14 11:40:56', '2023-07-14 11:40:34'),
	('24108607bb3377f4cadb9ea2f5e3d01ec2ba4175f3f87f56e591a2a342b2db275d5bcd15e7f86e73', 1, 3, 'api_token', '[]', 1, '2023-06-13 12:51:09', '2023-06-13 12:51:45', '2023-07-13 12:51:09'),
	('2a55f9d19c20ca75967122bc176a3a7ac45ce4bf81aaece1abf42e58f3092d53629821dc12e6abb2', 6, 3, 'api_token', '[]', 1, '2023-06-15 12:14:19', '2023-06-15 12:15:04', '2023-07-15 12:14:19'),
	('2a98050801322924767c0f0e4b5c2a54199129fae4c252d4f7102fac2f9b1ca073a30923e9418a28', 1, 1, 'api_token', '[]', 1, '2023-05-28 03:10:06', '2023-05-28 04:05:53', '2023-06-28 03:10:06'),
	('35150dc12f29bf79e5971cff5cfe1090be991543815ddd58967da02a8a0240465403b3b57e391610', 1, 3, 'api_token', '[]', 0, '2023-06-14 11:40:58', '2023-06-14 11:40:58', '2023-07-14 11:40:58'),
	('3f8524c59ee350d723c84ddd3f47e29e47eddb4e95fbcee467fdac1f5980a71d468b0fd8aafc9d52', 1, 3, 'api_token', '[]', 1, '2023-06-15 12:04:44', '2023-06-15 12:13:16', '2023-07-15 12:04:44'),
	('6769b1c233f1986b01b20ac394ea15fdbf3ed3fcaf038f7832e12774a62cbc72f037386eb3b32170', 1, 3, 'api_token', '[]', 0, '2023-06-14 12:29:58', '2023-06-14 12:29:58', '2023-07-14 12:29:58'),
	('70b7fe0b41f02f19ad90d80e5b58b856ed0fb45909cf0cae2209ce8b324b512dcfc3c740479f968e', 1, 3, 'api_token', '[]', 1, '2023-06-14 12:22:48', '2023-06-14 12:29:56', '2023-07-14 12:22:48'),
	('73055edaf7968df02c436750d8c329ea33111aa8537abd49bd3d00604aa99a4b001e74ffdbad588c', 7, 3, 'api_token', '[]', 1, '2023-06-15 12:13:40', '2023-06-15 12:14:06', '2023-07-15 12:13:40'),
	('740a46f6f618f7537abc19334321689f87a878afb76905c678023f3e036260705fa7ae58393af048', 1, 3, 'api_token', '[]', 1, '2023-06-13 12:51:47', '2023-06-13 12:53:27', '2023-07-13 12:51:47'),
	('7b52ab205a0ea8df6ce2ae2eefacb4dbe8640eaebf21bb0c476c690585cf7e2f0aebf1851458d899', 1, 3, 'api_token', '[]', 0, '2023-06-13 12:53:28', '2023-06-13 12:53:28', '2023-07-13 12:53:28'),
	('7cbe3e6ae4f0a9d00386b8c8bff51cb777bc6c7c28c2d47e12a8274038da59c5a4d5067e25347381', 1, 3, 'api_token', '[]', 0, '2023-06-14 12:21:44', '2023-06-14 12:21:44', '2023-07-14 12:21:44'),
	('84cb65525a1059134e2411d960f6bfbd42b074ab23dbc36b6609ffbc6490405cdea559afa9299793', 1, 3, 'api_token', '[]', 1, '2023-06-14 12:31:46', '2023-06-15 12:03:36', '2023-07-14 12:31:46'),
	('90f299b99689702ebbf834b96b7a268cd4ae61cfbfeace82d9c8f49aa8a57702fbfab07060624687', 1, 3, 'api_token', '[]', 1, '2023-06-13 11:37:27', '2023-06-13 12:51:07', '2023-07-13 11:37:27'),
	('9e949ea9157abd00b2c76c5607f9e999d62f273a0b623b95b6b007938463fc58a6ea56a7a2e9e84c', 1, 3, 'api_token', '[]', 1, '2023-06-15 12:15:06', '2023-06-15 12:15:49', '2023-07-15 12:15:06'),
	('af638c6a922c5eaa0d6c0410ff50ceca3a1a798ebea58dd2a2548d712ce03f1cec1ca89b90bb9253', 1, 3, 'api_token', '[]', 0, '2023-06-13 12:53:53', '2023-06-13 12:53:53', '2023-07-13 12:53:53'),
	('b6dd364e8a81dff99936bf39930b349ac253512b791b05fc5937025e739c3bc4efdce5581a03608a', 1, 3, 'api_token', '[]', 1, '2023-06-13 12:55:26', '2023-06-14 11:40:32', '2023-07-13 12:55:26'),
	('c9d8685a12216923c09f65fdb59ce84479fd1a0a5dacb1c0a0a2f129f05f017d80b1e1722831c823', 1, 1, 'api_token', '[]', 0, '2023-05-28 04:05:56', '2023-05-28 04:05:56', '2023-06-28 04:05:56'),
	('d7110a8c0c1b07f5314f7e1aa903684043b2e647825219492d1b5e168879f4aa664ba69aefa8bd4a', 1, 3, 'api_token', '[]', 0, '2023-06-13 12:53:31', '2023-06-13 12:53:31', '2023-07-13 12:53:31'),
	('f202dd5285feb8053d84ce85c4dfac141ac695fb719e8fda550428b449929fe158363e4e1b3450fb', 1, 3, 'api_token', '[]', 1, '2023-06-15 12:16:42', '2023-06-15 12:16:46', '2023-07-15 12:16:42'),
	('fe23b4b37654d601021266724726531276fe07cbcc34c5faf7cc113a38251d958ed28b2e6ae9b70c', 1, 3, 'api_token', '[]', 0, '2023-06-13 12:53:43', '2023-06-13 12:53:43', '2023-07-13 12:53:43');
/*!40000 ALTER TABLE `oauth_access_tokens` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.oauth_auth_codes
CREATE TABLE IF NOT EXISTS `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` bigint(20) unsigned NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.oauth_auth_codes: ~0 rows (approximately)
DELETE FROM `oauth_auth_codes`;
/*!40000 ALTER TABLE `oauth_auth_codes` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_auth_codes` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.oauth_clients
CREATE TABLE IF NOT EXISTS `oauth_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.oauth_clients: ~4 rows (approximately)
DELETE FROM `oauth_clients`;
/*!40000 ALTER TABLE `oauth_clients` DISABLE KEYS */;
INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
	(1, NULL, 'Laravel Personal Access Client', 'Nn52MJD0wIb1s3TAdpWclUIzVyzqr6CWahV97C0s', NULL, 'http://localhost', 1, 0, 0, '2023-05-28 02:25:56', '2023-05-28 02:25:56'),
	(2, NULL, 'Laravel Password Grant Client', 'goh9EV8NJbN7EhRWRhfI72lLxSLo0yQPuCDGH0Jj', 'users', 'http://localhost', 0, 1, 0, '2023-05-28 02:25:56', '2023-05-28 02:25:56'),
	(3, NULL, 'Laravel Personal Access Client', 'otSdYOv38c9YEAUvLBNfNX3bhX0fC5hdc0xFxR2m', NULL, 'http://localhost', 1, 0, 0, '2023-06-13 11:35:32', '2023-06-13 11:35:32'),
	(4, NULL, 'Laravel Password Grant Client', 'BfJjG3gIoTT4Xm2SgEFqbZkVgldy08EwNAJh8RjQ', 'users', 'http://localhost', 0, 1, 0, '2023-06-13 11:35:32', '2023-06-13 11:35:32');
/*!40000 ALTER TABLE `oauth_clients` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.oauth_personal_access_clients
CREATE TABLE IF NOT EXISTS `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.oauth_personal_access_clients: ~0 rows (approximately)
DELETE FROM `oauth_personal_access_clients`;
/*!40000 ALTER TABLE `oauth_personal_access_clients` DISABLE KEYS */;
INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
	(1, 1, '2023-05-28 02:25:56', '2023-05-28 02:25:56'),
	(2, 3, '2023-06-13 11:35:32', '2023-06-13 11:35:32');
/*!40000 ALTER TABLE `oauth_personal_access_clients` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.oauth_refresh_tokens
CREATE TABLE IF NOT EXISTS `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.oauth_refresh_tokens: ~0 rows (approximately)
DELETE FROM `oauth_refresh_tokens`;
/*!40000 ALTER TABLE `oauth_refresh_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth_refresh_tokens` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.password_reset_tokens
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.password_reset_tokens: ~0 rows (approximately)
DELETE FROM `password_reset_tokens`;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.personal_access_tokens
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.personal_access_tokens: ~0 rows (approximately)
DELETE FROM `personal_access_tokens`;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.reservations
CREATE TABLE IF NOT EXISTS `reservations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `guest_id` bigint(20) unsigned NOT NULL,
  `room_price` double(8,2) unsigned DEFAULT NULL,
  `total_stay` int(10) unsigned DEFAULT NULL,
  `total_price` double(8,2) unsigned DEFAULT NULL,
  `check_in` datetime DEFAULT NULL,
  `check_out` datetime DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `reservations_guest_id_foreign` (`guest_id`),
  CONSTRAINT `reservations_guest_id_foreign` FOREIGN KEY (`guest_id`) REFERENCES `guests` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.reservations: ~17 rows (approximately)
DELETE FROM `reservations`;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` (`id`, `guest_id`, `room_price`, `total_stay`, `total_price`, `check_in`, `check_out`, `start_date`, `end_date`, `status`, `active`, `created_at`, `updated_at`) VALUES
	(1, 9, 1000.00, 2, 2000.00, '2023-06-14 19:05:00', '2023-06-15 19:32:00', '2023-06-14', '2023-06-15', 'Reserved', 0, '2023-06-14 12:05:44', '2023-06-14 12:32:23'),
	(2, 18, 2000.00, 1, 2000.00, '2023-06-14 19:32:00', '2023-06-15 07:32:00', '2023-06-14', '2023-06-14', 'Reserved', 0, '2023-06-14 12:06:58', '2023-06-14 12:33:24'),
	(3, 10, 2000.00, 8, 16000.00, '2023-06-14 19:08:00', NULL, '2023-06-16', '2023-06-23', 'Cancel', 0, '2023-06-14 12:08:20', '2023-06-14 12:33:33'),
	(4, 10, 200.00, 1, 200.00, '2023-06-14 19:33:00', '2023-06-15 07:38:00', '2023-06-14', '2023-06-14', 'Reserved', 0, '2023-06-14 12:33:50', '2023-06-14 12:38:57'),
	(5, 9, 250.00, 3, 750.00, '2023-06-14 19:39:00', '2023-06-16 19:39:00', '2023-06-14', '2023-06-16', 'Reserved', 0, '2023-06-14 12:36:31', '2023-06-14 12:39:22'),
	(6, 10, 700.00, 1, 700.00, '2023-06-14 19:36:00', '2023-06-15 07:39:00', '2023-06-14', '2023-06-14', 'Reserved', 0, '2023-06-14 12:36:37', '2023-06-14 12:39:50'),
	(7, 12, 500.00, 7, 3500.00, '2023-06-14 19:36:00', '2023-06-24 07:40:00', '2023-06-17', '2023-06-23', 'Pending', 0, '2023-06-14 12:36:44', '2023-06-14 12:40:13'),
	(8, 8, 300.00, 1, 300.00, '2023-06-14 19:36:00', '2023-06-15 07:40:00', '2023-06-14', '2023-06-14', 'Reserved', 0, '2023-06-14 12:36:57', '2023-06-14 12:40:31'),
	(9, 17, 300.00, 9, 2700.00, '2023-06-14 19:36:00', '2023-06-23 07:40:00', '2023-06-14', '2023-06-22', 'Reserved', 0, '2023-06-14 12:37:07', '2023-06-14 12:40:48'),
	(10, 9, 200.00, 1, 200.00, '2023-06-15 19:37:00', '2023-06-16 07:40:00', '2023-06-15', '2023-06-15', 'Reserved', 0, '2023-06-14 12:37:26', '2023-06-14 12:41:09'),
	(11, 10, 700.00, 2, 1400.00, '2023-07-20 19:49:00', '2023-06-22 07:49:00', '2023-07-20', '2023-07-21', 'Reserved', 0, '2023-06-14 12:37:46', '2023-06-14 12:50:09'),
	(12, 11, 200.00, 1, 200.00, '2023-06-15 19:05:00', NULL, '2023-06-15', '2023-06-15', 'Cancel', 0, '2023-06-15 12:05:04', '2023-06-15 12:05:14'),
	(13, 11, 250.00, 1, 250.00, '2023-06-15 19:05:00', NULL, '2023-06-15', '2023-06-15', 'Pending', 1, '2023-06-15 12:05:18', '2023-06-15 12:05:18'),
	(14, 10, 700.00, 1, 700.00, NULL, NULL, '2023-06-15', '2023-06-15', 'Pending', 1, '2023-06-15 12:05:26', '2023-06-15 12:05:26'),
	(15, 8, 500.00, 1, 500.00, '2023-06-15 19:05:00', '2023-06-16 07:05:00', '2023-06-15', '2023-06-15', 'Reserved', 0, '2023-06-15 12:05:44', '2023-06-15 12:05:57'),
	(16, 11, 200.00, 11, 2200.00, '2023-06-15 19:09:00', NULL, '2023-06-15', '2023-06-25', 'Reserved', 1, '2023-06-15 12:09:50', '2023-06-15 12:10:04'),
	(17, 8, 300.00, 1, 300.00, '2023-06-15 19:10:00', NULL, '2023-06-15', '2023-06-15', 'Reserved', 1, '2023-06-15 12:10:16', '2023-06-15 12:10:25');
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.reservation_room
CREATE TABLE IF NOT EXISTS `reservation_room` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `reservation_id` bigint(20) unsigned NOT NULL,
  `room_id` bigint(20) unsigned NOT NULL,
  `occupied_date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `reservation_room_reservation_id_foreign` (`reservation_id`),
  KEY `reservation_room_room_id_foreign` (`room_id`),
  CONSTRAINT `reservation_room_reservation_id_foreign` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`),
  CONSTRAINT `reservation_room_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.reservation_room: ~44 rows (approximately)
DELETE FROM `reservation_room`;
/*!40000 ALTER TABLE `reservation_room` DISABLE KEYS */;
INSERT INTO `reservation_room` (`id`, `reservation_id`, `room_id`, `occupied_date`) VALUES
	(1, 1, 23, '2023-06-14'),
	(2, 1, 23, '2023-06-15'),
	(3, 2, 26, '2023-06-14'),
	(4, 3, 26, '2023-06-16'),
	(5, 3, 26, '2023-06-17'),
	(6, 3, 26, '2023-06-18'),
	(7, 3, 26, '2023-06-19'),
	(8, 3, 26, '2023-06-20'),
	(9, 3, 26, '2023-06-21'),
	(10, 3, 26, '2023-06-22'),
	(11, 3, 26, '2023-06-23'),
	(12, 4, 29, '2023-06-14'),
	(13, 5, 30, '2023-06-14'),
	(14, 6, 35, '2023-06-14'),
	(15, 7, 24, '2023-06-14'),
	(16, 8, 25, '2023-06-14'),
	(17, 9, 31, '2023-06-14'),
	(18, 9, 31, '2023-06-15'),
	(19, 9, 31, '2023-06-16'),
	(20, 9, 31, '2023-06-17'),
	(21, 9, 31, '2023-06-18'),
	(22, 9, 31, '2023-06-19'),
	(23, 9, 31, '2023-06-20'),
	(24, 9, 31, '2023-06-21'),
	(25, 9, 31, '2023-06-22'),
	(26, 10, 29, '2023-06-15'),
	(27, 11, 35, '2023-07-20'),
	(28, 11, 35, '2023-07-21'),
	(29, 12, 29, '2023-06-15'),
	(30, 13, 30, '2023-06-15'),
	(31, 14, 35, '2023-06-15'),
	(32, 15, 24, '2023-06-15'),
	(33, 16, 29, '2023-06-15'),
	(34, 16, 29, '2023-06-16'),
	(35, 16, 29, '2023-06-17'),
	(36, 16, 29, '2023-06-18'),
	(37, 16, 29, '2023-06-19'),
	(38, 16, 29, '2023-06-20'),
	(39, 16, 29, '2023-06-21'),
	(40, 16, 29, '2023-06-22'),
	(41, 16, 29, '2023-06-23'),
	(42, 16, 29, '2023-06-24'),
	(43, 16, 29, '2023-06-25'),
	(44, 17, 33, '2023-06-15');
/*!40000 ALTER TABLE `reservation_room` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roles_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.roles: ~4 rows (approximately)
DELETE FROM `roles`;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'admin', '2023-05-28 10:08:23', '2023-05-28 10:08:24', NULL),
	(2, 'manager', '2023-06-14 18:24:00', '2023-06-14 18:24:00', NULL),
	(3, 'accountant', '2023-06-14 18:24:08', '2023-06-14 18:24:09', NULL),
	(4, 'receptionist', '2023-06-14 18:24:24', '2023-06-14 18:24:25', NULL);
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.rooms
CREATE TABLE IF NOT EXISTS `rooms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type_id` bigint(20) unsigned NOT NULL,
  `floor_id` bigint(20) unsigned NOT NULL,
  `size_id` bigint(20) unsigned NOT NULL,
  `number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `price` double(8,2) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rooms_number_unique` (`number`),
  KEY `rooms_type_id_foreign` (`type_id`),
  KEY `rooms_floor_id_foreign` (`floor_id`),
  KEY `rooms_size_id_foreign` (`size_id`),
  KEY `rooms_name_index` (`name`),
  CONSTRAINT `rooms_floor_id_foreign` FOREIGN KEY (`floor_id`) REFERENCES `floors` (`id`),
  CONSTRAINT `rooms_size_id_foreign` FOREIGN KEY (`size_id`) REFERENCES `sizes` (`id`),
  CONSTRAINT `rooms_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.rooms: ~11 rows (approximately)
DELETE FROM `rooms`;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` (`id`, `type_id`, `floor_id`, `size_id`, `number`, `name`, `description`, `price`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(23, 1, 1, 1, '101', 'Moon Room', 'The Moon Room is an exquisite offering within the luxurious setting of a 5-star hotel. This exclusive room takes inspiration from the celestial wonders of the moon, combining elegance and comfort to create a truly exceptional guest experience.\r\nAs you step into the Moon Room, you are immediately enveloped in an ambiance of sophistication and tranquility. The interior design showcases a seamless blend of contemporary aesthetics and celestial motifs, invoking a sense of serenity and enchantment. Soft, muted colors resembling moonlight permeate the room, creating a soothing atmosphere that promotes relaxation.', 1000.00, '2023-05-28 07:59:54', '2023-06-13 11:40:44', NULL),
	(24, 1, 3, 2, '301', 'Star-gazing Room', 'As a guest of the Star-Gazing Room, you will have access to exceptional services and facilities provided by the 5-star hotel. The attentive staff is available to assist with any requests, ensuring a seamless and enjoyable stay. Additionally, the hotel may offer dining options, spa services, or other amenities to complement your star-gazing experience.\r\n\r\nThe Star-Gazing Room within this 5-star hotel offers a truly unforgettable and immersive stay. It provides an unparalleled opportunity to connect with the cosmos and witness the beauty of the night sky in a luxurious and comfortable setting. Whether you are a passionate astronomer or simply seeking a unique and magical experience, the Star-Gazing Room promises an extraordinary journey into the celestial realm.', 500.00, '2023-05-28 08:08:10', '2023-06-13 11:53:06', NULL),
	(25, 1, 3, 1, '302', 'Fuji Room', 'Every detail in the Fuji Room is carefully curated to ensure a seamless and enjoyable stay. Modern technology is seamlessly integrated, offering amenities such as high-speed internet access, a flat-screen TV, and convenient charging ports. The room\'s lighting and climate control systems can be easily adjusted to create the desired ambiance, enhancing the overall comfort of the space.', 300.00, '2023-05-28 08:09:03', '2023-06-13 11:56:52', NULL),
	(26, 1, 2, 3, '201', 'Sand Room', 'The en-suite bathroom of the Sand Room continues the coastal theme, featuring stylish fixtures and a calming color palette. Guests can indulge in a refreshing shower or luxuriate in a bathtub, surrounded by tastefully selected amenities and soft towels.\r\n\r\nModern technology and conveniences are seamlessly integrated into the Sand Room. Guests can enjoy high-speed internet access, a flat-screen TV with entertainment options, and other amenities that cater to their needs. The room also includes well-placed charging ports and smart controls for a hassle-free stay.', 2000.00, '2023-05-28 08:09:21', '2023-06-13 11:48:53', NULL),
	(27, 2, 1, 4, '102', 'Star Room', 'The Star Room is a captivating accommodation option within a premier 5-star hotel. This room is designed to evoke a sense of wonder and elegance, offering guests a delightful experience amidst a celestial ambiance.\r\n\r\nStep into the Star Room and be greeted by a tastefully decorated space that exudes a magical charm. The room\'s design draws inspiration from the mesmerizing beauty of the night sky, with subtle celestial elements incorporated into the decor. Soft lighting and carefully chosen color schemes create an atmosphere of tranquility, allowing guests to unwind and escape from the bustling world outside.', 700.00, '2023-06-13 11:43:30', '2023-06-13 11:43:30', NULL),
	(28, 1, 1, 2, '103', 'Planet Room', 'The Planet Room offers a spacious and luxurious setting, ensuring that guests have ample space to relax and unwind. The carefully curated furnishings provide both comfort and style, including a plush bed adorned with exquisite linens. The room\'s layout is thoughtfully designed to maximize comfort and functionality, while large windows offer stunning views of the surroundings, allowing guests to feel connected to the outside world.\r\n\r\nAttention to detail is paramount in the Planet Room\'s amenities. The en-suite bathroom features elegant fixtures and premium bath products, providing a luxurious bathing experience. Guests can indulge in a relaxing soak or invigorating shower, enveloped in an ambiance of tranquility.', 800.00, '2023-06-13 11:45:04', '2023-06-13 11:45:04', NULL),
	(29, 2, 2, 2, '202', 'Standard Room 202', 'The casual room features a comfortable queen-sized bed adorned with plush pillows and crisp linens, ensuring a restful night\'s sleep. Adjacent to the bed, you\'ll find a nightstand with conveniently placed reading lamps, allowing you to enjoy a good book or browse your favorite websites before bed.\r\n\r\nTo enhance your stay, the room is equipped with modern amenities such as a flat-screen television with cable channels, so you can catch up on your favorite shows or watch a movie. A work desk and chair are also provided, should you need to attend to any business matters or simply want to set up your laptop and check your emails.', 200.00, '2023-06-14 11:58:51', '2023-06-14 12:00:28', NULL),
	(30, 2, 2, 3, '203', 'Standard Room 203', 'The casual room features a comfortable queen-sized bed adorned with plush pillows and crisp linens, ensuring a restful night\'s sleep. Adjacent to the bed, you\'ll find a nightstand with conveniently placed reading lamps, allowing you to enjoy a good book or browse your favorite websites before bed.\r\n\r\nTo enhance your stay, the room is equipped with modern amenities such as a flat-screen television with cable channels, so you can catch up on your favorite shows or watch a movie. A work desk and chair are also provided, should you need to attend to any business matters or simply want to set up your laptop and check your emails.', 250.00, '2023-06-14 11:59:57', '2023-06-14 12:00:15', NULL),
	(31, 2, 3, 4, '303', 'Standard Room 303', 'The casual room features a comfortable queen-sized bed adorned with plush pillows and crisp linens, ensuring a restful night\'s sleep. Adjacent to the bed, you\'ll find a nightstand with conveniently placed reading lamps, allowing you to enjoy a good book or browse your favorite websites before bed.\r\n\r\nTo enhance your stay, the room is equipped with modern amenities such as a flat-screen television with cable channels, so you can catch up on your favorite shows or watch a movie. A work desk and chair are also provided, should you need to attend to any business matters or simply want to set up your laptop and check your emails.', 300.00, '2023-06-14 12:01:02', '2023-06-14 12:01:02', NULL),
	(32, 2, 3, 1, '304', 'Standard Room 304', 'The casual room features a comfortable queen-sized bed adorned with plush pillows and crisp linens, ensuring a restful night\'s sleep. Adjacent to the bed, you\'ll find a nightstand with conveniently placed reading lamps, allowing you to enjoy a good book or browse your favorite websites before bed.\r\n\r\nTo enhance your stay, the room is equipped with modern amenities such as a flat-screen television with cable channels, so you can catch up on your favorite shows or watch a movie. A work desk and chair are also provided, should you need to attend to any business matters or simply want to set up your laptop and check your emails.', 350.00, '2023-06-14 12:01:47', '2023-06-14 12:01:47', NULL),
	(33, 2, 1, 3, '104', 'Standard Room 104', 'The casual room features a comfortable queen-sized bed adorned with plush pillows and crisp linens, ensuring a restful night\'s sleep. Adjacent to the bed, you\'ll find a nightstand with conveniently placed reading lamps, allowing you to enjoy a good book or browse your favorite websites before bed.\r\n\r\nTo enhance your stay, the room is equipped with modern amenities such as a flat-screen television with cable channels, so you can catch up on your favorite shows or watch a movie. A work desk and chair are also provided, should you need to attend to any business matters or simply want to set up your laptop and check your emails.', 300.00, '2023-06-14 12:02:43', '2023-06-14 12:02:43', NULL),
	(34, 2, 1, 1, '105', 'Standard Room 105', 'The casual room features a comfortable queen-sized bed adorned with plush pillows and crisp linens, ensuring a restful night\'s sleep. Adjacent to the bed, you\'ll find a nightstand with conveniently placed reading lamps, allowing you to enjoy a good book or browse your favorite websites before bed.\r\n\r\nTo enhance your stay, the room is equipped with modern amenities such as a flat-screen television with cable channels, so you can catch up on your favorite shows or watch a movie. A work desk and chair are also provided, should you need to attend to any business matters or simply want to set up your laptop and check your emails.', 300.00, '2023-06-14 12:03:54', '2023-06-14 12:03:54', NULL),
	(35, 4, 2, 2, '204', 'Standard Room 204', 'The casual room features a comfortable queen-sized bed adorned with plush pillows and crisp linens, ensuring a restful night\'s sleep. Adjacent to the bed, you\'ll find a nightstand with conveniently placed reading lamps, allowing you to enjoy a good book or browse your favorite websites before bed.\r\n\r\nTo enhance your stay, the room is equipped with modern amenities such as a flat-screen television with cable channels, so you can catch up on your favorite shows or watch a movie. A work desk and chair are also provided, should you need to attend to any business matters or simply want to set up your laptop and check your emails.', 700.00, '2023-06-14 12:04:58', '2023-06-14 12:04:58', NULL);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.room_service
CREATE TABLE IF NOT EXISTS `room_service` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `room_id` bigint(20) unsigned NOT NULL,
  `service_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `room_service_room_id_foreign` (`room_id`),
  KEY `room_service_service_id_foreign` (`service_id`),
  CONSTRAINT `room_service_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`),
  CONSTRAINT `room_service_service_id_foreign` FOREIGN KEY (`service_id`) REFERENCES `services` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.room_service: ~49 rows (approximately)
DELETE FROM `room_service`;
/*!40000 ALTER TABLE `room_service` DISABLE KEYS */;
INSERT INTO `room_service` (`id`, `room_id`, `service_id`) VALUES
	(26, 23, 1),
	(27, 24, 1),
	(28, 25, 1),
	(29, 26, 1),
	(30, 23, 2),
	(31, 23, 3),
	(32, 27, 1),
	(33, 27, 2),
	(34, 27, 3),
	(35, 27, 5),
	(36, 27, 6),
	(37, 28, 1),
	(38, 28, 2),
	(40, 26, 2),
	(41, 26, 3),
	(42, 26, 4),
	(43, 26, 5),
	(44, 26, 6),
	(45, 24, 2),
	(46, 24, 3),
	(47, 25, 2),
	(48, 29, 1),
	(49, 29, 2),
	(50, 29, 3),
	(51, 29, 5),
	(52, 29, 6),
	(53, 30, 1),
	(54, 30, 2),
	(55, 30, 3),
	(56, 30, 5),
	(57, 30, 6),
	(58, 31, 1),
	(59, 31, 2),
	(60, 32, 1),
	(61, 32, 2),
	(62, 33, 1),
	(63, 33, 2),
	(64, 33, 3),
	(65, 33, 5),
	(66, 33, 6),
	(67, 34, 1),
	(68, 34, 2),
	(69, 34, 4),
	(70, 34, 5),
	(71, 34, 6),
	(72, 35, 1),
	(73, 35, 2),
	(74, 35, 4),
	(75, 35, 5),
	(76, 35, 6);
/*!40000 ALTER TABLE `room_service` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.services
CREATE TABLE IF NOT EXISTS `services` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.services: ~6 rows (approximately)
DELETE FROM `services`;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` (`id`, `name`, `icon`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'breakfast', 'mdi-food', '2023-05-28 11:21:38', '2023-05-28 11:21:39', NULL),
	(2, 'bathroom', 'mdi-bathtub', '2023-05-28 11:22:04', '2023-05-28 11:22:05', NULL),
	(3, 'smoking', 'mdi-smoking', '2023-05-28 11:22:28', '2023-05-28 11:22:29', NULL),
	(4, 'no-smoking', 'mdi-smoking-off', '2023-05-28 11:22:40', '2023-05-28 11:22:40', NULL),
	(5, 'pool', 'mdi-pool', '2023-05-28 11:22:57', '2023-05-28 11:22:58', NULL),
	(6, 'room service', 'mdi-room-service', '2023-05-28 11:23:18', '2023-05-28 11:23:18', NULL);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.sizes
CREATE TABLE IF NOT EXISTS `sizes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.sizes: ~4 rows (approximately)
DELETE FROM `sizes`;
/*!40000 ALTER TABLE `sizes` DISABLE KEYS */;
INSERT INTO `sizes` (`id`, `name`, `icon`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'Single room', 'mdi-human-male', '2023-05-28 11:17:05', '2023-05-28 11:17:06', NULL),
	(2, 'Double room', 'mdi-human-male-male', '2023-05-28 11:17:34', '2023-05-28 11:17:35', NULL),
	(3, 'Triple room', 'mdi-account-group', NULL, NULL, NULL),
	(4, 'Family room', 'mdi-human-male-female-child', NULL, NULL, NULL);
/*!40000 ALTER TABLE `sizes` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.types
CREATE TABLE IF NOT EXISTS `types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `types_name_index` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.types: ~4 rows (approximately)
DELETE FROM `types`;
/*!40000 ALTER TABLE `types` DISABLE KEYS */;
INSERT INTO `types` (`id`, `name`, `description`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 'VIP', NULL, '2023-05-28 11:15:12', '2023-05-28 11:15:13', NULL),
	(2, 'Standard', NULL, '2023-05-28 11:15:25', '2023-05-28 11:15:26', NULL),
	(3, 'Smoking', NULL, '2023-05-28 11:16:04', '2023-05-28 11:16:04', NULL),
	(4, 'No-smoking', NULL, '2023-05-28 11:16:10', '2023-05-28 11:16:11', NULL);
/*!40000 ALTER TABLE `types` ENABLE KEYS */;

-- Dumping structure for table vue_hotel.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned NOT NULL,
  `fname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  KEY `users_fname_lname_index` (`fname`,`lname`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table vue_hotel.users: ~7 rows (approximately)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `role_id`, `fname`, `lname`, `email`, `email_verified_at`, `password`, `active`, `image`, `address`, `gender`, `phone`, `remember_token`, `created_at`, `updated_at`, `deleted_at`) VALUES
	(1, 1, 'Long', 'Tran', 'long@gmail.com', NULL, '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, 'user-10.jpg', '117 Oxford Street', 1, '0777666333', NULL, '2023-05-28 10:09:43', '2023-06-14 12:30:11', NULL),
	(2, 2, 'Tuan', 'Minh', 'tuan@gmail.com', NULL, '$2y$10$0pYsoxx7dJaZwjpYeJf12OAmOLl42df/sz/66O6cs7ByXetzoGrMq', 1, NULL, '5 Thorne Ave. Newington, CT 06111', 1, '0777666333', NULL, '2023-06-14 11:41:55', '2023-06-14 11:45:15', NULL),
	(3, 3, 'Chien', 'Chung', 'chien@gmail.com', NULL, '$2y$10$3V52LD1V/sNS46vSE4PLxeJCn3NWx/PavEXnW34fijXSIB/qFbapG', 1, NULL, '39 High Point St. Ashburn, VA 20147', 1, '0888666333', NULL, '2023-06-14 11:42:23', '2023-06-14 11:45:23', NULL),
	(4, 4, 'Chau', 'Thu', 'chau@gmail.com', NULL, '$2y$10$NUXw4d95lGSrdGvpZ1SCE.G8gkP4j0YblxMZhgdvEEvt5bXSg7v0i', 1, 'windows-c-lUYtNjqxw-unsplash.jpg', '178 Wintergreen Street East Elmhurst, NY 11369', 0, '0906222333', NULL, '2023-06-14 11:43:40', '2023-06-14 11:45:32', NULL),
	(5, 2, 'Minh', 'Ngoc', 'minh@gmail.com', NULL, '$2y$10$Yo9iV3KK0qhB3UwAUmfBvO.Y1VqiZPxvRcfv3.Tsz0nJwNBfUdF9u', 0, 'jurica-koletic-7YVZYZeITc8-unsplash.jpg', NULL, 1, '0906222333', NULL, '2023-06-14 11:44:43', '2023-06-14 11:44:56', NULL),
	(6, 4, 'Rook', 'Kie', 'tieu@gmail.com', NULL, '$2y$10$7cZFnsGDOeNU2ePWF8kckeIvAGWKe0kc8FeFAsiCNrxihRlwc2xP.', 1, 'brooke-cagle-LCcFI_26diA-unsplash.jpg', NULL, 0, '0900666333', NULL, '2023-06-14 11:46:24', '2023-06-14 11:46:24', NULL),
	(7, 1, 'Tao', 'Huang', 'tao@gmail.com', NULL, '$2y$10$Hkp2qFBf87mhcXdRQkfD6OYB7wuGIdDUEH06ryt1jWr12.GWuoxky', 1, 'ana-itonishvili-Fyl8sMC2j2Q-unsplash.jpg', '1 Randall Mill Street Indiana, PA 15701', 0, '0666333777', NULL, '2023-06-14 11:47:24', '2023-06-14 11:47:24', NULL);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
