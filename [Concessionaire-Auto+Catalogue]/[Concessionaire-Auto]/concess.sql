INSERT INTO `addon_account` (`id`, `name`, `label`, `shared`) VALUES
(10, 'society_concess', 'concessionnaire', 1);

INSERT INTO `addon_inventory` (`id`, `name`, `label`, `shared`) VALUES
(17, 'society_concess', 'concessionnaire', 1);

INSERT INTO `jobs` (`name`, `label`, `whitelisted`, `SecondaryJob`) VALUES
('concess', 'concessionnaire', 1, 0);

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(33, 'concess', 0, 'novice', 'Novice', 100, '', ''),
(34, 'concess', 1, 'experimente', 'Experimenté', 100, '', ''),
(35, 'concess', 2, 'boss', 'Patron', 100, '', '');
