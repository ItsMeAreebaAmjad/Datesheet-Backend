-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 04, 2025 at 07:18 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `datesheet`
--

-- --------------------------------------------------------

--
-- Table structure for table `cs_courses`
--

CREATE TABLE `cs_courses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `semester_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cs_courses`
--

INSERT INTO `cs_courses` (`id`, `name`, `semester_id`) VALUES
(1, 'Programming Fundamental', 1),
(2, 'Introduction to Computing', 1),
(3, 'Functional English', 1),
(4, 'Calculus', 1),
(5, 'Applied Physics', 1),
(6, 'Workshop Practice', 1),
(7, 'Object Oriented Programming', 2),
(8, 'Digital Logic Design', 2),
(9, 'Psychology', 2),
(10, 'Communication Skills', 2),
(11, 'Multivariate Calculus', 2),
(12, 'Applied Probability and Statistics', 2),
(13, 'Translation of Holy Quran', 2),
(14, 'Data Structures and Algorithm', 3),
(15, 'Technical Writing and Presentation Skills', 3),
(16, 'Computer Organization and Assembly Language', 3),
(17, 'Linear Algebra', 3),
(18, 'Discrete Mathematics', 3),
(19, 'Database Systems', 4),
(20, 'Operating Systems', 4),
(21, 'Differentials Equations', 4),
(22, 'Design and Analysis of Algorithms', 4),
(23, 'Theory of Automata', 4),
(24, 'Translation of Holy Quran', 4),
(25, 'Information Security', 5),
(26, 'Artificial Intelligence', 5),
(27, 'Professional Practices in Software Development', 5),
(28, 'CS Elective-1', 5),
(29, 'Software Engineering', 5),
(30, 'Computer Networks', 6),
(31, 'CS Elective-2', 6),
(32, 'CS Elective-3', 6),
(33, 'Graph Theory', 6),
(34, 'Parallel and Distributed Computing', 6),
(35, 'Translation of Holy Quran', 6),
(36, 'FYP-I', 7),
(37, 'Compiler Construction', 7),
(38, 'CS Elective-4', 7),
(39, 'Islamic and Pakistan Studies-I', 7),
(40, 'CS Elective-5', 7),
(41, 'FYP-II', 8),
(42, 'Entrepreneurship & Business Management', 8),
(43, 'Islamic and Pakistan Studies-II', 8),
(44, 'International Language', 8),
(45, 'Leadership Strategies', 8),
(46, 'Translation of Holy Quran', 8);

-- --------------------------------------------------------

--
-- Table structure for table `datesheet_data`
--

CREATE TABLE `datesheet_data` (
  `id` int(11) NOT NULL,
  `session` varchar(50) NOT NULL,
  `exam_date` date NOT NULL,
  `exam_day` varchar(20) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `invigilator_name` varchar(255) DEFAULT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `room` varchar(50) NOT NULL,
  `discipline` varchar(255) NOT NULL,
  `semester` varchar(50) NOT NULL,
  `exam_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `datesheet_data`
--

INSERT INTO `datesheet_data` (`id`, `session`, `exam_date`, `exam_day`, `subject`, `invigilator_name`, `start_time`, `end_time`, `room`, `discipline`, `semester`, `exam_type`) VALUES
(172, 'Fall 2024', '2025-01-01', 'Monday', 'Calculus', 'Hafiz Muhammad Danish', '02:15:00', '03:45:00', 'F-15', 'Computer Science', '1', 'Mid-Term'),
(173, 'Fall 2024', '2025-01-02', 'Tuesday', 'Programming Fundamental', 'Mr. Usman Ghani', '02:15:00', '03:45:00', 'F-14', 'Computer Science', '1', 'Mid-Term'),
(174, 'Fall 2024', '2025-01-01', 'Monday', 'Programming Fundamental', 'Hafiz Muhammad Danish', '02:15:00', '03:45:00', 'F-14', 'Computer Science', '1', 'Final-Term'),
(175, 'Fall 2024', '2025-01-02', 'Tuesday', 'Introduction to Computing', 'Dr. Qurat-ul-Ain', '02:15:00', '03:45:00', 'G-6', 'Computer Science', '1', 'Final-Term'),
(176, 'Fall 2024', '2025-01-01', 'Monday', 'Digital Logic Design', 'Hafiz Muhammad Danish', '12:15:00', '01:45:00', 'F-14', 'Computer Science', '2', 'Final-Term'),
(177, 'Fall 2024', '2025-01-03', 'Tuesday', 'Psychology', 'Dr. Qurat-ul-Ain', '02:15:00', '03:45:00', 'G-6', 'Computer Science', '2', 'Final-Term');

-- --------------------------------------------------------

--
-- Table structure for table `invigilator`
--

CREATE TABLE `invigilator` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invigilator`
--

INSERT INTO `invigilator` (`id`, `name`) VALUES
(1, 'Dr. Muhammad Shahzad Asif'),
(2, 'Dr. Umar Qasim'),
(3, 'Dr. Farah Adeeba'),
(4, 'Dr. Irfan Yousuf'),
(5, 'Dr. Qurat-ul-Ain'),
(6, 'Ms. Alina Munir'),
(7, 'Hafiz Muhammad Danish'),
(8, 'Dania Batool'),
(9, 'Khola Naseem'),
(10, 'Ms. Anam Iftikhar'),
(11, 'Ms. Darakhshan Bokhat'),
(12, 'Mr. Zeeshan Ramzan'),
(13, 'Mr. Nadeem Iqbal'),
(14, 'Mr. Aizaz Akmal'),
(15, 'Ms. Namra Sheikh'),
(16, 'Mr. Usman Ghani'),
(17, 'Mr. Muhammad Nouman'),
(18, 'Ms. Rimsha Noreen'),
(19, 'Maryam Manzoor'),
(20, 'Ghazala Shabbir');

-- --------------------------------------------------------

--
-- Table structure for table `reviewinfo`
--

CREATE TABLE `reviewinfo` (
  `id` int(11) NOT NULL,
  `session_year` varchar(50) NOT NULL,
  `discipline` varchar(100) NOT NULL,
  `semester` int(11) NOT NULL,
  `exam_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `reviewinfo`
