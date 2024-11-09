-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 09, 2024 at 08:13 PM
-- Server version: 10.4.6-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cnrms`
--

-- --------------------------------------------------------

--
-- Table structure for table `class_notices`
--

CREATE TABLE `class_notices` (
  `sl_no` int(11) NOT NULL,
  `year` enum('First','Second','Third','Fourth','Masters') NOT NULL,
  `semester` enum('first','second','') NOT NULL,
  `admission_session` varchar(7) NOT NULL,
  `course` int(11) NOT NULL,
  `teacher` int(11) NOT NULL,
  `notice` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `class_schedule`
--

CREATE TABLE `class_schedule` (
  `sl_no` int(11) NOT NULL,
  `year` enum('First','Second','Third','Fourth','Masters') NOT NULL,
  `semester` enum('First','Second','') NOT NULL,
  `admission_session` varchar(7) NOT NULL,
  `course` int(11) NOT NULL,
  `teacher` int(11) NOT NULL,
  `room_no` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `refefence` int(11) NOT NULL,
  `publish_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('pending','conducted','cancelled') NOT NULL,
  `remarks` varchar(200) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `class_schedule`
--
DELIMITER $$
CREATE TRIGGER `after_class_schedule_update` AFTER UPDATE ON `class_schedule` FOR EACH ROW update class_schedule set new.update_time = current_timestamp()
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `courses`
--

CREATE TABLE `courses` (
  `id` int(11) NOT NULL,
  `title` varchar(50) NOT NULL,
  `syllabus` varchar(100) NOT NULL,
  `department` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `faculty` enum('science and engineering','business administration','law','social science','arts') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `faculty`) VALUES
(1, 'Matthematics', 'science and engineering');

-- --------------------------------------------------------

--
-- Table structure for table `resources`
--

CREATE TABLE `resources` (
  `id` int(11) NOT NULL,
  `teacher` int(11) DEFAULT NULL,
  `student` int(11) DEFAULT NULL,
  `course` int(11) NOT NULL,
  `share_time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `resource` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `first_name` varchar(15) NOT NULL,
  `middle_name` varchar(15) NOT NULL,
  `last_name` varchar(15) NOT NULL,
  `registration_no` varchar(10) DEFAULT NULL,
  `department` int(11) NOT NULL,
  `status` enum('active','passed','suspended','dropped') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `students_feedback`
--

CREATE TABLE `students_feedback` (
  `sl_no` int(11) NOT NULL,
  `student` int(11) NOT NULL,
  `schedule` int(11) NOT NULL,
  `feedback` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` int(11) NOT NULL,
  `name_prefix` varchar(15) DEFAULT NULL,
  `first_name` varchar(15) NOT NULL,
  `middle_name` varchar(15) DEFAULT NULL,
  `last_name` varchar(15) DEFAULT NULL,
  `designation` enum('lecturer','assistant professore','associate professore','professore') NOT NULL,
  `salary` decimal(9,2) NOT NULL,
  `department` int(11) NOT NULL,
  `office_room` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `name_prefix`, `first_name`, `middle_name`, `last_name`, `designation`, `salary`, `department`, `office_room`) VALUES
(1, 'Dr.', 'Md. Shakhawat', 'Hossain', NULL, 'assistant professore', '50000.00', 1, 1310),
(2, NULL, 'Abdullah', 'Ahmed', 'Faisal', 'associate professore', '60000.00', 1, 1306);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `class_notices`
--
ALTER TABLE `class_notices`
  ADD PRIMARY KEY (`sl_no`),
  ADD KEY `class_notices_courses` (`course`),
  ADD KEY `class_notices_teachers` (`teacher`);

--
-- Indexes for table `class_schedule`
--
ALTER TABLE `class_schedule`
  ADD PRIMARY KEY (`sl_no`),
  ADD KEY `class_schedule_class_notices` (`refefence`),
  ADD KEY `class_schedule_courses` (`course`),
  ADD KEY `class_schedule_teachers` (`teacher`);

--
-- Indexes for table `courses`
--
ALTER TABLE `courses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_courses_departments` (`department`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_resources_teachers` (`teacher`),
  ADD KEY `fk_resources_students` (`student`),
  ADD KEY `fk_resources_courses` (`course`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `registration_no` (`registration_no`),
  ADD KEY `fk_students_departments` (`department`);

--
-- Indexes for table `students_feedback`
--
ALTER TABLE `students_feedback`
  ADD KEY `fk_students_feedback_students` (`student`),
  ADD KEY `fk_students_feeeldback_class_schedule` (`schedule`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_teachers_departments` (`department`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `class_notices`
--
ALTER TABLE `class_notices`
  MODIFY `sl_no` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `class_schedule`
--
ALTER TABLE `class_schedule`
  MODIFY `sl_no` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `courses`
--
ALTER TABLE `courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `resources`
--
ALTER TABLE `resources`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `class_notices`
--
ALTER TABLE `class_notices`
  ADD CONSTRAINT `class_notices_courses` FOREIGN KEY (`course`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `class_notices_teachers` FOREIGN KEY (`teacher`) REFERENCES `teachers` (`id`);

--
-- Constraints for table `class_schedule`
--
ALTER TABLE `class_schedule`
  ADD CONSTRAINT `class_schedule_class_notices` FOREIGN KEY (`refefence`) REFERENCES `class_notices` (`sl_no`),
  ADD CONSTRAINT `class_schedule_courses` FOREIGN KEY (`course`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `class_schedule_teachers` FOREIGN KEY (`teacher`) REFERENCES `teachers` (`id`);

--
-- Constraints for table `courses`
--
ALTER TABLE `courses`
  ADD CONSTRAINT `fk_courses_departments` FOREIGN KEY (`department`) REFERENCES `departments` (`id`);

--
-- Constraints for table `resources`
--
ALTER TABLE `resources`
  ADD CONSTRAINT `fk_resources_courses` FOREIGN KEY (`course`) REFERENCES `courses` (`id`),
  ADD CONSTRAINT `fk_resources_students` FOREIGN KEY (`student`) REFERENCES `students` (`id`),
  ADD CONSTRAINT `fk_resources_teachers` FOREIGN KEY (`teacher`) REFERENCES `departments` (`id`);

--
-- Constraints for table `students`
--
ALTER TABLE `students`
  ADD CONSTRAINT `fk_students_departments` FOREIGN KEY (`department`) REFERENCES `departments` (`id`);

--
-- Constraints for table `students_feedback`
--
ALTER TABLE `students_feedback`
  ADD CONSTRAINT `fk_students_feedback_students` FOREIGN KEY (`student`) REFERENCES `students` (`id`),
  ADD CONSTRAINT `fk_students_feeeldback_class_schedule` FOREIGN KEY (`schedule`) REFERENCES `class_schedule` (`sl_no`);

--
-- Constraints for table `teachers`
--
ALTER TABLE `teachers`
  ADD CONSTRAINT `fk_teachers_departments` FOREIGN KEY (`department`) REFERENCES `departments` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
