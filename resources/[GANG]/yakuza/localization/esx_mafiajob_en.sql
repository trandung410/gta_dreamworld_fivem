INSERT INTO `addon_account` (name, label, shared) VALUES 
	('society_gang1','Gang1',1)
;

INSERT INTO `datastore` (name, label, shared) VALUES 
	('society_gang1','Gang1',1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
	('society_gang1', 'Gang1', 1)
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('gang1', 'Gang1', 1);

--
-- Déchargement des données de la table `jobs_grades`
--

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('gang1', 0, 'soldato', 'Ptite-Frappe', 1500, '{}', '{}'),
('gang1', 1, 'capo', 'Capo', 1800, '{}', '{}'),
('gang1', 2, 'consigliere', 'Consigliere', 2100, '{}', '{}'),
('gang1', 3, 'boss', 'Don', 2700, '{}', '{}');