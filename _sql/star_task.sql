-- phpMyAdmin SQL Dump
-- version 4.0.2
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Час створення: Сер 18 2013 р., 16:22
-- Версія сервера: 5.5.30-log
-- Версія PHP: 5.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База даних: `star_task`
--
CREATE DATABASE IF NOT EXISTS `star_task` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `star_task`;

DELIMITER $$
--
-- Процедури
--
DROP PROCEDURE IF EXISTS `check_uniq`$$
CREATE DEFINER=`root`@`%` PROCEDURE `check_uniq`(IN in_table_name VARCHAR (100), IN in_condition TEXT)
    READS SQL DATA
BEGIN
    
    DECLARE var_query VARCHAR(500) DEFAULT '';  
    
    /* Security checking input values */
    SET in_table_name = clear_input_data(in_table_name);
    SET in_condition = clear_input_data(in_condition);
    
    SET @var_result = NULL;

    SET @query = CONCAT("SELECT COUNT(*) INTO @var_result FROM `", in_table_name, "` WHERE ",in_condition," LIMIT 1;");
    -- SELECT @query;
    PREPARE var_query FROM @query; EXECUTE var_query; DEALLOCATE PREPARE var_query;

    IF (@var_result = 0) THEN SELECT '1' AS is_uniq;
    ELSE SELECT '0' AS is_uniq;
    END IF;

END$$

DROP PROCEDURE IF EXISTS `create_table`$$
CREATE DEFINER=`root`@`%` PROCEDURE `create_table`(IN `in_table_name` VARCHAR(40), IN `in_columns` TEXT, IN `in_sel` TINYINT UNSIGNED, IN `in_upd` TINYINT UNSIGNED, IN `in_ins` TINYINT UNSIGNED, IN `in_del` TINYINT UNSIGNED)
    READS SQL DATA
BEGIN
    DECLARE var_query VARCHAR(255);
    DECLARE var_field_prefix VARCHAR(40) DEFAULT '';
    DECLARE var_creator TEXT DEFAULT '';
    DECLARE var_insertor TEXT DEFAULT '';
    DECLARE var_col_type VARCHAR(40) DEFAULT '';
    DECLARE var_tmp_columns TEXT DEFAULT '';

    DECLARE var_position TINYINT UNSIGNED DEFAULT 1;
    DECLARE var_start TINYINT UNSIGNED DEFAULT 1;

    SET in_table_name = LOWER(in_table_name);
    SET in_columns = CONCAT(TRIM(in_columns),',');

    /* Get fields prefixes */
    SET var_field_prefix = MID(in_table_name, 1, 1);
    WHILE LOCATE('_', in_table_name, var_position) > 0 DO
        SET var_position = LOCATE('_', in_table_name, var_position) + 1;
        SET var_field_prefix = CONCAT(var_field_prefix, MID(in_table_name, var_position, 1));
    END WHILE;

    /*INSERT INTO `syst_defs_columns` (`table_name`,`field_name`,`field_type`,`field_read_level`,`field_write_level`) VALUES (1,2,3),(4,5,6),(7,8,9);*/
    SET var_insertor = CONCAT("('public_",in_table_name,"','",var_field_prefix,"_id','id','id',",in_sel,", 90)");
    
    /* Loop through fields definions and construct CREATE instruction */
    WHILE (LOCATE(',', in_columns, var_start) > 0) DO
        SET var_position = LOCATE(',', in_columns, var_start);
        SET var_tmp_columns = TRIM(MID(in_columns, var_start, var_position - var_start));

        IF (var_tmp_columns != '') THEN IF (LOCATE('=', var_tmp_columns)>0) THEN

            SET var_col_type = SUBSTRING_INDEX(var_tmp_columns, '=', -1);

            /* Construct fields defs for syst_defs_columns */
            SET var_insertor = CONCAT(var_insertor, ",('public_",in_table_name,"','",var_field_prefix,'_',SUBSTRING_INDEX(var_tmp_columns, '=', 1),"','",SUBSTRING_INDEX(var_tmp_columns, '=', 1),"','",var_col_type,"',",in_sel,',',in_upd,')');

            SET @query = CONCAT("SELECT `sct_type` INTO @sct_type FROM `syst_column_types` WHERE `sct_alias` LIKE '", var_col_type,"' LIMIT 1");
            PREPARE var_query FROM @query; EXECUTE var_query; DEALLOCATE PREPARE var_query;
            
            IF (@sct_type IS NOT NULL) THEN SET var_col_type = @sct_type; END IF;

            /* Construct fields defs for targeted table */
            SET var_creator = CONCAT(var_creator,' `',var_field_prefix,'_',SUBSTRING_INDEX(var_tmp_columns, '=', 1),'` ',var_col_type,' DEFAULT NULL, ');   
            
        END IF; END IF;
        SET var_start = var_position + 1;
    END WHILE;

    SET var_creator = CONCAT('CREATE TABLE IF NOT EXISTS `public_',in_table_name,'` ( `', var_field_prefix, '_id` int(11) NOT NULL AUTO_INCREMENT, ', var_creator);
    SET var_creator = CONCAT(var_creator, ' `read_level` int(11) NOT NULL DEFAULT 0, `write_level` int(11) NOT NULL DEFAULT 0, `owner` int(11) NOT NULL DEFAULT 0,');
    SET var_creator = CONCAT(var_creator, ' PRIMARY KEY (`', var_field_prefix, '_id`)) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1');
    SET @query = var_creator;
    PREPARE var_query FROM @query; EXECUTE var_query; DEALLOCATE PREPARE var_query;

    SET var_insertor = CONCAT('INSERT INTO `syst_defs_columns` (`table_name`,`field_name`,`field_caption`,`field_type`,`field_read_level`,`field_write_level`) VALUES ',var_insertor);
    SET @query = var_insertor;

    PREPARE var_query FROM @query; EXECUTE var_query; DEALLOCATE PREPARE var_query;

    SET var_insertor = 'INSERT INTO `syst_defs_tables` (`table_name`,`table_read_level`,`table_write_level`,`table_insert_level`,`table_delete_level`) VALUES';
    SET var_insertor = CONCAT(var_insertor," ('public_",in_table_name,"',",in_sel,',',in_upd,',',in_ins,',',in_del,')');
    SET @query = var_insertor;
    PREPARE var_query FROM @query; EXECUTE var_query; DEALLOCATE PREPARE var_query;

END$$

DROP PROCEDURE IF EXISTS `get_columns_defs`$$
CREATE DEFINER=`root`@`%` PROCEDURE `get_columns_defs`(IN in_table_name VARCHAR(40), IN in_read_level INT, IN in_write_level INT,
 OUT out_columns VARCHAR(255), OUT out_defs TEXT, OUT out_dicts VARCHAR(255))
BEGIN
    DECLARE var_column VARCHAR(100) DEFAULT '';
    DECLARE var_def varchar(100) DEFAULT '';
    DECLARE var_href varchar(100) DEFAULT '';
    DECLARE var_req VARCHAR(5) DEFAULT '';
    DECLARE var_uniq VARCHAR(5) DEFAULT '';
    DECLARE var_caption VARCHAR(100) DEFAULT '';
    DECLARE var_w_level INT(11) DEFAULT 0;
    DECLARE var_ro_ind VARCHAR(5) DEFAULT '';

    DECLARE var_is_end BOOLEAN DEFAULT FALSE;
    DECLARE result_cursor CURSOR FOR 
        SELECT `field_name`,`field_type`,`field_href`,`field_require`,`field_uniq`,`field_caption`,`field_write_level` FROM `syst_defs_columns` 
        WHERE `table_name` = in_table_name AND `field_read_level` <= in_read_level ORDER BY `field_order` ASC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_is_end = true;

    OPEN result_cursor;
    SET out_columns = ''; SET out_defs = '{'; SET out_dicts = ''; 

    FETCH result_cursor INTO var_column, var_def, var_href, var_req, var_uniq, var_caption, var_w_level;

    WHILE var_is_end != true DO

        SET out_columns = CONCAT(out_columns,'`',var_column,'`,');

        IF (var_w_level > in_write_level) THEN SET var_ro_ind = 'true'; ELSE SET var_ro_ind = 'false'; END IF;
        IF (var_req = '0') THEN SET var_req = 'false'; ELSE SET var_req = 'true'; END IF;
        IF (var_uniq = '0') THEN SET var_uniq = 'false'; ELSE SET var_uniq = 'true'; END IF;
        IF (var_caption IS NULL) THEN SET var_caption = var_column; END IF;

        SET out_defs = CONCAT
        (out_defs,'"',var_column,'":{"type":"',var_def,'","caption":"',var_caption,'","r_only":',var_ro_ind,',"require":',var_req,',"unique":',var_uniq,'},');

                
        IF (var_def='select' OR var_def='multi' OR var_def='radio') THEN 
            SET out_dicts = CONCAT(out_dicts, var_column,':',var_href,',');
        END IF;

        FETCH result_cursor INTO var_column, var_def, var_href, var_req, var_uniq, var_caption, var_w_level;

    END WHILE;
    CLOSE result_cursor;

    SET out_defs = CONCAT(TRIM(TRAILING ',' FROM out_defs),'}');
    SET out_columns = TRIM(TRAILING ',' FROM out_columns);
    SET out_dicts = TRIM(TRAILING ',' FROM out_dicts);