--

INSERT INTO `reviewinfo` (`id`, `session_year`, `discipline`, `semester`, `exam_type`) VALUES
(77, 'Fall 2024', 'CS', 1, 'Final'),
(78, 'Fall 2024', 'CS', 1, 'Final'),
(79, 'Fall 2024', 'CS', 2, 'Final'),
(80, 'Fall 2024', 'CS', 1, 'Midterm'),
(81, 'Fall 2025', 'CS', 5, 'Midterm'),
(82, 'Fall 2024', 'CS', 3, 'Midterm'),
(83, 'Fall 2024', 'CS', 3, 'Midterm');

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `id` int(11) NOT NULL,
  `room_number` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`id`, `room_number`) VALUES
(1, 'F-09'),
(2, 'F-13'),
(3, 'F-14'),
(4, 'F-15'),
(5, 'F-16'),
(6, 'G-5'),
(7, 'G-6'),
(8, 'G-18'),
(9, 'G-19'),
(10, 'G-20'),
(11, 'G-7'),
(12, 'F-17'),
(13, 'G-10'),
(14, 'G-16'),
(15, 'G-11'),
(16, 'F-04'),
(17, 'F-05'),
(18, 'F-08');

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `id` int(11) NOT NULL,
  `session_year` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `session`
--

INSERT INTO `session` (`id`, `session_year`) VALUES
(20, 'Fall 2024'),
(23, 'Fall 2025');

-- --------------------------------------------------------

--
-- Table structure for table `se_courses`
--

CREATE TABLE `se_courses` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `semester_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `se_courses`
--

INSERT INTO `se_courses` (`id`, `name`, `semester_id`) VALUES
(1, 'Introduction to Computing (ITC)', 1),
(2, 'Programming Fundamentals (PF)', 1),
(3, 'Functional English (FE)', 1),
(4, 'Calculus', 1),
(5, 'Applied Physics (APH)', 1),
(6, 'Workshop Practice (WP)', 1),
(7, 'Object Oriented Programming (OOP)', 2),
(8, 'Islamic and Pak Studies-I', 2),
(9, 'Discrete Mathematical Structures (DMS)', 2),
(10, 'Software Engineering (SE)', 2),
(11, 'Linear Algebra and Differential Equations', 2),
(12, 'Translation of the Holy Quran', 2),
(13, 'Data Structures & Algorithms (DSA)', 3),
(14, 'Introduction to Human Computer Interaction', 3),
(15, 'Software Requirement Engineering (SRE)', 3),
(16, 'Applied Probability & Statistics', 3),
(17, 'Communication Skills LAB', 3),
(18, 'Translation of the Holy Quran', 3),
(19, 'Operating Systems (OS)', 4),
(20, 'Database System', 4),
(21, 'Software Design & Architecture (SDA)', 4),
(22, 'Psychology', 4),
(23, 'Islamic and Pak Studies-II', 4),
(24, 'Sociology for Engineering', 4),
(25, 'Software Construction and Development (SC&D)', 5),
(26, 'Computer Networks (CN)', 5),
(27, 'Technical Writing and Presentation Skills', 5),
(28, 'SE-Elective-I', 5),
(29, 'SE-Supporting-I', 5),
(30, 'Translation of the Holy Quran', 5),
(31, 'Software Quality Engineering', 6),
(32, 'Information Security', 6),
(33, 'Professional Practices in Software Development', 6),
(34, 'Principles of Web Engineering', 6),
(35, 'SE-Elective-II', 6),
(36, 'SE-Supporting-II', 6),
(37, 'Software Project Management', 7),
(38, 'Software Re-Engineering', 7),
(39, 'SE-Elective-III', 7),
(40, 'SE-Elective-IV', 7),
(41, 'Entrepreneurship and Business Management', 7),
(42, 'FYP-I', 7),
(43, 'SE-Supporting-III', 8),
(44, 'SE-Elective-V', 8),
(45, 'FYP-II', 8),
(46, 'Leadership Strategies', 8),
(47, 'International Language', 8),
(48, 'Translation of the Holy Quran', 8);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cs_courses`
--
ALTER TABLE `cs_courses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `datesheet_data`
--
ALTER TABLE `datesheet_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invigilator`
--
ALTER TABLE `invigilator`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `reviewinfo`
--
ALTER TABLE `reviewinfo`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `rooms`
--
ALTER TABLE `rooms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `se_courses`
--
ALTER TABLE `se_courses`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cs_courses`
--
ALTER TABLE `cs_courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT for table `datesheet_data`
--
ALTER TABLE `datesheet_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=178;

--
-- AUTO_INCREMENT for table `invigilator`
--
ALTER TABLE `invigilator`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `reviewinfo`
--
ALTER TABLE `reviewinfo`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=84;

--
-- AUTO_INCREMENT for table `rooms`
--
ALTER TABLE `rooms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `session`
--
ALTER TABLE `session`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `se_courses`
--
ALTER TABLE `se_courses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
