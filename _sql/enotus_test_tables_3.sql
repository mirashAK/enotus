-- phpMyAdmin SQL Dump
-- version 4.0.2
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Час створення: Вер 02 2013 р., 14:28
-- Версія сервера: 5.5.30-log
-- Версія PHP: 5.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Структура таблиці `dict_genders`
--

DROP TABLE IF EXISTS `dict_genders`;
CREATE TABLE IF NOT EXISTS `dict_genders` (
  `dict_id` int(11) NOT NULL AUTO_INCREMENT,
  `dict_value` varchar(20) NOT NULL,
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_id` (`dict_id`),
  KEY `dict_id_2` (`dict_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Дамп даних таблиці `dict_genders`
--

INSERT INTO `dict_genders` (`dict_id`, `dict_value`) VALUES
(9, 'male'),
(2, 'female'),
(10, 'thing');

-- --------------------------------------------------------

--
-- Структура таблиці `dict_timesets`
--

DROP TABLE IF EXISTS `dict_timesets`;
CREATE TABLE IF NOT EXISTS `dict_timesets` (
  `dict_id` int(11) NOT NULL AUTO_INCREMENT,
  `dict_value` varchar(100) NOT NULL,
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_id` (`dict_id`),
  KEY `dict_id_2` (`dict_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп даних таблиці `dict_timesets`
--

INSERT INTO `dict_timesets` (`dict_id`, `dict_value`) VALUES
(1, 'UTC -1'),
(2, 'UTC 2');

-- --------------------------------------------------------

--
-- Структура таблиці `hrefs_articles_to_categories`
--

DROP TABLE IF EXISTS `hrefs_articles_to_categories`;
CREATE TABLE IF NOT EXISTS `hrefs_articles_to_categories` (
  `href_cat_id` int(11) NOT NULL,
  `href_article_id` int(11) NOT NULL,
  `read_level` int(11) NOT NULL DEFAULT '0',
  `write_level` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `hrefs_articles_to_categories`
--

INSERT INTO `hrefs_articles_to_categories` (`href_cat_id`, `href_article_id`, `read_level`, `write_level`, `owner`) VALUES
(1, 1, 0, 50, 1),
(1, 2, 0, 50, 1),
(2, 1, 0, 50, 1),
(2, 2, 0, 50, 1);

-- --------------------------------------------------------

--
-- Структура таблиці `public_articles`
--

DROP TABLE IF EXISTS `public_articles`;
CREATE TABLE IF NOT EXISTS `public_articles` (
  `article_id` int(11) NOT NULL AUTO_INCREMENT,
  `article_name` varchar(255) NOT NULL,
  `article_alias` varchar(255) NOT NULL,
  `article_text` text,
  `read_level` int(11) NOT NULL DEFAULT '0',
  `write_level` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`article_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп даних таблиці `public_articles`
--

INSERT INTO `public_articles` (`article_id`, `article_name`, `article_alias`, `article_text`, `read_level`, `write_level`, `owner`) VALUES
(1, 'Тестовая статья 1', 'article-1', '<p>Apple победила Samsung в США, но ей не удалось этого сделать в Великобритании. Еще летом британский суд отклонил обвинение Apple в том, что Samsung скопировала дизайн iPad для своих планшетов Galaxy Tab. Более того, судья Колин Бирсс (Colin Birss) сделал это весьма забавным образом, сказав, что «планшеты Samsung не настолько круты, как iPad». А раз они не так хороши, то и о каком-то заимствовании речи быть не может.</p>\r\n<hr class="separator" />\r\n<p>Apple не сдалась, подала на апелляцию на это решение и получила еще один похожий ответ, но с последствиями для себя, сообщает The Verge.</p>', 0, 50, 1),
(2, 'Тестовая статья 2', 'article-2', '<p>Только вчера появилась информация об уровне цен на планшеты Microsoft Surface RT с новой ОС Windows 8. А уже сегодня стало известно, что по предварительным заказам уже были раскуплены все имеющиеся в наличии планшеты с 32 ГБ флэш-памяти. Напомним, эта наиболее доступная модель без обложки-клавиатуры в комплекте обладает ценой $499. В продаже пока еще доступны более дорогие устройства, за которые Microsoft просит $599 и $699.</p>\r\n<hr class="separator" />\r\n<p>Совсем немного времени прошло с момента официального релиза новой операционной системы Windows 8, а компания Microsoft уже столкнулась с судебным разбирательством, вызванным этой ОС.</p>\r\n\r\n<p>Так, компания SurfCast обратилась с исковым заявлением в Окружной суд США в штате Мэн (U.S. District Court in Maine), в котором обвиняет Microsoft в нарушении одного из четырех принадлежащих ей патентов - №6,724,403. Этот патент описывает технологию плиточного интерфейса для мобильных устройств. Патент датирован 20 апреля 2004 года. Плиточный интерфейс является одним из отличительных признаков настольной операционной системы Windows 8. Он также используется и в мобильных версиях ОС Windows Phone 7 и Windows Phone 8. Таким образом, SurfCast обвиняет Microsoft в создании, использовании, продаже и предложении продавать программные продукты и аппаратные решения, в которых незаконно используется указанный патент. Кроме того, Microsoft, якобы, способствует дальнейшему нарушению патента, побуждая сторонних разработчиков программного обеспечения создавать приложения с плитками интерфейса для магазина Windows Store. В связи с этим SurfCast требует, чтобы суд установил факт прямого и косвенного нарушения патента со стороны Microsoft. Также в иске указано требование обязать Microsoft подсчитать и выплатить в пользу SurfCast все убытки, связанные с нарушением патента.</p>\r\n\r\n<p>В свою очередь представитель Microsoft назвал обвинения в незаконном использовании указанного патента необоснованными. Компания намерена доказать в суде, что она создала уникальный пользовательский опыт взаимодействия с ОС.</p>', 0, 50, 1);

-- --------------------------------------------------------

--
-- Структура таблиці `public_categories`
--

DROP TABLE IF EXISTS `public_categories`;
CREATE TABLE IF NOT EXISTS `public_categories` (
  `cat_id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(255) NOT NULL,
  `cat_alias` varchar(255) NOT NULL,
  `cat_parent_id` int(11) NOT NULL DEFAULT '0',
  `read_level` int(11) NOT NULL DEFAULT '0',
  `write_level` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`cat_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Дамп даних таблиці `public_categories`
--

INSERT INTO `public_categories` (`cat_id`, `cat_name`, `cat_alias`, `cat_parent_id`, `read_level`, `write_level`, `owner`) VALUES
(1, 'Публикации', 'articles', 0, 0, 80, 1),
(2, 'Новости', 'news', 0, 0, 80, 1);

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
(3, 'Про компанию', 'home', 1, 1, 0, 80, 1),
(4, 'Услуги', 'services', 1, 2, 0, 80, 1),
(5, 'Публикации', 'articles', 1, 3, 0, 80, 1),
(6, 'Заявка на экспертную оценку', 'forms/request', 1, 4, 0, 80, 1),
(7, 'Контакты', 'contacts', 1, 5, 0, 80, 1);

-- --------------------------------------------------------

--
-- Структура таблиці `public_static_pages`
--

DROP TABLE IF EXISTS `public_static_pages`;
CREATE TABLE IF NOT EXISTS `public_static_pages` (
  `static_page_id` int(11) NOT NULL AUTO_INCREMENT,
  `static_page_alias` varchar(255) NOT NULL,
  `static_page_text` text NOT NULL,
  `owner` int(11) NOT NULL,
  `read_level` int(11) NOT NULL,
  `write_level` int(11) NOT NULL,
  PRIMARY KEY (`static_page_id`),
  UNIQUE KEY `static_page_alias` (`static_page_alias`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп даних таблиці `public_static_pages`
--

INSERT INTO `public_static_pages` (`static_page_id`, `static_page_alias`, `static_page_text`, `owner`, `read_level`, `write_level`) VALUES
(1, 'home', '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus gravida, ipsum a pretium suscipit, ligula eros semper ante, in pretium mi nibh nec lorem. Maecenas iaculis libero ut nibh auctor gravida. Suspendisse sed sapien neque. Praesent aliquet, nibh at aliquam faucibus, felis sapien facilisis mi, quis blandit eros risus vel metus. Suspendisse eget facilisis purus. Sed eu urna laoreet felis blandit porta. Morbi ornare bibendum bibendum.</p>\r\n\r\n<p>Nam tincidunt cursus arcu, sed vestibulum tortor egestas eu. Proin lobortis, metus quis malesuada lobortis, est elit semper felis, sed convallis nunc augue ac justo. Curabitur tincidunt nisi id tellus placerat et laoreet augue posuere. Nulla mattis, neque et adipiscing sagittis, metus diam hendrerit purus, id semper leo lectus vel velit. Mauris nulla eros, tempor vel molestie nec, congue vel risus. In vitae ullamcorper metus. Aliquam risus justo, facilisis non molestie et, molestie vel orci. Donec vel arcu diam, et rutrum dolor. Nullam pharetra facilisis neque varius mollis. Quisque scelerisque luctus sodales. Sed vitae eleifend libero. Nullam euismod libero sed turpis egestas egestas. Vestibulum ullamcorper ante pellentesque quam egestas tempus. Donec lacus dolor, lacinia fermentum malesuada eget, sollicitudin a augue.</p>\r\n\r\n<p>Maecenas tristique cursus urna, ac adipiscing libero suscipit vel. Nunc elementum mattis leo in euismod. Fusce commodo auctor consequat. In volutpat est pharetra nibh iaculis convallis. Nam scelerisque dui id turpis aliquet id pellentesque tortor ullamcorper. Nunc nec turpis id magna mattis commodo vel nec eros. Aenean eget metus erat, in iaculis nunc. Integer in diam risus. Aliquam mollis, nisi vitae lobortis aliquam, eros erat ornare justo, id ultricies erat quam eget felis. Maecenas orci libero, porttitor nec tempus hendrerit, ullamcorper eget quam. Integer lorem nunc, ultrices eu tincidunt at, dapibus et lectus. Cras magna elit, dignissim eget dignissim nec, interdum et sem.</p>\r\n\r\n<p>Morbi ornare ornare nisi, eget semper velit tempus eget. Fusce vitae ipsum nisl, eget viverra enim. Sed aliquam placerat mauris. Quisque et magna vel tortor rhoncus sagittis ac eu neque. Maecenas interdum pharetra quam at sollicitudin. Nunc metus libero, imperdiet at ullamcorper a, faucibus sed quam. Morbi non molestie metus. Cras viverra justo non nisi accumsan eget mattis ligula tempor. Nam varius, quam a iaculis sodales, dui mauris aliquet nibh, sit amet faucibus justo nibh et dolor. Vestibulum nec nisl et mi pulvinar semper sit amet nec eros.</p>\r\n\r\n<p>Nullam eu purus massa. Ut sed cursus nibh. Praesent vulputate odio aliquet odio auctor volutpat. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Aenean dictum luctus neque a molestie. Suspendisse convallis feugiat turpis, sit amet lacinia quam gravida in. Mauris sollicitudin lacus a felis accumsan molestie. Aliquam vehicula eros quis leo placerat mattis. Donec sodales eros quis mauris luctus porttitor. Quisque orci eros, consectetur ac sodales euismod, posuere ut massa. Suspendisse vel felis ante, at dignissim tellus. Nam id pharetra purus. Nullam viverra, odio nec scelerisque aliquam, massa metus porttitor diam, id ullamcorper turpis dolor vitae leo. Vestibulum mattis congue lorem, in placerat mi pharetra at. Nullam in diam massa, vitae ultricies leo. Ut elementum, nisl sed blandit dignissim, justo lacus rutrum ligula, ut luctus est neque ut nulla.</p> ', 1, 20, 50),
(2, 'contacts', '<p>agle не способен подключаться к сотовым сетям или сетям Wi-Fi, однако в устройстве есть модуль Bluetooth. Это позволяет пользователю отправлять на читалку книги с компьютера, со смартфона или с планшета.\r\n\r\nЕще одна особенности немецкой читалки - элементы питания: Beagle работает от двух батареек типоразмера AAA. Они помещаются в "утолщение" в нижней части устройства. Менять батарейки пользователю придется реже, чем раз в год, утверждает производитель.\r\n\r\nTxtr назвала цену устройств (9,9 евро), однако не уточнила, когда именно Beagle поступит в продажу. Известно, что читалку можно будет купить в Европе. Компания также рассматривает возможность поставлять устройство в Азию и в США.\r\n\r\nЭкраны на электронных чернилах, которые используются в большинстве читалок, расходуют электроэнергию только в момент обновления изображения - в частности, при перелистывании страницы. Благодаря этому устройства с такими экранами могут работать от батареи гораздо дольше, чем устройства с ЖК-экранами.</p>', 1, 20, 50),
(3, 'services', '<p>События, о которых пойдёт речь, точнее - явная сторона этих событий, как кажется, хорошо известны, детально изучены и приобрели колоссальное значение во всех аспектах жизни человечества.\r\n\r\nПроизойдя почти две тысячи лет назад, они приобрели и историческое, и научное, и философское, и культовое значение такой пронзительной мощности, что сегодня уже, в общем-то, и не важно, какова была их истинная подоплёка. Так, механизм зарождения космического тела, предположительно обрушившегося на Землю 65 миллионов лет назад и вызвавшего гигантские биологические сдвиги на нашей планете, не имеет для нас существенного значения в сравнении с этими последствиями1 .\r\n\r\nОднако, как ни курьёзно это звучит, но о событиях относительно столь недавних (подумаешь - 2000 лет! - всего лишь 25 человек, проживших один за другим по 80 лет) свидетельств очевидцев почти так же мало как о событиях доисторического периода. За пределами христианского предания о них почти не упоминается, а само это предание проходило столько редакционно-цензурных переработок, доработок, чисток, переводов, что даже явная сторона событий допускает известную вольность трактовок.</p>', 1, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблиці `public_users`
--

DROP TABLE IF EXISTS `public_users`;
CREATE TABLE IF NOT EXISTS `public_users` (
  `u_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_f_user_id` int(11) NOT NULL DEFAULT '0',
  `u_name` varchar(60) DEFAULT NULL,
  `u_soname` varchar(100) DEFAULT NULL,
  `u_gender` int(11) DEFAULT NULL,
  `u_timeset` int(11) DEFAULT NULL,
  `u_settings` text,
  `read_level` int(11) NOT NULL DEFAULT '0',
  `write_level` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `u_id` (`u_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Дамп даних таблиці `public_users`
--

INSERT INTO `public_users` (`u_id`, `u_f_user_id`, `u_name`, `u_soname`, `u_gender`, `u_timeset`, `u_settings`, `read_level`, `write_level`, `owner`) VALUES
(1, 0, 'link', 'One', 2, NULL, NULL, 0, 0, 0),
(2, 0, 'link', '<a href="link;">(link)</a>', NULL, 1, NULL, 0, 0, 0),
(3, 0, 'new_link', '<a href="link;">(link)</a>', NULL, 2, NULL, 40, 41, 0),
(4, 0, 'link', '/^(([^<>()[].,;:s@"]+(.[^<>()[].,;:s@"]+)*)|(".+"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])', 2, NULL, NULL, 0, 0, 0),
(5, 0, 'link', '/^(([^<>()[].,;:s@"]+(.[^<>()[].,;:s@"]+)*)|(".+"))@(([[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}])', NULL, 1, NULL, 0, 0, 0),
(6, 0, 'link', '/^(([^<>()[].,;:s@', NULL, 2, NULL, 0, 0, 0),
(7, 0, 'link', 'wewewewe', 9, 2, NULL, 0, 0, 0),
(8, 0, ': ', 'wewewewe', 2, NULL, NULL, 0, 50, 0),
(9, 0, ': ', 'wewewewe', 2, NULL, NULL, 0, 0, 0),
(10, 0, ':', 'wewewewe', NULL, NULL, NULL, 0, 0, 0),
(23, 19, 'Евгений308', 'evgen@u.com', 2, 1, NULL, 10, 91, 19),
(19, 13, 'Евгений ЛИСИН', 'evgen@u.com', 2, 1, '13', 40, 41, 13);

-- --------------------------------------------------------

--
-- Структура таблиці `syst_column_types`
--

DROP TABLE IF EXISTS `syst_column_types`;
CREATE TABLE IF NOT EXISTS `syst_column_types` (
  `sct_id` int(11) NOT NULL AUTO_INCREMENT,
  `sct_alias` varchar(255) DEFAULT NULL,
  `sct_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sct_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Column type definitions for create_table function' AUTO_INCREMENT=8 ;

--
-- Дамп даних таблиці `syst_column_types`
--

INSERT INTO `syst_column_types` (`sct_id`, `sct_alias`, `sct_type`) VALUES
(1, 'json', 'TEXT'),
(2, 'id', 'INT(11)'),
(3, 'pass', 'VARCHAR(100)'),
(4, 'email', 'VARCHAR(50)'),
(5, 'phone', 'VARCHAR(50)'),
(6, 'edit', 'VARCHAR(250)'),
(7, 'textarea', 'TEXT');

-- --------------------------------------------------------

--
-- Структура таблиці `syst_defs_columns`
--

DROP TABLE IF EXISTS `syst_defs_columns`;
CREATE TABLE IF NOT EXISTS `syst_defs_columns` (
  `def_id` int(11) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) DEFAULT NULL,
  `field_name` varchar(45) DEFAULT NULL,
  `field_type` varchar(45) DEFAULT NULL,
  `field_href` varchar(100) DEFAULT NULL,
  `field_require` tinyint(1) NOT NULL DEFAULT '0',
  `field_uniq` tinyint(1) NOT NULL DEFAULT '0',
  `field_caption` varchar(100) DEFAULT NULL,
  `field_read_level` smallint(6) DEFAULT NULL,
  `field_write_level` smallint(6) DEFAULT NULL,
  `field_order` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`def_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=54 ;

--
-- Дамп даних таблиці `syst_defs_columns`
--

INSERT INTO `syst_defs_columns` (`def_id`, `table_name`, `field_name`, `field_type`, `field_href`, `field_require`, `field_uniq`, `field_caption`, `field_read_level`, `field_write_level`, `field_order`) VALUES
(52, 'public_users', 'u_gender', 'radio', 'dict_genders', 0, 0, 'Gender', 0, 20, 6),
(3, 'public_main_menu', 'menu_item_name', 'edit', NULL, 0, 0, 'menu_item_name', 0, 50, 0),
(4, 'public_main_menu', 'menu_item_link', 'edit', NULL, 0, 0, 'menu_item_link', 0, 50, 0),
(5, 'public_main_menu', 'owner', 'id', NULL, 0, 0, 'owner', 80, 50, 0),
(6, 'public_static_pages', 'static_page_id', 'id', NULL, 0, 0, 'id', 20, 50, 0),
(7, 'public_static_pages', 'static_page_alias', 'edit', NULL, 0, 0, 'alias', 0, 50, 0),
(8, 'public_static_pages', 'static_page_text', 'text', NULL, 0, 0, 'text', 0, 50, 0),
(10, 'public_categories', 'cat_id', 'id', NULL, 0, 0, 'id', 0, 80, 0),
(11, 'public_categories', 'cat_name', 'edit', NULL, 0, 0, 'name', 0, 80, 0),
(12, 'public_categories', 'cat_alias', 'edit', NULL, 0, 0, 'alias', 0, 80, 0),
(13, 'public_categories', 'cat_parent_id', 'id', NULL, 0, 0, 'parent_id', 0, 80, 0),
(14, 'public_articles', 'article_id', 'id', NULL, 0, 0, 'id', 0, 50, 0),
(15, 'public_articles', 'article_name', 'edit', NULL, 0, 0, 'name', 0, 50, 0),
(16, 'public_articles', 'article_alias', 'edit', NULL, 0, 0, 'alias', 0, 50, 0),
(17, 'public_articles', 'article_text', 'edit', NULL, 0, 0, 'text', 0, 50, 0),
(18, 'hrefs_articles_to_categories', 'href_cat_id', 'id', NULL, 0, 0, 'cat_id', 0, 50, 0),
(19, 'hrefs_articles_to_categories', 'href_article_id', 'id', NULL, 0, 0, 'article_id', 0, 50, 0),
(42, 'public_users', 'u_id', 'id', NULL, 0, 0, 'id', 0, 90, 1),
(43, 'public_users', 'u_name', 'edit', NULL, 0, 0, 'Name', 0, 40, 3),
(44, 'public_users', 'u_soname', 'email', NULL, 0, 0, 'Soname', 0, 40, 4),
(45, 'public_users', 'u_settings', 'json', NULL, 1, 0, NULL, 0, 40, 5),
(46, 'public_users', 'u_f_user_id', 'id', NULL, 0, 1, NULL, 0, 40, 2),
(53, 'public_users', 'u_timeset', 'select', 'dict_timesets', 0, 0, 'Timezones', 0, 20, 7);

-- --------------------------------------------------------

--
-- Структура таблиці `syst_defs_tables`
--

DROP TABLE IF EXISTS `syst_defs_tables`;
CREATE TABLE IF NOT EXISTS `syst_defs_tables` (
  `tbl_def_id` int(11) NOT NULL AUTO_INCREMENT,
  `table_name` varchar(100) NOT NULL,
  `table_read_level` int(11) NOT NULL,
  `table_write_level` int(11) NOT NULL,
  `table_insert_level` int(11) NOT NULL DEFAULT '0',
  `table_delete_level` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tbl_def_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Дамп даних таблиці `syst_defs_tables`
--

INSERT INTO `syst_defs_tables` (`tbl_def_id`, `table_name`, `table_read_level`, `table_write_level`, `table_insert_level`, `table_delete_level`) VALUES
(4, 'public_users', 10, 50, 40, 50);

-- --------------------------------------------------------

--
-- Структура таблиці `syst_groups`
--

DROP TABLE IF EXISTS `syst_groups`;
CREATE TABLE IF NOT EXISTS `syst_groups` (
  `group_id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(255) NOT NULL,
  `group_read_level` int(11) NOT NULL,
  `group_write_level` int(11) NOT NULL,
  PRIMARY KEY (`group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп даних таблиці `syst_groups`
--

INSERT INTO `syst_groups` (`group_id`, `group_name`, `group_read_level`, `group_write_level`) VALUES
(1, 'super_administrators', 100, 100),
(2, 'administrators', 90, 90),
(3, 'guests', 20, 20),
(4, 'users', 40, 40),
(5, 'clients', 60, 60),
(6, 'managers', 80, 80);

-- --------------------------------------------------------

--
-- Структура таблиці `syst_sessions`
--

DROP TABLE IF EXISTS `syst_sessions`;
CREATE TABLE IF NOT EXISTS `syst_sessions` (
  `sess_id` int(11) NOT NULL AUTO_INCREMENT,
  `sess_f_user_id` int(11) NOT NULL DEFAULT '0',
  `sess_user_token` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `sess_user_last_ip` varchar(15) NOT NULL,
  `sess_user_data` text,
  `sess_user_last_activity` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`sess_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=379 ;

--
-- Дамп даних таблиці `syst_sessions`
--

INSERT INTO `syst_sessions` (`sess_id`, `sess_f_user_id`, `sess_user_token`, `sess_user_last_ip`, `sess_user_data`, `sess_user_last_activity`) VALUES
(378, 0, '7a36db4f9e16bfd7600c5f59409edade', '127.0.0.1', 'NLFix/gKE6uLx0ZrbeqHGvedFu2RS5jvKUNU7XzxdCb69dGtkFJRmV++dkdK9e8HAyNCKgfjg7Cym/agVFl/gA', '2013-07-25 15:29:46');

-- --------------------------------------------------------

--
-- Структура таблиці `syst_settings`
--

DROP TABLE IF EXISTS `syst_settings`;
CREATE TABLE IF NOT EXISTS `syst_settings` (
  `sett_id` int(11) NOT NULL AUTO_INCREMENT,
  `sett_session_time` varchar(20) NOT NULL,
  `sett_session_last` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sett_user_token_time` varchar(20) NOT NULL,
  `sett_passw_salt` varchar(50) NOT NULL,
  PRIMARY KEY (`sett_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп даних таблиці `syst_settings`
--

INSERT INTO `syst_settings` (`sett_id`, `sett_session_time`, `sett_session_last`, `sett_user_token_time`, `sett_passw_salt`) VALUES
(1, '2:15:0.0', '2013-07-25 14:53:53', '1:05:0.0', 'ababagalamaga');

-- --------------------------------------------------------

--
-- Структура таблиці `syst_users`
--

DROP TABLE IF EXISTS `syst_users`;
CREATE TABLE IF NOT EXISTS `syst_users` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_login` varchar(150) DEFAULT NULL,
  `user_email` varchar(100) DEFAULT NULL,
  `user_pass` varchar(255) NOT NULL,
  `user_is_active` tinyint(1) NOT NULL DEFAULT '1',
  `user_f_group_id` int(11) NOT NULL DEFAULT '4',
  `user_reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_login` (`user_login`,`user_email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Дамп даних таблиці `syst_users`
--

INSERT INTO `syst_users` (`user_id`, `user_login`, `user_email`, `user_pass`, `user_is_active`, `user_f_group_id`, `user_reg_date`) VALUES
(1, 'admin', 'admin@admin.com', 'abLEFxdWWYR3c', 1, 1, '0000-00-00 00:00:00'),
(2, 'user', 'user@user.com', 'df7f48cfa90519dc72aa72c9c8e869b3', 1, 3, '0000-00-00 00:00:00'),
(3, 'test', 'test@mail', '763259646ecb5234653b19809bacc972', 1, 3, '2013-06-06 07:17:11'),
(5, 'some_user', 'some@some.net', '763259646ecb5234653b19809bacc972', 1, 2, '2013-05-22 13:29:18'),
(6, 'some2_user', 'some2@some.net', 'df7f48cfa90519dc72aa72c9c8e869b3', 0, 2, '2013-05-22 13:35:58'),
(13, '', 'evgen300@i.ua', '763259646ecb5234653b19809bacc972', 1, 4, '2013-06-07 12:15:23'),
(14, '', '12dsd@s.com', '763259646ecb5234653b19809bacc972', 1, 4, '2013-06-19 11:09:23'),
(15, '', 'bers_7771@ukr.net', '35473a09bce53ee3e2ac7d6a0628137b', 1, 2, '2013-07-03 13:15:40'),
(16, '', 'evgen301@i.ua', '763259646ecb5234653b19809bacc972', 1, 2, '2013-07-11 12:03:41'),
(17, '', 'evgen302@i.ua', '763259646ecb5234653b19809bacc972', 1, 2, '2013-07-11 12:10:27'),
(18, '', 'evgen303@i.ua', '3703159c8e9d5b35c4a83bd89636ecb3', 1, 2, '2013-07-11 14:29:20'),
(19, '', 'evgen308@i.ua', '763259646ecb5234653b19809bacc972', 1, 4, '2013-07-12 10:00:00');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