END$$

DROP PROCEDURE IF EXISTS `get_signature`$$
CREATE DEFINER=`root`@`%` PROCEDURE `get_signature`(IN `in_user_token` VARCHAR(40), IN `in_ip` VARCHAR(15), IN `in_table_name` VARCHAR(40))
    READS SQL DATA
BEGIN
    DECLARE var_query VARCHAR(255);
    DECLARE var_conditions VARCHAR(255) DEFAULT '';
    DECLARE var_active_user_id INT;
    DECLARE var_user_write_lvl INT DEFAULT 0;
    DECLARE var_user_read_lvl INT DEFAULT 0;
    /* Variables for permitted columns */
    DECLARE var_selected_columns VARCHAR(255)DEFAULT '';
    DECLARE var_selected_defs TEXT;
    DECLARE var_selected_dicts VARCHAR(255) DEFAULT '';
    DECLARE var_dicts_defs VARCHAR(255) DEFAULT '';

    /* Security checking input values */
    SET in_table_name = clear_input_data(in_table_name);
    SET in_user_token = clear_input_data(in_user_token);
    SET in_ip = clear_input_data(in_ip);

    /* Check if user token is valid */
    SELECT check_token (in_user_token, in_ip) INTO var_active_user_id;
    IF (var_active_user_id < 0) THEN
        SELECT "ERROR: Token not found";
    ELSE /* If user is valid */
        /* Check user group and get read_access_level*/
        IF (var_active_user_id > 0) THEN
            SELECT `group_read_level`, `group_write_level` INTO var_user_read_lvl, var_user_write_lvl FROM `syst_groups` WHERE `group_id` = (SELECT `user_f_group_id`  FROM `syst_users` WHERE `user_id` = var_active_user_id LIMIT 1) LIMIT 1;
        ELSE 
            SELECT `group_read_level`, `group_write_level` INTO var_user_read_lvl, var_user_write_lvl FROM `syst_groups` WHERE `group_name` = 'guests' LIMIT 1;
        END IF;

        CALL get_columns_defs(in_table_name, var_user_read_lvl, var_user_write_lvl, var_selected_columns, var_selected_defs, var_selected_dicts);

        /* Give out columns definions */
        SELECT var_selected_defs AS columns_defs;

        /* Give out dictationaries */
        IF (var_selected_dicts!='') THEN
            WHILE (LOCATE(',', var_selected_dicts) != 0) DO

                SET var_dicts_defs = SUBSTRING_INDEX(var_selected_dicts, ',', 1);
                SELECT SUBSTRING_INDEX(var_dicts_defs, ':', 1) AS dict_field,
                    SUBSTRING_INDEX(var_dicts_defs, ':', -1) AS dict_table;

                SET @query = CONCAT("SELECT * FROM `",SUBSTRING_INDEX(var_dicts_defs, ':', -1),"`");
                PREPARE var_query FROM @query; EXECUTE var_query; DEALLOCATE PREPARE var_query;

                SET var_selected_dicts = TRIM(LEADING var_dicts_defs FROM var_selected_dicts);

                SET var_selected_dicts = TRIM(TRIM(LEADING ',' FROM var_selected_dicts));
                
            END WHILE;

                SELECT SUBSTRING_INDEX(var_selected_dicts, ':', 1) AS dict_field,
                    SUBSTRING_INDEX(var_selected_dicts, ':', -1) AS dict_table;
                SET @query = CONCAT("SELECT * FROM `",SUBSTRING_INDEX(var_selected_dicts, ':', -1),"`;");
                PREPARE var_query FROM @query; EXECUTE var_query; DEALLOCATE PREPARE var_query; 
        END IF;

    END IF;
END$$

DROP PROCEDURE IF EXISTS `get_table`$$
CREATE DEFINER=`root`@`%` PROCEDURE `get_table`(
    IN in_user_token VARCHAR(40), 
    IN in_ip VARCHAR(15), 
    IN in_table_name varchar(40), 
    IN in_where varchar(100), 
    IN in_order varchar(100), 
    IN in_limit varchar(30)
)
    READS SQL DATA
BEGIN
    DECLARE var_query VARCHAR(255);
    DECLARE var_conditions VARCHAR(255) DEFAULT '';
    DECLARE var_active_user_id INT;
    DECLARE var_user_write_lvl INT DEFAULT 0;
    DECLARE var_user_read_lvl INT DEFAULT 0;
    /* Variables for permitted columns */
    DECLARE var_selected_columns VARCHAR(255)DEFAULT '';
    DECLARE var_selected_defs TEXT;
    DECLARE var_selected_dicts VARCHAR(255) DEFAULT '';
    DECLARE var_dicts_defs VARCHAR(255) DEFAULT '';

    /* Security checking input values */
    SET in_table_name = clear_input_data(in_table_name);
    SET in_user_token = clear_input_data(in_user_token);
    SET in_ip = clear_input_data(in_ip);
    SET in_where = REPLACE(REPLACE(REPLACE(LOWER(in_where),'update',''),'insert',''),';','');
    SET in_order = clear_input_data(in_order);
    SET in_limit = clear_input_data(in_limit);

    /* Check if user token is valid */
    SELECT check_token (in_user_token, in_ip) INTO var_active_user_id;
    IF (var_active_user_id < 0) THEN
        SELECT "ERROR: Token not found";
    ELSE /* If user is valid */
        /* Check user group and get read_access_level*/
        IF (var_active_user_id > 0) THEN
            SELECT `group_read_level`, `group_write_level` INTO var_user_read_lvl, var_user_write_lvl FROM `syst_groups` WHERE `group_id` = (SELECT `user_f_group_id`  FROM `syst_users` WHERE `user_id` = var_active_user_id LIMIT 1) LIMIT 1;
        ELSE 
            SELECT `group_read_level`, `group_write_level` INTO var_user_read_lvl, var_user_write_lvl FROM `syst_groups` WHERE `group_name` = 'guests' LIMIT 1;
        END IF;

        CALL get_columns_defs(in_table_name, var_user_read_lvl, var_user_write_lvl, var_selected_columns, var_selected_defs, var_selected_dicts);

        /* Give out columns definions */
        SELECT var_selected_defs AS columns_defs;

        /* Form conditions */
        IF CHAR_LENGTH(in_where)>0 THEN
            SET var_conditions = CONCAT(var_conditions, " WHERE (", in_where, ")");
            SET var_conditions = CONCAT(var_conditions, " AND (`owner` = ", var_active_user_id, " OR `read_level` <= ", var_user_read_lvl,")");
        ELSE
            SET var_conditions = CONCAT(var_conditions, " WHERE (`owner` = ", var_active_user_id, " OR `read_level` <= ", var_user_read_lvl,")");
        END IF;

        IF (in_limit != '1') THEN
            /* Try to count rows */
            SET @query = CONCAT("SELECT COUNT(*) INTO @all_rows_count FROM `", in_table_name, "`", var_conditions);
            PREPARE var_query FROM @query;
            EXECUTE var_query;
            DEALLOCATE PREPARE var_query;
        END IF;

        /* Form other conditions */
        IF CHAR_LENGTH(in_order)>0 THEN SET var_conditions = CONCAT(var_conditions, " ORDER BY ", in_order); END IF;
        IF CHAR_LENGTH(in_limit)>0 THEN SET var_conditions = CONCAT(var_conditions, " LIMIT ", in_limit); END IF;

        /* Main result query */
        SET @query = CONCAT("SELECT ", var_selected_columns, ",IF((",var_user_write_lvl," > `write_level` OR `owner`=",var_active_user_id,"), '0', '1') AS `r_only`, `owner` FROM `", in_table_name, "`", var_conditions);
        -- SELECT @query;
        PREPARE var_query FROM @query;
        EXECUTE var_query;
        DEALLOCATE PREPARE var_query; 

        IF (in_limit != '1') THEN
            /* Give out total rows count */
            SELECT @all_rows_count AS total_count;
        END IF;

        /* Give out dictationaries */
        IF (var_selected_dicts!='') THEN
            WHILE (LOCATE(',', var_selected_dicts) != 0) DO

                SET var_dicts_defs = SUBSTRING_INDEX(var_selected_dicts, ',', 1);
                SELECT SUBSTRING_INDEX(var_dicts_defs, ':', 1) AS dict_field,
                    SUBSTRING_INDEX(var_dicts_defs, ':', -1) AS dict_table;

                SET @query = CONCAT("SELECT * FROM `",SUBSTRING_INDEX(var_dicts_defs, ':', -1),"`");
                PREPARE var_query FROM @query; EXECUTE var_query; DEALLOCATE PREPARE var_query;

                SET var_selected_dicts = TRIM(LEADING var_dicts_defs FROM var_selected_dicts);

                SET var_selected_dicts = TRIM(TRIM(LEADING ',' FROM var_selected_dicts));
                
            END WHILE;

                SELECT SUBSTRING_INDEX(var_selected_dicts, ':', 1) AS dict_field,
                    SUBSTRING_INDEX(var_selected_dicts, ':', -1) AS dict_table;
                SET @query = CONCAT("SELECT * FROM `",SUBSTRING_INDEX(var_selected_dicts, ':', -1),"`;");
                PREPARE var_query FROM @query; EXECUTE var_query; DEALLOCATE PREPARE var_query; 
        END IF;

    END IF;

