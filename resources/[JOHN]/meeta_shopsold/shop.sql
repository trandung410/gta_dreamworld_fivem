-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.14-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for overkill
CREATE DATABASE IF NOT EXISTS `overkill` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `overkill`;

-- Dumping structure for table overkill.shops_new
CREATE TABLE IF NOT EXISTS `shops_new` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item` varchar(100) COLLATE utf8mb4_bin NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;

-- Dumping data for table overkill.shops_new: ~45 rows (approximately)
DELETE FROM `shops_new`;
/*!40000 ALTER TABLE `shops_new` DISABLE KEYS */;
INSERT INTO `shops_new` (`id`, `item`, `price`, `category`) VALUES
	(1, 'bread', 200, 'Normal'),
	(2, 'water', 15, 'Normal'),
	(21, 'mining_lease', 1000, 'Mining'),
	(23, 'hookah', 1000, 'Weed'),
	(24, 'croquettes', 100, 'Normal'),
	(25, 'jumelles', 1500, 'Normal'),
	(26, 'fishingrod', 250, 'Fish'),
	(27, 'fishbait', 5, 'Fish'),
	(28, 'turtlebait', 50, 'Fish'),
	(29, 'plongee1', 100, 'Police'),
	(30, 'hatchet_lj', 1000, 'Normal'),
	(31, 'shovel', 1000, 'Normal'),
	(32, 'fixkit', 400, 'Car'),
	(33, 'beer', 100, 'Normal'),
	(34, 'rag', 1000, 'Car'),
	(35, 'wash', 200, 'Car'),
	(36, 'energy_drink', 200, 'Normal'),
	(37, 'handcuffs', 40000, 'Hand'),
	(38, 'handcuffs_key', 5000, 'Hand'),
	(40, 'paper_bag', 4000, 'Hand'),
	(41, 'radio', 20000, 'Normal'),
	(42, 'beer', 100, 'Weed1'),
	(43, 'hookah', 1000, 'Weed1'),
	(44, 'license_doctor', 10000, 'Ambulance'),
	(45, 'medikit', 0, 'Ambulance'),
	(46, 'bandage', 0, 'Ambulance'),
	(47, 'defibrillator', 15000, 'Ambulance'),
	(48, 'news_cam', 1000, 'Journalist'),
	(49, 'news_mic', 1000, 'Journalist'),
	(50, 'news_bmic', 1000, 'Journalist'),
	(51, 'cola', 20, 'Normal'),
	(56, 'anesthetic1', 0, 'Ambulance'),
	(57, 'anesthetic2', 0, 'Ambulance'),
	(58, 'firstaid', 0, 'Ambulance'),
	(59, 'donut1', 20, 'Prison'),
	(60, 'donut2', 20, 'Prison'),
	(61, 'water', 20, 'Prison'),
	(62, 'juice', 100, 'Normal'),
	(63, 'coffee', 50, 'Normal'),
	(64, 'sickle', 150, 'Normal'),
	(65, 'drill', 150, 'Normal'),
	(66, 'tool_banana', 150, 'Normal'),
	(67, 'lychee_cleaver', 150, 'Normal'),
	(68, 'durian_tool', 150, 'Normal'),
	(69, 'apple_cleaver', 150, 'Normal');
/*!40000 ALTER TABLE `shops_new` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
