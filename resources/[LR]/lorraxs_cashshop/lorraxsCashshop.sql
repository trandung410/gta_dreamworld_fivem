
ALTER TABLE `users`
	ADD COLUMN `cash` INT NULL DEFAULT 1 AFTER `name`;
CREATE TABLE IF NOT EXISTS `cashshop` (
  `name` char(50) COLLATE utf32_vietnamese_ci DEFAULT NULL,
  `label` char(50) COLLATE utf32_vietnamese_ci DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `type` char(50) COLLATE utf32_vietnamese_ci DEFAULT NULL,
  `src` varchar(255) COLLATE utf32_vietnamese_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf32 COLLATE=utf32_vietnamese_ci;
INSERT INTO `cashshop` (`name`, `label`, `price`, `type`, `src`) VALUES
	('bread', 'Bánh Mì', 1000, 'item', 'https://i.imgur.com/qpAX4Bo.png'),
	('water', 'Nước', 1, 'item', 'https://i.imgur.com/qpAX4Bo.png'),
	('t20', 'Siêu Xe T20', 40000, 'vehicle', 'https://wiki.rage.mp/images/7/7d/T20.png'),
	('weapon_pistol', 'Súng Lục', 1000, 'weapon', 'https://wiki.rage.mp/images/9/95/Pistol-icon.png');