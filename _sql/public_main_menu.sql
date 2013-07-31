-- phpMyAdmin SQL Dump
-- version 4.0.4.1
-- http://www.phpmyadmin.net
--
-- Хост: bremsen.mysql.ukraine.com.ua
-- Час створення: Лип 26 2013 р., 17:38
-- Версія сервера: 5.1.61-cll
-- Версія PHP: 5.2.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База даних: `bremsen_enotus`
--

-- --------------------------------------------------------

--
-- Структура таблиці `public_main_menu`
--

DROP TABLE IF EXISTS `public_main_menu`;
CREATE TABLE IF NOT EXISTS `public_main_menu` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_item_name` varchar(100) NOT NULL,
  `menu_item_link` varchar(255) NOT NULL,
  `menu_item_parent` int(11) NOT NULL DEFAULT '0',
  `menu_item_order` int(11) NOT NULL DEFAULT '0',
  `read_level` int(11) NOT NULL,
  `write_level` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Дамп даних таблиці `public_main_menu`
--

INSERT INTO `public_main_menu` (`menu_id`, `menu_item_name`, `menu_item_link`, `menu_item_parent`, `menu_item_order`, `read_level`, `write_level`, `owner`) VALUES
(1, 'main_menu', '', 0, 0, 0, 80, 1),
(2, 'bottom_menu', '', 0, 0, 0, 80, 1),
(3, 'База документов', 'documents', 1, 1, 0, 80, 1),
(4, 'О проекте', 'about', 1, 2, 0, 80, 1),
(5, 'Тарифы', 'tariffs', 1, 3, 0, 80, 1),
(6, 'F.A.Q.', 'faq', 1, 4, 0, 80, 1),
(7, 'Контактная информация', 'contacts', 1, 5, 0, 80, 1);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
