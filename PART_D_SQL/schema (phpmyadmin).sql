-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 19, 2022 at 04:54 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `collanity part_d_sql`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `author` varchar(255) NOT NULL,
  `year_of_publication` year(4) NOT NULL,
  `book_status` enum('available','borrowed','damaged','lost') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`id`, `title`, `author`, `year_of_publication`, `book_status`) VALUES
(1, 'Classical Mythology', 'Mark P. O. Morford', 2002, 'available'),
(2, 'Clara Callan', 'Richard Bruce Wright', 2001, 'available'),
(3, 'Decision in Normandy', 'Carlo D\'Este', 1991, 'available'),
(4, 'The Mummies of Urumchi', 'E. J. W. Barber', 1999, 'available'),
(5, 'The Kitchen God\'s Wife', 'Amy Tan', 1991, 'available');

-- --------------------------------------------------------

--
-- Table structure for table `borrowinghistory`
--

CREATE TABLE `borrowinghistory` (
  `id` int(11) NOT NULL,
  `book_id` int(11) NOT NULL,
  `visitor_id` int(11) NOT NULL,
  `borrowing_date` date NOT NULL,
  `return_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `borrowinghistory`
--

INSERT INTO `borrowinghistory` (`id`, `book_id`, `visitor_id`, `borrowing_date`, `return_date`) VALUES
(1, 1, 2, '2006-01-15', '2006-01-20'),
(2, 2, 3, '2006-01-19', '2006-01-21'),
(3, 5, 3, '2006-01-23', '2006-01-30'),
(4, 5, 2, '2006-02-05', '2006-02-08'),
(5, 3, 1, '2006-02-06', '2006-02-10'),
(6, 4, 1, '2006-02-11', '2006-03-15'),
(7, 3, 2, '2006-02-15', '2006-03-25'),
(8, 1, 3, '2006-03-31', '2006-04-25');

-- --------------------------------------------------------

--
-- Table structure for table `visitors`
--

CREATE TABLE `visitors` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` enum('male','female') NOT NULL,
  `address` varchar(255) NOT NULL,
  `phone_number` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `visitors`
--

INSERT INTO `visitors` (`id`, `name`, `date_of_birth`, `gender`, `address`, `phone_number`) VALUES
(1, 'Budi', '1990-01-23', 'male', 'Jl. Something No. 51', '08XXXXXXXXXX'),
(2, 'Anto', '1990-01-23', 'male', 'Jl. Something No. 51', '08XXXXXXXXXX'),
(3, 'Cindy', '1990-01-23', 'female', 'Jl. Something No. 51', '08XXXXXXXXXX');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `borrowinghistory`
--
ALTER TABLE `borrowinghistory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_borrowinghistory_books` (`book_id`),
  ADD KEY `FK_borrowinghistory_visitors` (`visitor_id`);

--
-- Indexes for table `visitors`
--
ALTER TABLE `visitors`
  ADD PRIMARY KEY (`id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `borrowinghistory`
--
ALTER TABLE `borrowinghistory`
  ADD CONSTRAINT `FK_borrowinghistory_books` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`),
  ADD CONSTRAINT `FK_borrowinghistory_visitors` FOREIGN KEY (`visitor_id`) REFERENCES `visitors` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