END$$

DROP PROCEDURE IF EXISTS `get_user`$$
CREATE DEFINER=`root`@`%` PROCEDURE `get_user`(IN `in_user_token` VARCHAR(40), IN `in_ip` VARCHAR(15))
    READS SQL DATA
BEGIN
    DECLARE var_user_id INT;
    DECLARE var_user_is_active TINYINT;
    DECLARE var_user_last_ip VARCHAR(15);
    DECLARE var_user_auth_time VARCHAR(25);
    DECLARE var_user_data TEXT;
    DECLARE var_garbage VARCHAR(255);

    SET in_user_token = clear_input_data (in_user_token);
    SET in_ip = clear_input_data (in_ip);


    IF (in_ip = '') THEN
        SELECT '-1' AS 'Status';
        SELECT 'Not enough parameters' AS 'Error';
    ELSE

        /*Get user id and clear session*/
        SET var_user_id = check_token (in_user_token, in_ip);

        IF (in_user_token = '') || (var_user_id = -1) THEN
            /*if there is no user token, create some new*/
            SET in_user_token = MD5 ( CONCAT( RAND(), in_ip, NOW() ) );
            SET var_user_last_ip = in_ip;
            SET var_user_id = 0;
            SET var_user_auth_time = NOW();
            SET var_user_data = NULL;
            INSERT INTO `syst_sessions` (`sess_user_token`,`sess_user_last_ip`,`sess_user_last_activity`, `sess_f_user_id`)
            VALUES (in_user_token, var_user_last_ip, var_user_auth_time, var_user_id);
        
        ELSE
            /* Try to get user session data */
            SELECT `sess_user_last_activity`, `sess_user_data`
            INTO var_user_auth_time, var_user_data
            FROM `syst_sessions` 
            WHERE ( `sess_user_token` = in_user_token )
            LIMIT 1;

        END IF;

        CASE

        /* If found guest session */
        WHEN var_user_id = 0 THEN

            SELECT '0' AS 'Status';
            SELECT in_user_token AS 'user_token', in_ip AS 'last_ip', var_user_auth_time AS 'last_activity',
            var_user_id AS 'user_id', var_user_data AS 'session_data';

        /* If found user session */
        WHEN var_user_id > 0 THEN
            
            SELECT '1' AS 'Status';
            SELECT in_user_token AS 'user_token', in_ip AS 'last_ip', var_user_auth_time AS 'last_activity',
            var_user_id AS 'user_id', var_user_data AS 'session_data',
            `usr`.`user_login` AS 'user_login', `usr`.`user_email` AS 'user_email', `usr`.`user_is_active` AS 'is_active', `usr`.`user_f_group_id` AS 'group_id'
            FROM `syst_users` AS `usr`
            WHERE `usr`.`user_id` = var_user_id LIMIT 1; 
            /*`uinf`.`user_info_id`
            LEFT JOIN `public_users_info` AS `uinf` ON (`usr`.`user_id`=`uinf`.`user_info_f_user_id`)*/

        END CASE;

    END IF; /* IF (in_ip = '') THEN */

END$$

DROP PROCEDURE IF EXISTS `get_users`$$
CREATE DEFINER=`root`@`%` PROCEDURE `get_users`(IN in_user_token varchar(40), IN in_ip varchar(15))
    READS SQL DATA
BEGIN
    DECLARE var_token_is_active TINYINT;

    SELECT check_token (in_user_token, in_ip) INTO var_token_is_active;

   
    IF (var_token_is_active = 0) THEN
        SELECT 'ERROR: Token not found';
    ELSE SELECT in_ip;
    END IF;

END$$

DROP PROCEDURE IF EXISTS `set_table`$$
CREATE DEFINER=`root`@`%` PROCEDURE `set_table`(
    IN in_user_token VARCHAR(40),
    IN in_ip VARCHAR(15),
    IN in_table_name VARCHAR(40),
    IN in_values TEXT,
    IN in_where VARCHAR(250)
)
    READS SQL DATA
BEGIN
    /* Procedure variables */
    DECLARE var_length BIGINT DEFAULT 1;
    DECLARE var_start BIGINT DEFAULT 1;
    DECLARE var_name VARCHAR(250) DEFAULT '';
    DECLARE var_value TEXT DEFAULT '';
    DECLARE var_prepare TEXT DEFAULT '';
    DECLARE var_prep_part VARCHAR(250) DEFAULT '';
    DECLARE var_active_user_id INT DEFAULT NULL;
    DECLARE var_user_write_lvl INT DEFAULT 0;
    DECLARE var_user_read_lvl INT DEFAULT 0;
    DECLARE var_table_read_lvl INT DEFAULT NULL;

    /* Cursor for fetching syst_defs_columns */
    DECLARE var_is_end BOOLEAN DEFAULT false;
    DECLARE result_cursor CURSOR FOR 
        SELECT `field_name` FROM `syst_defs_columns` 
        WHERE `table_name` = in_table_name AND `field_write_level` <= var_user_write_lvl;
        -- ORDER BY `field_order` ASC;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_is_end = true;

    /* Security checking input values */
    SET in_user_token   = clear_input_data(in_user_token);
    SET in_ip           = clear_input_data(in_ip);
    SET in_table_name   = clear_input_data(in_table_name);
    SET in_values       = clear_input_data(in_values);
    SET in_where        = clear_input_data(in_where);

    /* Check if user token is valid */
    SELECT check_token (in_user_token, in_ip) INTO var_active_user_id;

    IF (var_active_user_id < 0) THEN
        SELECT '-1'; /* ERROR: Token not found */

    ELSE /* If user is valid */
        /* Check user group and get read_access_level*/
        IF (var_active_user_id > 0) THEN
            SELECT `group_read_level`, `group_write_level` INTO var_user_read_lvl, var_user_write_lvl FROM `syst_groups`
            WHERE `group_id` = (SELECT `user_f_group_id`  FROM `syst_users` WHERE `user_id` = var_active_user_id LIMIT 1) LIMIT 1;
        ELSE 
            SELECT `group_read_level`, `group_write_level` INTO var_user_read_lvl, var_user_write_lvl FROM `syst_groups` 
            WHERE `group_name` = 'guests' LIMIT 1;
        END IF;

        /* Get field default read level*/
        SELECT `table_read_level` INTO var_table_read_lvl FROM `syst_defs_tables` WHERE `table_name` = in_table_name LIMIT 1;
        IF (var_table_read_lvl IS NOT NULL) THEN SET var_user_read_lvl = var_table_read_lvl; END IF;

        OPEN result_cursor;
        FETCH result_cursor INTO var_name;

        WHILE var_is_end != true DO

            SET var_value = '';
            /* Get Fields values */
            SET var_start = LOCATE(CONCAT('\\"',var_name,'\\":'), in_values, 1) + LENGTH(CONCAT('\\"',var_name,'\\":'));
            SET var_start = LOCATE('\\"', in_values, var_start) + 2;
            
            SET var_length = LOCATE('\\"', in_values, var_start) - var_start;
            SET var_value = MID(in_values, var_start, var_length);

            /* INSERT */
            IF (in_where = '') THEN 
                    IF (var_value != '') THEN
                    SET var_prep_part = CONCAT(var_prep_part,'`',var_name,'`,');
                    SET var_prepare = CONCAT(var_prepare,"'",var_value,"',");
                END IF;
            /* UPDATE */
            ELSE
                IF (var_value != '') THEN
                    SET var_prepare = CONCAT(var_prepare,'`',var_name,"`='",var_value,"',");
                END IF;
            END IF;

            FETCH result_cursor INTO var_name;
        END WHILE;

        /* INSERT */
        IF (in_where = '') THEN
            SET var_prep_part = CONCAT(var_prep_part,'`owner`,`read_level`,`write_level`');
            SET var_prepare = CONCAT(var_prepare,"'",var_active_user_id,"','",var_user_read_lvl,"','",(var_user_write_lvl + 1),"'");
            SET @query = CONCAT('INSERT INTO `',in_table_name,'` (',var_prep_part,') VALUES (',var_prepare,');');
        /* UPDATE */
        ELSE
            SET @query = CONCAT('UPDATE `',in_table_name,'` SET ',TRIM(TRAILING ',' FROM var_prepare),
            ' WHERE (', in_where, ') AND (`owner`=',var_active_user_id,' OR `write_level`<=',var_user_write_lvl,') LIMIT 1;');
        END IF;

        PREPARE var_prepare FROM @query; EXECUTE var_prepare; DEALLOCATE PREPARE var_prepare;
            
    END IF;

