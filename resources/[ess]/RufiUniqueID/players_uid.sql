CREATE TABLE IF NOT EXISTS `players_uid` (
  `name` varchar(60) NOT NULL,
  `steam` varchar(60) NOT NULL,
  `uid` int(11) NOT NULL AUTO_INCREMENT,
   PRIMARY KEY (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;