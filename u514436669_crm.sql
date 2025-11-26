-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 05, 2025 at 06:42 AM
-- Server version: 11.8.3-MariaDB-log
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u514436669_crm`
--

-- --------------------------------------------------------

--
-- Table structure for table `rise_activity_logs`
--

CREATE TABLE `rise_activity_logs` (
  `id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `action` enum('created','updated','deleted','bitbucket_notification_received','github_notification_received') NOT NULL,
  `log_type` varchar(30) NOT NULL,
  `log_type_title` mediumtext NOT NULL,
  `log_type_id` int(11) NOT NULL DEFAULT 0,
  `changes` mediumtext DEFAULT NULL,
  `log_for` varchar(30) NOT NULL DEFAULT '0',
  `log_for_id` int(11) NOT NULL DEFAULT 0,
  `log_for2` varchar(30) DEFAULT NULL,
  `log_for_id2` int(11) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_activity_logs`
--

INSERT INTO `rise_activity_logs` (`id`, `created_at`, `created_by`, `action`, `log_type`, `log_type_title`, `log_type_id`, `changes`, `log_for`, `log_for_id`, `log_for2`, `log_for_id2`, `deleted`) VALUES
(1, '2025-07-04 04:27:49', 55, 'created', 'task', 'Syllabus Download', 1, NULL, 'project', 2, '', 0, 0),
(2, '2025-07-04 04:31:06', 55, 'updated', 'task', 'Syllabus Download', 1, 'a:2:{s:11:\"description\";a:2:{s:4:\"from\";s:44:\"we need to download the following subjects\r\n\";s:2:\"to\";s:84:\"we need to download the following subjects\r\n1.C#\r\n2. DEVOPS\r\n3.MERN & MEAN\r\n4.ABAP\r\n\";}s:13:\"collaborators\";a:2:{s:4:\"from\";s:2:\"24\";s:2:\"to\";s:5:\"24,23\";}}', 'project', 2, '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rise_announcements`
--

CREATE TABLE `rise_announcements` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `created_by` int(11) NOT NULL,
  `share_with` mediumtext DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `files` text NOT NULL,
  `read_by` mediumtext DEFAULT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_article_helpful_status`
--

CREATE TABLE `rise_article_helpful_status` (
  `id` int(11) NOT NULL,
  `article_id` int(11) NOT NULL,
  `status` enum('yes','no') NOT NULL,
  `created_by` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_attendance`
--