END$$

--
-- Функції
--
DROP FUNCTION IF EXISTS `add_user`$$
CREATE DEFINER=`root`@`%` FUNCTION `add_user`(in_login varchar(150), in_email varchar(150), in_pass varchar(250)) RETURNS varchar(100) CHARSET utf8
    READS SQL DATA
BEGIN
    DECLARE var_user_code CHAR( 40 ) DEFAULT NULL;
    DECLARE var_check_code CHAR( 40 ) DEFAULT NULL;
    DECLARE var_user_id INT( 11 ) DEFAULT NULL;
    /* Security checking input values */
    SET in_login = TRIM(REPLACE(REPLACE(in_login,'=',''),';',''));
    SET in_email = TRIM(REPLACE(REPLACE(in_email,'=',''),';',''));
    SET in_pass = TRIM(REPLACE(REPLACE(in_pass,'=',''),';',''));
    
    IF (in_email = '') THEN
        RETURN '-2'; /* ERROR: Email not found */
    END IF;
    IF (in_pass = '') THEN
        RETURN '-1'; /* ERROR: Password not setted */
    END IF;

    /* Check if user email already exists */

    SELECT `user_id` INTO var_user_id FROM `syst_users`
    WHERE `user_email` LIKE in_email LIMIT 1;

    IF (var_user_id IS NULL) THEN

        SET in_pass = gen_passwd (in_pass, '');
        SET var_user_code = MD5 ( CONCAT( in_email, RAND(), in_login, NOW() ) );

        /* Check if confirm record allready exists */
        SELECT `sess_user_token` INTO var_check_code FROM `syst_sessions` WHERE `sess_user_data`
        LIKE CONCAT("'", in_email, "','", in_login, "','", in_pass, "'") LIMIT 1;

        IF (var_check_code IS NULL) THEN

            INSERT INTO `syst_sessions` (`sess_user_token`, `sess_user_data`, `sess_user_last_activity`)
            VALUES ( var_user_code, CONCAT("'", in_email, "','", in_login, "','", in_pass, "'"), NOW());
            /* INSERT INTO `syst_users` (`user_login`,`user_email`,`user_pass`, `user_reg_code`, `user_is_active`)
            VALUES (in_login, in_email, in_pass, var_user_code, 0); */
        ELSE 
            UPDATE `syst_sessions` SET `sess_user_token` = var_user_code, `sess_user_last_activity` = NOW()
            WHERE `sess_user_token` = var_check_code LIMIT 1;
        END IF;

        RETURN CONCAT('?token=', var_user_code);
    ELSE
        RETURN '0'; /* ERROR: Email exists */
    END IF;
END$$

DROP FUNCTION IF EXISTS `check_token`$$
CREATE DEFINER=`root`@`%` FUNCTION `check_token`(`in_user_token` VARCHAR(40), `in_ip` VARCHAR(15)) RETURNS int(11)
    READS SQL DATA
BEGIN
    DECLARE var_user_id INT;
    DECLARE var_user_is_active TINYINT;
    DECLARE var_user_last_ip VARCHAR(15);
    DECLARE var_user_auth_time VARCHAR(25);

    DECLARE var_token_life_time VARCHAR(20);
    DECLARE var_session_life_time VARCHAR(20);
    DECLARE var_session_last_time VARCHAR(20);

    SET in_user_token = clear_input_data (in_user_token);
    SET in_ip = clear_input_data (in_ip);

    /* Get settings */
    SELECT `sett_session_time`,`sett_session_last`,`sett_user_token_time`
    INTO var_session_life_time, var_session_last_time, var_token_life_time
    FROM `syst_settings` WHERE `sett_id` = 1 LIMIT 1;

    /* Calculate time */
    /* If time much session life time */
    IF (CAST( UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(ADDTIME(var_session_last_time, var_session_life_time)) as SIGNED) > 0 ) THEN
        DELETE FROM `syst_sessions` WHERE `sess_user_last_activity` < SUBTIME(NOW(), var_session_life_time);
        UPDATE `syst_settings` SET `sett_session_last` = NOW() WHERE `sett_id` = 1 LIMIT 1;
    END IF;
    
    /* Try to get user session data */
    SELECT `sess_user_last_ip`, `sess_user_last_activity`, `sess_f_user_id`
    INTO var_user_last_ip, var_user_auth_time, var_user_id
    FROM `syst_sessions` 
    WHERE ( `sess_user_token` = in_user_token )
    LIMIT 1;

    IF var_user_id IS NULL THEN RETURN -1; /* Token not found */ END IF;

    /* If found guest session */
    IF var_user_id = 0 THEN 
        /* Update last user activity */
        UPDATE `syst_sessions` SET `sess_user_last_activity` = NOW(), `sess_user_last_ip` = in_ip
        WHERE `sess_user_token` = in_user_token LIMIT 1;
        RETURN 0; /* Guest session */
    END IF;

    /* If found user session */
    IF var_user_id > 0 THEN
        
        /* Check if user is active */
        SELECT `user_is_active` INTO var_user_is_active FROM `syst_users`
        WHERE `user_id` = var_user_id LIMIT 1;

        IF var_user_is_active IS NULL THEN RETURN -2; /* If user not found in syst_users table */ END IF;

        /* Calculate time */
        SET var_token_life_time = CAST(UNIX_TIMESTAMP(NOW()) - UNIX_TIMESTAMP(ADDTIME(var_user_auth_time, var_token_life_time)) as SIGNED);

        /* Check life time, user activation and ip */
        IF (var_user_is_active = 0) || (var_user_last_ip != in_ip) || (var_token_life_time > 0) THEN
            /* Clear user id */
            UPDATE `syst_sessions` SET `sess_f_user_id` = 0, `sess_user_last_activity` = NOW()
            WHERE `sess_user_token` = in_user_token LIMIT 1;
            RETURN 0; /*If expired, user not active or different ip then return Guest session */
        ELSE 
            /* Update last user activity */
            UPDATE `syst_sessions` SET `sess_user_last_activity` = NOW()
            WHERE `sess_user_token` = in_user_token LIMIT 1;
            RETURN var_user_id;
        END IF;
    END IF;

END$$

