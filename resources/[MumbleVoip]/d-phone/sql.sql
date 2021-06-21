
CREATE TABLE IF NOT EXISTS `phone_business` (
  `job` varchar(50) NOT NULL,
  `motd` varchar(255) NOT NULL,
  `motdchanged` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `receiver` varchar(10) NOT NULL,
  `num` varchar(10) NOT NULL,
  `time` varchar(50) NOT NULL,
  `accepts` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `phone_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(40) NOT NULL,
  `name` longtext NOT NULL,
  `number` longtext NOT NULL,
  `favourite` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_information` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `wallpaper` varchar(255) NOT NULL DEFAULT 'https://cdn.discordapp.com/attachments/717040110641741894/802176415269257236/bright.png',
  `darkmode` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `identifier` (`identifier`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `date` varchar(50) NOT NULL DEFAULT 'current_timestamp()',
  `isgps` varchar(500) NOT NULL DEFAULT '0',
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  `isService` varchar(50) NOT NULL DEFAULT '0',
  `isAnonym` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=255 DEFAULT CHARSET=utf8;

CREATE TABLE IF NOT EXISTS `phone_twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL DEFAULT '0',
  `username` varchar(50) NOT NULL DEFAULT '0',
  `userid` varchar(50) NOT NULL DEFAULT '0',
  `avatar` varchar(2555) NOT NULL DEFAULT 'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_twitter_likes` (
  `identifier` varchar(50) DEFAULT NULL,
  `liked` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_twitter_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `username` varchar(50) NOT NULL DEFAULT '0',
  `userid` varchar(50) NOT NULL DEFAULT '0',
  `avatar` varchar(2555) NOT NULL DEFAULT '0',
  `date` varchar(50) NOT NULL DEFAULT '0',
  `message` varchar(50) NOT NULL DEFAULT '0',
  `imageurl` varchar(266) NOT NULL DEFAULT '0',
  `likes` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4;

ALTER TABLE `users` ADD COLUMN `phone_number` VARCHAR(10) NULL;

ALTER TABLE `jobs` ADD COLUMN `handyservice` VARCHAR(2) NOT NULL DEFAULT '0';
ALTER TABLE `jobs` ADD COLUMN `hasapp` int(2) NOT NULL DEFAULT '0';
ALTER TABLE `jobs` ADD COLUMN `onlyboss` int(2) NOT NULL DEFAULT '0';