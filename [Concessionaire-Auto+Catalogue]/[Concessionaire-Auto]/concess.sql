INSERT INTO `addon_account` (name, label, shared) VALUES
(10, 'society_concess', 'concessionnaire', 1);

INSERT INTO `addon_inventory` (name, label, shared) VALUES
(17, 'society_concess', 'concessionnaire', 1);

INSERT INTO `jobs` (name, label) VALUES
('concess', 'concessionnaire', 1, 0);

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
(33, 'concess', 0, 'novice', 'Novice', 100, '', ''),
(34, 'concess', 1, 'experimente', 'Experimenté', 100, '', ''),
(35, 'concess', 2, 'boss', 'Patron', 100, '', '');