DROP FUNCTION IF EXISTS `clear_input_data`$$
CREATE DEFINER=`root`@`%` FUNCTION `clear_input_data`( in_data varchar(255) ) RETURNS varchar(255) CHARSET utf8
    NO SQL
BEGIN
    SET in_data = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(in_data,'%',''),'"','\"'),"'","\'"),'<','\<'),'>','\>'),')','\)'),'(','\('),';','\;'));
    RETURN in_data;  
END$$

DROP FUNCTION IF EXISTS `do_auth`$$
CREATE DEFINER=`root`@`%` FUNCTION `do_auth`(auth_key varchar(150), pass varchar(255), ip varchar(15), exist_token varchar(40)) RETURNS varchar(40) CHARSET utf8
    READS SQL DATA
BEGIN
    DECLARE var_user_id INT;
    DECLARE var_user_token CHAR( 40 );
    DECLARE var_user_is_active TINYINT;
    SET auth_key = clear_input_data (auth_key);
    SET pass = clear_input_data (pass);
    SET ip = clear_input_data (ip);
    SET exist_token = clear_input_data (exist_token);

    IF (auth_key = '') || (ip = '') THEN
        RETURN '-3'; /* 'ERROR: Some value not set'; */
    END IF;

    SET pass = gen_passwd (pass, '');
    /* Try to get user */
    SELECT `user_id`, `user_is_active` INTO var_user_id, var_user_is_active FROM `syst_users` 
    WHERE `user_email` = auth_key AND `user_pass` = pass 
    LIMIT 1;

    IF (var_user_id IS NULL) THEN
        RETURN '-2'; /* 'ERROR: Combination not found' */
    END IF;
    IF (var_user_is_active = 0) THEN
        RETURN '-1'; /* 'ERROR: User not activated' */
    END IF;

    SET var_user_token = MD5 ( CONCAT( auth_key, ip, NOW() ) );

    IF (exist_token != '') THEN
        /* If there is old user data in session table */
        DELETE FROM `syst_sessions` WHERE `sess_f_user_id` = var_user_id AND sess_user_token != var_user_token LIMIT 1;
        UPDATE `syst_sessions` SET `sess_user_token` = var_user_token, `sess_f_user_id` = var_user_id, `sess_user_last_ip` = ip, `sess_user_last_activity` = NOW()
        WHERE `sess_user_token` = exist_token LIMIT 1;
        RETURN var_user_token;
    ELSE
        /* Check if session record allready exists*/
        SELECT `sess_user_token` INTO exist_token FROM `syst_sessions`
        WHERE `sess_f_user_id` = var_user_id LIMIT 1;

        IF (exist_token IS NULL) THEN
            INSERT INTO `syst_sessions` (`sess_f_user_id`, `sess_user_token`, `sess_user_last_ip`, `sess_user_last_activity`)
            VALUES (var_user_id, var_user_token, ip, NOW());
            RETURN var_user_token;
        ELSE
            UPDATE `syst_sessions` SET `sess_user_token` = var_user_token, `sess_user_last_ip` = ip, `sess_user_last_activity` = NOW()
            WHERE `sess_user_token` = exist_token LIMIT 1;
            RETURN var_user_token;
        END IF;
    END IF;
END$$

DROP FUNCTION IF EXISTS `gen_passwd`$$
CREATE DEFINER=`root`@`%` FUNCTION `gen_passwd`(in_pass varchar(250), in_salt varchar(40)) RETURNS varchar(80) CHARSET utf8
    READS SQL DATA
BEGIN

    DECLARE var_passw_salt CHAR( 40 );
    DECLARE var_passw CHAR( 255 );
    /* Security checking input values */
    SET in_pass = TRIM(REPLACE(REPLACE(in_pass,'=',''),';',''));
    SET in_salt = TRIM(REPLACE(REPLACE(in_salt,'=',''),';',''));

    IF (in_pass = '') THEN
        RETURN "ERROR: Password not setted";
    END IF;

    IF (in_salt = '') THEN
        /* Get salt value from sett table */
        SELECT `sett_passw_salt` INTO var_passw_salt FROM `syst_settings` LIMIT 1;
    ELSE
        SET var_passw_salt = in_salt;
    END IF;

    SET var_passw = ENCRYPT(in_pass, var_passw_salt);
    IF (var_passw IS NULL) THEN SET var_passw = MD5(CONCAT(in_pass, var_passw_salt)); END IF;
    RETURN var_passw;

END$$

DROP FUNCTION IF EXISTS `logout_user`$$
CREATE DEFINER=`root`@`%` FUNCTION `logout_user`(in_user_token VARCHAR(40), in_ip VARCHAR(15)) RETURNS varchar(40) CHARSET utf8
    READS SQL DATA
BEGIN
    DECLARE var_user_token CHAR( 40 );

    SET in_user_token = clear_input_data (in_user_token);
    SET in_ip = clear_input_data (in_ip);

    SET var_user_token = MD5 ( CONCAT( in_ip, in_user_token, NOW() ) );

    UPDATE `syst_sessions` SET `sess_user_token` = var_user_token, `sess_f_user_id` = 0, `sess_user_last_ip` = in_ip, `sess_user_last_activity` = NOW()
    WHERE `sess_user_token` = in_user_token LIMIT 1;

RETURN var_user_token;
END$$

DROP FUNCTION IF EXISTS `reg_user`$$
CREATE DEFINER=`root`@`%` FUNCTION `reg_user`(reg_token varchar(40), ip varchar(15), exist_token varchar(40)) RETURNS varchar(40) CHARSET utf8
    READS SQL DATA
BEGIN
    DECLARE var_user_data TEXT DEFAULT NULL;
    DECLARE var_user_email varchar(40) DEFAULT NULL;
    DECLARE var_user_login varchar(40) DEFAULT NULL;
    DECLARE var_user_pass varchar(40) DEFAULT NULL;
    DECLARE var_user_id int(11) DEFAULT NULL;

    SET reg_token = clear_input_data (reg_token);
    SET exist_token = clear_input_data (exist_token);
    SET ip = clear_input_data (ip);

    /* Try to read reg token from session */
    SELECT `sess_user_data` INTO var_user_data
    FROM `syst_sessions` WHERE `sess_user_token` = reg_token
    LIMIT 1;

    IF (var_user_data IS NULL) THEN RETURN '-2'; /* 'ERROR: Reg token not found' */ END IF;

    IF (var_user_data != '') THEN IF (LOCATE("','", var_user_data) > 0) THEN

        SET var_user_email = TRIM(LEADING "'" FROM SUBSTRING_INDEX(var_user_data, "','", 1));
        SET var_user_pass = TRIM(TRAILING "'" FROM SUBSTRING_INDEX(var_user_data, "','", -1));
        SET var_user_login = TRIM(LEADING "'" FROM SUBSTRING_INDEX(var_user_data, "','", 2));
        SET var_user_login = TRIM(TRAILING "'" FROM SUBSTRING_INDEX(var_user_login, "','", -1));

        /* Check if email exist */
        SELECT `user_id` INTO var_user_id FROM `syst_users`
        WHERE `user_email` LIKE var_user_email; 

        IF (var_user_id IS NULL) THEN

            INSERT INTO `syst_users` (`user_email`, `user_login`, `user_pass`, `user_reg_date`)
            VALUES (var_user_email, var_user_login, var_user_pass, NOW());

            DELETE FROM `syst_sessions` WHERE `sess_user_token` = reg_token LIMIT 1;

            SET var_user_id = LAST_INSERT_ID();
            SET reg_token = MD5 ( CONCAT( var_user_email, var_user_login, NOW() ) );

            IF (exist_token != '') THEN
                UPDATE `syst_sessions` SET `sess_user_token` = reg_token, `sess_f_user_id` = var_user_id,
                `sess_user_last_activity` = NOW(), `sess_user_last_ip` = ip
                WHERE `sess_user_token` = exist_token LIMIT 1;
            ELSE
                INSERT INTO `syst_sessions` (`sess_f_user_id`, `sess_user_token`, `sess_user_last_activity`, `sess_user_last_ip`)
                VALUES (var_user_id, reg_token, NOW(), ip);
            END IF;

        ELSE RETURN '0'; /* 'ERROR: User already registered' */

        END IF;

    ELSE RETURN '-1'; /* 'ERROR: User data is empty' */

    END IF; END IF;

