-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 26, 2020 at 10:28 AM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.1.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `testapi`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_data` (IN `p_name` VARCHAR(200), IN `p_skills` VARCHAR(200), IN `p_address` VARCHAR(200), IN `p_designation` VARCHAR(200), IN `p_age` VARCHAR(200))  BEGIN
insert into emp (name, skills, address, designation,age) values (p_name,p_skills,p_address, p_designation,p_age);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_emp` (IN `p_id` INT(10))  NO SQL
BEGIN
    DELETE FROM emp WHERE ID=p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `edit_emp` (IN `p_id` INT(10))  NO SQL
BEGIN
     SELECT * FROM emp
 WHERE id=p_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `require_view_value` (IN `p_id` INT(10), OUT `p_name` VARCHAR(200), OUT `p_age` VARCHAR(20))  NO SQL
BEGIN
  SELECT  name, age INTO p_name, p_age  
   FROM emp WHERE id = p_id;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `update_emp` (IN `p_id` INT(10), IN `p_name` VARCHAR(200), IN `p_skills` VARCHAR(231), IN `p_address` VARCHAR(200), IN `p_designation` VARCHAR(200), IN `p_age` VARCHAR(200))  BEGIN

SET @up_date = now()+6;

 UPDATE emp
 SET
 name = p_name, 
 skills=p_skills, 
 address = p_address, 
 designation=p_designation, 
 age=p_age,
 u_date=@up_date
 WHERE id = p_id;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_all_data` ()  BEGIN
 select * from emp;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `view_data` (INOUT `p_name` VARCHAR(255), INOUT `p_age` VARCHAR(255))  BEGIN
select * from emp where name=p_name and age=p_age;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `emp`
--

CREATE TABLE `emp` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `skills` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `age` int(11) NOT NULL,
  `dlt_id` int(10) DEFAULT NULL,
  `d_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `u_date` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emp`
--

INSERT INTO `emp` (`id`, `name`, `skills`, `address`, `designation`, `age`, `dlt_id`, `d_date`, `u_date`) VALUES
(1, 'sorna', 'cook', 'Dhaka', 'house wife', 21, NULL, '2020-02-16 05:10:29', NULL),
(3, 'rasel karim', 'php', '', 'Developer', 23, NULL, '2020-02-16 10:55:14', NULL),
(4, 'karim', 'php', 'Dhaka', 'Delover', 23, 2, '2020-02-26 06:50:05', '2020-02-26 06:50:11');

--
-- Triggers `emp`
--
DELIMITER $$
CREATE TRIGGER `Add_data` AFTER INSERT ON `emp` FOR EACH ROW BEGIN
INSERT into emp_add (aname, aage, askills, adesignation, aaddress, emp_id) VALUES(new.name, new.age, new.skills, new.designation, new.address, new.id);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Delete_data` BEFORE DELETE ON `emp` FOR EACH ROW DELETE FROM emp_add WHERE emp_id = old.id
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `Update_data` AFTER UPDATE ON `emp` FOR EACH ROW BEGIN
UPDATE emp_add SET 
    aname = new.name, 
    askills = new.skills,
    adesignation = new.designation,
    aaddress = new.address,
    aage = new.age
    WHERE emp_id = new.id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `emp_add`
--

