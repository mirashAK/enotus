-- phpMyAdmin SQL Dump
-- version 4.0.2
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Час створення: Вер 02 2013 р., 14:27
-- Версія сервера: 5.5.30-log
-- Версія PHP: 5.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

-- --------------------------------------------------------

--
-- Структура таблиці `dict_countries`
--

DROP TABLE IF EXISTS `dict_countries`;
CREATE TABLE IF NOT EXISTS `dict_countries` (
  `dict_id` int(11) NOT NULL AUTO_INCREMENT,
  `dict_value` varchar(100) NOT NULL,
  PRIMARY KEY (`dict_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп даних таблиці `dict_countries`
--

INSERT INTO `dict_countries` (`dict_id`, `dict_value`) VALUES
(1, 'ukraine'),
(2, 'russia'),
(3, 'belarus'),
(4, 'germany');

-- --------------------------------------------------------

--
-- Структура таблиці `dict_langs`
--

DROP TABLE IF EXISTS `dict_langs`;
CREATE TABLE IF NOT EXISTS `dict_langs` (
  `dict_id` int(11) NOT NULL AUTO_INCREMENT,
  `dict_value` varchar(20) NOT NULL,
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `dict_id` (`dict_id`),
  KEY `dict_id_2` (`dict_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=11 ;

--
-- Дамп даних таблиці `dict_langs`
--

INSERT INTO `dict_langs` (`dict_id`, `dict_value`) VALUES
(9, 'ru'),
(2, 'uk'),
(10, 'en');

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
-- Структура таблиці `public_companies`
--

DROP TABLE IF EXISTS `public_companies`;
CREATE TABLE IF NOT EXISTS `public_companies` (
  `pc_id` int(11) NOT NULL AUTO_INCREMENT,
  `pc_name` varchar(255) NOT NULL,
  `pc_city` varchar(255) NOT NULL,
  `pc_adress` text NOT NULL,
  `pc_okpo` varchar(100) NOT NULL,
  `pc_account` varchar(100) NOT NULL,
  `pc_mfo` varchar(100) NOT NULL,
  `pc_bank` varchar(255) NOT NULL,
  `pc_phones` text NOT NULL,
  `read_level` int(11) NOT NULL,
  `write_level` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  PRIMARY KEY (`pc_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Дамп даних таблиці `public_companies`
--

INSERT INTO `public_companies` (`pc_id`, `pc_name`, `pc_city`, `pc_adress`, `pc_okpo`, `pc_account`, `pc_mfo`, `pc_bank`, `pc_phones`, `read_level`, `write_level`, `owner`) VALUES
(16, 'ФОП Васильченко123', 'Днепропетровск', '', '3242334234343', '343434', '343434', 'ПриватБанк', '["+386766767676"]', 10, 21, 25),
(14, 'ФОП Евгений', 'Севастополь', 'ул. Глухова 1 кв 79', '3242334234343', '343434', '343434', 'ПриватБанк', '', 10, 21, 27),
(13, 'ФОП Васильченко', 'Днепропетровск', '', '', '', '', '', '', 10, 21, 26);

-- --------------------------------------------------------

--
-- Структура таблиці `public_menus`
--

DROP TABLE IF EXISTS `public_menus`;
CREATE TABLE IF NOT EXISTS `public_menus` (
  `menu_id` int(11) NOT NULL AUTO_INCREMENT,
  `menu_item_name` varchar(100) NOT NULL,
  `menu_item_link` varchar(255) NOT NULL,
  `menu_item_parent` int(11) NOT NULL DEFAULT '0',
  `menu_item_order` int(11) NOT NULL DEFAULT '0',
  `read_level` int(11) NOT NULL,
  `write_level` int(11) NOT NULL,
  `owner` int(11) NOT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=20 ;

--
-- Дамп даних таблиці `public_menus`
--

INSERT INTO `public_menus` (`menu_id`, `menu_item_name`, `menu_item_link`, `menu_item_parent`, `menu_item_order`, `read_level`, `write_level`, `owner`) VALUES
(1, 'main_menu', '', 0, 0, 0, 80, 1),
(2, 'bottom_menu', '', 0, 0, 0, 80, 1),
(3, 'menu_item_documents_base', 'documents', 1, 1, 0, 80, 1),
(4, 'menu_item_about', 'about', 1, 2, 0, 80, 1),
(5, 'menu_item_tariffs', 'tariffs', 1, 3, 0, 80, 1),
(6, 'menu_item_faq', 'faq', 1, 4, 0, 80, 1),
(11, 'system_registration', 'auth/reg', 8, 0, 0, 80, 1),
(7, 'menu_item_contacts', 'contacts', 1, 5, 0, 80, 1),
(9, 'menu_item_first', 'documents/first', 3, 0, 0, 80, 1),
(8, 'system_links', '', 0, 0, 0, 80, 1),
(10, 'menu_item_second', 'documents/first/second', 9, 0, 0, 80, 1),
(12, 'system_logout', 'auth/logout', 8, 0, 0, 80, 1),
(13, 'user_menu', '', 0, 0, 0, 80, 1),
(14, 'system_restore_pass', 'auth/restoration', 8, 0, 0, 80, 1),
(15, 'system_change_pass', 'auth/change_pass', 8, 0, 0, 80, 1),
(16, 'menu_item_user_journal', 'user/journal', 13, 0, 20, 80, 1),
(17, 'menu_item_user_tariff', 'user/tariff', 13, 0, 20, 80, 1),
(18, 'menu_item_user_history', 'user/history', 13, 0, 20, 80, 1),
(19, 'menu_item_user_settings', 'user/settings', 13, 0, 20, 80, 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

--
-- Дамп даних таблиці `public_static_pages`
--

INSERT INTO `public_static_pages` (`static_page_id`, `static_page_alias`, `static_page_text`, `owner`, `read_level`, `write_level`) VALUES
(4, 'documents', '<h1 class="_fleft no-bottom">База документов</h1>\r\n\r\n<ul class="filters _fright -in-heading">\r\n    <li class="is-active" data-role="filter" data-option="alphabet"><span>по алфавиту</span></li>\r\n    <li data-role="filter" data-option="popularity"><span >по популярности</span></li>\r\n    <li data-role="filter" data-option="availability"><span>доступные</span></li>\r\n</ul>\r\n\r\n\r\n<div class="_cfix"></div>\r\n\r\n<div class="base-sub-heading">показывать документы <a class="drop-link link-choose-country -open" href="#"><span class="title">для всех стран</span><i class="icon icon-choose-country"></i></a></div>\r\n\r\n<div class="main-col">\r\n\r\n\r\n    <div class="control-row search-helper-row doc-base-search">\r\n        <form class="control-cell _prel" action="#" method="post">\r\n            <input type="text" name="search_helper" id="search-helper" class="text search-helper" placeholder="Название документа">\r\n\r\n\r\n            <button class="btn -special link-search" type="submit">\r\n                <i class="icon icon-search"></i>\r\n            </button>\r\n            <span class="clear-search-field icon icon-clear is-hidden" id="clear-search-field" title="Очистить"></span>\r\n        </form>\r\n    </div>\r\n\r\n\r\n    <!-- item -->\r\n    <article class="doc-block">\r\n        <table>\r\n            <tr>\r\n                <td>\r\n                    <h2><a href="#">Доверенность (М2)</a></h2>\r\n\r\n                    <p>\r\n                        документ, выдаваемый одним лицом другому для представительства перед третьим лицом\r\n                    </p>\r\n                </td>\r\n                <td class="doc-desc">\r\n                    <div class="doc-prev">\r\n                        <span class="doc-prev-figure"></span>\r\n                    </div>\r\n                    <div class="doc-type">\r\n                        <b>A4,</b> <br>горизонтальный\r\n                    </div>\r\n                    <div class="_cfix"></div>\r\n                    <p>Вы можете создать документ этого типа.</p>\r\n                    <p><a href="#"><i class="icon icon-doc-ex"></i>Пример документа</a></p>\r\n                </td>\r\n            </tr>\r\n        </table>\r\n        <div class="addition">\r\n            У вас в <a href="#">журнале</a> <b>5</b> документов этого типа.\r\n        </div>\r\n    </article>\r\n    <!-- /item -->\r\n\r\n\r\n    <!-- item -->\r\n    <article class="doc-block is-blocked">\r\n        <table>\r\n            <tr>\r\n                <td>\r\n                    <h2><a href="#">Расходная накладная</a></h2>\r\n\r\n                    <p>\r\n                        документ, используемый при передаче товарно-материальных ценностей от одного лица другому\r\n                    </p>\r\n                </td>\r\n                <td class="doc-desc">\r\n                    <div class="doc-prev">\r\n                        <span class="doc-prev-figure is-vertical"></span>\r\n                    </div>\r\n                    <div class="doc-type">\r\n                        <b>A4,</b> <br>вертикальный\r\n                    </div>\r\n                    <div class="_cfix"></div>\r\n                    <p>Создание такого документа не доступно в вашем пакете. \r\n                        <br><a href="#">Улучшить тарифный пакет?</a></p>\r\n                    <p><a href="#"><i class="icon icon-doc-ex"></i>Пример документа</a></p>\r\n                </td>\r\n            </tr>\r\n        </table>\r\n        <div class="addition">\r\n            Вы пока не создавали таких документов.\r\n        </div>\r\n    </article>\r\n    <!-- /item -->\r\n\r\n\r\n    <!-- item -->\r\n    <article class="doc-block">\r\n        <table>\r\n            <tr>\r\n                <td>\r\n                    <h2><a href="#">Расходно-кассовый ордер</a></h2>\r\n\r\n                    <p>\r\n                        денежный документ, которым оформляется кассовая операция по выдаче наличных денег предприятиями, учреждениями\r\n                    </p>\r\n                </td>\r\n                <td class="doc-desc">\r\n                    <div class="doc-prev">\r\n                        <span class="doc-prev-figure"></span>\r\n                    </div>\r\n                    <div class="doc-type">\r\n                        <b>A5,</b> <br>горизонтальный\r\n                    </div>\r\n                    <div class="_cfix"></div>\r\n                    <p>Вы можете создать документ этого типа.</p>\r\n                    <p><a href="#"><i class="icon icon-doc-ex"></i>Пример документа</a></p>\r\n                </td>\r\n            </tr>\r\n        </table>\r\n        <div class="addition">\r\n            У вас в <a href="#">журнале</a> <b>12</b> документов этого типа.\r\n        </div>\r\n    </article>\r\n    <!-- /item -->\r\n\r\n\r\n    <!-- item -->\r\n    <article class="doc-block is-blocked">\r\n        <table>\r\n            <tr>\r\n                <td>\r\n                    <h2><a href="#">Приходно-кассовый ордер</a></h2>\r\n\r\n                    <p>\r\n                        документ первичной учетной документации кассовых операций, по которому производится прием средств в кассу организации\r\n                    </p>\r\n                </td>\r\n                <td class="doc-desc">\r\n                    <div class="doc-prev">\r\n                        <span class="doc-prev-figure is-vertical"></span>\r\n                    </div>\r\n                    <div class="doc-type">\r\n                        <b>A4,</b> <br>вертикальный\r\n                    </div>\r\n                    <div class="_cfix"></div>\r\n                    <p>Создание такого документа не доступно в вашем пакете. \r\n                        <br><a href="#">Улучшить тарифный пакет?</a></p>\r\n                    <p><a href="#"><i class="icon icon-doc-ex"></i>Пример документа</a></p>\r\n                </td>\r\n            </tr>\r\n        </table>\r\n        <div class="addition">\r\n            У вас в <a href="#">журнале</a> <b>7</b> документов этого типа.\r\n        </div>\r\n    </article>\r\n    <!-- /item -->\r\n\r\n\r\n    <!-- item -->\r\n    <article class="doc-block is-blocked">\r\n        <table>\r\n            <tr>\r\n                <td>\r\n                    <h2><a href="#">Cчет (на оплату)</a></h2>\r\n\r\n                    <p>\r\n                        документ, содержащий платежные реквизиты получателя, по которым плательщик осуществляет безналичный перевод денежных средств за перечисленные товары и (или) услуги\r\n                    </p>\r\n                </td>\r\n                <td class="doc-desc">\r\n                    <div class="doc-prev">\r\n                        <span class="doc-prev-figure is-vertical"></span>\r\n                    </div>\r\n                    <div class="doc-type">\r\n                        <b>A5,</b> <br>вертикальный\r\n                    </div>\r\n                    <div class="_cfix"></div>\r\n                    <p>Вы создали максимальное количество таких документов, доступное в вашем пакете.\r\n                        <br><a href="#">Улучшить тарифный пакет?</a></p>\r\n                    <p><a href="#"><i class="icon icon-doc-ex"></i>Пример документа</a></p>\r\n                </td>\r\n            </tr>\r\n        </table>\r\n        <div class="addition">\r\n            У вас в <a href="#">журнале</a> <b>5</b> документов этого типа.\r\n        </div>\r\n    </article>\r\n    <!-- /item -->\r\n\r\n\r\n    <!-- pagination [ -->\r\n    <div class="pagination">\r\n        <ul>\r\n            <li class="edge"><a href="#p-first">первая</a></li>\r\n            <li class="controls-prev icon icon-prev"><a href="#p-prev">предыдущая</a></li>\r\n            <li><a href="#p-1">1</a></li>\r\n            <li class="is-current"><span>2</span></li>\r\n            <li><a href="#p-3">3</a></li>\r\n            <li><a href="#p-4">4</a></li>\r\n            <li><a href="#p-5">5</a></li>\r\n            <li class="controls-next icon icon-next"><a href="#p-next">следующая</a></li>\r\
n            <li class="edge"><a href="#p-last">последняя</a></li>\r\n        </ul>\r\n    </div>\r\n    <!-- ] pagination -->\r\n\r\n\r\n</div>\r\n\r\n<div class="side-col">\r\n    <div class="stiped-wrap" data-spy="affix" data-offset-top="200">\r\n        <div class="striped -type-2">\r\n            <div class="striped-inner">\r\n                <h2>\r\n                    Ваш тарифный пакет <a href="#">Light</a>\r\n                </h2>\r\n\r\n                <p>\r\n                    <a href="#"><i class="icon icon-doc-clip"></i>Журнал документов</a>\r\n                </p>\r\n\r\n                <p>\r\n                    В этом месяце вы можете создать еще <b>4</b> документа.\r\n                </p>\r\n\r\n                <div class="doc-counter">\r\n                    <span class="doc-counter-item is-active"></span>\r\n                    <span class="doc-counter-item is-active"></span>\r\n                    <span class="doc-counter-item is-active"></span>\r\n                    <span class="doc-counter-item is-active"></span>\r\n                    <span class="doc-counter-item"></span>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n</div>\r\n\r\n<div class="_cfix"></div>', 1, 0, 50),
(7, 'faq', '<h1>Наиболее часто задаваемые вопросы</h1>\r\n\r\n<!-- collapsible block [ -->\r\n<div class="acc-block">\r\n    <div class="acc-head js-acc-head">\r\n        <h2>Как сохранить документ в образцы?</h2><i class="acc-head-arrow"></i>\r\n    </div>\r\n\r\n    <div class="acc-text js-acc-text">\r\n        <p>\r\n            Для того, чтобы сохранить документ в образцы, отметьте соответстующий чекбокс внизу формы документа, придумайте название образца, по которому вы сможете его опознать, и создайте документ. Форма будет автоматически сохранена на ваш компьютер и в образцы. В следующий раз вы сможете просто выбрать этот образец, все поля будут заполнены автоматически, согласно заполнению, присутствовавшему при сохранении.\r\n        </p>\r\n    </div>\r\n</div>\r\n<!-- ] collapsible block -->\r\n\r\n\r\n<!-- collapsible block [ -->\r\n<div class="acc-block">\r\n    <div class="acc-head js-acc-head">\r\n        <h2>Как создать документ?</h2><i class="acc-head-arrow"></i>\r\n    </div>\r\n\r\n    <div class="acc-text js-acc-text">\r\n        <p>\r\n            Для того, чтобы сохранить документ в образцы, отметьте соответстующий чекбокс внизу формы документа, придумайте название образца, по которому вы сможете его опознать, и создайте документ. Форма будет автоматически сохранена на ваш компьютер и в образцы. В следующий раз вы сможете просто выбрать этот образец, все поля будут заполнены автоматически, согласно заполнению, присутствовавшему при сохранении.\r\n        </p>\r\n    </div>\r\n</div>\r\n<!-- ] collapsible block -->\r\n\r\n\r\n<!-- collapsible block [ -->\r\n<div class="acc-block">\r\n    <div class="acc-head js-acc-head">\r\n        <h2>Как связаться с нами?</h2><i class="acc-head-arrow"></i>\r\n    </div>\r\n\r\n    <div class="acc-text js-acc-text">\r\n        <p>\r\n            На странице <a href="#">контактная информация</a> есть форма обратной связи. Заполните все поля.\r\n        </p>\r\n    </div>\r\n</div>\r\n<!-- ] collapsible block -->\r\n\r\n\r\n<!-- collapsible block [ -->\r\n<div class="acc-block">\r\n    <div class="acc-head js-acc-head">\r\n        <h2>Как зарегистрироваться?</h2><i class="acc-head-arrow"></i>\r\n    </div>\r\n\r\n    <div class="acc-text js-acc-text">\r\n        <p>\r\n            Для того, чтобы сохранить документ в образцы, отметьте соответстующий чекбокс внизу формы документа, придумайте название образца, по которому вы сможете его опознать, и создайте документ. Форма будет автоматически сохранена на ваш компьютер и в образцы. В следующий раз вы сможете просто выбрать этот образец, все поля будут заполнены автоматически, согласно заполнению, присутствовавшему при сохранении.\r\n        </p>\r\n    </div>\r\n</div>\r\n<!-- ] collapsible block -->\r\n\r\n\r\n<!-- collapsible block [ -->\r\n<div class="acc-block">\r\n    <div class="acc-head js-acc-head">\r\n        <h2>Как платить?</h2><i class="acc-head-arrow"></i>\r\n    </div>\r\n\r\n    <div class="acc-text js-acc-text">\r\n        <p>\r\n            Для того, чтобы сохранить документ в образцы, отметьте соответстующий чекбокс внизу формы документа, придумайте название образца, по которому вы сможете его опознать, и создайте документ. Форма будет автоматически сохранена на ваш компьютер и в образцы. В следующий раз вы сможете просто выбрать этот образец, все поля будут заполнены автоматически, согласно заполнению, присутствовавшему при сохранении.\r\n        </p>\r\n    </div>\r\n</div>\r\n<!-- ] collapsible block -->', 1, 0, 50),
(5, 'about', '<h1>О проекте</h1>\r\n\r\n<p>Продолжая до бесконечности ряд 1, 2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31 и т.д., имеем высшая арифметика трансформирует неопределенный интеграл, как и предполагалось. Частная производная, очевидно, стремится к нулю. Нормаль к поверхности синхронизирует скачок функции, таким образом сбылась мечта идиота - утверждение полностью доказано. Математическая статистика отрицательна. В соответствии с законом больших чисел, мнимая единица привлекает коллинеарный неопределенный интеграл, что и требовалось доказать.\r\n</p>\r\n\r\n<h2>Как тут все работает</h2>\r\n\r\n<p>Сравнивая две формулы, приходим к следующему заключению: математический анализ правомочен. Прямоугольная матрица отображает предел последовательности, в итоге приходим к логическому противоречию. Умножение двух векторов (скалярное) изящно проецирует предел последовательности, что и требовалось доказать. Поэтому геодезическая линия небезынтересно поддерживает эмпирический интеграл от функции комплексной переменной, что и требовалось доказать. Интеграл по ориентированной области, исключая очевидный случай, основан на тщательном анализе.\r\n</p>\r\n\r\n<h3>\r\n    Кому поможет Енотус\r\n</h3>\r\n\r\n<p>Сходящийся ряд транслирует ряд Тейлора, как и предполагалось. Открытое множество порождает нормальный неопределенный интеграл, таким образом сбылась мечта идиота - утверждение полностью доказано. Критерий интегрируемости изящно определяет линейно зависимый интеграл от функции, обращающейся в бесконечность в изолированной точке, откуда следует доказываемое равенство. Математическое моделирование однозначно показывает, что ротор векторного поля допускает интеграл Дирихле, что несомненно приведет нас к истине.\r\n</p>\r\n\r\n<dl>\r\n    <dt><h4><b class="hl">1.</b> Зарегистрируйтесь</h4></dt>\r\n    <dd>Комплексное число нейтрализует лист Мёбиуса, что неудивительно. Умножение вектора на число тривиально. Поле направлений проецирует изоморфный максимум, что и требовалось доказать. Геометрическая прогрессия оправдывает интеграл Фурье, что и требовалось доказать.</dd>\r\n\r\n    <dt><h4><b class="hl">2.</b> Найдите документ</h4></dt>\r\n    <dd>Уравнение в частных производных позитивно трансформирует интеграл по бесконечной области, что несомненно приведет нас к истине.</dd>\r\n</dl>', 1, 0, 50),
(6, 'tariffs', '<h1>Тарифы</h1>\r\n\r\n<!-- tariffs [ -->\r\n<div class="tariffs-list _cfix">\r\n\r\n\r\n    <!-- item [ -->\r\n    <div class="tariffs-item -light stiped-wrap">\r\n        <div class="striped -type-2">\r\n            <div class="striped-inner">\r\n                <div class="tariffs-item-head">\r\n                    <div>Тарифный пакет</div>\r\n                    <div class="name colorize">Light<span class="current-tariff">Ваш пакет</span></div>\r\n                </div>\r\n\r\n\r\n                <div class="tariff-body">\r\n                    <div class="tariff-features">\r\n                        <i class="icon icon-features"></i>\r\n                        <span class="colorize">Состав пакета:</span> позволяет создать 5 документов разных типов в месяц, сохранять и работать с созданными документами без ограничения по времени.\r\n                    </div>\r\n\r\n\r\n                    <div class="tariff-cost">\r\n                        <i class="icon icon-cost"></i>\r\n                        <span class="colorize">Стоимость пакета:</span> бесплатно.\r\n                    </div>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n    <!-- ] item -->\r\n\r\n    <!-- item [ -->\r\n    <div class="tariffs-item -optima stiped-wrap">\r\n        <div class="striped -type-3">\r\n            <div class="striped-inner">\r\n                <div class="tariffs-item-head">\r\n                    <div>Тарифный пакет</div>\r\n                    <div class="name colorize">Optima<span class="current-tariff">Ваш пакет</span></div>\r\n                </div>\r\n\r\n\r\n                <div class="tariff-body">\r\n                    <div class="tariff-features">\r\n                        <i class="icon icon-features"></i>\r\n                        <span class="colorize">Состав пакета:</span> неограниченное количество операций по созданию и работе с документами в течение месяца.\r\n                    </div>\r\n\r\n\r\n                    <div class="tariff-cost">\r\n                        <i class="icon icon-cost"></i>\r\n                        <span class="colorize">Стоимость пакета:</span> 50 грн в месяц.\r\n                    </div>\r\n                </div>\r\n\r\n\r\n                <div class="tariff-footer">\r\n                    <button type="button" class="btn -primary">Оплатить пакет</button>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n    <!-- ] item -->\r\n\r\n\r\n    <!-- item [ -->\r\n    <div class="tariffs-item -group is-disabled stiped-wrap">\r\n        <div class="striped -type-4">\r\n            <div class="striped-inner">\r\n                <div class="tariffs-item-head">\r\n                    <div>Тарифный пакет</div>\r\n                    <div class="name colorize">Group<span class="current-tariff">Ваш пакет</span></div>\r\n                </div>\r\n\r\n\r\n                <div class="tariff-body">\r\n                    <div class="tariff-features">\r\n                        <i class="icon icon-features"></i>\r\n                        <span class="colorize">Состав пакета:</span> неограниченное количество операций по созданию и работе с документами в течение месяца.\r\n                    </div>\r\n\r\n\r\n                    <div class="tariff-cost">\r\n                        <i class="icon icon-cost"></i>\r\n                        <span class="colorize">Стоимость пакета:</span> 50 грн в месяц.\r\n                    </div>\r\n                </div>\r\n\r\n\r\n                <div class="tariff-footer">\r\n                    <div class="warning"><i class="icon icon-warning"></i>Пакет находится в разработке</div>\r\n                </div>\r\n            </div>\r\n        </div>\r\n    </div>\r\n    <!-- ] item -->\r\n</div>\r\n<!-- ] tariffs -->', 1, 0, 50),
(8, 'contacts', '<h1>Контактная информация</h1>\r\n\r\n<div class="stiped-wrap form-contact">\r\n    <div class="striped -type-1">\r\n        <div class="striped-inner">\r\n            <form action="" method="post" class="form">\r\n                <h2>Обратная связь</h2>\r\n\r\n                <p class="form-legend">\r\n                    вы можете связаться с нами, заполнив эту форму, все поля формы обязательны к заполнению\r\n                </p>\r\n\r\n                <div class="control-row">\r\n                    <div class="control-cell _fleft">\r\n                        <label>\r\n                            Ваше имя:<br>\r\n                            <input type="text" name="name" id="name" class="text required" value="Евгения">\r\n                        </label>\r\n                    </div>\r\n\r\n                    <div class="control-cell _fleft">\r\n                        <label>\r\n                            E-mail:<br>\r\n                            <input type="text" name="email" id="email" class="text email required" value="possumwood@gmail.com">\r\n                        </label>\r\n                    </div>\r\n\r\n                    <div class="_cfix"></div>\r\n                </div>\r\n\r\n                <div class="control-row">\r\n                    <div class="control-cell">\r\n                        <label>\r\n                            Ваш вопрос:<br>\r\n                            <textarea name="contact" id="contact" class="required">Можно ли добавить на сайт транспортную накладную?</textarea>\r\n                        </label>\r\n                    </div>\r\n                </div>\r\n\r\n                <div class="control-row captcha">\r\n                    <img src="media/captcha.jpg" title="Введите символы с изображения">\r\n                </div>\r\n\r\n                <div class="control-row">\r\n                    <div class="control-cell">\r\n                        <label>\r\n                            Проверочный код:<br>\r\n                            <input type="text" name="captcha_code" id="captcha-code" class="text captcha-code" value="1569">\r\n                        </label>\r\n                    </div>\r\n                </div>\r\n\r\n                <div class="control-row">\r\n                    <div class="control-cell">\r\n                        <button type="submit" class="btn -primary">Отправить</button>\r\n                        <button type="reset" class="btn">Очистить</button>\r\n                    </div>\r\n                </div>\r\n            </form>\r\n        </div>\r\n    </div>\r\n</div>', 1, 0, 50);

-- --------------------------------------------------------

--
-- Структура таблиці `public_users`
--

DROP TABLE IF EXISTS `public_users`;
CREATE TABLE IF NOT EXISTS `public_users` (
  `u_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_f_user_id` int(11) NOT NULL DEFAULT '0',
  `u_name` varchar(255) DEFAULT NULL,
  `u_f_company` int(11) NOT NULL,
  `u_f_country` int(11) DEFAULT NULL,
  `u_lang` varchar(2) DEFAULT 'ru',
  `u_settings` text,
  `read_level` int(11) NOT NULL DEFAULT '0',
  `write_level` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `u_id` (`u_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Дамп даних таблиці `public_users`
--

INSERT INTO `public_users` (`u_id`, `u_f_user_id`, `u_name`, `u_f_company`, `u_f_country`, `u_lang`, `u_settings`, `read_level`, `write_level`, `owner`) VALUES
(12, 26, 'Александр', 13, 3, 'ru', NULL, 10, 21, 26),
(11, 25, 'Александр Юрьевич', 16, 2, 'ru', NULL, 10, 21, 25),
(13, 27, 'Евгений', 14, 3, 'ru', NULL, 10, 21, 27);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Column type definitions for create_table function' AUTO_INCREMENT=9 ;

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
(7, 'textarea', 'TEXT'),
(8, 'array', 'TEXT');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=66 ;

--
-- Дамп даних таблиці `syst_defs_columns`
--

INSERT INTO `syst_defs_columns` (`def_id`, `table_name`, `field_name`, `field_type`, `field_href`, `field_require`, `field_uniq`, `field_caption`, `field_read_level`, `field_write_level`, `field_order`) VALUES
(3, 'public_menus', 'menu_item_name', 'edit', NULL, 0, 0, 'menu_item_name', 0, 50, 0),
(4, 'public_menus', 'menu_item_link', 'edit', NULL, 0, 0, 'menu_item_link', 0, 50, 0),
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
(43, 'public_users', 'u_name', 'edit', NULL, 0, 0, 'Name', 0, 20, 3),
(54, 'public_users', 'u_lang', 'edit', NULL, 0, 0, 'Interface', 0, 20, 5),
(45, 'public_users', 'u_settings', 'json', NULL, 0, 0, 'user_settings', 0, 20, 6),
(46, 'public_users', 'u_f_user_id', 'id', NULL, 0, 1, 'user_id', 0, 20, 2),
(53, 'public_users', 'u_f_country', 'select', 'dict_countries', 0, 0, 'Country', 0, 20, 4),
(56, 'public_companies', 'pc_id', 'id', NULL, 0, 0, 'id', 20, 80, 0),
(57, 'public_companies', 'pc_name', 'edit', NULL, 0, 0, 'name', 20, 20, 0),
(58, 'public_companies', 'pc_city', 'edit', NULL, 0, 0, 'city', 20, 20, 0),
(59, 'public_companies', 'pc_adress', 'text', NULL, 0, 0, 'adress', 20, 20, 0),
(60, 'public_companies', 'pc_okpo', 'edit', NULL, 0, 0, 'okpo', 20, 20, 0),
(61, 'public_companies', 'pc_account', 'edit', NULL, 0, 0, 'account', 20, 20, 0),
(62, 'public_companies', 'pc_mfo', 'edit', NULL, 0, 0, 'mfo', 20, 20, 0),
(63, 'public_companies', 'pc_bank', 'edit', NULL, 0, 0, 'bank', 20, 20, 0),
(64, 'public_companies', 'pc_phones', 'array', NULL, 0, 0, 'phones', 20, 20, 0),
(65, 'public_users', 'u_f_company', 'id', 'public_companies', 0, 0, 'company_id', 20, 20, 0);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Дамп даних таблиці `syst_defs_tables`
--

INSERT INTO `syst_defs_tables` (`tbl_def_id`, `table_name`, `table_read_level`, `table_write_level`, `table_insert_level`, `table_delete_level`) VALUES
(4, 'public_users', 10, 50, 40, 50),
(6, 'public_companies', 10, 50, 40, 50);

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
(3, 'guests', 0, 0),
(4, 'users', 20, 20),
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=424 ;

--
-- Дамп даних таблиці `syst_sessions`
--

INSERT INTO `syst_sessions` (`sess_id`, `sess_f_user_id`, `sess_user_token`, `sess_user_last_ip`, `sess_user_data`, `sess_user_last_activity`) VALUES
(420, 25, '3a382541235cf2b4b053efb94c020527', '127.0.0.1', 'b48YxKiNdsk4YE9MAOyRQ7062r0xlTCorys7s1JLg/qT2LARhGkZnJgSMPPbFAUi9ulqpWMzvc+VKtrqmByG3A', '2013-09-02 10:26:55');

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
(1, '2:15:0.0', '2013-09-02 08:51:16', '1:05:0.0', 'ababagalamaga');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=28 ;

--
-- Дамп даних таблиці `syst_users`
--

INSERT INTO `syst_users` (`user_id`, `user_login`, `user_email`, `user_pass`, `user_is_active`, `user_f_group_id`, `user_reg_date`) VALUES
(1, 'admin', 'admin@admin.com', 'abLEFxdWWYR3c', 1, 1, '0000-00-00 00:00:00'),
(25, '', 'bers_000@ukr.net', '763259646ecb5234653b19809bacc972', 1, 4, '2013-08-23 12:12:13'),
(26, 'bers_001@ukr.net', 'bers_001@ukr.net', '3703159c8e9d5b35c4a83bd89636ecb3', 1, 4, '2013-08-28 12:52:07'),
(27, 'bers_002@ukr.net', 'bers_002@ukr.net', '763259646ecb5234653b19809bacc972', 1, 4, '2013-08-29 08:03:10');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