RETURN reg_token;
END$$

DROP FUNCTION IF EXISTS `reset_passwd`$$
CREATE DEFINER=`root`@`%` FUNCTION `reset_passwd`(pass_token varchar(40), ip varchar(15), in_pass varchar(250), exist_token varchar(40)) RETURNS varchar(40) CHARSET utf8
    READS SQL DATA
BEGIN
    DECLARE var_user_id int(11) DEFAULT NULL;
    DECLARE var_user_data VARCHAR(40) DEFAULT NULL;
    /* Security checking input values */
    SET pass_token = clear_input_data (pass_token);
    SET exist_token = clear_input_data (exist_token);
    SET ip = clear_input_data (ip);
    SET in_pass = TRIM(REPLACE(REPLACE(in_pass,'=',''),';',''));

    /* Try to read pass token from session */
    SELECT `sess_user_data` INTO var_user_data FROM `syst_sessions` WHERE `sess_user_token` = pass_token
    LIMIT 1;

    IF (var_user_data IS NULL) THEN RETURN '-2'; /* 'ERROR: Pass token not found' */ END IF;

    /* Check existing user */
    SELECT `user_id` INTO var_user_id FROM `syst_users` WHERE `user_id` = var_user_data
    LIMIT 1;

    IF (var_user_id IS NULL) THEN RETURN '-1'; /* 'ERROR: User not found' */ END IF;    

    SET in_pass = gen_passwd (in_pass, '');
    UPDATE `syst_users` SET `user_pass` = in_pass WHERE `user_id` = var_user_id LIMIT 1;
    DELETE FROM `syst_sessions` WHERE `sess_user_token` = pass_token LIMIT 1;

    SET pass_token = MD5 ( CONCAT( RAND(), exist_token, NOW() ) );

    IF (exist_token != '') THEN
        UPDATE `syst_sessions` SET `sess_user_token` = pass_token, `sess_f_user_id` = var_user_id,
        `sess_user_last_activity` = NOW(), `sess_user_last_ip` = ip
        WHERE `sess_user_token` = exist_token LIMIT 1;
    ELSE
        INSERT INTO `syst_sessions` (`sess_f_user_id`, `sess_user_token`, `sess_user_last_activity`, `sess_user_last_ip`)
        VALUES (var_user_id, pass_token, NOW(), ip);
    END IF;

RETURN pass_token;
END$$

DROP FUNCTION IF EXISTS `set_session`$$
CREATE DEFINER=`root`@`%` FUNCTION `set_session`(`in_user_token` VARCHAR(40), `in_ip` VARCHAR(15), `in_data` TEXT) RETURNS varchar(40) CHARSET utf8
    READS SQL DATA
BEGIN
    DECLARE var_user_id INT;
    DECLARE var_user_ip CHAR( 15 );
    
    SET in_data = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(in_data,'%',''),"'",''),'<',''),'>',''),')',''),'(',''),'=',''));
    SET in_ip = clear_input_data (in_ip);
    SET in_user_token = clear_input_data (in_user_token);

    /* Check if session record allready exists*/
    SELECT `sess_f_user_id`, `sess_user_last_ip` INTO var_user_id, var_user_ip FROM `syst_sessions`
    WHERE `sess_user_token` = in_user_token LIMIT 1;

    IF (var_user_id IS NULL) THEN
    
        /* SET in_user_token = MD5 ( CONCAT( RAND(), in_ip, NOW() ) );*/
        INSERT INTO `syst_sessions` (`sess_user_token`,`sess_user_last_ip`,`sess_user_last_activity`, `sess_user_data`)
        VALUES (in_user_token, in_ip, NOW(), in_data);
        RETURN in_user_token;

    END IF;

    IF (var_user_ip != in_ip) THEN SET var_user_id = 0; END IF;

    /* Update last user activity */
    UPDATE `syst_sessions` SET `sess_user_last_activity` = NOW(), `sess_f_user_id` = var_user_id,
    `sess_user_data` = in_data, `sess_user_last_ip` = in_ip
    WHERE `sess_user_token` = in_user_token LIMIT 1;

RETURN in_user_token;
END$$

DROP FUNCTION IF EXISTS `token_passwd`$$
CREATE DEFINER=`root`@`%` FUNCTION `token_passwd`(in_email varchar(150)) RETURNS varchar(100) CHARSET utf8
    READS SQL DATA
BEGIN
    DECLARE var_pass_code CHAR( 40 ) DEFAULT NULL;
    DECLARE var_check_code CHAR( 40 ) DEFAULT NULL;
    DECLARE var_user_id INT( 11 ) DEFAULT NULL;
    /* Security checking input values */
    SET in_email = TRIM(REPLACE(REPLACE(in_email,'=',''),';',''));

    IF (in_email = '') THEN
        RETURN '-1'; /* ERROR: Email not found */
    END IF;

    /* Get user */
    SELECT `user_id` INTO var_user_id FROM `syst_users`
    WHERE `user_email` LIKE in_email LIMIT 1;

    IF (var_user_id IS NOT NULL) THEN
        SET var_pass_code = MD5 ( CONCAT( in_email, RAND(), var_user_id, NOW() ) );

        /* Check if confirm record allready exists */
        SELECT `sess_user_token` INTO var_check_code FROM `syst_sessions`
        WHERE `sess_user_data` = var_user_id LIMIT 1;

        IF (var_check_code IS NULL) THEN
            INSERT INTO `syst_sessions` (`sess_user_token`, `sess_user_data`, `sess_user_last_activity`)
            VALUES ( var_pass_code, var_user_id, NOW());
        ELSE
            UPDATE `syst_sessions` SET `sess_user_token` = var_pass_code, `sess_user_last_activity` = NOW()
            WHERE `sess_user_token` = var_check_code LIMIT 1;
        END IF;

        RETURN CONCAT('?token=', var_pass_code);
    ELSE
        RETURN '0'; /* ERROR: User not found */
    END IF;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Структура таблиці `ci_sessions`
--