CREATE TABLE `rise_attendance` (
  `id` int(11) NOT NULL,
  `status` enum('incomplete','pending','approved','rejected','deleted') NOT NULL DEFAULT 'incomplete',
  `user_id` int(11) NOT NULL,
  `in_time` datetime NOT NULL,
  `out_time` datetime DEFAULT NULL,
  `checked_by` int(11) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `checked_at` datetime DEFAULT NULL,
  `reject_reason` text DEFAULT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_attendance`
--

INSERT INTO `rise_attendance` (`id`, `status`, `user_id`, `in_time`, `out_time`, `checked_by`, `note`, `checked_at`, `reject_reason`, `deleted`) VALUES
(1, 'pending', 55, '2025-07-02 04:31:46', '2025-07-02 06:09:20', NULL, '', NULL, NULL, 0),
(2, 'pending', 55, '2025-07-03 06:02:28', '2025-07-04 04:06:42', NULL, '', NULL, NULL, 0),
(3, 'pending', 55, '2025-07-04 04:06:45', '2025-07-04 10:32:22', NULL, '', NULL, NULL, 0),
(4, 'incomplete', 55, '2025-07-07 05:12:11', NULL, NULL, NULL, NULL, NULL, 0),
(5, 'incomplete', 1, '2025-07-21 05:00:12', NULL, NULL, NULL, NULL, NULL, 0),
(6, 'pending', 65, '2025-09-24 14:13:03', '2025-09-24 14:13:11', NULL, '', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rise_automation_settings`
--

CREATE TABLE `rise_automation_settings` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `matching_type` enum('match_any','match_all') NOT NULL,
  `event_name` text NOT NULL,
  `conditions` text NOT NULL,
  `actions` text NOT NULL,
  `related_to` varchar(255) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_checklist_groups`
--

CREATE TABLE `rise_checklist_groups` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `checklists` mediumtext NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_checklist_items`
--

CREATE TABLE `rise_checklist_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `is_checked` int(11) NOT NULL DEFAULT 0,
  `task_id` int(11) NOT NULL DEFAULT 0,
  `sort` int(11) NOT NULL DEFAULT 0,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_checklist_template`
--

CREATE TABLE `rise_checklist_template` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_checklist_template`
--

INSERT INTO `rise_checklist_template` (`id`, `title`, `deleted`) VALUES
(1, 'Internal', 0);

-- --------------------------------------------------------

--
-- Table structure for table `rise_ci_sessions`
--

CREATE TABLE `rise_ci_sessions` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `data` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_ci_sessions`
--

INSERT INTO `rise_ci_sessions` (`id`, `ip_address`, `timestamp`, `data`) VALUES
('ci_session:887af62b77ccc5de8c7ca3bba6885322', '106.200.23.77', '2025-09-25 05:01:37', 0x5f5f63695f6c6173745f726567656e65726174657c693a313735383737363439373b5f63695f70726576696f75735f75726c7c733a36303a2268747470733a2f2f79636f7265746563686e6f6c6f676965732e696e2f63726d2f696e6465782e7068702f64617368626f6172642f696e6465782f31223b757365725f69647c733a323a223635223b),
('ci_session:25875d0027752daaabffd705549576dd', '106.200.23.77', '2025-09-25 04:53:53', 0x5f5f63695f6c6173745f726567656e65726174657c693a313735383737363033333b),
('ci_session:c5aa8777f61eeddcb7555fbb7069b194', '106.200.23.77', '2025-09-25 04:54:14', 0x5f5f63695f6c6173745f726567656e65726174657c693a313735383737363035343b),
('ci_session:d3933126e0469ae75d148153ad9785f8', '106.200.23.77', '2025-09-25 05:31:54', 0x5f5f63695f6c6173745f726567656e65726174657c693a313735383737363439373b5f63695f70726576696f75735f75726c7c733a3135333a2268747470733a2f2f79636f7265746563686e6f6c6f676965732e696e2f63726d2f696e6465782e7068702f6576656e74732f63616c656e6461725f6576656e74732f6576656e74732f302f3f73746172743d323032352d30382d3331543030253341303025334130302532423035253341333026656e643d323032352d31302d31325430302533413030253341303025324230352533413330223b757365725f69647c733a323a223635223b),
('ci_session:9f893923d91c2001a574ceea6fc5c17e', '106.200.23.77', '2025-09-25 05:01:37', 0x5f5f63695f6c6173745f726567656e65726174657c693a313735383737363439373b),
('ci_session:721d90cb314f0cb88f2ef1d1b02d829e', '106.200.22.84', '2025-09-26 07:23:15', 0x5f5f63695f6c6173745f726567656e65726174657c693a313735383837313339353b5f63695f70726576696f75735f75726c7c733a35323a2268747470733a2f2f79636f7265746563686e6f6c6f676965732e696e2f63726d2f696e6465782e7068702f64617368626f617264223b757365725f69647c733a323a223635223b),
('ci_session:aa319da3ba7c8ec4d464e0b8080749af', '106.200.22.84', '2025-09-26 07:04:12', 0x5f5f63695f6c6173745f726567656e65726174657c693a313735383837303235323b),
('ci_session:ba13975baf38fe7044081a795902d50a', '106.200.22.84', '2025-09-26 07:04:37', 0x5f5f63695f6c6173745f726567656e65726174657c693a313735383837303237373b),
('ci_session:7d1473c7b52b9500737413ac1cc272ac', '106.200.22.84', '2025-09-26 07:07:18', 0x5f5f63695f6c6173745f726567656e65726174657c693a313735383837303433383b),
('ci_session:261a8b589c2f76745626bf01c01195d0', '106.200.22.84', '2025-09-26 07:07:20', 0x5f5f63695f6c6173745f726567656e65726174657c693a313735383837303434303b),
('ci_session:2d8a24538654c535c2bf73b0a64bc250', '106.200.22.84', '2025-09-26 07:25:25', 0x5f5f63695f6c6173745f726567656e65726174657c693a313735383837313339353b5f63695f70726576696f75735f75726c7c733a35353a2268747470733a2f2f79636f7265746563686e6f6c6f676965732e696e2f63726d2f696e6465782e7068702f66696c655f6d616e61676572223b757365725f69647c733a323a223635223b),
('ci_session:11f765ee108abaca8cbf86f384482b21', '106.200.22.84', '2025-09-26 07:23:15', 0x5f5f63695f6c6173745f726567656e65726174657c693a313735383837313339353b),
('ci_session:f12171a657f9d68bd4963f2fbefed2ca', '2409:40f4:100a:63ab:3413:fe84:bdce:23e9', '2025-10-25 09:57:11', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313338363233303b5f63695f70726576696f75735f75726c7c733a34393a2268747470733a2f2f79636f7265746563686e6f6c6f676965732e696e2f63726d2f696e6465782e7068702f7369676e696e223b),
('ci_session:75dc09531b4397b883b98d5b3b308117', '103.241.242.5', '2025-10-25 09:57:18', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313338363233363b5f63695f70726576696f75735f75726c7c733a34393a2268747470733a2f2f79636f7265746563686e6f6c6f676965732e696e2f63726d2f696e6465782e7068702f7369676e696e223b),
('ci_session:5bced3e274e8c7e54659007e5cfbfea5', '103.44.18.165', '2025-10-25 09:57:19', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313338363233373b5f63695f70726576696f75735f75726c7c733a34393a2268747470733a2f2f79636f7265746563686e6f6c6f676965732e696e2f63726d2f696e6465782e7068702f7369676e696e223b),
('ci_session:b8be0d1ccc1251e873df04121a925107', '202.62.92.68', '2025-10-25 09:57:20', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313338363234303b5f63695f70726576696f75735f75726c7c733a34393a2268747470733a2f2f79636f7265746563686e6f6c6f676965732e696e2f63726d2f696e6465782e7068702f7369676e696e223b),
('ci_session:a9ac0b59b9b1bf148213124c52bd368d', '106.200.14.62', '2025-10-29 10:08:17', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313733323238373b5f63695f70726576696f75735f75726c7c733a36343a2268747470733a2f2f79636f7265746563686e6f6c6f676965732e696e2f63726d2f696e6465782e7068702f70726f6a656374732f616c6c5f70726f6a65637473223b757365725f69647c733a323a223635223b),
('ci_session:6f0e15f2b63a5784de348bb7fb0f09c0', '106.200.14.62', '2025-10-29 10:04:49', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313733323238393b),
('ci_session:ec41680232fc4d3e7b57892cb3ce37d9', '106.200.14.62', '2025-10-29 10:05:05', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313733323330353b),
('ci_session:ce206b822d5398ab68de5edf1f4b18bb', '106.200.14.62', '2025-10-29 10:07:49', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313733323436393b),
('ci_session:93f1d223ad7827c5f491324d21a00ff8', '106.200.14.62', '2025-10-29 10:07:51', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313733323437313b),
('ci_session:c0b18c2baf4719ea725c34eab32c7a9d', '106.200.14.62', '2025-10-29 10:08:11', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313733323439313b),
('ci_session:9d62c28b59d783a751e069c8ea698bcd', '106.200.14.62', '2025-10-29 10:08:13', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313733323439333b),
('ci_session:5d4f00d80c7d53b01a6ca05396a0b393', '106.200.14.62', '2025-10-29 10:08:15', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313733323439353b),
('ci_session:5f83d97bd7b46f665cd7c8f353196a77', '106.200.14.62', '2025-10-29 10:08:17', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313733323439373b),
('ci_session:69c634ffd23bcb214132c5daff5dccc6', '106.200.14.62', '2025-11-01 09:03:02', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938373738323b5f63695f70726576696f75735f75726c7c733a36303a2268747470733a2f2f79636f7265746563686e6f6c6f676965732e696e2f63726d2f696e6465782e7068702f64617368626f6172642f696e6465782f31223b757365725f69647c733a323a223635223b),
('ci_session:5b525fc758160f34063fa6b639368600', '106.200.14.62', '2025-11-01 08:21:45', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353330353b),
('ci_session:ee174e9a9319551ada128597d10953f6', '106.200.14.62', '2025-11-01 08:21:48', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353330383b),
('ci_session:b5c1a189f7a2d868e6f8cf0e889078b1', '106.200.14.62', '2025-11-01 08:22:04', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353332343b),
('ci_session:f1cd8ddd92c6002c41501d469267a615', '106.200.14.62', '2025-11-01 08:22:07', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353332373b),
('ci_session:a09907fdd18caa1348daad406a87a30f', '106.200.14.62', '2025-11-01 08:22:25', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353334353b),
('ci_session:95c7c18fca8b27db7cb7d1333ee2296f', '106.200.14.62', '2025-11-01 08:22:30', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353335303b),
('ci_session:540bf0d6c0bd584a81911be1b5b1872d', '106.200.14.62', '2025-11-01 08:22:34', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353335343b),
('ci_session:ef38df3afcc4de1754f9384ca23761bf', '106.200.14.62', '2025-11-01 08:22:36', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353335363b),
('ci_session:311983a565d5a3004778e7d666f0afe6', '106.200.14.62', '2025-11-01 08:22:42', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353336323b),
('ci_session:e59ecf0149615f6d266e04a4e5acd0c5', '106.200.14.62', '2025-11-01 08:22:44', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353336343b),
('ci_session:ffbb65099af6feb4220bdd3647c58339', '106.200.14.62', '2025-11-01 08:22:49', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353336393b),
('ci_session:071e9c515e7efa9b708905ba96d511e1', '106.200.14.62', '2025-11-01 08:23:16', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353339363b),
('ci_session:8224ef61a4d6d3d50905f0563c59a3a0', '106.200.14.62', '2025-11-01 08:23:20', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353430303b),
('ci_session:f92c0520b4b24420dab097efa3c9baab', '106.200.14.62', '2025-11-01 08:23:23', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353430333b),
('ci_session:8933f0fbc49877fbf9fe8335f6fd6573', '106.200.14.62', '2025-11-01 08:23:23', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353430333b),
('ci_session:39047d738f9705aed0673ee5ee967b83', '106.200.14.62', '2025-11-01 08:23:29', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353430393b),
('ci_session:dd5acee960348e2aa410f07309315a0d', '106.200.14.62', '2025-11-01 08:23:37', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353431373b),
('ci_session:966853c0f89c00b4c35bc8941fd9763d', '106.200.14.62', '2025-11-01 08:23:51', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938353433313b),
('ci_session:d1d9ad910744acd30dbea8dbef9128cd', '106.200.14.62', '2025-11-01 09:07:55', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938373738323b5f63695f70726576696f75735f75726c7c733a3135333a2268747470733a2f2f79636f7265746563686e6f6c6f676965732e696e2f63726d2f696e6465782e7068702f6576656e74732f63616c656e6461725f6576656e74732f6576656e74732f302f3f73746172743d323032352d31302d3236543030253341303025334130302532423035253341333026656e643d323032352d31322d30375430302533413030253341303025324230352533413330223b757365725f69647c733a323a223635223b),
('ci_session:3e8f945fa28c29126f1870359d2d5562', '106.200.14.62', '2025-11-01 09:03:03', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938373738333b),
('ci_session:7cdea11d1e614d39f698157c6c437254', '106.200.14.62', '2025-11-01 09:05:05', 0x5f5f63695f6c6173745f726567656e65726174657c693a313736313938373930353b);

-- --------------------------------------------------------

--
-- Table structure for table `rise_clients`
--

CREATE TABLE `rise_clients` (
  `id` int(11) NOT NULL,
  `company_name` varchar(150) NOT NULL,
  `type` enum('organization','person') NOT NULL DEFAULT 'organization',
  `address` text DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `website` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `currency_symbol` varchar(20) DEFAULT NULL,
  `starred_by` mediumtext NOT NULL,
  `group_ids` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `is_lead` tinyint(1) NOT NULL DEFAULT 0,
  `lead_status_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `lead_source_id` int(11) NOT NULL,
  `last_lead_status` text NOT NULL,
  `client_migration_date` date DEFAULT NULL,
  `vat_number` text DEFAULT NULL,
  `gst_number` text DEFAULT NULL,
  `stripe_customer_id` text NOT NULL,
  `stripe_card_ending_digit` int(11) NOT NULL,
  `currency` varchar(3) DEFAULT NULL,
  `disable_online_payment` tinyint(1) NOT NULL DEFAULT 0,
  `labels` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_clients`
--

INSERT INTO `rise_clients` (`id`, `company_name`, `type`, `address`, `city`, `state`, `zip`, `country`, `created_date`, `website`, `phone`, `currency_symbol`, `starred_by`, `group_ids`, `deleted`, `is_lead`, `lead_status_id`, `owner_id`, `created_by`, `sort`, `lead_source_id`, `last_lead_status`, `client_migration_date`, `vat_number`, `gst_number`, `stripe_customer_id`, `stripe_card_ending_digit`, `currency`, `disable_online_payment`, `labels`) VALUES
(1, 'asdf', 'organization', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', '', 0, 0, 0, 0, 1, 0, 0, '', NULL, NULL, NULL, '', 0, NULL, 0, NULL),
(2, 'Geninfo-Tech', 'organization', '', 'Madurai', 'Tamilnadu', '625201', 'India', '2025-08-25 08:02:24', 'geninfotechinnovations.in', '09626885353', '', '', '', 0, 0, 0, 0, 58, 0, 0, '', NULL, '', '', '', 0, '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `rise_client_groups`
--

CREATE TABLE `rise_client_groups` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_company`
--

CREATE TABLE `rise_company` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `address` text NOT NULL,
  `phone` text NOT NULL,
  `email` text NOT NULL,
  `website` text NOT NULL,
  `vat_number` text NOT NULL,
  `gst_number` text NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `logo` mediumtext NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_contracts`
--

CREATE TABLE `rise_contracts` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `client_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `contract_date` date NOT NULL,
  `valid_until` date NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `last_email_sent_date` date DEFAULT NULL,
  `status` enum('draft','sent','accepted','declined') NOT NULL DEFAULT 'draft',
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `discount_type` enum('before_tax','after_tax') NOT NULL,
  `discount_amount` double NOT NULL,
  `discount_amount_type` enum('percentage','fixed_amount') NOT NULL,
  `content` mediumtext NOT NULL,
  `public_key` varchar(10) NOT NULL,
  `accepted_by` int(11) NOT NULL DEFAULT 0,
  `staff_signed_by` int(11) NOT NULL DEFAULT 0,
  `meta_data` text NOT NULL,
  `files` mediumtext NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_contract_items`
--

CREATE TABLE `rise_contract_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `contract_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_contract_templates`
--

CREATE TABLE `rise_contract_templates` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `template` mediumtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_custom_fields`
--

CREATE TABLE `rise_custom_fields` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `title_language_key` text NOT NULL,
  `placeholder_language_key` text NOT NULL,
  `show_in_embedded_form` tinyint(4) NOT NULL DEFAULT 0,
  `placeholder` text NOT NULL,
  `example_variable_name` text DEFAULT NULL,
  `options` mediumtext NOT NULL,
  `field_type` varchar(50) NOT NULL,
  `related_to` varchar(50) NOT NULL,
  `sort` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `add_filter` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_table` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_invoice` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_estimate` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_contract` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_order` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_proposal` tinyint(1) NOT NULL DEFAULT 0,
  `visible_to_admins_only` tinyint(1) NOT NULL DEFAULT 0,
  `hide_from_clients` tinyint(1) NOT NULL DEFAULT 0,
  `disable_editing_by_clients` tinyint(1) NOT NULL DEFAULT 0,
  `show_on_kanban_card` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_subscription` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_custom_field_values`
--

CREATE TABLE `rise_custom_field_values` (
  `id` int(11) NOT NULL,
  `related_to_type` varchar(50) NOT NULL,
  `related_to_id` int(11) NOT NULL,
  `custom_field_id` int(11) NOT NULL,
  `value` longtext NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_custom_widgets`
--

CREATE TABLE `rise_custom_widgets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `content` mediumtext DEFAULT NULL,
  `show_title` tinyint(1) NOT NULL DEFAULT 0,
  `show_border` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_dashboards`
--

CREATE TABLE `rise_dashboards` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `data` text DEFAULT NULL,
  `color` varchar(15) NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_email_templates`
--

CREATE TABLE `rise_email_templates` (
  `id` int(11) NOT NULL,
  `template_name` varchar(50) NOT NULL,
  `email_subject` text NOT NULL,
  `default_message` mediumtext NOT NULL,
  `custom_message` mediumtext DEFAULT NULL,
  `template_type` enum('default','custom') NOT NULL DEFAULT 'default',
  `language` varchar(50) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_estimates`
--

CREATE TABLE `rise_estimates` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `estimate_request_id` int(11) NOT NULL DEFAULT 0,
  `estimate_date` date NOT NULL,
  `valid_until` date NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `last_email_sent_date` date DEFAULT NULL,
  `status` enum('draft','sent','accepted','declined') NOT NULL DEFAULT 'draft',
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `discount_type` enum('before_tax','after_tax') NOT NULL,
  `discount_amount` double NOT NULL,
  `discount_amount_type` enum('percentage','fixed_amount') NOT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `accepted_by` int(11) NOT NULL DEFAULT 0,
  `meta_data` text NOT NULL,
  `created_by` int(11) NOT NULL,
  `signature` text NOT NULL,
  `public_key` text NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_estimate_comments`
--

CREATE TABLE `rise_estimate_comments` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `description` mediumtext NOT NULL,
  `estimate_id` int(11) NOT NULL DEFAULT 0,
  `files` longtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_estimate_forms`
--

CREATE TABLE `rise_estimate_forms` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` longtext NOT NULL,
  `status` enum('active','inactive') NOT NULL,
  `assigned_to` int(11) NOT NULL,
  `public` tinyint(1) NOT NULL DEFAULT 0,
  `enable_attachment` tinyint(4) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_estimate_items`
--

CREATE TABLE `rise_estimate_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `estimate_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_estimate_requests`
--

CREATE TABLE `rise_estimate_requests` (
  `id` int(11) NOT NULL,
  `estimate_form_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `client_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `assigned_to` int(11) NOT NULL,
  `status` enum('new','processing','hold','canceled','estimated') NOT NULL DEFAULT 'new',
  `files` mediumtext NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_events`
--

CREATE TABLE `rise_events` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `location` mediumtext DEFAULT NULL,
  `client_id` int(11) NOT NULL DEFAULT 0,
  `labels` text NOT NULL,
  `share_with` mediumtext DEFAULT NULL,
  `editable_google_event` tinyint(1) NOT NULL DEFAULT 0,
  `google_event_id` text NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `lead_id` int(11) NOT NULL DEFAULT 0,
  `ticket_id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `task_id` int(11) NOT NULL DEFAULT 0,
  `proposal_id` int(11) NOT NULL DEFAULT 0,
  `contract_id` int(11) NOT NULL DEFAULT 0,
  `subscription_id` int(11) NOT NULL DEFAULT 0,
  `invoice_id` int(11) NOT NULL DEFAULT 0,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `estimate_id` int(11) NOT NULL DEFAULT 0,
  `related_user_id` int(11) NOT NULL DEFAULT 0,
  `next_recurring_time` datetime DEFAULT NULL,
  `no_of_cycles_completed` int(11) NOT NULL DEFAULT 0,
  `snoozing_time` datetime DEFAULT NULL,
  `reminder_status` enum('new','shown','done') NOT NULL DEFAULT 'new',
  `type` enum('event','reminder') NOT NULL DEFAULT 'event',
  `color` varchar(15) NOT NULL,
  `recurring` int(11) NOT NULL DEFAULT 0,
  `repeat_every` int(11) NOT NULL DEFAULT 0,
  `repeat_type` enum('days','weeks','months','years') DEFAULT NULL,
  `no_of_cycles` int(11) NOT NULL DEFAULT 0,
  `last_start_date` date DEFAULT NULL,
  `recurring_dates` longtext NOT NULL,
  `confirmed_by` text NOT NULL,
  `rejected_by` text NOT NULL,
  `files` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_events`
--

INSERT INTO `rise_events` (`id`, `title`, `description`, `start_date`, `end_date`, `start_time`, `end_time`, `created_by`, `location`, `client_id`, `labels`, `share_with`, `editable_google_event`, `google_event_id`, `deleted`, `lead_id`, `ticket_id`, `project_id`, `task_id`, `proposal_id`, `contract_id`, `subscription_id`, `invoice_id`, `order_id`, `estimate_id`, `related_user_id`, `next_recurring_time`, `no_of_cycles_completed`, `snoozing_time`, `reminder_status`, `type`, `color`, `recurring`, `repeat_every`, `repeat_type`, `no_of_cycles`, `last_start_date`, `recurring_dates`, `confirmed_by`, `rejected_by`, `files`) VALUES
(1, 'student regigtration at genfotech ', 'Around 10 students from Bharath Niketan Engineering College, Theni\r\n ', '2025-07-07', '2025-07-07', '11:00:00', '13:00:00', 55, 'Institute', 0, '', '', 0, '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, 0, NULL, 'new', 'event', '#4a8af4', 0, 1, 'months', 0, '0000-00-00', '', '0', '0', 'a:0:{}');

-- --------------------------------------------------------

--
-- Table structure for table `rise_event_tracker`
--

CREATE TABLE `rise_event_tracker` (
  `id` int(11) NOT NULL,
  `event_type` varchar(255) NOT NULL,
  `context` varchar(255) NOT NULL,
  `context_id` int(11) NOT NULL,
  `read_count` int(11) DEFAULT NULL,
  `status` enum('new','read') DEFAULT 'new',
  `last_read_time` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `logs` text DEFAULT NULL,
  `random_id` varchar(10) NOT NULL,
  `deleted` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_expenses`
--

CREATE TABLE `rise_expenses` (
  `id` int(11) NOT NULL,
  `expense_date` date NOT NULL,
  `category_id` int(11) NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `amount` double NOT NULL,
  `files` mediumtext NOT NULL,
  `title` text NOT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `client_id` int(11) NOT NULL DEFAULT 0,
  `recurring` tinyint(4) NOT NULL DEFAULT 0,
  `recurring_expense_id` tinyint(4) NOT NULL DEFAULT 0,
  `repeat_every` int(11) NOT NULL DEFAULT 0,
  `repeat_type` enum('days','weeks','months','years') DEFAULT NULL,
  `no_of_cycles` int(11) NOT NULL DEFAULT 0,
  `next_recurring_date` date DEFAULT NULL,
  `no_of_cycles_completed` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_expense_categories`
--

CREATE TABLE `rise_expense_categories` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_file_category`
--

CREATE TABLE `rise_file_category` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `type` enum('project') NOT NULL DEFAULT 'project',
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_folders`
--

CREATE TABLE `rise_folders` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `folder_id` varchar(255) NOT NULL,
  `parent_id` int(11) NOT NULL,
  `level` text DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `permissions` text DEFAULT NULL,
  `context` varchar(255) NOT NULL,
  `context_id` int(11) NOT NULL,
  `starred_by` mediumtext NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_general_files`
--

CREATE TABLE `rise_general_files` (
  `id` int(11) NOT NULL,
  `file_name` text NOT NULL,
  `file_id` text DEFAULT NULL,
  `service_type` varchar(20) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `file_size` double NOT NULL,
  `created_at` datetime NOT NULL,
  `client_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `uploaded_by` int(11) NOT NULL,
  `folder_id` int(11) DEFAULT 0,
  `context` varchar(100) NOT NULL,
  `context_id` int(11) DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_help_articles`
--

CREATE TABLE `rise_help_articles` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` longtext NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `files` text NOT NULL,
  `total_views` int(11) NOT NULL DEFAULT 0,
  `sort` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_help_categories`
--

CREATE TABLE `rise_help_categories` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text NOT NULL,
  `type` enum('help','knowledge_base') NOT NULL,
  `sort` int(11) NOT NULL,
  `articles_order` varchar(3) NOT NULL DEFAULT '',
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_invoices`
--

CREATE TABLE `rise_invoices` (
  `id` int(11) NOT NULL,
  `type` enum('invoice','credit_note') NOT NULL DEFAULT 'invoice',
  `client_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `bill_date` date NOT NULL,
  `due_date` date NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `labels` text DEFAULT NULL,
  `last_email_sent_date` date DEFAULT NULL,
  `status` enum('draft','not_paid','cancelled','credited') NOT NULL DEFAULT 'draft',
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `tax_id3` int(11) NOT NULL DEFAULT 0,
  `recurring` tinyint(4) NOT NULL DEFAULT 0,
  `recurring_invoice_id` int(11) NOT NULL DEFAULT 0,
  `repeat_every` int(11) NOT NULL DEFAULT 0,
  `repeat_type` enum('days','weeks','months','years') DEFAULT NULL,
  `no_of_cycles` int(11) NOT NULL DEFAULT 0,
  `next_recurring_date` date DEFAULT NULL,
  `no_of_cycles_completed` int(11) NOT NULL DEFAULT 0,
  `due_reminder_date` date DEFAULT NULL,
  `recurring_reminder_date` date DEFAULT NULL,
  `discount_amount` double NOT NULL,
  `discount_amount_type` enum('percentage','fixed_amount') NOT NULL,
  `discount_type` enum('before_tax','after_tax') NOT NULL,
  `cancelled_at` datetime DEFAULT NULL,
  `cancelled_by` int(11) NOT NULL,
  `files` mediumtext NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `estimate_id` int(11) NOT NULL DEFAULT 0,
  `main_invoice_id` int(11) NOT NULL DEFAULT 0,
  `subscription_id` int(11) NOT NULL DEFAULT 0,
  `invoice_total` double NOT NULL,
  `invoice_subtotal` double NOT NULL,
  `discount_total` double NOT NULL,
  `tax` double NOT NULL,
  `tax2` double NOT NULL,
  `tax3` double NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `display_id` text NOT NULL,
  `number_year` int(11) DEFAULT NULL,
  `number_sequence` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_invoice_items`
--

CREATE TABLE `rise_invoice_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `invoice_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `taxable` tinyint(1) NOT NULL DEFAULT 1,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_invoice_payments`
--

CREATE TABLE `rise_invoice_payments` (
  `id` int(11) NOT NULL,
  `amount` double NOT NULL,
  `payment_date` date NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `note` text DEFAULT NULL,
  `invoice_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `transaction_id` tinytext DEFAULT NULL,
  `created_by` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_items`
--

CREATE TABLE `rise_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `files` mediumtext NOT NULL,
  `show_in_client_portal` tinyint(1) NOT NULL DEFAULT 0,
  `category_id` int(11) NOT NULL,
  `taxable` tinyint(1) NOT NULL DEFAULT 0,
  `sort` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_item_categories`
--

CREATE TABLE `rise_item_categories` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_labels`
--

CREATE TABLE `rise_labels` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `color` varchar(15) NOT NULL,
  `context` enum('event','invoice','note','project','task','ticket','to_do','subscription','client') DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_leads`
--

CREATE TABLE `rise_leads` (
  `id` int(11) NOT NULL,
  `company_name` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(150) NOT NULL,
  `address` text DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `state` varchar(50) DEFAULT NULL,
  `zip` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `created_date` date NOT NULL,
  `website` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_lead_source`
--

CREATE TABLE `rise_lead_source` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `sort` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_lead_source`
--

INSERT INTO `rise_lead_source` (`id`, `title`, `sort`, `deleted`) VALUES
(1, 'Google', 1, 0),
(2, 'Facebook', 2, 0),
(3, 'Twitter', 3, 0),
(4, 'Youtube', 4, 0),
(5, 'Elsewhere', 5, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rise_lead_status`
--

CREATE TABLE `rise_lead_status` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `color` varchar(7) NOT NULL,
  `sort` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_lead_status`
--

INSERT INTO `rise_lead_status` (`id`, `title`, `color`, `sort`, `deleted`) VALUES
(1, 'New', '#f1c40f', 0, 0),
(2, 'Qualified', '#2d9cdb', 1, 0),
(3, 'Discussion', '#29c2c2', 2, 0),
(4, 'Negotiation', '#2d9cdb', 3, 0),
(5, 'Won', '#83c340', 4, 0),
(6, 'Lost', '#e74c3c', 5, 0),
(7, 'Enquiry', '#d43480', 6, 1),
(8, 'Course', '#dbadff', 7, 1),
(9, 'Internship', '#4a8af4', 8, 1),
(10, 'Inplant Training', '#4a8af4', 9, 1),
(11, 'Lead Source', '#e18a00', 10, 1);

-- --------------------------------------------------------

--
-- Table structure for table `rise_leave_applications`
--

CREATE TABLE `rise_leave_applications` (
  `id` int(11) NOT NULL,
  `leave_type_id` int(11) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_hours` decimal(7,2) NOT NULL,
  `total_days` decimal(5,2) NOT NULL,
  `applicant_id` int(11) NOT NULL,
  `reason` mediumtext NOT NULL,
  `status` enum('pending','approved','rejected','canceled') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL,
  `created_by` int(11) NOT NULL,
  `checked_at` datetime DEFAULT NULL,
  `checked_by` int(11) NOT NULL DEFAULT 0,
  `files` text NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_leave_types`
--

CREATE TABLE `rise_leave_types` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `color` varchar(7) NOT NULL,
  `description` text DEFAULT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_likes`
--

CREATE TABLE `rise_likes` (
  `id` int(11) NOT NULL,
  `project_comment_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_messages`
--

CREATE TABLE `rise_messages` (
  `id` int(11) NOT NULL,
  `subject` varchar(255) NOT NULL DEFAULT 'Untitled',
  `message` mediumtext NOT NULL,
  `created_at` datetime NOT NULL,
  `from_user_id` int(11) NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `status` enum('unread','read') NOT NULL DEFAULT 'unread',
  `message_id` int(11) NOT NULL DEFAULT 0,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `files` longtext NOT NULL,
  `deleted_by_users` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_milestones`
--

CREATE TABLE `rise_milestones` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `project_id` int(11) NOT NULL,
  `due_date` date NOT NULL,
  `description` text NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_notes`
--

CREATE TABLE `rise_notes` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `client_id` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `labels` text DEFAULT NULL,
  `files` mediumtext NOT NULL,
  `is_public` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `category_id` int(11) DEFAULT 0,
  `color` varchar(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_note_category`
--

CREATE TABLE `rise_note_category` (
  `id` int(11) NOT NULL,
  `name` text DEFAULT NULL,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_notifications`
--

CREATE TABLE `rise_notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` longtext NOT NULL,
  `created_at` datetime NOT NULL,
  `notify_to` mediumtext NOT NULL,
  `read_by` mediumtext NOT NULL,
  `event` varchar(250) NOT NULL,
  `project_id` int(11) NOT NULL,
  `task_id` int(11) NOT NULL,
  `project_comment_id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `ticket_comment_id` int(11) NOT NULL,
  `project_file_id` int(11) NOT NULL,
  `leave_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `to_user_id` int(11) NOT NULL,
  `activity_log_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `lead_id` int(11) NOT NULL,
  `invoice_payment_id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `estimate_id` int(11) NOT NULL,
  `contract_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `estimate_request_id` int(11) NOT NULL,
  `actual_message_id` int(11) NOT NULL,
  `parent_message_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `announcement_id` int(11) NOT NULL,
  `proposal_id` int(11) NOT NULL,
  `estimate_comment_id` int(11) NOT NULL,
  `subscription_id` int(11) NOT NULL,
  `expense_id` int(11) NOT NULL,
  `proposal_comment_id` int(11) NOT NULL,
  `reminder_log_id` int(11) NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_notification_settings`
--

CREATE TABLE `rise_notification_settings` (
  `id` int(11) NOT NULL,
  `event` varchar(250) NOT NULL,
  `category` varchar(50) NOT NULL,
  `enable_email` int(11) NOT NULL DEFAULT 0,
  `enable_web` int(11) NOT NULL DEFAULT 0,
  `enable_slack` int(11) NOT NULL DEFAULT 0,
  `notify_to_team` text NOT NULL,
  `notify_to_team_members` text NOT NULL,
  `notify_to_terms` text NOT NULL,
  `sort` int(11) NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_orders`
--

CREATE TABLE `rise_orders` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `status_id` int(11) NOT NULL,
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `discount_amount` double NOT NULL,
  `discount_amount_type` enum('percentage','fixed_amount') NOT NULL,
  `discount_type` enum('before_tax','after_tax') NOT NULL,
  `created_by` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `files` longtext NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `created_by_hash` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_order_items`
--

CREATE TABLE `rise_order_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `order_id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `sort` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `created_by_hash` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_order_status`
--

CREATE TABLE `rise_order_status` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `color` varchar(7) NOT NULL,
  `sort` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_pages`
--

CREATE TABLE `rise_pages` (
  `id` int(11) NOT NULL,
  `title` text DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `slug` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `internal_use_only` tinyint(1) NOT NULL DEFAULT 0,
  `visible_to_team_members_only` tinyint(1) NOT NULL DEFAULT 0,
  `visible_to_clients_only` tinyint(1) NOT NULL DEFAULT 0,
  `full_width` tinyint(1) NOT NULL DEFAULT 0,
  `hide_topbar` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_payment_methods`
--

CREATE TABLE `rise_payment_methods` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `type` varchar(100) NOT NULL DEFAULT 'custom',
  `description` text NOT NULL,
  `online_payable` tinyint(1) NOT NULL DEFAULT 0,
  `available_on_invoice` tinyint(1) NOT NULL DEFAULT 0,
  `minimum_payment_amount` double NOT NULL DEFAULT 0,
  `settings` longtext NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_paypal_ipn`
--

CREATE TABLE `rise_paypal_ipn` (
  `id` int(11) NOT NULL,
  `verification_code` text NOT NULL,
  `payment_verification_code` text NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `contact_user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_pin_comments`
--

CREATE TABLE `rise_pin_comments` (
  `id` int(11) NOT NULL,
  `project_comment_id` int(11) NOT NULL DEFAULT 0,
  `ticket_comment_id` int(11) NOT NULL DEFAULT 0,
  `pinned_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_posts`
--

CREATE TABLE `rise_posts` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `description` mediumtext NOT NULL,
  `post_id` int(11) NOT NULL,
  `share_with` text DEFAULT NULL,
  `files` longtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_projects`
--

CREATE TABLE `rise_projects` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `project_type` enum('client_project','internal_project') NOT NULL DEFAULT 'client_project',
  `start_date` date DEFAULT NULL,
  `deadline` date DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `created_date` date DEFAULT NULL,
  `created_by` int(11) NOT NULL DEFAULT 0,
  `status` enum('open','completed','hold','canceled') NOT NULL DEFAULT 'open',
  `status_id` int(11) NOT NULL DEFAULT 1,
  `labels` text DEFAULT NULL,
  `price` double NOT NULL DEFAULT 0,
  `starred_by` mediumtext NOT NULL,
  `estimate_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `proposal_id` int(11) DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_projects`
--

INSERT INTO `rise_projects` (`id`, `title`, `description`, `project_type`, `start_date`, `deadline`, `client_id`, `created_date`, `created_by`, `status`, `status_id`, `labels`, `price`, `starred_by`, `estimate_id`, `order_id`, `proposal_id`, `deleted`) VALUES
(1, 'Syllabus making', '', 'internal_project', '2025-07-03', '2025-07-05', 0, '2025-07-03', 1, 'open', 1, '', 0, '', 0, 0, 0, 1),
(2, 'Syllabus Making', '', 'internal_project', '2025-07-03', '2025-07-05', 0, '2025-07-04', 55, 'open', 1, '', 0, '', 0, 0, 0, 0),
(3, 'Gen-Info-tech Website', 'Complete website completion for gen-info Tech ', 'client_project', '2025-08-25', '2025-08-30', 2, '2025-08-25', 58, 'open', 1, '', 0, '', 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rise_project_comments`
--

CREATE TABLE `rise_project_comments` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `description` mediumtext NOT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `comment_id` int(11) NOT NULL DEFAULT 0,
  `task_id` int(11) NOT NULL DEFAULT 0,
  `file_id` int(11) NOT NULL DEFAULT 0,
  `customer_feedback_id` int(11) NOT NULL DEFAULT 0,
  `files` longtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_project_files`
--

CREATE TABLE `rise_project_files` (
  `id` int(11) NOT NULL,
  `file_name` text NOT NULL,
  `file_id` text DEFAULT NULL,
  `service_type` varchar(20) DEFAULT NULL,
  `description` mediumtext DEFAULT NULL,
  `file_size` double NOT NULL,
  `created_at` datetime NOT NULL,
  `project_id` int(11) NOT NULL,
  `uploaded_by` int(11) NOT NULL,
  `category_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `folder_id` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_project_members`
--

CREATE TABLE `rise_project_members` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `is_leader` tinyint(1) DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_project_members`
--

INSERT INTO `rise_project_members` (`id`, `user_id`, `project_id`, `is_leader`, `deleted`) VALUES
(1, 1, 1, 1, 0),
(2, 24, 1, 0, 0),
(3, 55, 2, 1, 0),
(4, 24, 2, 0, 0),
(5, 23, 2, 0, 0),
(6, 58, 3, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rise_project_settings`
--

CREATE TABLE `rise_project_settings` (
  `project_id` int(11) NOT NULL,
  `setting_name` varchar(100) NOT NULL,
  `setting_value` mediumtext NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_project_status`
--

CREATE TABLE `rise_project_status` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `title_language_key` text NOT NULL,
  `key_name` varchar(100) NOT NULL,
  `icon` varchar(50) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_project_time`
--

CREATE TABLE `rise_project_time` (
  `id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime DEFAULT NULL,
  `hours` float NOT NULL,
  `status` enum('open','logged','approved') NOT NULL DEFAULT 'logged',
  `note` text DEFAULT NULL,
  `task_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_project_time`
--

INSERT INTO `rise_project_time` (`id`, `project_id`, `user_id`, `start_time`, `end_time`, `hours`, `status`, `note`, `task_id`, `deleted`) VALUES
(1, 2, 55, '2025-07-04 04:31:12', NULL, 0, 'open', NULL, 1, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rise_proposals`
--

CREATE TABLE `rise_proposals` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `proposal_date` date NOT NULL,
  `valid_until` date NOT NULL,
  `note` mediumtext DEFAULT NULL,
  `last_email_sent_date` date DEFAULT NULL,
  `status` enum('draft','sent','accepted','declined') NOT NULL DEFAULT 'draft',
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `discount_type` enum('before_tax','after_tax') NOT NULL,
  `discount_amount` double NOT NULL,
  `discount_amount_type` enum('percentage','fixed_amount') NOT NULL,
  `content` mediumtext NOT NULL,
  `public_key` varchar(10) NOT NULL,
  `accepted_by` int(11) NOT NULL DEFAULT 0,
  `created_by` int(11) NOT NULL DEFAULT 0,
  `total_views` int(11) NOT NULL DEFAULT 0,
  `last_preview_seen` datetime DEFAULT NULL,
  `meta_data` text NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `project_id` int(11) DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_proposal_comments`
--

CREATE TABLE `rise_proposal_comments` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `description` mediumtext NOT NULL,
  `proposal_id` int(11) NOT NULL DEFAULT 0,
  `files` longtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_proposal_items`
--

CREATE TABLE `rise_proposal_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `proposal_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_proposal_templates`
--

CREATE TABLE `rise_proposal_templates` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `template` mediumtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_reminder_logs`
--

CREATE TABLE `rise_reminder_logs` (
  `id` int(11) NOT NULL,
  `context` varchar(255) NOT NULL,
  `context_id` int(11) NOT NULL,
  `reminder_event` varchar(255) DEFAULT NULL,
  `notification_status` enum('draft','completed') NOT NULL DEFAULT 'draft',
  `reminder_date` date DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_reminder_settings`
--

CREATE TABLE `rise_reminder_settings` (
  `id` int(11) NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'app',
  `context` text NOT NULL,
  `reminder_event` text NOT NULL,
  `reminder1` int(11) DEFAULT NULL,
  `reminder2` int(11) DEFAULT NULL,
  `reminder3` int(11) DEFAULT NULL,
  `reminder4` int(11) DEFAULT NULL,
  `reminder5` int(11) DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_roles`
--

CREATE TABLE `rise_roles` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `permissions` mediumtext DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_roles`
--

INSERT INTO `rise_roles` (`id`, `title`, `permissions`, `deleted`) VALUES
(1, 'Tech Lead', 'a:60:{s:5:\"leave\";s:0:\"\";s:14:\"leave_specific\";s:0:\"\";s:10:\"attendance\";s:3:\"all\";s:19:\"attendance_specific\";s:0:\"\";s:7:\"invoice\";s:0:\"\";s:12:\"subscription\";s:0:\"\";s:8:\"estimate\";s:0:\"\";s:8:\"contract\";s:0:\"\";s:8:\"proposal\";s:0:\"\";s:7:\"expense\";s:0:\"\";s:5:\"order\";s:0:\"\";s:6:\"client\";s:3:\"all\";s:15:\"client_specific\";s:0:\"\";s:4:\"lead\";s:0:\"\";s:6:\"ticket\";s:3:\"all\";s:15:\"ticket_specific\";s:0:\"\";s:12:\"announcement\";s:0:\"\";s:23:\"help_and_knowledge_base\";s:0:\"\";s:20:\"do_not_show_projects\";N;s:23:\"can_manage_all_projects\";N;s:19:\"can_create_projects\";s:1:\"1\";s:17:\"can_edit_projects\";s:1:\"1\";s:34:\"can_edit_only_own_created_projects\";N;s:36:\"can_delete_only_own_created_projects\";N;s:19:\"can_delete_projects\";s:1:\"1\";s:30:\"can_add_remove_project_members\";s:1:\"1\";s:16:\"can_create_tasks\";s:1:\"1\";s:14:\"can_edit_tasks\";s:1:\"1\";s:16:\"can_delete_tasks\";s:1:\"1\";s:20:\"can_comment_on_tasks\";s:1:\"1\";s:24:\"show_assigned_tasks_only\";N;s:37:\"can_update_only_assigned_tasks_status\";N;s:21:\"can_create_milestones\";s:1:\"1\";s:19:\"can_edit_milestones\";s:1:\"1\";s:21:\"can_delete_milestones\";s:1:\"1\";s:16:\"can_delete_files\";s:1:\"1\";s:34:\"can_view_team_members_contact_info\";N;s:34:\"can_view_team_members_social_links\";N;s:29:\"team_member_update_permission\";s:0:\"\";s:38:\"team_member_update_permission_specific\";s:0:\"\";s:27:\"timesheet_manage_permission\";s:3:\"all\";s:36:\"timesheet_manage_permission_specific\";s:0:\"\";s:21:\"disable_event_sharing\";N;s:22:\"hide_team_members_list\";N;s:28:\"can_delete_leave_application\";N;s:18:\"message_permission\";s:0:\"\";s:27:\"message_permission_specific\";s:0:\"\";s:26:\"job_info_manage_permission\";s:0:\"\";s:32:\"can_manage_all_kinds_of_settings\";N;s:36:\"can_manage_user_role_and_permissions\";s:0:\"\";s:34:\"can_add_or_invite_new_team_members\";N;s:36:\"can_activate_deactivate_team_members\";N;s:23:\"can_delete_team_members\";N;s:19:\"timeline_permission\";s:0:\"\";s:28:\"timeline_permission_specific\";s:0:\"\";s:33:\"client_feedback_access_permission\";s:3:\"all\";s:35:\"team_members_note_manage_permission\";N;s:25:\"can_upload_and_edit_files\";s:1:\"1\";s:14:\"can_view_files\";s:1:\"1\";s:23:\"can_comment_on_projects\";s:3:\"all\";}', 0),
(2, 'Marketing', 'a:60:{s:5:\"leave\";s:0:\"\";s:14:\"leave_specific\";s:0:\"\";s:10:\"attendance\";s:0:\"\";s:19:\"attendance_specific\";s:0:\"\";s:7:\"invoice\";s:3:\"all\";s:12:\"subscription\";s:3:\"all\";s:8:\"estimate\";s:3:\"all\";s:8:\"contract\";s:3:\"all\";s:8:\"proposal\";s:3:\"all\";s:7:\"expense\";s:3:\"all\";s:5:\"order\";s:3:\"all\";s:6:\"client\";s:3:\"all\";s:15:\"client_specific\";s:0:\"\";s:4:\"lead\";s:3:\"all\";s:6:\"ticket\";s:0:\"\";s:15:\"ticket_specific\";s:0:\"\";s:12:\"announcement\";s:0:\"\";s:23:\"help_and_knowledge_base\";s:0:\"\";s:20:\"do_not_show_projects\";N;s:23:\"can_manage_all_projects\";N;s:19:\"can_create_projects\";N;s:17:\"can_edit_projects\";N;s:34:\"can_edit_only_own_created_projects\";N;s:36:\"can_delete_only_own_created_projects\";N;s:19:\"can_delete_projects\";N;s:30:\"can_add_remove_project_members\";N;s:16:\"can_create_tasks\";s:1:\"1\";s:14:\"can_edit_tasks\";s:1:\"1\";s:16:\"can_delete_tasks\";s:1:\"1\";s:20:\"can_comment_on_tasks\";s:1:\"1\";s:24:\"show_assigned_tasks_only\";N;s:37:\"can_update_only_assigned_tasks_status\";N;s:21:\"can_create_milestones\";N;s:19:\"can_edit_milestones\";N;s:21:\"can_delete_milestones\";N;s:16:\"can_delete_files\";N;s:34:\"can_view_team_members_contact_info\";N;s:34:\"can_view_team_members_social_links\";N;s:29:\"team_member_update_permission\";s:0:\"\";s:38:\"team_member_update_permission_specific\";s:0:\"\";s:27:\"timesheet_manage_permission\";s:0:\"\";s:36:\"timesheet_manage_permission_specific\";s:0:\"\";s:21:\"disable_event_sharing\";N;s:22:\"hide_team_members_list\";N;s:28:\"can_delete_leave_application\";N;s:18:\"message_permission\";s:0:\"\";s:27:\"message_permission_specific\";s:0:\"\";s:26:\"job_info_manage_permission\";s:0:\"\";s:32:\"can_manage_all_kinds_of_settings\";N;s:36:\"can_manage_user_role_and_permissions\";s:0:\"\";s:34:\"can_add_or_invite_new_team_members\";N;s:36:\"can_activate_deactivate_team_members\";N;s:23:\"can_delete_team_members\";N;s:19:\"timeline_permission\";s:8:\"specific\";s:28:\"timeline_permission_specific\";s:8:\"member:1\";s:33:\"client_feedback_access_permission\";s:3:\"all\";s:35:\"team_members_note_manage_permission\";N;s:25:\"can_upload_and_edit_files\";N;s:14:\"can_view_files\";s:1:\"1\";s:23:\"can_comment_on_projects\";s:3:\"all\";}', 0),
(3, 'Team member', 'a:60:{s:5:\"leave\";s:0:\"\";s:14:\"leave_specific\";s:0:\"\";s:10:\"attendance\";s:3:\"all\";s:19:\"attendance_specific\";s:0:\"\";s:7:\"invoice\";s:0:\"\";s:12:\"subscription\";s:0:\"\";s:8:\"estimate\";s:0:\"\";s:8:\"contract\";s:0:\"\";s:8:\"proposal\";s:0:\"\";s:7:\"expense\";s:0:\"\";s:5:\"order\";s:0:\"\";s:6:\"client\";s:3:\"own\";s:15:\"client_specific\";s:0:\"\";s:4:\"lead\";s:0:\"\";s:6:\"ticket\";s:13:\"assigned_only\";s:15:\"ticket_specific\";s:0:\"\";s:12:\"announcement\";s:0:\"\";s:23:\"help_and_knowledge_base\";s:0:\"\";s:20:\"do_not_show_projects\";N;s:23:\"can_manage_all_projects\";N;s:19:\"can_create_projects\";N;s:17:\"can_edit_projects\";s:1:\"1\";s:34:\"can_edit_only_own_created_projects\";N;s:36:\"can_delete_only_own_created_projects\";N;s:19:\"can_delete_projects\";N;s:30:\"can_add_remove_project_members\";N;s:16:\"can_create_tasks\";s:1:\"1\";s:14:\"can_edit_tasks\";s:1:\"1\";s:16:\"can_delete_tasks\";N;s:20:\"can_comment_on_tasks\";s:1:\"1\";s:24:\"show_assigned_tasks_only\";N;s:37:\"can_update_only_assigned_tasks_status\";N;s:21:\"can_create_milestones\";N;s:19:\"can_edit_milestones\";N;s:21:\"can_delete_milestones\";N;s:16:\"can_delete_files\";s:1:\"1\";s:34:\"can_view_team_members_contact_info\";N;s:34:\"can_view_team_members_social_links\";N;s:29:\"team_member_update_permission\";s:0:\"\";s:38:\"team_member_update_permission_specific\";s:0:\"\";s:27:\"timesheet_manage_permission\";s:3:\"own\";s:36:\"timesheet_manage_permission_specific\";s:0:\"\";s:21:\"disable_event_sharing\";N;s:22:\"hide_team_members_list\";N;s:28:\"can_delete_leave_application\";N;s:18:\"message_permission\";s:0:\"\";s:27:\"message_permission_specific\";s:0:\"\";s:26:\"job_info_manage_permission\";s:0:\"\";s:32:\"can_manage_all_kinds_of_settings\";N;s:36:\"can_manage_user_role_and_permissions\";s:0:\"\";s:34:\"can_add_or_invite_new_team_members\";N;s:36:\"can_activate_deactivate_team_members\";N;s:23:\"can_delete_team_members\";N;s:19:\"timeline_permission\";s:0:\"\";s:28:\"timeline_permission_specific\";s:0:\"\";s:33:\"client_feedback_access_permission\";s:3:\"all\";s:35:\"team_members_note_manage_permission\";N;s:25:\"can_upload_and_edit_files\";s:1:\"1\";s:14:\"can_view_files\";s:1:\"1\";s:23:\"can_comment_on_projects\";s:3:\"all\";}', 0),
(4, 'Admin-Operation', 'a:60:{s:5:\"leave\";s:3:\"all\";s:14:\"leave_specific\";s:0:\"\";s:10:\"attendance\";s:3:\"all\";s:19:\"attendance_specific\";s:0:\"\";s:7:\"invoice\";s:0:\"\";s:12:\"subscription\";s:3:\"all\";s:8:\"estimate\";s:0:\"\";s:8:\"contract\";s:0:\"\";s:8:\"proposal\";s:0:\"\";s:7:\"expense\";s:0:\"\";s:5:\"order\";s:3:\"all\";s:6:\"client\";s:3:\"all\";s:15:\"client_specific\";s:0:\"\";s:4:\"lead\";s:3:\"all\";s:6:\"ticket\";s:3:\"all\";s:15:\"ticket_specific\";s:0:\"\";s:12:\"announcement\";s:3:\"all\";s:23:\"help_and_knowledge_base\";s:3:\"all\";s:20:\"do_not_show_projects\";N;s:23:\"can_manage_all_projects\";s:1:\"1\";s:19:\"can_create_projects\";N;s:17:\"can_edit_projects\";N;s:34:\"can_edit_only_own_created_projects\";N;s:36:\"can_delete_only_own_created_projects\";N;s:19:\"can_delete_projects\";N;s:30:\"can_add_remove_project_members\";N;s:16:\"can_create_tasks\";N;s:14:\"can_edit_tasks\";N;s:16:\"can_delete_tasks\";N;s:20:\"can_comment_on_tasks\";N;s:24:\"show_assigned_tasks_only\";N;s:37:\"can_update_only_assigned_tasks_status\";N;s:21:\"can_create_milestones\";N;s:19:\"can_edit_milestones\";N;s:21:\"can_delete_milestones\";N;s:16:\"can_delete_files\";N;s:34:\"can_view_team_members_contact_info\";s:1:\"1\";s:34:\"can_view_team_members_social_links\";s:1:\"1\";s:29:\"team_member_update_permission\";s:3:\"all\";s:38:\"team_member_update_permission_specific\";s:0:\"\";s:27:\"timesheet_manage_permission\";s:3:\"all\";s:36:\"timesheet_manage_permission_specific\";s:0:\"\";s:21:\"disable_event_sharing\";N;s:22:\"hide_team_members_list\";N;s:28:\"can_delete_leave_application\";N;s:18:\"message_permission\";s:8:\"specific\";s:27:\"message_permission_specific\";s:18:\"member:1,member:23\";s:26:\"job_info_manage_permission\";s:3:\"all\";s:32:\"can_manage_all_kinds_of_settings\";N;s:36:\"can_manage_user_role_and_permissions\";s:0:\"\";s:34:\"can_add_or_invite_new_team_members\";s:1:\"1\";s:36:\"can_activate_deactivate_team_members\";s:1:\"1\";s:23:\"can_delete_team_members\";N;s:19:\"timeline_permission\";s:2:\"no\";s:28:\"timeline_permission_specific\";s:0:\"\";s:33:\"client_feedback_access_permission\";N;s:35:\"team_members_note_manage_permission\";s:3:\"all\";s:25:\"can_upload_and_edit_files\";N;s:14:\"can_view_files\";N;s:23:\"can_comment_on_projects\";N;}', 0),
(5, 'Academic', NULL, 0),
(6, 'Placement', NULL, 0),
(7, 'vendor', 'a:60:{s:5:\"leave\";s:0:\"\";s:14:\"leave_specific\";s:0:\"\";s:10:\"attendance\";s:0:\"\";s:19:\"attendance_specific\";s:0:\"\";s:7:\"invoice\";s:0:\"\";s:12:\"subscription\";s:0:\"\";s:8:\"estimate\";s:0:\"\";s:8:\"contract\";s:0:\"\";s:8:\"proposal\";s:0:\"\";s:7:\"expense\";s:0:\"\";s:5:\"order\";s:0:\"\";s:6:\"client\";s:3:\"own\";s:15:\"client_specific\";s:0:\"\";s:4:\"lead\";s:3:\"own\";s:6:\"ticket\";s:13:\"assigned_only\";s:15:\"ticket_specific\";s:0:\"\";s:12:\"announcement\";s:0:\"\";s:23:\"help_and_knowledge_base\";s:0:\"\";s:20:\"do_not_show_projects\";N;s:23:\"can_manage_all_projects\";N;s:19:\"can_create_projects\";s:1:\"1\";s:17:\"can_edit_projects\";s:1:\"1\";s:34:\"can_edit_only_own_created_projects\";N;s:36:\"can_delete_only_own_created_projects\";N;s:19:\"can_delete_projects\";N;s:30:\"can_add_remove_project_members\";s:1:\"1\";s:16:\"can_create_tasks\";s:1:\"1\";s:14:\"can_edit_tasks\";s:1:\"1\";s:16:\"can_delete_tasks\";N;s:20:\"can_comment_on_tasks\";s:1:\"1\";s:24:\"show_assigned_tasks_only\";N;s:37:\"can_update_only_assigned_tasks_status\";N;s:21:\"can_create_milestones\";s:1:\"1\";s:19:\"can_edit_milestones\";s:1:\"1\";s:21:\"can_delete_milestones\";N;s:16:\"can_delete_files\";N;s:34:\"can_view_team_members_contact_info\";N;s:34:\"can_view_team_members_social_links\";N;s:29:\"team_member_update_permission\";s:3:\"all\";s:38:\"team_member_update_permission_specific\";s:0:\"\";s:27:\"timesheet_manage_permission\";s:0:\"\";s:36:\"timesheet_manage_permission_specific\";s:0:\"\";s:21:\"disable_event_sharing\";N;s:22:\"hide_team_members_list\";N;s:28:\"can_delete_leave_application\";N;s:18:\"message_permission\";s:0:\"\";s:27:\"message_permission_specific\";s:0:\"\";s:26:\"job_info_manage_permission\";s:3:\"all\";s:32:\"can_manage_all_kinds_of_settings\";N;s:36:\"can_manage_user_role_and_permissions\";s:0:\"\";s:34:\"can_add_or_invite_new_team_members\";N;s:36:\"can_activate_deactivate_team_members\";N;s:23:\"can_delete_team_members\";N;s:19:\"timeline_permission\";s:0:\"\";s:28:\"timeline_permission_specific\";s:0:\"\";s:33:\"client_feedback_access_permission\";s:3:\"all\";s:35:\"team_members_note_manage_permission\";N;s:25:\"can_upload_and_edit_files\";s:1:\"1\";s:14:\"can_view_files\";s:1:\"1\";s:23:\"can_comment_on_projects\";s:3:\"all\";}', 0);

-- --------------------------------------------------------

--
-- Table structure for table `rise_settings`
--

CREATE TABLE `rise_settings` (
  `setting_name` varchar(100) NOT NULL,
  `setting_value` mediumtext NOT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'app',
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_settings`
--

INSERT INTO `rise_settings` (`setting_name`, `setting_value`, `type`, `deleted`) VALUES
('accepted_file_formats', 'jpg,jpeg,png,doc,xlsx,txt,pdf,zip,webm', 'app', 0),
('allowed_ip_addresses', '', 'app', 0),
('app_title', 'Codeshell CRM', 'app', 0),
('client_can_access_notes', '1', 'app', 0),
('client_can_access_store', '', 'app', 0),
('client_can_add_files', '', 'app', 0),
('client_can_add_project_files', '1', 'app', 0),
('client_can_assign_tasks', '', 'app', 0),
('client_can_comment_on_files', '1', 'app', 0),
('client_can_comment_on_tasks', '1', 'app', 0),
('client_can_create_projects', '1', 'app', 0),
('client_can_create_reminders', '', 'app', 0),
('client_can_create_tasks', '', 'app', 0),
('client_can_delete_own_files_in_project', '', 'app', 0),
('client_can_edit_projects', '1', 'app', 0),
('client_can_edit_tasks', '', 'app', 0),
('client_can_view_activity', '1', 'app', 0),
('client_can_view_files', '', 'app', 0),
('client_can_view_gantt', '', 'app', 0),
('client_can_view_milestones', '1', 'app', 0),
('client_can_view_overview', '1', 'app', 0),
('client_can_view_project_files', '1', 'app', 0),
('client_can_view_tasks', '1', 'app', 0),
('client_message_own_contacts', '', 'app', 0),
('client_message_users', '', 'app', 0),
('contract_color', '#000000', 'app', 0),
('conversion_rate', 'a:0:{}', 'app', 0),
('create_recurring_tasks_before', '1', 'app', 0),
('currency_position', 'left', 'app', 0),
('currency_symbol', '₹', 'app', 0),
('date_format', 'Y-m-d', 'app', 0),
('decimal_separator', '.', 'app', 0),
('default_contract_template', '1', 'app', 0),
('default_currency', 'INR', 'app', 0),
('default_due_date_after_billing_date', '14', 'app', 0),
('default_permissions_for_non_primary_contact', 'projects', 'app', 0),
('default_proposal_template', '1', 'app', 0),
('default_theme_color', 'F2F2F2', 'app', 0),
('disable_access_favorite_project_option_for_clients', '', 'app', 0),
('disable_client_login', '', 'app', 0),
('disable_client_signup', '', 'app', 0),
('disable_dashboard_customization_by_clients', '', 'app', 0),
('disable_editing_left_menu_by_clients', '', 'app', 0),
('disable_topbar_menu_customization', '', 'app', 0),
('disable_user_invitation_option_by_clients', '', 'app', 0),
('email_sent_from_address', 'goappalam@gmail.com', 'app', 0),
('email_sent_from_name', 'Yuvaraj', 'app', 0),
('enable_audio_recording', '1', 'app', 0),
('enable_recurring_option_for_tasks', '1', 'app', 0),
('enable_rich_text_editor', '0', 'app', 0),
('estimate_color', '#000000', 'app', 0),
('favicon', 'a:1:{s:9:\"file_name\";s:30:\"_file686349c85b204-favicon.png\";}', 'app', 0),
('first_day_of_week', '0', 'app', 0),
('hidden_client_menus', '', 'app', 0),
('invoice_color', '#000000', 'app', 0),
('invoice_item_list_background', '#f4f4f4', 'app', 0),
('invoice_logo', 'default-invoice-logo.png', 'app', 0),
('invoice_number_format', '{SERIAL}', 'app', 0),
('invoice_prefix', 'INVOICE #', 'app', 0),
('item_purchase_code', 'dhzdturyEtmEYe55y3', 'app', 0),
('landing_page', '', 'app', 0),
('language', 'english', 'app', 0),
('module_announcement', '1', 'app', 0),
('module_attendance', '1', 'app', 0),
('module_chat', '1', 'app', 0),
('module_contract', '1', 'app', 0),
('module_estimate', '1', 'app', 0),
('module_estimate_request', '1', 'app', 0),
('module_event', '1', 'app', 0),
('module_expense', '1', 'app', 0),
('module_file_manager', '1', 'app', 0),
('module_gantt', '1', 'app', 0),
('module_help', '1', 'app', 0),
('module_invoice', '1', 'app', 0),
('module_knowledge_base', '1', 'app', 0),
('module_lead', '1', 'app', 0),
('module_leave', '1', 'app', 0),
('module_message', '1', 'app', 0),
('module_note', '1', 'app', 0),
('module_order', '1', 'app', 0),
('module_project_timesheet', '1', 'app', 0),
('module_proposal', '1', 'app', 0),
('module_reminder', '1', 'app', 0),
('module_subscription', '1', 'app', 0),
('module_ticket', '1', 'app', 0),
('module_timeline', '1', 'app', 0),
('module_todo', '1', 'app', 0),
('no_of_decimals', '2', 'app', 0),
('order_color', '#000000', 'app', 0),
('project_tab_order_of_clients', '', 'app', 0),
('project_task_deadline_overdue_reminder', '1', 'app', 0),
('project_task_deadline_pre_reminder', '1', 'app', 0),
('project_task_reminder_on_the_day_of_deadline', '1', 'app', 0),
('proposal_color', '#000000', 'app', 0),
('pwa_icon', 'a:1:{s:9:\"file_name\";s:31:\"_file686349f671d75-pwa_icon.png\";}', 'app', 0),
('pwa_theme_color', '#1c2026', 'app', 0),
('rows_per_page', '10', 'app', 0),
('scrollbar', 'jquery', 'app', 0),
('show_background_image_in_signin_page', 'no', 'app', 0),
('show_in_kanban', '', 'app', 0),
('show_logo_in_signin_page', 'no', 'app', 0),
('show_the_status_checkbox_in_tasks_list', '1', 'app', 0),
('show_theme_color_changer', 'yes', 'app', 0),
('show_time_with_task_start_date_and_deadline', '1', 'app', 0),
('signin_page_background', 'sigin-background-image.jpg', 'app', 0),
('site_logo', 'a:1:{s:9:\"file_name\";s:32:\"_file686349c85ab07-site-logo.png\";}', 'app', 0),
('support_only_project_related_tasks_globally', '1', 'app', 0),
('task_point_range', '5', 'app', 0),
('time_format', 'capital', 'app', 0),
('timezone', 'Asia/Kolkata', 'app', 0),
('user_1_dashboard', '', 'user', 0),
('user_10_dashboard', '', 'user', 0),
('user_11_dashboard', '', 'user', 0),
('user_12_dashboard', '', 'user', 0),
('user_15_dashboard', '', 'user', 0),
('user_17_dashboard', '', 'user', 0),
('user_18_dashboard', '', 'user', 0),
('user_2_dashboard', '1', 'user', 0),
('user_23_dashboard', '', 'user', 0),
('user_24_dashboard', '', 'user', 0),
('user_3_dashboard', '', 'user', 0),
('user_31_dashboard', '', 'user', 0),
('user_32_dashboard', '', 'user', 0),
('user_4_dashboard', '', 'user', 0),
('user_5_dashboard', '', 'user', 0),
('user_52_dashboard', '', 'user', 0),
('user_53_dashboard', '', 'user', 0),
('user_54_dashboard', '', 'user', 0),
('user_55_dashboard', '', 'user', 0),
('user_58_dashboard', '', 'user', 0),
('user_6_dashboard', '', 'user', 0),
('user_60_dashboard', '', 'user', 0),
('user_61_dashboard', '', 'user', 0),
('user_65_dashboard', '', 'user', 0),
('user_7_dashboard', '', 'user', 0),
('user_8_dashboard', '', 'user', 0),
('user_9_dashboard', '', 'user', 0),
('verify_email_before_client_signup', '', 'app', 0),
('weekends', '', 'app', 0);

-- --------------------------------------------------------

--
-- Table structure for table `rise_social_links`
--

CREATE TABLE `rise_social_links` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `facebook` text DEFAULT NULL,
  `twitter` text DEFAULT NULL,
  `linkedin` text DEFAULT NULL,
  `googleplus` text DEFAULT NULL,
  `digg` text DEFAULT NULL,
  `youtube` text DEFAULT NULL,
  `pinterest` text DEFAULT NULL,
  `instagram` text DEFAULT NULL,
  `github` text DEFAULT NULL,
  `tumblr` text DEFAULT NULL,
  `vine` text DEFAULT NULL,
  `whatsapp` text DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_stripe_ipn`
--

CREATE TABLE `rise_stripe_ipn` (
  `id` int(11) NOT NULL,
  `session_id` text NOT NULL,
  `verification_code` text NOT NULL,
  `payment_verification_code` text NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `contact_user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `payment_method_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `setup_intent` text NOT NULL,
  `subscription_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_subscriptions`
--

CREATE TABLE `rise_subscriptions` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `client_id` int(11) NOT NULL,
  `bill_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `note` mediumtext DEFAULT NULL,
  `labels` text NOT NULL,
  `status` enum('draft','pending','active','cancelled') NOT NULL DEFAULT 'draft',
  `payment_status` enum('success','failed') NOT NULL DEFAULT 'success',
  `tax_id` int(11) NOT NULL DEFAULT 0,
  `tax_id2` int(11) NOT NULL DEFAULT 0,
  `repeat_every` int(11) NOT NULL DEFAULT 1,
  `repeat_type` enum('days','weeks','months','years') DEFAULT NULL,
  `no_of_cycles` int(11) NOT NULL DEFAULT 0,
  `next_recurring_date` date DEFAULT NULL,
  `no_of_cycles_completed` int(11) NOT NULL DEFAULT 0,
  `cancelled_at` datetime DEFAULT NULL,
  `cancelled_by` int(11) NOT NULL,
  `files` mediumtext NOT NULL,
  `company_id` int(11) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `type` enum('app','stripe') NOT NULL DEFAULT 'app',
  `stripe_subscription_id` text NOT NULL,
  `stripe_product_id` text NOT NULL,
  `stripe_product_price_id` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_subscription_items`
--

CREATE TABLE `rise_subscription_items` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` text DEFAULT NULL,
  `quantity` double NOT NULL,
  `unit_type` varchar(20) NOT NULL DEFAULT '',
  `rate` double NOT NULL,
  `total` double NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `subscription_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_tasks`
--

CREATE TABLE `rise_tasks` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `project_id` int(11) NOT NULL,
  `milestone_id` int(11) NOT NULL DEFAULT 0,
  `assigned_to` int(11) NOT NULL,
  `deadline` datetime DEFAULT NULL,
  `labels` text DEFAULT NULL,
  `points` tinyint(4) NOT NULL DEFAULT 1,
  `status` enum('to_do','in_progress','done') NOT NULL DEFAULT 'to_do',
  `status_id` int(11) NOT NULL,
  `priority_id` int(11) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `collaborators` text NOT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `recurring` tinyint(1) NOT NULL DEFAULT 0,
  `repeat_every` int(11) NOT NULL DEFAULT 0,
  `repeat_type` enum('days','weeks','months','years') DEFAULT NULL,
  `no_of_cycles` int(11) NOT NULL DEFAULT 0,
  `recurring_task_id` int(11) NOT NULL DEFAULT 0,
  `no_of_cycles_completed` int(11) NOT NULL DEFAULT 0,
  `created_date` date DEFAULT NULL,
  `blocking` text NOT NULL,
  `blocked_by` text NOT NULL,
  `parent_task_id` int(11) NOT NULL,
  `next_recurring_date` date DEFAULT NULL,
  `reminder_date` date DEFAULT NULL,
  `ticket_id` int(11) NOT NULL,
  `status_changed_at` datetime DEFAULT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT 0,
  `expense_id` int(11) NOT NULL DEFAULT 0,
  `subscription_id` int(11) NOT NULL DEFAULT 0,
  `proposal_id` int(11) NOT NULL DEFAULT 0,
  `contract_id` int(11) NOT NULL DEFAULT 0,
  `order_id` int(11) NOT NULL DEFAULT 0,
  `estimate_id` int(11) NOT NULL DEFAULT 0,
  `invoice_id` int(11) NOT NULL DEFAULT 0,
  `lead_id` int(11) NOT NULL DEFAULT 0,
  `client_id` int(11) NOT NULL DEFAULT 0,
  `context` enum('project','client','lead','invoice','estimate','order','contract','proposal','subscription','ticket','expense','general') NOT NULL DEFAULT 'general',
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_tasks`
--

INSERT INTO `rise_tasks` (`id`, `title`, `description`, `project_id`, `milestone_id`, `assigned_to`, `deadline`, `labels`, `points`, `status`, `status_id`, `priority_id`, `start_date`, `collaborators`, `sort`, `recurring`, `repeat_every`, `repeat_type`, `no_of_cycles`, `recurring_task_id`, `no_of_cycles_completed`, `created_date`, `blocking`, `blocked_by`, `parent_task_id`, `next_recurring_date`, `reminder_date`, `ticket_id`, `status_changed_at`, `deleted`, `expense_id`, `subscription_id`, `proposal_id`, `contract_id`, `order_id`, `estimate_id`, `invoice_id`, `lead_id`, `client_id`, `context`, `created_by`) VALUES
(1, 'Syllabus Download', 'we need to download the following subjects\r\n1.C#\r\n2. DEVOPS\r\n3.MERN & MEAN\r\n4.ABAP\r\n', 2, 0, 55, '2025-07-04 17:00:00', '', 1, 'to_do', 1, 1, '2025-07-04 10:00:00', '24,23', 1000, 0, 1, 'months', 0, 0, 0, '2025-07-04', '', '', 0, NULL, NULL, 0, NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'project', 55);

-- --------------------------------------------------------

--
-- Table structure for table `rise_task_priority`
--

CREATE TABLE `rise_task_priority` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `icon` varchar(20) NOT NULL,
  `color` varchar(7) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_task_priority`
--

INSERT INTO `rise_task_priority` (`id`, `title`, `icon`, `color`, `deleted`) VALUES
(1, 'Immediate', 'bookmark', '#e74c3c', 0),
(2, 'Moderate', 'loader', '#f1c40f', 0),
(3, 'Time Taken', 'aperture', '#e74c3c', 0);

-- --------------------------------------------------------

--
-- Table structure for table `rise_task_status`
--

CREATE TABLE `rise_task_status` (
  `id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `key_name` varchar(100) NOT NULL,
  `color` varchar(7) NOT NULL,
  `sort` int(11) NOT NULL,
  `hide_from_kanban` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `hide_from_non_project_related_tasks` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_task_status`
--

INSERT INTO `rise_task_status` (`id`, `title`, `key_name`, `color`, `sort`, `hide_from_kanban`, `deleted`, `hide_from_non_project_related_tasks`) VALUES
(1, 'To Do', '', '#e74c3c', 1, 0, 0, 0),
(2, 'In Progress', '', '#f1c40f', 2, 0, 0, 0),
(3, 'Done', '', '#83c340', 3, 0, 0, 0),
(4, 'Verified', '', '#83c340', 4, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rise_taxes`
--

CREATE TABLE `rise_taxes` (
  `id` int(11) NOT NULL,
  `title` tinytext NOT NULL,
  `percentage` double NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0,
  `stripe_tax_id` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_team`
--

CREATE TABLE `rise_team` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `members` mediumtext NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_team_member_job_info`
--

CREATE TABLE `rise_team_member_job_info` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `date_of_hire` date DEFAULT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0,
  `salary` double NOT NULL DEFAULT 0,
  `salary_term` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_team_member_job_info`
--

INSERT INTO `rise_team_member_job_info` (`id`, `user_id`, `date_of_hire`, `deleted`, `salary`, `salary_term`) VALUES
(1, 58, '2025-08-23', 0, 50000, 'Monthly'),
(2, 59, '2025-08-23', 0, 5000, 'monthly'),
(3, 60, '2025-08-23', 0, 10000, 'monthly'),
(4, 61, '2025-08-20', 0, 100000, 'monthly'),
(5, 62, '2025-08-24', 0, 5000, 'monthly'),
(6, 63, '2025-09-24', 0, 10000, 'Full time'),
(7, 64, '2025-09-24', 0, 10000, 'Full time'),
(8, 65, '2025-09-24', 0, 10000, 'Full time');

-- --------------------------------------------------------

--
-- Table structure for table `rise_tickets`
--

CREATE TABLE `rise_tickets` (
  `id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `project_id` int(11) NOT NULL DEFAULT 0,
  `ticket_type_id` int(11) NOT NULL,
  `title` text NOT NULL,
  `created_by` int(11) NOT NULL,
  `requested_by` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL,
  `status` enum('new','client_replied','open','closed') NOT NULL DEFAULT 'new',
  `last_activity_at` datetime DEFAULT NULL,
  `assigned_to` int(11) NOT NULL DEFAULT 0,
  `creator_name` varchar(100) NOT NULL,
  `creator_email` varchar(255) NOT NULL,
  `labels` text DEFAULT NULL,
  `task_id` int(11) NOT NULL,
  `closed_at` datetime NOT NULL,
  `merged_with_ticket_id` int(11) NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_ticket_comments`
--

CREATE TABLE `rise_ticket_comments` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `description` mediumtext NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `files` longtext DEFAULT NULL,
  `is_note` tinyint(1) NOT NULL DEFAULT 0,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_ticket_templates`
--

CREATE TABLE `rise_ticket_templates` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext NOT NULL,
  `ticket_type_id` int(11) NOT NULL,
  `private` mediumtext NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_ticket_types`
--

CREATE TABLE `rise_ticket_types` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_to_do`
--

CREATE TABLE `rise_to_do` (
  `id` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `title` text NOT NULL,
  `description` mediumtext DEFAULT NULL,
  `labels` text DEFAULT NULL,
  `status` enum('to_do','done') NOT NULL DEFAULT 'to_do',
  `start_date` date DEFAULT NULL,
  `deleted` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rise_users`
--

CREATE TABLE `rise_users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `user_type` enum('staff','client','lead') NOT NULL DEFAULT 'client',
  `is_admin` tinyint(1) NOT NULL DEFAULT 0,
  `role_id` int(11) NOT NULL DEFAULT 0,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `image` text DEFAULT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `message_checked_at` datetime DEFAULT NULL,
  `client_id` int(11) NOT NULL DEFAULT 0,
  `notification_checked_at` datetime DEFAULT NULL,
  `is_primary_contact` tinyint(1) NOT NULL DEFAULT 0,
  `job_title` varchar(100) NOT NULL DEFAULT 'Untitled',
  `disable_login` tinyint(1) NOT NULL DEFAULT 0,
  `note` mediumtext DEFAULT NULL,
  `address` text DEFAULT NULL,
  `alternative_address` text DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `alternative_phone` varchar(20) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `ssn` varchar(20) DEFAULT NULL,
  `gender` enum('male','female','other') DEFAULT NULL,
  `sticky_note` mediumtext DEFAULT NULL,
  `skype` text DEFAULT NULL,
  `language` varchar(50) NOT NULL,
  `enable_web_notification` tinyint(1) NOT NULL DEFAULT 1,
  `enable_email_notification` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime DEFAULT NULL,
  `last_online` datetime DEFAULT NULL,
  `requested_account_removal` tinyint(1) NOT NULL DEFAULT 0,
  `client_permissions` text DEFAULT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_users`
--

INSERT INTO `rise_users` (`id`, `first_name`, `last_name`, `user_type`, `is_admin`, `role_id`, `email`, `password`, `image`, `status`, `message_checked_at`, `client_id`, `notification_checked_at`, `is_primary_contact`, `job_title`, `disable_login`, `note`, `address`, `alternative_address`, `phone`, `alternative_phone`, `dob`, `ssn`, `gender`, `sticky_note`, `skype`, `language`, `enable_web_notification`, `enable_email_notification`, `created_at`, `last_online`, `requested_account_removal`, `client_permissions`, `deleted`) VALUES
(1, 'Yuvaraj', 'Seenipandi', 'staff', 1, 0, 'goappalam@gmail.com', '$2y$10$mLsRLCnOD3113U9WlTlmxee5mKlod1.tT73Tl1q1y78CsTrBxgLbu', NULL, 'active', '2025-05-16 09:52:10', 0, '2025-06-11 10:56:31', 0, 'CEO & Co-Founder', 0, NULL, 'yuvaraj@codeshell.in', '', '8778641324', '', '0000-00-00', '', 'male', NULL, '', '', 1, 1, '0000-00-00 00:00:00', '2025-07-21 06:33:52', 0, NULL, 1),
(2, 'Vignesh', 'Balan', 'staff', 0, 1, 'vigneshbalan@codeshell.in', '$2y$10$RGns3Q7dXGb/7gfKB.kNIeA0gpl6X0mfM2tMPNO4EkD91F1Kq6VJO', NULL, 'active', NULL, 0, NULL, 0, 'Team Lead', 0, NULL, 'vignesh@codeshell.in', NULL, '', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-04-09 08:29:34', '2025-05-02 16:37:28', 0, NULL, 1),
(3, 'Keerthana valli', 'R', 'staff', 0, 1, 'keerthana@codeshell.in', '$2y$10$1AybgK7BzebVhXoFcdh.UemifgrP6iX9HZmeY1oLvkjHMknOgV0FK', NULL, 'active', NULL, 0, '2025-05-01 04:43:56', 0, 'FrontEnd Developer', 0, NULL, '', NULL, '', NULL, NULL, NULL, 'female', NULL, NULL, '', 1, 1, '2025-04-10 00:56:55', '2025-05-02 15:43:17', 0, NULL, 1),
(4, 'Gokul', 'Easwaran', 'staff', 0, 3, 'gokul@codeshell.in', '$2y$10$2.yIgi8DCH8VWk40jUOq/OGgothAMOC.cf6lAUudnOan.B2DMEY6G', NULL, 'active', NULL, 0, NULL, 0, 'Backend Developer', 0, NULL, '', NULL, '', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-04-10 01:02:22', '2025-05-02 06:54:15', 0, NULL, 1),
(5, 'Nasrin', 'Fathima', 'staff', 0, 3, 'nasrin@codeshell.in', '$2y$10$HQiLFwz4cF.zzS/u6mh6xe/U0bxuD6/wz6QYlq2OCPJuYx0oxDV1C', NULL, 'active', '2025-04-18 16:27:25', 0, NULL, 0, 'Backend Developer', 0, NULL, '', NULL, '', NULL, NULL, NULL, 'female', NULL, NULL, '', 1, 1, '2025-04-10 01:04:08', '2025-05-02 16:37:49', 0, NULL, 1),
(6, 'A L Asha', 'Rani', 'staff', 0, 3, 'asha@codeshell.in', '$2y$10$ju4PTsJzF.uuTQaDJusbRuOu8z5thPkMXrXzaW2POkSVuuarlI5Bi', NULL, 'active', '2025-04-27 06:42:20', 0, '2025-04-27 06:42:26', 0, 'UX/UI Designer', 0, NULL, '', '', '7010798446', '', '1996-02-14', '', 'female', '', '', '', 1, 1, '2025-04-10 01:05:34', '2025-05-02 14:31:32', 0, NULL, 1),
(7, 'Siva', 'K', 'staff', 0, 0, 'siva@codeshell.in', '$2y$10$7FGQcWzypham/ip7LJFqwOJSknm5R3vTs8Bq9EkFNjce.JYEMxD6i', NULL, 'inactive', NULL, 0, NULL, 0, 'Frontend Developer', 0, NULL, '', NULL, '', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-04-10 01:08:15', '2025-04-10 04:27:23', 0, NULL, 1),
(8, 'Palaniyammal', 'P', 'staff', 0, 3, 'palaniyammal@codeshell.in', '$2y$10$IkEYnA.RF6ZNwUQk7o3YuuKO0iMEf4WiCWlZS7KP7refLvblW5iDC', NULL, 'active', NULL, 0, NULL, 0, 'Frontend Developer', 0, NULL, '', NULL, '', NULL, NULL, NULL, 'female', NULL, NULL, '', 1, 1, '2025-04-10 01:09:24', '2025-05-02 16:17:34', 0, NULL, 1),
(9, 'Muni', 'Nathan', 'staff', 0, 2, 'muni@codeshell.in', '$2y$10$PbDVx5yeK2y4OBVfitPUbuHsXkhuZAMuAJNBgqZGwRWX/b.OvyFYW', NULL, 'active', NULL, 0, NULL, 0, 'Marketing Executive', 0, NULL, '', NULL, '', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-04-10 01:18:10', '2025-05-02 12:14:20', 0, NULL, 1),
(10, 'Ilango', 'seenipandi', 'staff', 0, 2, 'ilango@codeshell.in', '$2y$10$6BEezLerrjmNQYLhw7K92uJWe8ti6vvpNbZWo7HA1fIN2WgKFq9Tq', NULL, 'active', '2025-04-14 12:58:14', 0, NULL, 0, 'Marketing Executive', 0, NULL, '', NULL, '', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-04-10 01:19:16', '2025-05-02 12:51:37', 0, NULL, 1),
(11, 'Manikandan', 'M', 'staff', 1, 0, 'mani@codeshell.in', '$2y$10$TabaOFglF4D2H7Atdc3RuuRI31EmxXJ1Ji/4IOaGwGJ5W1AxKOwTm', NULL, 'active', '2025-04-17 09:52:21', 0, NULL, 0, 'CFO & Marketing Lead', 0, NULL, '', NULL, '', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-04-10 01:20:44', '2025-05-02 13:50:47', 0, NULL, 1),
(12, 'Merlin', 'Ranjithsingh', 'client', 0, 0, 'sportspersonapp@gmail.com', '$2y$10$V0tSZAqqbk15mG54wCsufew5plGVgYsNJdinHTMbS/IF3tRU8C1Se', NULL, 'active', NULL, 2, NULL, 1, '', 0, '', NULL, NULL, '', NULL, NULL, NULL, 'male', NULL, '', '', 1, 1, '2025-04-11 02:15:01', '2025-04-12 16:18:52', 0, 'all', 1),
(13, 'Ramanathan', 'P', 'client', 0, 0, 'rklshares1@gmail.com', '$2y$10$LuSmcN6v0Dhqfr2cdK2Yi.0TZkdqlGrwCWL4LSfd88X9P6xSjItYS', NULL, 'active', NULL, 4, NULL, 1, 'Owner', 0, '', NULL, NULL, '', NULL, NULL, NULL, 'male', NULL, '', '', 1, 1, '2025-04-11 03:34:00', NULL, 0, 'all', 1),
(14, 'Ragavan', 'Adhishankar', 'client', 0, 0, 'ragavanadhisankar@gmail.com', '$2y$10$3pONEAs2qI3XJA4IGnrsYOIRMOFSoejdIbUAQQRZSuEwhpIBb/8Si', NULL, 'active', NULL, 5, NULL, 1, '', 0, '', NULL, NULL, '', NULL, NULL, NULL, 'male', NULL, '', '', 1, 1, '2025-04-11 07:19:37', NULL, 0, 'all', 1),
(15, 'Venkadesh', 'M', 'client', 0, 0, 'alminostructures@gmail.com', '$2y$10$z6IJ9TXPyFBvsltEVmj8rexuldgOpkwx3HwzHomwR3Z44uxuYQwJ2', NULL, 'active', NULL, 7, NULL, 1, '', 0, '', NULL, NULL, '', NULL, NULL, NULL, 'male', NULL, '', '', 1, 1, '2025-04-11 07:38:12', '2025-04-24 15:29:24', 0, 'all', 1),
(16, 'Selva', 'Viknesh', 'staff', 0, 2, 'selva@codeshell.in', '$2y$10$oGFWmgQCDMBGEwUjcVgWSeXBbHpE1SkdsUhKaVgP04WneqICwzZc2', NULL, 'active', NULL, 0, NULL, 0, 'CMO & Co-Founder', 0, NULL, 'selva@codeshell.in', NULL, '', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-04-11 07:57:19', NULL, 0, NULL, 1),
(17, 'PooMurugan', 'B', 'client', 0, 0, 'Chandrantechnologies@gmail.com', '$2y$10$AAYGkliKp.bEHJ951kK5H.otiwm/6l3bdi5RMe49BV548zLcJFL0i', NULL, 'active', NULL, 9, NULL, 1, '', 0, '', NULL, NULL, '7094455441', NULL, NULL, NULL, 'male', NULL, '', '', 1, 1, '2025-04-11 09:06:26', '2025-04-30 05:55:51', 0, 'all', 1),
(18, 'Karthik', 'Dharsan Pvt Ltd', 'client', 0, 0, 'leosofabed1212@gmail.com', '$2y$10$94id0B2qYw56k1PAJma4q.4kXYRWcJ6Ilx7sCpQviKD2VzpazlYlq', NULL, 'active', NULL, 12, NULL, 1, '', 0, '', NULL, NULL, '', NULL, NULL, NULL, '', NULL, '', '', 1, 1, '2025-04-11 11:57:22', '2025-04-21 10:03:20', 0, 'all', 1),
(19, 'Vanathi', 'R', 'client', 0, 0, 'aasvatech@gmail.com', '$2y$10$jpPwcv3jxuLyMuhA5KkhUu2yexqfCtMxPPNMx8368hwXJS/eZf0x6', NULL, 'active', NULL, 13, NULL, 1, '', 0, '', NULL, NULL, '', NULL, NULL, NULL, 'female', NULL, '', '', 1, 1, '2025-04-12 07:35:53', NULL, 0, 'all', 1),
(20, 'Asif', 'M', 'client', 0, 0, 'ashifahamed380@gmail.com', '$2y$10$QGgQNxVzYosZLK6Gs6yCYOytBQh7hIy7qdIfwO5/njFwVzPOXjTfC', NULL, 'active', NULL, 15, NULL, 1, '', 0, '', NULL, NULL, '', NULL, NULL, NULL, 'male', NULL, '', '', 1, 1, '2025-04-12 12:27:32', NULL, 0, 'all', 1),
(21, 'Gopal', 'A', 'client', 0, 0, 'gopalsivan88@gmail.com', '$2y$10$ivfqP9vGoL03wZ3dAQg2Ze30rRe7bzgVQBwv3UvlQyuzTqBsgDbB6', NULL, 'active', NULL, 19, NULL, 1, '', 0, '', NULL, NULL, '', NULL, NULL, NULL, 'male', NULL, '', '', 1, 1, '2025-04-16 08:04:25', NULL, 0, 'all', 1),
(22, 'Swetha', 'M', 'staff', 0, 0, 'swetha@genfotechinnovations.com', '$2y$10$UbEGGq8C2YTTRJRNXset2u1HmJFEksa4/A5GzUbWJBElg1r6KiBfG', NULL, 'active', NULL, 0, NULL, 0, 'Administrator ', 0, NULL, '', NULL, '', NULL, NULL, NULL, 'female', NULL, NULL, '', 1, 1, '2025-05-15 09:37:17', NULL, 0, NULL, 1),
(23, 'Gopal', 'A', 'staff', 1, 0, 'gopalsivan88@gmail.com', '$2y$10$oQqHNv0iKm9YuKmlSS8AhuMKgLnBeaus4gFuLl2FEW0z0w85kktwC', NULL, 'active', '2025-07-13 15:49:41', 0, '2025-06-19 08:58:26', 0, 'Managing Director', 0, NULL, 'gopalsivan88@gmail.com', NULL, '', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-05-15 09:41:18', '2025-08-23 12:50:13', 0, NULL, 1),
(24, 'Swetha', 'S', 'staff', 0, 4, 'swetha120604@gmail.com', '$2y$10$Wp/wUxdzvefTNscFLZeihu9mdDCvGsTwu3lPiuvkvGRDf4fx8Dh4S', NULL, 'active', '2025-06-13 04:37:17', 0, '2025-06-13 04:37:02', 0, 'Administrator', 0, NULL, '', '', '', '', '0000-00-00', '', 'female', NULL, '', '', 1, 1, '2025-05-15 09:53:51', '2025-07-16 10:17:47', 0, NULL, 1),
(25, 'swetha', 's', 'client', 0, 0, 'swetha@gmail.com', '$2y$10$gaxjwSUEh//5IVyARIuf7.epI.ZE5huskV3N5Y1nec0ADvWZoGaDG', NULL, 'active', NULL, 36, NULL, 1, '', 0, '', NULL, NULL, '', NULL, NULL, NULL, 'female', NULL, '', '', 1, 1, '2025-05-15 10:01:01', NULL, 0, 'all', 1),
(26, 'Vanathi', 'R', 'lead', 0, 0, 'aasvatech@gmail.com', NULL, NULL, 'active', NULL, 47, NULL, 1, 'Founder', 0, '', NULL, NULL, '', NULL, NULL, NULL, 'female', NULL, '', '', 1, 1, '2025-05-18 05:08:58', NULL, 0, NULL, 0),
(27, 'Manikandan', 'M', 'staff', 1, 0, 'mani@codeshell.in', '$2y$10$.1KwebT7FhmE6yFoKsCmPuOpb8fKNTFntvWktWhOmUR/NyKjejQK6', NULL, 'active', NULL, 0, NULL, 0, 'CFO', 0, NULL, 'mani@codeshell.in', NULL, '9655709551', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-05-21 10:30:34', NULL, 0, NULL, 1),
(28, 'Ilangovan', 'Seenipandi', 'staff', 0, 2, 'ilango@codeshell.in', '$2y$10$Rhy5pAdbj550g7svKy9PyOy3xou8NhkXnKd9KQXC9k40FZOXDtsoy', NULL, 'active', NULL, 0, NULL, 0, 'Marketing Executive', 0, NULL, 'ilango@codeshell.in', NULL, '9025692440', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-05-21 10:31:44', NULL, 0, NULL, 1),
(29, 'Muninathan', 'M', 'staff', 0, 2, 'muninathan@codeshell.in', '$2y$10$jZv8eUlv3vyA.AxWE7zqReZGrOl4LmNIO9PlOftroM9sDase8Mz0S', NULL, 'active', NULL, 0, NULL, 0, 'Marketing Executive', 0, NULL, 'muninathan@codeshell.in', NULL, '8667034084', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-05-21 10:33:09', NULL, 0, NULL, 1),
(30, 'Selva Vignesh', 'V', 'staff', 0, 2, 'selva@codeshell.in', '$2y$10$eHite.ocRrmKFdyHYHfb8ujxW.auoB0S1tW8x.ExZtVjS4XhkjQei', NULL, 'active', NULL, 0, NULL, 0, 'CMO', 0, NULL, 'selva@codeshell.in', NULL, '6383607637', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-05-21 10:34:17', NULL, 0, NULL, 1),
(31, 'shanmuga', 'priya', 'staff', 1, 0, 'priya@codeshell.in', '$2y$10$WNHnM7QiguapmvZrNT8XV.Xkf7j.0keOmxy.t/divoPwoy9Yovnc2', NULL, 'active', NULL, 0, NULL, 0, 'Admin', 0, NULL, 'priya@codeshell.in', NULL, '9626525538', NULL, NULL, NULL, 'female', NULL, NULL, '', 1, 1, '2025-05-28 09:41:07', '2025-08-23 15:38:35', 0, NULL, 1),
(32, 'padmavathi', 'J E', 'staff', 0, 2, 'padma@codeshell.in', '$2y$10$4q1leHIqvH9W.jXOqKck5.Y0zrSUlzJYuWfAT8dJ5/INTYt0iuRQO', NULL, 'active', NULL, 0, NULL, 0, 'Intern', 0, NULL, 'padma@codeshell.in', NULL, '9150524664', NULL, NULL, NULL, 'female', NULL, NULL, '', 1, 1, '2025-05-28 09:44:58', '2025-08-23 11:19:08', 0, NULL, 1),
(33, 'Ram', 'LJ Consultancy', 'staff', 0, 7, 'ram@codeshell.in', '$2y$10$es6Ima6yeUVhjIMBDTG0gOWDYVjRjAnEpfxoLzKP1ASBnnSIUXPfC', NULL, 'active', NULL, 0, NULL, 0, 'Placement Co-ordinator', 0, NULL, 'ram@codeshell.in', NULL, '', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-06-01 05:11:46', NULL, 0, NULL, 1),
(34, 'Manikandan', 'M', 'staff', 1, 0, 'mani@codeshell.in', '$2y$10$Za/rOxjaCk635vWWegVyJupZ1V4dXuzJBpnftodT.X2CmPLzB/tqy', NULL, 'active', NULL, 0, NULL, 0, 'CFO & Marketing Lead- (Codeshell Technologies)', 0, NULL, 'mani@codeshell.in', NULL, '9655709551', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-06-01 05:14:08', NULL, 0, NULL, 1),
(35, 'Ilangovan', 'Seenipandi', 'staff', 0, 2, 'ilango@codeshell.in', '$2y$10$0.x3OpDxhNHCph3BFL4xueZuFAbUTQWr2Mc7o4rWnvJMYWP7shrUa', NULL, 'active', NULL, 0, NULL, 0, 'Marketing Executive/IT Recruiter ( Codeshell)', 0, NULL, 'ilango@codeshell.in', NULL, '9025692440', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-06-01 05:16:01', NULL, 0, NULL, 1),
(36, 'Muni', 'Nathan', 'staff', 0, 2, 'muni@codeshell.in', '$2y$10$9LD.ksjZ1c/4DYDn5EnRiOK1bXeyZHR5FVYjxHBzZ4QEsylQzqm6a', NULL, 'active', NULL, 0, NULL, 0, 'Marketing Executive/IT Recruiter', 0, NULL, 'muni@codeshell.in', NULL, '', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-06-01 05:18:00', NULL, 0, NULL, 1),
(37, 'Karthik', 'raja', 'staff', 0, 2, 'karthik@codeshell.in', '$2y$10$Avi4Jee3aNEtlNW/EhgAo.T2WGxZ7zJvzAYFNbwii5b5M5wk0L0re', NULL, 'active', NULL, 0, NULL, 0, 'Marketing Intern', 0, NULL, 'karthik@codeshell.in', NULL, '', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-06-01 05:19:14', NULL, 0, NULL, 1),
(38, '', '', 'lead', 0, 0, '', NULL, NULL, 'active', NULL, 72, NULL, 1, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, '2025-06-02 10:52:20', NULL, 0, NULL, 0),
(39, '', '', 'lead', 0, 0, '', NULL, NULL, 'active', NULL, 73, NULL, 1, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, '2025-06-02 10:52:20', NULL, 0, NULL, 0),
(40, '', '', 'lead', 0, 0, '', NULL, NULL, 'active', NULL, 74, NULL, 1, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, '2025-06-02 10:52:20', NULL, 0, NULL, 1),
(41, '', '', 'lead', 0, 0, '', NULL, NULL, 'active', NULL, 75, NULL, 1, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, '2025-06-02 10:52:20', NULL, 0, NULL, 1),
(42, '', '', 'lead', 0, 0, '', NULL, NULL, 'active', NULL, 76, NULL, 1, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, '2025-06-02 10:53:21', NULL, 0, NULL, 1),
(43, '', '', 'lead', 0, 0, '', NULL, NULL, 'active', NULL, 77, NULL, 1, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, '2025-06-02 10:53:21', NULL, 0, NULL, 1),
(44, '', '', 'lead', 0, 0, '', NULL, NULL, 'active', NULL, 78, NULL, 1, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, '2025-06-02 10:53:21', NULL, 0, NULL, 1),
(45, '', '', 'lead', 0, 0, '', NULL, NULL, 'active', NULL, 79, NULL, 1, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, '2025-06-02 10:53:21', NULL, 0, NULL, 1),
(46, '', '', 'lead', 0, 0, '', NULL, NULL, 'active', NULL, 80, NULL, 1, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, '2025-06-02 10:53:26', NULL, 0, NULL, 1),
(47, '', '', 'lead', 0, 0, '', NULL, NULL, 'active', NULL, 81, NULL, 1, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, '2025-06-02 10:53:26', NULL, 0, NULL, 1),
(48, '', '', 'lead', 0, 0, '', NULL, NULL, 'active', NULL, 82, NULL, 1, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, '2025-06-02 10:53:26', NULL, 0, NULL, 0),
(49, '', '', 'lead', 0, 0, '', NULL, NULL, 'active', NULL, 83, NULL, 1, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, '2025-06-02 10:53:26', NULL, 0, NULL, 1),
(50, 'Bhuvana', 'T', 'client', 0, 0, 'bhuvana@codeshell.in', '$2y$10$KQbDqy7qjv0ATMnuCkQ9BuT3jiDMqt1VwMnUtHPL75vY4OSxw50vS', NULL, 'active', NULL, 54, NULL, 1, 'Student - Intern', 0, '', NULL, NULL, '', NULL, NULL, NULL, 'female', NULL, '', '', 1, 1, '2025-06-12 16:48:26', NULL, 0, 'all', 0),
(51, 'krithika', 'Krithika', 'client', 0, 0, 'krithika@codeshell.in', '$2y$10$AR2UMsvQ1dzBuSzJfQ27hOm3PbWcoEpI9j4juZOZ6yz.vvYmhHFHe', NULL, 'active', NULL, 104, NULL, 1, '', 0, '', NULL, NULL, '', NULL, NULL, NULL, 'female', NULL, '', '', 1, 1, '2025-06-13 04:06:41', NULL, 0, 'all', 0),
(52, 'Salini', 'A', 'client', 0, 0, 'salini.a2503@gmail.com', '$2y$10$gpPHY/AdFJjsUUHVexkzD.QOEMkHUYEaogdU.pK6CFsqxYQt9AIwe', NULL, 'active', NULL, 105, NULL, 1, 'Student  - Intern', 0, '', NULL, NULL, '7845406243', NULL, NULL, NULL, 'female', NULL, '', '', 1, 1, '2025-06-13 07:39:47', '2025-06-13 07:47:47', 0, 'all', 0),
(53, 'salini', 'A', 'staff', 0, 0, 'salini@codeshell.in', '$2y$10$5nZ0n.enCgU9Ft2EkYXrt.oG10lSnGcV3aBGyhGGyaPVGLgpuYNUy', NULL, 'active', NULL, 0, NULL, 0, 'Student - intern', 0, NULL, 'salini@codeshell.in', NULL, '7845406243', NULL, NULL, NULL, 'female', NULL, NULL, '', 1, 1, '2025-06-13 07:45:02', '2025-06-13 08:05:06', 0, NULL, 1),
(54, 'Neroling', 'Jinda', 'staff', 0, 1, 'neroling@codeshell.in', '$2y$10$ARft7UORFNeDwmi5TpVqOO86b8zLcWcg7hB.gJzodLE83dYA03QPW', NULL, 'active', NULL, 0, NULL, 0, 'Student - Internship', 0, NULL, 'neroling@codeshell.in', 'Mullan compound, Sethupathi Nagar,  Puyal Kappagam, Pamban - 623521.', '6379734605', '', '0000-00-00', '', 'female', NULL, '', '', 1, 1, '2025-06-16 05:13:19', '2025-06-16 08:23:20', 0, NULL, 1),
(55, 'Pandeeswari', 'Raju', 'staff', 0, 4, 'pandeeswari@genfotechinnovations.in', '$2y$10$YYayd6hkQnLUaNkJdoNH0.jcMbLhg7aB/2IRc8DXctwyjF1IHkspC', NULL, 'active', '2025-08-23 08:50:38', 0, '2025-06-19 08:57:55', 0, 'Admin', 0, NULL, 'pandeeswari@genfotechinnovations.in', NULL, '9080970633', NULL, NULL, NULL, 'female', NULL, NULL, '', 1, 1, '2025-06-17 05:08:25', '2025-08-23 08:51:28', 0, NULL, 1),
(56, '', '', 'client', 0, 0, 'asdf@gmail.com\r\n', '1234asdf', NULL, 'active', NULL, 0, NULL, 0, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, NULL, NULL, 0, NULL, 0),
(57, 'asdf', 'asdf', 'client', 0, 0, 'asdf1@gmail.com', '$2y$10$hssl68adI1Lx5pHFBSMPOulSucWOIDxa8FvgOx3UZyB.ZWB8V6YFC', NULL, 'active', NULL, 1, NULL, 1, 'Untitled', 0, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '', 1, 1, '2025-08-23 11:12:32', NULL, 0, 'all', 0),
(58, 'charan', 'ycore', 'staff', 1, 0, 'charan.ycoretechnology@gmail.com', '$2y$10$OrtcZiLHdjOj5y4coHRKdO6uupWcB/FnbURbc3nAoMxtGzfPDGA1i', NULL, 'active', NULL, 0, NULL, 0, 'CEO', 0, NULL, 'charan.ycoretechnology@gmail.com', NULL, '9626885353', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-08-23 12:37:23', '2025-09-24 09:26:33', 0, NULL, 0),
(59, 'Harish', 's', 'staff', 0, 1, 'harish.ycoretechnologies@gmail.com', '$2y$10$TmeirQzTmjP2llGyqqDCDOSz4MXXKD93j0TrteHWV70s1RTUy14Qm', NULL, 'active', NULL, 0, NULL, 0, 'Internship Team Lead (ITL)', 0, NULL, 'harish.ycoretechnologies@gmail', NULL, '1234567891', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-08-23 16:03:58', NULL, 0, NULL, 0),
(60, 'yamuna', 'ycore', 'staff', 0, 0, 'yamuna.ycoretechnologies@gmail.com', '$2y$10$U3mqb5Cw6hNv6JDD2rHBH.Jg8.U/4bJMEn4HVzY.cxaStKdVdLGZm', NULL, 'active', NULL, 0, NULL, 0, 'Managing Director', 0, NULL, 'yamuna.ycoretechnologies@gmail.com', NULL, '9626885353', NULL, NULL, NULL, 'female', NULL, NULL, '', 1, 1, '2025-08-23 16:40:35', '2025-08-24 02:56:16', 0, NULL, 1),
(61, 'yamuna', 'ycore', 'staff', 1, 0, 'yamuna.ycoretechnologies@gmail.com', '$2y$10$SHhBazBpoN9nwO7dMxrZZ.zvogEtsU902UDPVEOiTbVmKibyAHkya', NULL, 'active', NULL, 0, NULL, 0, 'Promoter/Managing Director', 0, NULL, 'yamuna.ycoretechnologies@gmail.com', NULL, '9626885353', NULL, NULL, NULL, 'female', NULL, NULL, '', 1, 1, '2025-08-24 02:58:42', '2025-08-24 03:20:57', 0, NULL, 0),
(62, 'Padmavathi', 'x', 'staff', 0, 1, 'padmavathi.ycoretechnologies@gmail.com', '$2y$10$M/VR.dT4aPHOWxxoxiPClOc4VvG39fLNBF9Qzj21etE38umdF9iTy', NULL, 'active', NULL, 0, NULL, 0, 'Technical Lead Intern (TLI)', 0, NULL, 'padmavathi.ycoretechnologies@gmail.com', NULL, '9150524664', NULL, NULL, NULL, 'female', NULL, NULL, '', 1, 1, '2025-08-24 03:13:07', NULL, 0, NULL, 0),
(63, 'Test', 'Test', 'staff', 1, 0, 'ycoretechnologies@gmail.com', '$2y$10$lMz.V713c0lHNzKx/RCFfeqwe5V4eV5Pj.p3zQoGxDcAI6wECzMcK', NULL, 'active', NULL, 0, NULL, 0, 'Test ID', 0, NULL, 'ycoretechnology@gmail.com', NULL, '1234567890', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-09-24 09:22:03', NULL, 0, NULL, 0),
(64, 'Test', 'Test', 'staff', 1, 0, 'saravanacharan13@gmail.com', '$2y$10$hANRiZUBbuFo0xaR7CcM5eRYoeiy2lisXZRS60zpAX4kF5rXuJAh6', NULL, 'active', NULL, 0, NULL, 0, 'Test ID', 0, NULL, 'ycoretechnology@gmail.com', NULL, '1234567890', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-09-24 09:25:50', NULL, 0, NULL, 0),
(65, 'Test', 'Test', 'staff', 1, 0, 'saravanasivan13@gmail.com', '$2y$10$py4wooP3SfWSETalhetO0e4CYKweWv9j1u4cgAStIecZ6TuW8DfEC', NULL, 'active', NULL, 0, NULL, 0, 'Test ID', 0, NULL, 'ycoretechnology@gmail.com', NULL, '1234567890', NULL, NULL, NULL, 'male', NULL, NULL, '', 1, 1, '2025-09-24 09:26:18', '2025-11-01 09:07:05', 0, NULL, 0);

-- --------------------------------------------------------

--
-- Table structure for table `rise_verification`
--

CREATE TABLE `rise_verification` (
  `id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `type` enum('invoice_payment','reset_password','verify_email','invitation') NOT NULL,
  `code` varchar(10) NOT NULL,
  `params` text NOT NULL,
  `deleted` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Dumping data for table `rise_verification`
--

INSERT INTO `rise_verification` (`id`, `created_at`, `type`, `code`, `params`, `deleted`) VALUES
(1, '2025-08-23 15:42:33', 'reset_password', 'DUPXkqTwpW', 'a:2:{s:5:\"email\";s:32:\"charan.ycoretechnology@gmail.com\";s:11:\"expire_time\";i:1756050153;}', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `rise_activity_logs`
--
ALTER TABLE `rise_activity_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `log_for` (`log_for`,`log_for_id`),
  ADD KEY `log_for2` (`log_for2`,`log_for_id2`),
  ADD KEY `log_type` (`log_type`,`log_type_id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `rise_announcements`
--
ALTER TABLE `rise_announcements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `rise_article_helpful_status`
--
ALTER TABLE `rise_article_helpful_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_attendance`
--
ALTER TABLE `rise_attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `checked_by` (`checked_by`);

--
-- Indexes for table `rise_automation_settings`
--
ALTER TABLE `rise_automation_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_checklist_groups`
--
ALTER TABLE `rise_checklist_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_checklist_items`
--
ALTER TABLE `rise_checklist_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_checklist_template`
--
ALTER TABLE `rise_checklist_template`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_ci_sessions`
--
ALTER TABLE `rise_ci_sessions`
  ADD KEY `ci_sessions_timestamp` (`timestamp`);

--
-- Indexes for table `rise_clients`
--
ALTER TABLE `rise_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `owner_id` (`owner_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `lead_source_id` (`lead_source_id`),
  ADD KEY `is_lead` (`is_lead`);

--
-- Indexes for table `rise_client_groups`
--
ALTER TABLE `rise_client_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_company`
--
ALTER TABLE `rise_company`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_contracts`
--
ALTER TABLE `rise_contracts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_contract_items`
--
ALTER TABLE `rise_contract_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_contract_templates`
--
ALTER TABLE `rise_contract_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_custom_fields`
--
ALTER TABLE `rise_custom_fields`
  ADD PRIMARY KEY (`id`),
  ADD KEY `related_to` (`related_to`),
  ADD KEY `field_type` (`field_type`);

--
-- Indexes for table `rise_custom_field_values`
--
ALTER TABLE `rise_custom_field_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `related_to_type` (`related_to_type`),
  ADD KEY `related_to_id` (`related_to_id`),
  ADD KEY `custom_field_id` (`custom_field_id`);

--
-- Indexes for table `rise_custom_widgets`
--
ALTER TABLE `rise_custom_widgets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `rise_dashboards`
--
ALTER TABLE `rise_dashboards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `rise_email_templates`
--
ALTER TABLE `rise_email_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_estimates`
--
ALTER TABLE `rise_estimates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_estimate_comments`
--
ALTER TABLE `rise_estimate_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_estimate_forms`
--
ALTER TABLE `rise_estimate_forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_estimate_items`
--
ALTER TABLE `rise_estimate_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_estimate_requests`
--
ALTER TABLE `rise_estimate_requests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_events`
--
ALTER TABLE `rise_events`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `task_id` (`task_id`),
  ADD KEY `recurring` (`recurring`),
  ADD KEY `start_date` (`start_date`),
  ADD KEY `end_date` (`end_date`);

--
-- Indexes for table `rise_event_tracker`
--
ALTER TABLE `rise_event_tracker`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_expenses`
--
ALTER TABLE `rise_expenses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `rise_expense_categories`
--
ALTER TABLE `rise_expense_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_file_category`
--
ALTER TABLE `rise_file_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_folders`
--
ALTER TABLE `rise_folders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_general_files`
--
ALTER TABLE `rise_general_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_help_articles`
--
ALTER TABLE `rise_help_articles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_help_categories`
--
ALTER TABLE `rise_help_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_invoices`
--
ALTER TABLE `rise_invoices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status` (`status`),
  ADD KEY `due_date` (`due_date`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `rise_invoice_items`
--
ALTER TABLE `rise_invoice_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_invoice_payments`
--
ALTER TABLE `rise_invoice_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id` (`id`),
  ADD KEY `id_2` (`id`);

--
-- Indexes for table `rise_items`
--
ALTER TABLE `rise_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_item_categories`
--
ALTER TABLE `rise_item_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_labels`
--
ALTER TABLE `rise_labels`
  ADD PRIMARY KEY (`id`),
  ADD KEY `context` (`context`);

--
-- Indexes for table `rise_leads`
--
ALTER TABLE `rise_leads`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_lead_source`
--
ALTER TABLE `rise_lead_source`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_lead_status`
--
ALTER TABLE `rise_lead_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_leave_applications`
--
ALTER TABLE `rise_leave_applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `leave_type_id` (`leave_type_id`),
  ADD KEY `user_id` (`applicant_id`),
  ADD KEY `checked_by` (`checked_by`);

--
-- Indexes for table `rise_leave_types`
--
ALTER TABLE `rise_leave_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_likes`
--
ALTER TABLE `rise_likes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_messages`
--
ALTER TABLE `rise_messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `message_from` (`from_user_id`),
  ADD KEY `message_to` (`to_user_id`);

--
-- Indexes for table `rise_milestones`
--
ALTER TABLE `rise_milestones`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_notes`
--
ALTER TABLE `rise_notes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_note_category`
--
ALTER TABLE `rise_note_category`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_notifications`
--
ALTER TABLE `rise_notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `rise_notification_settings`
--
ALTER TABLE `rise_notification_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event` (`event`);

--
-- Indexes for table `rise_orders`
--
ALTER TABLE `rise_orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_order_items`
--
ALTER TABLE `rise_order_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_order_status`
--
ALTER TABLE `rise_order_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_pages`
--
ALTER TABLE `rise_pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_payment_methods`
--
ALTER TABLE `rise_payment_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_paypal_ipn`
--
ALTER TABLE `rise_paypal_ipn`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_pin_comments`
--
ALTER TABLE `rise_pin_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_posts`
--
ALTER TABLE `rise_posts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_projects`
--
ALTER TABLE `rise_projects`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `status_id` (`status_id`);

--
-- Indexes for table `rise_project_comments`
--
ALTER TABLE `rise_project_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_project_files`
--
ALTER TABLE `rise_project_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_project_members`
--
ALTER TABLE `rise_project_members`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `project_id` (`project_id`);

--
-- Indexes for table `rise_project_settings`
--
ALTER TABLE `rise_project_settings`
  ADD UNIQUE KEY `unique_index` (`project_id`,`setting_name`);

--
-- Indexes for table `rise_project_status`
--
ALTER TABLE `rise_project_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_project_time`
--
ALTER TABLE `rise_project_time`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_proposals`
--
ALTER TABLE `rise_proposals`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_proposal_comments`
--
ALTER TABLE `rise_proposal_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_proposal_items`
--
ALTER TABLE `rise_proposal_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_proposal_templates`
--
ALTER TABLE `rise_proposal_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_reminder_logs`
--
ALTER TABLE `rise_reminder_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_reminder_settings`
--
ALTER TABLE `rise_reminder_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_roles`
--
ALTER TABLE `rise_roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_settings`
--
ALTER TABLE `rise_settings`
  ADD UNIQUE KEY `setting_name` (`setting_name`);

--
-- Indexes for table `rise_social_links`
--
ALTER TABLE `rise_social_links`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_stripe_ipn`
--
ALTER TABLE `rise_stripe_ipn`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_subscriptions`
--
ALTER TABLE `rise_subscriptions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_subscription_items`
--
ALTER TABLE `rise_subscription_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_tasks`
--
ALTER TABLE `rise_tasks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `status_id` (`status_id`),
  ADD KEY `priority_id` (`priority_id`),
  ADD KEY `sort` (`sort`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `milestone_id` (`milestone_id`),
  ADD KEY `assigned_to` (`assigned_to`),
  ADD KEY `ticket_id` (`ticket_id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `estimate_id` (`estimate_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `contract_id` (`contract_id`),
  ADD KEY `proposal_id` (`proposal_id`),
  ADD KEY `subscription_id` (`subscription_id`),
  ADD KEY `expense_id` (`expense_id`),
  ADD KEY `lead_id` (`lead_id`);

--
-- Indexes for table `rise_task_priority`
--
ALTER TABLE `rise_task_priority`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_task_status`
--
ALTER TABLE `rise_task_status`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_taxes`
--
ALTER TABLE `rise_taxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_team`
--
ALTER TABLE `rise_team`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_team_member_job_info`
--
ALTER TABLE `rise_team_member_job_info`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `rise_tickets`
--
ALTER TABLE `rise_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `ticket_type_id` (`ticket_type_id`),
  ADD KEY `assigned_to` (`assigned_to`);

--
-- Indexes for table `rise_ticket_comments`
--
ALTER TABLE `rise_ticket_comments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_ticket_templates`
--
ALTER TABLE `rise_ticket_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_ticket_types`
--
ALTER TABLE `rise_ticket_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rise_to_do`
--
ALTER TABLE `rise_to_do`
  ADD PRIMARY KEY (`id`),
  ADD KEY `created_by` (`created_by`);

--
-- Indexes for table `rise_users`
--
ALTER TABLE `rise_users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_type` (`user_type`),
  ADD KEY `email` (`email`),
  ADD KEY `client_id` (`client_id`),
  ADD KEY `deleted` (`deleted`);

--
-- Indexes for table `rise_verification`
--
ALTER TABLE `rise_verification`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `rise_activity_logs`
--
ALTER TABLE `rise_activity_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rise_announcements`
--
ALTER TABLE `rise_announcements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_article_helpful_status`
--
ALTER TABLE `rise_article_helpful_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_attendance`
--
ALTER TABLE `rise_attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rise_automation_settings`
--
ALTER TABLE `rise_automation_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_checklist_groups`
--
ALTER TABLE `rise_checklist_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_checklist_items`
--
ALTER TABLE `rise_checklist_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_checklist_template`
--
ALTER TABLE `rise_checklist_template`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rise_clients`
--
ALTER TABLE `rise_clients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `rise_client_groups`
--
ALTER TABLE `rise_client_groups`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_company`
--
ALTER TABLE `rise_company`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_contracts`
--
ALTER TABLE `rise_contracts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_contract_items`
--
ALTER TABLE `rise_contract_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_contract_templates`
--
ALTER TABLE `rise_contract_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_custom_fields`
--
ALTER TABLE `rise_custom_fields`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_custom_field_values`
--
ALTER TABLE `rise_custom_field_values`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_custom_widgets`
--
ALTER TABLE `rise_custom_widgets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_dashboards`
--
ALTER TABLE `rise_dashboards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_email_templates`
--
ALTER TABLE `rise_email_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_estimates`
--
ALTER TABLE `rise_estimates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_estimate_comments`
--
ALTER TABLE `rise_estimate_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_estimate_forms`
--
ALTER TABLE `rise_estimate_forms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_estimate_items`
--
ALTER TABLE `rise_estimate_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_estimate_requests`
--
ALTER TABLE `rise_estimate_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_events`
--
ALTER TABLE `rise_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rise_event_tracker`
--
ALTER TABLE `rise_event_tracker`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_expenses`
--
ALTER TABLE `rise_expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_expense_categories`
--
ALTER TABLE `rise_expense_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_file_category`
--
ALTER TABLE `rise_file_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_folders`
--
ALTER TABLE `rise_folders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_general_files`
--
ALTER TABLE `rise_general_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_help_articles`
--
ALTER TABLE `rise_help_articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_help_categories`
--
ALTER TABLE `rise_help_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_invoices`
--
ALTER TABLE `rise_invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_invoice_items`
--
ALTER TABLE `rise_invoice_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_invoice_payments`
--
ALTER TABLE `rise_invoice_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_items`
--
ALTER TABLE `rise_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_item_categories`
--
ALTER TABLE `rise_item_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_labels`
--
ALTER TABLE `rise_labels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_leads`
--
ALTER TABLE `rise_leads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_lead_source`
--
ALTER TABLE `rise_lead_source`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `rise_lead_status`
--
ALTER TABLE `rise_lead_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `rise_leave_applications`
--
ALTER TABLE `rise_leave_applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_leave_types`
--
ALTER TABLE `rise_leave_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_likes`
--
ALTER TABLE `rise_likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_messages`
--
ALTER TABLE `rise_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_milestones`
--
ALTER TABLE `rise_milestones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_notes`
--
ALTER TABLE `rise_notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_note_category`
--
ALTER TABLE `rise_note_category`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_notifications`
--
ALTER TABLE `rise_notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_notification_settings`
--
ALTER TABLE `rise_notification_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_orders`
--
ALTER TABLE `rise_orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_order_items`
--
ALTER TABLE `rise_order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_order_status`
--
ALTER TABLE `rise_order_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_pages`
--
ALTER TABLE `rise_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_payment_methods`
--
ALTER TABLE `rise_payment_methods`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_paypal_ipn`
--
ALTER TABLE `rise_paypal_ipn`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_pin_comments`
--
ALTER TABLE `rise_pin_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_posts`
--
ALTER TABLE `rise_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_projects`
--
ALTER TABLE `rise_projects`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rise_project_comments`
--
ALTER TABLE `rise_project_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_project_files`
--
ALTER TABLE `rise_project_files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_project_members`
--
ALTER TABLE `rise_project_members`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `rise_project_status`
--
ALTER TABLE `rise_project_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_project_time`
--
ALTER TABLE `rise_project_time`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rise_proposals`
--
ALTER TABLE `rise_proposals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_proposal_comments`
--
ALTER TABLE `rise_proposal_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_proposal_items`
--
ALTER TABLE `rise_proposal_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_proposal_templates`
--
ALTER TABLE `rise_proposal_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_reminder_logs`
--
ALTER TABLE `rise_reminder_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_reminder_settings`
--
ALTER TABLE `rise_reminder_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_roles`
--
ALTER TABLE `rise_roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `rise_stripe_ipn`
--
ALTER TABLE `rise_stripe_ipn`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_subscriptions`
--
ALTER TABLE `rise_subscriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_subscription_items`
--
ALTER TABLE `rise_subscription_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_tasks`
--
ALTER TABLE `rise_tasks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `rise_task_priority`
--
ALTER TABLE `rise_task_priority`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `rise_task_status`
--
ALTER TABLE `rise_task_status`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `rise_taxes`
--
ALTER TABLE `rise_taxes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_team`
--
ALTER TABLE `rise_team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_team_member_job_info`
--
ALTER TABLE `rise_team_member_job_info`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `rise_tickets`
--
ALTER TABLE `rise_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_ticket_comments`
--
ALTER TABLE `rise_ticket_comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_ticket_templates`
--
ALTER TABLE `rise_ticket_templates`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_ticket_types`
--
ALTER TABLE `rise_ticket_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_to_do`
--
ALTER TABLE `rise_to_do`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `rise_users`
--
ALTER TABLE `rise_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=66;

--
-- AUTO_INCREMENT for table `rise_verification`
--
ALTER TABLE `rise_verification`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
