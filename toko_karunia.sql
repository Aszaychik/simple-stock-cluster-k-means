-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for toko_karunia
CREATE DATABASE IF NOT EXISTS `toko_karunia` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `toko_karunia`;

-- Dumping structure for table toko_karunia.product
CREATE TABLE IF NOT EXISTS `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) NOT NULL,
  `stok_awal` int NOT NULL DEFAULT '0',
  `stok_terjual` int NOT NULL DEFAULT '0',
  `harga` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table toko_karunia.product: ~47 rows (approximately)
DELETE FROM `product`;
INSERT INTO `product` (`id`, `nama`, `stok_awal`, `stok_terjual`, `harga`) VALUES
	(10, 'Mc toshiba 75mn', 61, 24, 5000000),
	(11, 'Mc aqua 88dd', 24, 9, 3000000),
	(12, 'Mc poltron 1076', 81, 51, 4500000),
	(13, 'Mc sharp 70mw', 60, 44, 3500000),
	(14, 'Mc sharp 80mw', 64, 25, 3200000),
	(15, 'Mc sharp 1070', 92, 44, 3100000),
	(16, 'Mc panasonic 96bb', 96, 26, 4000000),
	(17, 'Speaker polytron 8Ff22', 84, 52, 2000000),
	(18, 'Speaker poltron 8ff28', 84, 55, 2500000),
	(19, 'Speaker polytron 8cf28', 97, 52, 2300000),
	(20, 'Les polytron 175', 33, 21, 1500000),
	(21, 'Led polytron 32CV', 30, 21, 3100000),
	(22, 'Led polytron 32ag', 31, 15, 3100000),
	(23, 'Led polytron 43cv', 98, 36, 4500000),
	(24, 'Led toshiba 32smart', 11, 2, 3500000),
	(25, 'Wf maspion 41k', 27, 12, 2200000),
	(26, 'Wf maspion 4001RC', 39, 8, 2400000),
	(27, 'Pw maspion 1809', 47, 27, 1800000),
	(28, 'Breket 43', 11, 4, 200000),
	(29, 'Boxfrezer aqua 200', 73, 36, 6000000),
	(30, 'Boxfrezer aqua 150', 69, 51, 5000000),
	(31, 'Mcc sharp 70mw', 30, 10, 3400000),
	(32, 'Mcc polytron 8076', 42, 18, 3300000),
	(33, 'Les sharp 197W', 85, 55, 1800000),
	(34, 'Les polytron 177', 67, 22, 1700000),
	(35, 'Led coocaa 32', 31, 7, 2800000),
	(36, 'Speaker polytron pas pro 15F', 58, 17, 2600000),
	(37, 'Antena toyosaki', 68, 51, 120000),
	(38, 'Kompor rinnai 522E', 51, 34, 700000),
	(39, 'Kompor nico 2tungku', 69, 40, 600000),
	(40, 'Breket bold 32', 89, 64, 300000),
	(41, 'Df wellhome karakter', 24, 16, 400000),
	(42, 'Ac sharp 5bey', 71, 22, 3000000),
	(43, 'Showcase polytron 237', 71, 52, 2500000),
	(44, 'Les sharp 317mg', 56, 29, 2000000),
	(45, 'Les sharp 236mh', 71, 48, 2100000),
	(46, 'Mc sharp 90mw', 73, 19, 3400000),
	(47, 'Mc LG 8000', 12, 4, 4000000),
	(48, 'Mc polytron 7073', 60, 27, 3600000),
	(49, 'Speaker polytron pas 8e12', 16, 11, 2700000),
	(50, 'Led aqua 32android', 82, 16, 3800000),
	(51, 'Led aqua 43android', 48, 24, 4500000),
	(52, 'Mcom miyako 512C', 13, 4, 1500000),
	(53, 'Mcom miyako 18bh', 98, 26, 1400000),
	(54, 'Mcom cosmos 6368', 69, 27, 1800000),
	(55, 'Blender philips 2115', 23, 17, 1200000),
	(56, 'Pipa ac artic 1pk', 18, 7, 50000);

-- Dumping structure for table toko_karunia.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table toko_karunia.user: ~1 rows (approximately)
DELETE FROM `user`;
INSERT INTO `user` (`id`, `username`, `password`) VALUES
	(1, 'admin', '$2b$12$bFTllc9uoMDcalgOYan.c.LqscchW7Wpy/EWZQT.Ngd2wFubARv3O');

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