DROP TABLE IF EXISTS `ci_sessions`;
CREATE TABLE IF NOT EXISTS `ci_sessions` (
  `session_id` varchar(40) NOT NULL DEFAULT '0',
  `ip_address` varchar(45) NOT NULL DEFAULT '0',
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(10) unsigned NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`),
  KEY `last_activity_idx` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `ci_sessions`
--

INSERT INTO `ci_sessions` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('186862bb0dd508085b8e73065d3c2baa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:22.0) Gecko/20100101 Firefox/22.0', 1372752112, ''),
('3bc796c4770d0f5c3dd6ae1a971e5b59', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:22.0) Gecko/20100101 Firefox/22.0', 1372669095, ''),
('7b96bb6328012707c6905983a8466178', '127.0.0.1', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:21.0) Gecko/20100101 Firefox/21.0', 1372148965, '');

-- --------------------------------------------------------

--
-- Структура таблиці `emails_blacklist`
--

DROP TABLE IF EXISTS `emails_blacklist`;
CREATE TABLE IF NOT EXISTS `emails_blacklist` (
  `emb_id` int(11) NOT NULL AUTO_INCREMENT,
  `emb_email` varchar(255) NOT NULL,
  `emb_added` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`emb_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

--
-- Дамп даних таблиці `emails_blacklist`
--

INSERT INTO `emails_blacklist` (`emb_id`, `emb_email`, `emb_added`) VALUES
(1, 'bers_777@ukr.net', '2013-08-07 13:54:27'),
(2, 'sharklasers.com', '2013-08-07 14:31:45'),
(3, 'guerrillamailblock.com', '2013-08-07 14:31:45'),
(4, 'guerrillamail.com', '2013-08-07 14:31:45'),
(5, 'guerrillamail.net', '2013-08-07 14:31:45'),
(6, 'guerrillamail.biz', '2013-08-07 14:31:45'),
(7, 'guerrillamail.org', '2013-08-07 14:31:45'),
(8, 'guerrillamail.de', '2013-08-07 14:31:45'),
(9, 'spam4.me', '2013-08-07 14:31:45'),
(10, 'mailspeed.rur', '2013-08-07 14:31:45'),
(11, 'mqkr.net', '2013-08-07 14:31:45'),
(12, '12minutemail.com', '2013-08-07 14:31:45'),
(13, 'mytempemail.com', '2013-08-07 14:31:45'),
(14, 'spamobox.com', '2013-08-07 14:31:45'),
(15, 'vipmail.pw', '2013-08-07 14:31:45'),
(16, 'shitmail.me', '2013-08-07 14:31:45'),
(17, 'disposableinbox.com', '2013-08-07 14:31:45'),
(18, 'filzmail.com', '2013-08-07 14:31:45'),
(19, 'freemail.msuroid.com', '2013-08-07 14:31:45'),
(20, 'anonymbox.com', '2013-08-07 14:31:45'),
(21, 'yopmail.com', '2013-08-07 14:31:45'),
(22, 'TempEMail.net', '2013-08-07 14:31:45'),
(23, 'spambog.com', '2013-08-07 14:31:45'),
(24, 'spambog.de', '2013-08-07 14:31:45'),
(25, 'mfsa.ru', '2013-08-07 14:31:45'),
(26, 'spam.su', '2013-08-07 14:31:45'),
(27, 'nospam.ws', '2013-08-07 14:31:45'),
(28, 'mailinator.com', '2013-08-07 14:31:45'),
(29, 'safetymail.info', '2013-08-07 14:31:45'),
(30, 'trashcanmail.com', '2013-08-07 14:31:45'),
(31, 'mintemail.com', '2013-08-07 14:31:45'),
(32, 'jetable.org', '2013-08-07 14:31:45'),
(33, 'asdasd.ru', '2013-08-07 14:31:45'),
(34, 'dispostable.com', '2013-08-07 14:31:45'),
(35, 'spamgourmet.com', '2013-08-07 14:31:45'),
(36, 'minutemail.com', '2013-08-07 14:32:14');

-- --------------------------------------------------------

--
-- Структура таблиці `packages`
--

DROP TABLE IF EXISTS `packages`;
CREATE TABLE IF NOT EXISTS `packages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `users_count` int(11) NOT NULL,
  `disk_limit` bigint(20) NOT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `is_active` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Дамп даних таблиці `packages`
--

INSERT INTO `packages` (`id`, `name`, `users_count`, `disk_limit`, `amount`, `is_active`) VALUES
(1, 'freelancer', 1, 0, '0.00', 1),
(2, 'group', 10, 10737418240, '19.95', 1),
(3, 'team', 30, 32212254720, '39.95', 1),
(4, 'company', -1, 107374182400, '99.95', 1);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Дамп даних таблиці `public_menus`
--

INSERT INTO `public_menus` (`menu_id`, `menu_item_name`, `menu_item_link`, `menu_item_parent`, `menu_item_order`, `read_level`, `write_level`, `owner`) VALUES
(1, 'main_menu', '', 0, 0, 0, 80, 1),
(2, 'bottom_menu', '', 0, 0, 0, 80, 1),
(3, 'top_app_menu', '', 0, 0, 0, 80, 1),
(4, 'tasks', 'tasks', 3, 1, 0, 90, 1),
(5, 'people', 'people', 3, 2, 0, 90, 1),
(6, 'settings', 'account/settings', 3, 3, 0, 90, 1),
(7, 'search', 'search', 3, 4, 0, 90, 1),
(8, 'trash', 'trash', 3, 5, 0, 90, 1),
(9, 'referral', 'user/referral', 6, 1, 0, 90, 1),
(10, 'requisites', 'account/requisites', 6, 2, 0, 90, 1),
(11, 'about', 'about', 2, 1, 0, 90, 1),
(12, 'blog', 'blog', 2, 2, 0, 90, 1),
(13, 'referral', 'referral', 2, 3, 0, 90, 1),
(14, 'help', 'help', 2, 4, 0, 90, 1),
(15, 'conditions', 'conditions', 2, 5, 0, 90, 1),
(16, 'privacy', 'privacy', 2, 6, 0, 90, 1),
(17, 'main', '', 1, 1, 0, 90, 1),
(18, 'capabilities', 'capabilities', 1, 2, 0, 90, 1),
(19, 'prices', 'prices', 1, 3, 0, 90, 1),
(20, 'help', 'help', 1, 4, 0, 90, 1),
(21, 'blog', 'blog', 1, 5, 0, 90, 1),
(22, 'permissions', 'user/permissions', 5, 0, 0, 90, 1),
(23, 'profile', 'user/profile', 5, 0, 0, 90, 1);

-- --------------------------------------------------------

--
-- Структура таблиці `public_users`
--

DROP TABLE IF EXISTS `public_users`;
CREATE TABLE IF NOT EXISTS `public_users` (
  `u_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_f_user_id` int(11) NOT NULL,
  `u_name` varchar(255) DEFAULT NULL,
  `u_gender` int(11) NOT NULL,
  `u_lang` varchar(2) NOT NULL DEFAULT 'ru',
  `u_f_timezone` int(11) DEFAULT NULL,
  `u_image` varchar(100) NOT NULL,
  `u_settings` text,
  `read_level` int(11) NOT NULL DEFAULT '0',
  `write_level` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`u_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=30 ;

--
-- Дамп даних таблиці `public_users`
--

INSERT INTO `public_users` (`u_id`, `u_f_user_id`, `u_name`, `u_gender`, `u_lang`, `u_f_timezone`, `u_image`, `u_settings`, `read_level`, `write_level`, `owner`) VALUES
(1, 3, 'Tester', 1, 'ru', 0, '', NULL, 0, 0, 0),
(5, 13, 'Александр13', 1, 'ru', 13, 'avatar.jpg', '{"last_ws":"test123","last_ws_id":"5"}', 0, 0, 0),
(17, 33, 'Куликов', 1, 'ru', 13, '', NULL, 0, 0, 0),
(29, 35, 'bers_777', 1, 'ru', 13, 'avatar.jpg', '{"last_ws":"test123","last_ws_id":"5"}', 0, 0, 0),
(18, 32, 'Евгений', 1, 'ru', 13, 'avatar.jpg', '{"last_ws":"testing","last_ws_id":"9"}', 0, 0, 0),
(28, 37, 'Name', 1, 'ru', 13, '', '{"last_ws":"evgen301","last_ws_id":"6"}', 0, 0, 0),
(27, 36, 'evgen302', 1, 'ru', 13, 'avatar.jpg', '{}', 0, 0, 0);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Дамп даних таблиці `syst_defs_columns`
--

INSERT INTO `syst_defs_columns` (`def_id`, `table_name`, `field_name`, `field_type`, `field_href`, `field_require`, `field_uniq`, `field_caption`, `field_read_level`, `field_write_level`, `field_order`) VALUES
(1, 'public_users', 'u_id', 'id', NULL, 0, 0, 'id', 0, 90, 0),
(2, 'public_users', 'u_name', 'edit', NULL, 0, 0, 'Name', 0, 50, 0),
(3, 'public_users', 'u_soname', 'email', NULL, 0, 0, 'Soname', 0, 50, 0),
(4, 'public_users', 'u_settings', 'json', NULL, 0, 0, 'Settings', 0, 50, 0),
(5, 'public_users', 'u_f_user_id', 'id', NULL, 0, 0, 'user_id', 0, 40, 0),
(13, 'public_menus', 'menu_item_parent', 'select', NULL, 0, 0, 'menu_item_parent', 60, 60, 0),
(12, 'public_menus', 'menu_item_link', 'edit', NULL, 0, 0, 'menu_item_link', 0, 20, 0),
(11, 'public_menus', 'menu_item_name', 'edit', NULL, 0, 0, 'menu_item_name', 0, 20, 0),
(10, 'public_menus', 'menu_id', 'id', NULL, 0, 0, 'menu_id', 60, 60, 0),
(14, 'public_menus', 'menu_item_order', 'order', NULL, 0, 0, 'menu_item_order', 60, 60, 0);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Дамп даних таблиці `syst_defs_tables`
--

INSERT INTO `syst_defs_tables` (`tbl_def_id`, `table_name`, `table_read_level`, `table_write_level`, `table_insert_level`, `table_delete_level`) VALUES
(4, 'public_users', 0, 50, 0, 50),
(7, 'public_menus', 0, 20, 20, 20);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=214 ;

--
-- Дамп даних таблиці `syst_sessions`
--

INSERT INTO `syst_sessions` (`sess_id`, `sess_f_user_id`, `sess_user_token`, `sess_user_last_ip`, `sess_user_data`, `sess_user_last_activity`) VALUES
(213, 13, '0a315febd5ba9733e8363eda5816af15', '127.0.0.1', '/x2MAS4D5kvQyndAB5VtE86upxcpoGl4qdqdI6roCHgEsCmOOXCN6l+59OH5a7lMQOubNxA2gJEKdYAdpsMy/GS+xMVXgh5xJe4GGQHNnM+cAWbag+8wNY9kSwZLUfX/uoLdfoVFP9az+moAsv1/qs154/2eyYVXsspSsiUiQPXvGSBlpDn/c8hc3wMI2drnfzhnDxAcEaebQO44oHhcyKy0L9A2MZxOYOn8pQaNZb+LrueXc9kuM0mQ5Xe6LDNX', '2013-08-16 14:58:16');

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
(1, '1:30:0.0', '2013-08-16 14:02:49', '0:15:0.0', 'ababagalamaga');

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=38 ;

--
-- Дамп даних таблиці `syst_users`
--

INSERT INTO `syst_users` (`user_id`, `user_login`, `user_email`, `user_pass`, `user_is_active`, `user_f_group_id`, `user_reg_date`) VALUES
(1, 'admin', 'admin@admin.com', 'abLEFxdWWYR3c', 1, 1, '0000-00-00 00:00:00'),
(32, 'evgen301', 'evgen301@i.ua', '3703159c8e9d5b35c4a83bd89636ecb3', 1, 4, '2013-07-23 08:02:06'),
(13, 'evgen300', 'evgen300@i.ua', '763259646ecb5234653b19809bacc972', 1, 4, '2013-06-07 12:15:23'),
(35, '', 'bers_777@ukr.net', '763259646ecb5234653b19809bacc972', 1, 4, '2013-07-26 09:56:06'),
(36, 'evgen302', 'evgen302@i.ua', '763259646ecb5234653b19809bacc972', 1, 4, '2013-08-01 15:30:54'),
(37, '', 'olku@isd.dp.ua', '763259646ecb5234653b19809bacc972', 1, 4, '2013-08-02 09:43:33');

-- --------------------------------------------------------

--
-- Структура таблиці `tasks_viewers`
--

DROP TABLE IF EXISTS `tasks_viewers`;
CREATE TABLE IF NOT EXISTS `tasks_viewers` (
  `tv_ws_id` int(11) NOT NULL,
  `tv_viewer_id` int(11) NOT NULL,
  `tv_viewed_id` int(11) NOT NULL,
  PRIMARY KEY (`tv_viewed_id`,`tv_viewer_id`),
  KEY `fk_tasks_viewers_syst_users1_idx` (`tv_viewer_id`),
  KEY `fk_tasks_viewers_syst_users2_idx` (`tv_viewed_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `tasks_viewers`
--

INSERT INTO `tasks_viewers` (`tv_ws_id`, `tv_viewer_id`, `tv_viewed_id`) VALUES
(5, 35, 13),
(5, 13, 13),
(5, 13, 32),
(5, 35, 32);

-- --------------------------------------------------------

--
-- Структура таблиці `user_temp`
--

DROP TABLE IF EXISTS `user_temp`;
CREATE TABLE IF NOT EXISTS `user_temp` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `order` int(11) DEFAULT NULL,
  `email` varchar(250) NOT NULL,
  `verify_key` char(32) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '0',
  `lang` varchar(5) DEFAULT NULL,
  `referral` varchar(15) DEFAULT NULL,
  `invited_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `referral` (`referral`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=84 ;

--
-- Дамп даних таблиці `user_temp`
--

INSERT INTO `user_temp` (`id`, `order`, `email`, `verify_key`, `created_at`, `updated_at`, `is_active`, `lang`, `referral`, `invited_id`) VALUES
(83, NULL, 'olku@isd.dp.ua', 'd9d185386589cb44774c03f5e8ff3582', '2013-08-07 13:55:45', NULL, 0, 'ru', '357963292261551', NULL);

-- --------------------------------------------------------

--
-- Структура таблиці `workspaces`
--

DROP TABLE IF EXISTS `workspaces`;
CREATE TABLE IF NOT EXISTS `workspaces` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `package_id` varchar(45) DEFAULT '1',
  `creator_id` int(11) DEFAULT NULL,
  `subdomain` varchar(100) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `dt_added` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ws_status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `subdomain_UNIQUE` (`subdomain`),
  KEY `fk_workspaces_syst_users1_idx` (`creator_id`),
  KEY `fk_workspaces_packages1_idx` (`package_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

--
-- Дамп даних таблиці `workspaces`
--

INSERT INTO `workspaces` (`id`, `package_id`, `creator_id`, `subdomain`, `title`, `dt_added`, `ws_status`) VALUES
(5, '2', 13, 'test123', 'не Мастерская Ярослава Бирзула', '2013-08-07 12:47:27', 1),
(6, '1', 32, 'evgen301', 'Мастерская Ярослава', '2013-07-23 12:56:12', 1),
(7, '1', 13, 'myspace', 'не Мастерская Ярослава Бирзула', '2013-07-31 13:13:34', 0),
(8, '1', 32, 'evgen300', 'не Мастерская Ярослава Бирзула', '2013-08-01 14:09:27', 0),
(9, '2', 32, 'testing', 'testing', '2013-08-01 14:43:22', 0),
(10, '1', 32, 'ababababa', 'Workspot - школа дизайна', '2013-08-01 14:51:57', 1),
(11, '1', 36, 'evgen302', 'не Мастерская Ярослава Бирзула', '2013-08-01 15:30:54', 1);

-- --------------------------------------------------------

--
-- Структура таблиці `ws_invites`
--

DROP TABLE IF EXISTS `ws_invites`;
CREATE TABLE IF NOT EXISTS `ws_invites` (
  `wsi_f_ws_id` int(11) NOT NULL DEFAULT '0',
  `wsi_f_inviter_id` int(11) NOT NULL DEFAULT '0',
  `wsi_f_user_id` int(11) NOT NULL DEFAULT '0',
  `wsi_user_email` varchar(100) NOT NULL DEFAULT '',
  `wsi_token` varchar(45) DEFAULT NULL,
  `wsi_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`wsi_f_ws_id`,`wsi_f_inviter_id`,`wsi_f_user_id`,`wsi_user_email`),
  KEY `fk_ws_invites_syst_users1_idx` (`wsi_f_inviter_id`),
  KEY `fk_ws_invites_syst_users2_idx` (`wsi_f_user_id`),
  KEY `fk_ws_invites_workspaces1_idx` (`wsi_f_ws_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблиці `ws_ref_users`
--

DROP TABLE IF EXISTS `ws_ref_users`;
CREATE TABLE IF NOT EXISTS `ws_ref_users` (
  `wsru_f_user_id` int(11) NOT NULL,
  `wsru_f_ws_id` int(11) NOT NULL,
  `wsru_f_role_id` int(11) DEFAULT NULL,
  `wsru_status` int(11) DEFAULT NULL,
  `wsru_create_date` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`wsru_f_user_id`,`wsru_f_ws_id`),
  KEY `fk_ws_ref_users_workspaces1_idx` (`wsru_f_ws_id`),
  KEY `fk_ws_ref_users_ws_user_roles1_idx` (`wsru_f_role_id`),
  KEY `fk_ws_ref_users_syst_users1_idx` (`wsru_f_user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `ws_ref_users`
--

INSERT INTO `ws_ref_users` (`wsru_f_user_id`, `wsru_f_ws_id`, `wsru_f_role_id`, `wsru_status`, `wsru_create_date`) VALUES
(32, 5, 1, 1, '2013-07-23 09:02:06'),
(32, 6, 1, 1, '2013-07-23 12:56:12'),
(13, 6, 2, 1, '2013-07-26 08:03:04'),
(13, 5, 1, 1, '2013-07-26 08:03:41'),
(13, 9, 2, 1, '2013-08-16 07:46:06'),
(35, 6, 2, 1, '2013-07-26 09:56:06'),
(13, 7, 1, 0, '2013-07-31 13:13:34'),
(32, 8, 2, 1, '2013-08-01 14:10:20'),
(32, 9, 1, 1, '2013-08-01 14:43:22'),
(32, 10, 1, 1, '2013-08-01 14:51:57'),
(36, 11, 1, 1, '2013-08-01 15:30:54'),
(13, 8, 2, 0, '2013-08-05 07:30:42'),
(35, 5, 2, 1, '2013-08-16 07:48:31');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
