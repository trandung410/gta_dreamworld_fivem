CREATE TABLE IF NOT EXISTS `occupation` (
  `name` char(50) DEFAULT NULL,
  `gang_name` char(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
CREATE TABLE IF NOT EXISTS `occupation_point` (
  `gang_name` char(50) DEFAULT NULL,
  `point` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;