CREATE TABLE `emp_add` (
  `id` int(10) NOT NULL,
  `aname` varchar(255) DEFAULT NULL,
  `aage` varchar(255) DEFAULT NULL,
  `askills` varchar(255) DEFAULT NULL,
  `adesignation` varchar(255) DEFAULT NULL,
  `aaddress` varchar(255) DEFAULT NULL,
  `emp_id` int(10) NOT NULL,
  `ad_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `emp_add`
--

INSERT INTO `emp_add` (`id`, `aname`, `aage`, `askills`, `adesignation`, `aaddress`, `emp_id`, `ad_date`) VALUES
(1, 'sorna', '21', 'cook', 'house wife', 'Dhaka', 1, '2020-02-16 11:10:06'),
(3, 'rasel karim', '23', 'php', 'Developer', '', 3, '2020-02-16 11:14:06'),
(4, 'karim', '23', 'php', 'Delover', 'Dhaka', 4, '2020-02-16 11:18:00');

--
-- Triggers `emp_add`
--
DELIMITER $$
CREATE TRIGGER `AddDeleteData` AFTER DELETE ON `emp_add` FOR EACH ROW INSERT into emp_delete_after_insert (dname,dage,dskills,ddesignation,daddress,emp_id) VALUES(old.aname, old.aage, old.askills, old.adesignation, old.aaddress, old.id)
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `AddUpdateData` AFTER UPDATE ON `emp_add` FOR EACH ROW IF (select count(*) from emp_update_after_insert WHERE add_id = new.id)=1
THEN
	UPDATE emp_update_after_insert SET 
    uname = new.aname, 
    uskills = new.askills,
    udesignation = new.adesignation,
    uaddress = new.aaddress,
    uage = new.aage
    WHERE add_id = new.id;
ELSE
    INSERT into emp_update_after_insert (uname, uage, uskills, udesignation, uaddress, add_id) VALUES(new.aname, new.aage, new.askills, new.adesignation, new.aaddress, new.id);	

END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `DeleteUpdateData` BEFORE DELETE ON `emp_add` FOR EACH ROW DELETE FROM emp_update_after_insert WHERE add_id = old.id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `emp_delete_after_insert`
--

CREATE TABLE `emp_delete_after_insert` (
  `id` int(10) NOT NULL,
  `dname` varchar(255) DEFAULT NULL,
  `dage` varchar(255) DEFAULT NULL,
  `dskills` varchar(255) DEFAULT NULL,
  `ddesignation` varchar(255) DEFAULT NULL,
  `daddress` varchar(255) DEFAULT NULL,
  `emp_id` int(10) NOT NULL,
  `dd_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `emp_delete_after_insert`
--

INSERT INTO `emp_delete_after_insert` (`id`, `dname`, `dage`, `dskills`, `ddesignation`, `daddress`, `emp_id`, `dd_date`) VALUES
(1, 'rasel', '0', 'php', 'Developer', '', 2, '2020-02-16 11:13:38');

-- --------------------------------------------------------

--
-- Table structure for table `emp_event_insert`
--

CREATE TABLE `emp_event_insert` (
  `id` int(10) NOT NULL,
  `uname` varchar(255) DEFAULT NULL,
  `uage` varchar(255) DEFAULT NULL,
  `uskills` varchar(255) DEFAULT NULL,
  `uaddress` varchar(255) DEFAULT NULL,
  `udesignation` varchar(255) DEFAULT NULL,
  `emp_id` int(10) NOT NULL,
  `d_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `emp_event_insert`
--

INSERT INTO `emp_event_insert` (`id`, `uname`, `uage`, `uskills`, `uaddress`, `udesignation`, `emp_id`, `d_date`) VALUES
(1, 'sorna', '21', 'cook', 'Dhaka', 'house wife', 1, '2020-02-16 05:12:00'),
(2, 'rasel karim', '23', 'php', '', 'Developer', 3, '2020-02-17 06:55:00'),
(3, 'rasel karim', '32', 'php', '', 'Developer', 4, '2020-02-17 11:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `emp_update_after_insert`
--

CREATE TABLE `emp_update_after_insert` (
  `id` int(10) NOT NULL,
  `uname` varchar(255) DEFAULT NULL,
  `uage` varchar(255) DEFAULT NULL,
  `uskills` varchar(255) DEFAULT NULL,
  `udesignation` varchar(255) DEFAULT NULL,
  `uaddress` varchar(255) DEFAULT NULL,
  `add_id` int(10) NOT NULL,
  `d_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `emp_update_after_insert`
--

INSERT INTO `emp_update_after_insert` (`id`, `uname`, `uage`, `uskills`, `udesignation`, `uaddress`, `add_id`, `d_date`) VALUES
(1, 'sorna', '21', 'cook', 'house wife', 'Dhaka', 1, '2020-02-16 11:10:29'),
(2, 'karim', '23', 'php', 'Delover', 'Dhaka', 4, '2020-02-16 12:16:40'),
(3, 'rasel karim', '23', 'php', 'Developer', '', 3, '2020-02-16 16:55:14');

-- --------------------------------------------------------

--
-- Table structure for table `mytable1`
--

CREATE TABLE `mytable1` (
  `id` int(11) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `skills` varchar(255) NOT NULL,
  `address` varchar(255) NOT NULL,
  `designation` varchar(255) NOT NULL,
  `age` int(11) NOT NULL,
  `d_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `mytable1`
--

INSERT INTO `mytable1` (`id`, `name`, `skills`, `address`, `designation`, `age`, `d_date`) VALUES
(1, 'sorna', 'cook', 'Mirpur', 'house wife', 23, '2020-02-13 04:13:28'),
(2, 'rasel', 'php', '', 'Developer', 32, '2020-02-13 04:13:40'),
(4, 'Rasel', 'css', 'Dhaka', 'web', 12, '2020-02-13 04:58:03'),
(5, 'Rasel', 'css', 'Dhaka', 'web', 12, '2020-02-13 04:58:27');

-- --------------------------------------------------------

--
-- Table structure for table `test_table`
--

CREATE TABLE `test_table` (
  `id` int(10) NOT NULL,
  `msisdn` varchar(255) NOT NULL,
  `d_date` datetime NOT NULL,
  `d_update` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `test_table`
--

INSERT INTO `test_table` (`id`, `msisdn`, `d_date`, `d_update`) VALUES
(17, '8801552202700', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(18, '8801552202701', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(19, '8801552202702', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(20, '8801552202700', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(21, '8801552202701', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(22, '8801552202702', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(23, '8801552202700', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(24, '8801552202701', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(25, '8801552202702', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `emp`
--
ALTER TABLE `emp`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emp_add`
--
ALTER TABLE `emp_add`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emp_delete_after_insert`
--
ALTER TABLE `emp_delete_after_insert`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emp_event_insert`
--
ALTER TABLE `emp_event_insert`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `emp_update_after_insert`
--
ALTER TABLE `emp_update_after_insert`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mytable1`
--
ALTER TABLE `mytable1`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `test_table`
--
ALTER TABLE `test_table`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `emp`
--
ALTER TABLE `emp`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `emp_add`
--
ALTER TABLE `emp_add`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `emp_delete_after_insert`
--
ALTER TABLE `emp_delete_after_insert`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `emp_event_insert`
--
ALTER TABLE `emp_event_insert`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `emp_update_after_insert`
--
ALTER TABLE `emp_update_after_insert`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mytable1`
--
ALTER TABLE `mytable1`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `test_table`
--
ALTER TABLE `test_table`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `CreateNewDatabase` ON SCHEDULE EVERY 1 MINUTE STARTS '2020-02-12 23:00:00' ENDS '2021-10-22 23:00:00' ON COMPLETION NOT PRESERVE DISABLE COMMENT 'Create new another database' DO CREATE TABLE testapi.mytable1 LIKE testapi.emp$$

CREATE DEFINER=`root`@`localhost` EVENT `AnotherTabledataInsert` ON SCHEDULE EVERY 1 MINUTE STARTS '2020-02-12 23:00:00' ENDS '2021-06-17 23:00:00' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'another database another table data insert' DO INSERT INTO testapi.mytable SELECT * FROM testapi.emp$$

CREATE DEFINER=`root`@`localhost` EVENT `data_insert_from_delete_table` ON SCHEDULE EVERY 1 MINUTE STARTS '2020-02-12 23:00:00' ENDS '2020-11-19 23:00:00' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'data insert from delete table' DO INSERT INTO emp (name, age, skills, address, designation, dlt_id)
    SELECT dname, dage, dskills, daddress, ddesignation, emp_id  FROM emp_delete_after_insert    
    WHERE NOT EXISTS (SELECT name, age, skills, address, designation, dlt_id
                   FROM emp
                   WHERE emp.dlt_id = emp_delete_after_insert.emp_id)$$

CREATE DEFINER=`root`@`localhost` EVENT `DeleteDataFromTable` ON SCHEDULE EVERY 3 MINUTE STARTS '2020-02-10 12:15:00' ENDS '2020-09-24 00:00:00' ON COMPLETION NOT PRESERVE DISABLE COMMENT 'Delete Table' DO DELETE FROM emp$$

CREATE DEFINER=`root`@`localhost` EVENT `Another_database_table_create_and_data_insert` ON SCHEDULE EVERY 1 MINUTE STARTS '2020-02-12 23:00:00' ENDS '2022-05-26 00:00:00' ON COMPLETION NOT PRESERVE DISABLE COMMENT 'Another Table Data Insert' DO BEGIN
	CREATE TABLE apilearning.mytable_new LIKE testapi.mytable;
	INSERT INTO apilearning.mytable_new SELECT * FROM testapi.mytable;
	RENAME TABLE testapi.mytable TO testapi.mytable_old;
	TRUNCATE testapi.mytable_old;
END$$

CREATE DEFINER=`root`@`localhost` EVENT `UpdateData` ON SCHEDULE EVERY 1 MINUTE STARTS '2020-02-10 14:56:00' ENDS '2021-02-17 23:00:00' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'Upadate data' DO UPDATE emp_event_insert 
SET 
emp_event_insert.uname  = ( SELECT emp.name  FROM emp WHERE emp.id = emp_event_insert.emp_id),
emp_event_insert.uage  = ( SELECT emp.age  FROM emp WHERE emp.id = emp_event_insert.emp_id),
emp_event_insert.uskills  = ( SELECT emp.skills  FROM emp WHERE emp.id = emp_event_insert.emp_id),
emp_event_insert.uaddress  = ( SELECT emp.address  FROM emp WHERE emp.id = emp_event_insert.emp_id),
emp_event_insert.udesignation  = ( SELECT emp.designation  FROM emp WHERE emp.id = emp_event_insert.emp_id)$$

CREATE DEFINER=`root`@`localhost` EVENT `AddData` ON SCHEDULE EVERY 1 MINUTE STARTS '2020-02-10 15:00:00' ENDS '2023-06-07 23:00:00' ON COMPLETION NOT PRESERVE ENABLE COMMENT 'AddData' DO INSERT INTO emp_event_insert (uname, uage, uskills, uaddress, udesignation, emp_id)
    SELECT name, age, skills, address, designation, id  FROM emp
        WHERE NOT EXISTS (SELECT uname, uage, uskills, uaddress, udesignation, emp_id
                              FROM emp_event_insert
                              WHERE emp.id = emp_event_insert.emp_id)$$

DELIMITER ;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
