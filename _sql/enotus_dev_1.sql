-- phpMyAdmin SQL Dump
-- version 4.0.2
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Час створення: Чрв 11 2013 р., 12:01
-- Версія сервера: 5.5.30-log
-- Версія PHP: 5.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База даних: `enotus_dev`
--
CREATE DATABASE IF NOT EXISTS `enotus_dev` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `enotus_dev`;

DELIMITER $$
--
-- Процедури
--
DROP PROCEDURE IF EXISTS `create_table`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_table`(IN in_table_name VARCHAR(40), IN in_columns TEXT,
	IN in_sel TINYINT UNSIGNED, IN in_upd TINYINT UNSIGNED, IN in_ins TINYINT UNSIGNED, IN in_del TINYINT UNSIGNED)
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
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_columns_defs`(IN in_table_name varchar(40), IN in_read_level INT, IN in_write_level INT, OUT out_columns varchar(255), OUT out_defs varchar(512))
BEGIN
	DECLARE var_is_end BOOLEAN DEFAULT false;
	DECLARE var_column varchar(100) DEFAULT "";
	DECLARE var_def varchar(100) DEFAULT "";
	DECLARE var_caption varchar(100) DEFAULT "";
	DECLARE result_cursor CURSOR FOR SELECT `field_name`,`field_type`,`field_caption` FROM `syst_defs_columns` WHERE `table_name` = in_table_name AND `field_read_level` <= in_read_level AND `field_write_level` <= in_write_level;
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET var_is_end = true;

	OPEN result_cursor;
-- '{"name":{"type":"type","caption":"caption","value":"value"}}'
	FETCH result_cursor INTO var_column, var_def, var_caption;
	IF var_is_end != true THEN
		SET out_columns = CONCAT ("`", var_column);
		SET out_defs = CONCAT ('{"', var_column, '":{"type":"', var_def, '","caption":"', var_caption, '"}');
		WHILE var_is_end != true DO
			FETCH result_cursor INTO var_column, var_def, var_caption;
			IF var_is_end != true THEN
				SET out_columns = CONCAT (out_columns, "`,`", var_column);
				SET out_defs = CONCAT (out_defs, ', "', var_column, '":{"type":"', var_def, '","caption":"', var_caption, '"}');
			END IF;
		END WHILE;
		SET out_columns = CONCAT (out_columns, "`");
		SET out_defs = CONCAT (out_defs, "}");
	END IF;

	CLOSE result_cursor;
END$$

DROP PROCEDURE IF EXISTS `get_signature`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_signature`(IN in_user_token VARCHAR(40), IN in_ip VARCHAR(15), IN in_table_name varchar(40))
    READS SQL DATA
BEGIN
	DECLARE var_query VARCHAR(255);
	DECLARE var_active_user_id INT;
	/* Variables for permitted columns */
	DECLARE var_selected_columns VARCHAR(255);
	DECLARE var_selected_defs VARCHAR(255);
	DECLARE var_selected_captions VARCHAR(255);
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
		SET @query = CONCAT("SELECT `group_read_level` INTO @read_level FROM `syst_groups` WHERE `group_id` = (SELECT `user_f_group_id`  FROM `syst_users` WHERE `user_id` = ", var_active_user_id, " LIMIT 1) LIMIT 1");
		ELSE SET @query = CONCAT("SELECT `group_read_level` INTO @read_level FROM `syst_groups` WHERE `group_name` = 'guests' LIMIT 1");
		END IF;
		PREPARE var_query FROM @query;
		EXECUTE var_query;
		DEALLOCATE PREPARE var_query;

		CALL get_columns_defs(in_table_name, @read_level, 100, @var_selected_columns, @var_selected_defs);

		/* Give out columns definions */
		SELECT @var_selected_defs AS columns_defs;
	END IF;
END$$

DROP PROCEDURE IF EXISTS `get_table`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_table`(IN in_user_token VARCHAR(40), IN in_ip VARCHAR(15), IN in_table_name varchar(40), IN in_where varchar(100), IN in_order varchar(100), IN in_limit varchar(30))
    READS SQL DATA
BEGIN
	DECLARE var_query VARCHAR(255);
	DECLARE var_conditions VARCHAR(255) DEFAULT "";
	DECLARE var_active_user_id INT;
	/* Variables for permitted columns */
	DECLARE var_selected_columns VARCHAR(255);
	DECLARE var_selected_defs VARCHAR(255);
	DECLARE var_selected_captions VARCHAR(255);
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
		SET @query = CONCAT("SELECT `group_read_level` INTO @read_level FROM `syst_groups` WHERE `group_id` = (SELECT `user_f_group_id`  FROM `syst_users` WHERE `user_id` = ", var_active_user_id, " LIMIT 1) LIMIT 1");
		ELSE SET @query = CONCAT("SELECT `group_read_level` INTO @read_level FROM `syst_groups` WHERE `group_name` = 'guests' LIMIT 1");
		END IF;
		PREPARE var_query FROM @query;
		EXECUTE var_query;
		DEALLOCATE PREPARE var_query;

		CALL get_columns_defs(in_table_name, @read_level, 100, @var_selected_columns, @var_selected_defs);

		/* Give out columns definions */
		SELECT @var_selected_defs AS columns_defs;

		/* Form conditions */
		IF CHAR_LENGTH(in_where)>0 THEN
			SET var_conditions = CONCAT(var_conditions, " WHERE (", in_where, ")");
			SET var_conditions = CONCAT(var_conditions, " AND (`owner` = ", var_active_user_id, " OR `read_level` <= ", @read_level,")");
		ELSE
			SET var_conditions = CONCAT(var_conditions, " WHERE (`owner` = ", var_active_user_id, " OR `read_level` <= ", @read_level,")");
		END IF;

		/* Try to count rows */
		SET @query = CONCAT("SELECT COUNT(*) INTO @all_rows_count FROM `", in_table_name, "`", var_conditions);
		PREPARE var_query FROM @query;
		EXECUTE var_query;
		DEALLOCATE PREPARE var_query;

		/* Form other conditions */
		IF CHAR_LENGTH(in_order)>0 THEN SET var_conditions = CONCAT(var_conditions, " ORDER BY ", in_order); END IF;
		IF CHAR_LENGTH(in_limit)>0 THEN SET var_conditions = CONCAT(var_conditions, " LIMIT ", in_limit); END IF;

		
		/* Main result query */
		SET @query = CONCAT("SELECT ", @var_selected_columns, " FROM `", in_table_name, "`", var_conditions);
		-- SELECT @query;
		PREPARE var_query FROM @query;
		EXECUTE var_query;
		DEALLOCATE PREPARE var_query; 

		/* Give out total rows count */
		SELECT @all_rows_count AS total_count;

    END IF;

END$$

DROP PROCEDURE IF EXISTS `get_user`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_user`(IN in_user_token VARCHAR(40), IN in_ip VARCHAR(15))
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
			`usr`.`user_login` AS 'login', `usr`.`user_email` AS 'email', `usr`.`user_is_active` AS 'is_active', `usr`.`user_f_group_id` AS 'group_id'
			FROM `syst_users` AS `usr`
			WHERE `usr`.`user_id` = var_user_id LIMIT 1; 
			/*`uinf`.`user_info_id`
			LEFT JOIN `public_users_info` AS `uinf` ON (`usr`.`user_id`=`uinf`.`user_info_f_user_id`)*/

		END CASE;

    END IF; /* IF (in_ip = '') THEN */

END$$

DROP PROCEDURE IF EXISTS `get_users`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_users`(IN in_user_token varchar(40), IN in_ip varchar(15))
    READS SQL DATA
BEGIN
    DECLARE var_token_is_active TINYINT;

    SELECT check_token (in_user_token, in_ip) INTO var_token_is_active;

   
    IF (var_token_is_active = 0) THEN
        SELECT 'ERROR: Token not found';
    ELSE SELECT in_ip;
    END IF;

END$$

--
-- Функції
--
DROP FUNCTION IF EXISTS `add_user`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `add_user`(in_login varchar(150), in_email varchar(150), in_pass varchar(250)) RETURNS varchar(600) CHARSET utf8
    READS SQL DATA
BEGIN
	DECLARE var_user_code CHAR( 40 );
	DECLARE var_user_id INT( 11 );
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
	WHERE `user_email` LIKE in_email;

	IF (var_user_id IS NULL) THEN

		SET in_pass = gen_passwd (in_pass, '');
		SET var_user_code = MD5 ( CONCAT( in_email, RAND(), in_login, NOW() ) );

		INSERT INTO `syst_sessions` (`sess_user_token`, `sess_user_data`, `sess_user_last_activity`)
		VALUES ( var_user_code, CONCAT("'", in_email, "','", in_login, "','", in_pass, "'"), NOW());

		/* INSERT INTO `syst_users` (`user_login`,`user_email`,`user_pass`, `user_reg_code`, `user_is_active`)
		VALUES (in_login, in_email, in_pass, var_user_code, 0); */

		RETURN CONCAT('?token=', var_user_code);
	ELSE
		RETURN '0'; /* ERROR: Email exists */
	END IF;
END$$

DROP FUNCTION IF EXISTS `check_token`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `check_token`(`in_user_token` VARCHAR(40), `in_ip` VARCHAR(15)) RETURNS int(11)
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
CREATE DEFINER=`root`@`localhost` FUNCTION `clear_input_data`( in_data varchar(255) ) RETURNS varchar(255) CHARSET utf8
    NO SQL
BEGIN
	SET in_data = TRIM(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(in_data,'%',''),'"',''),"'",''),'<',''),'>',''),')',''),'(',''),';',''));
	RETURN in_data;  
END$$

DROP FUNCTION IF EXISTS `do_auth`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `do_auth`(auth_key varchar(150), pass varchar(255), ip varchar(15), exist_token varchar(40)) RETURNS varchar(40) CHARSET utf8
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
CREATE DEFINER=`root`@`localhost` FUNCTION `gen_passwd`(in_pass varchar(250), in_salt varchar(40)) RETURNS varchar(80) CHARSET utf8
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

DROP FUNCTION IF EXISTS `reg_user`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `reg_user`(reg_token varchar(40), ip varchar(15), exist_token varchar(40)) RETURNS varchar(40) CHARSET utf8
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

DROP FUNCTION IF EXISTS `set_session`$$
CREATE DEFINER=`root`@`localhost` FUNCTION `set_session`(in_user_token VARCHAR(40), in_ip VARCHAR(15), in_data TEXT) RETURNS varchar(40) CHARSET utf8
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

DELIMITER ;

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
(3, 'База документов', 'documents', 1, 1, 0, 80, 1),
(4, 'О проекте', 'about', 1, 2, 0, 80, 1),
(5, 'Тарифы', 'tariffs', 1, 3, 0, 80, 1),
(6, 'F.A.Q.', 'faq', 1, 4, 0, 80, 1),
(7, 'Контактная информация', 'contacts', 1, 5, 0, 80, 1);

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
  `u_f_user_id` int(11) NOT NULL,
  `u_name` varchar(40) DEFAULT NULL,
  `u_soname` varchar(50) DEFAULT NULL,
  `u_settings` text,
  `read_level` int(11) NOT NULL DEFAULT '0',
  `write_level` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`u_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Дамп даних таблиці `public_users`
--

INSERT INTO `public_users` (`u_id`, `u_f_user_id`, `u_name`, `u_soname`, `u_settings`, `read_level`, `write_level`, `owner`) VALUES
(1, 3, 'Tester', 'Testovich', NULL, 0, 0, 0),
(2, 13, 'AAA', 'BBB', NULL, 0, 0, 0);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COMMENT='Column type definitions for create_table function' AUTO_INCREMENT=5 ;

--
-- Дамп даних таблиці `syst_column_types`
--

INSERT INTO `syst_column_types` (`sct_id`, `sct_alias`, `sct_type`) VALUES
(1, 'json', 'TEXT'),
(2, 'id', 'INT(11)'),
(3, 'pass', 'VARCHAR(100)'),
(4, 'email', 'VARCHAR(50)');

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
  `field_caption` varchar(100) DEFAULT NULL,
  `field_read_level` smallint(6) DEFAULT NULL,
  `field_write_level` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`def_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=52 ;

--
-- Дамп даних таблиці `syst_defs_columns`
--

INSERT INTO `syst_defs_columns` (`def_id`, `table_name`, `field_name`, `field_type`, `field_caption`, `field_read_level`, `field_write_level`) VALUES
(37, 'public_articles_new_test', 'ant_id', 'id', NULL, 90, 90),
(3, 'public_main_menu', 'menu_item_name', 'edit', 'menu_item_name', 0, 50),
(4, 'public_main_menu', 'menu_item_link', 'edit', 'menu_item_link', 0, 50),
(5, 'public_main_menu', 'owner', 'id', 'owner', 80, 50),
(6, 'public_static_pages', 'static_page_id', 'id', 'id', 20, 50),
(7, 'public_static_pages', 'static_page_alias', 'edit', 'alias', 0, 50),
(8, 'public_static_pages', 'static_page_text', 'text', 'text', 0, 50),
(10, 'public_categories', 'cat_id', 'id', 'id', 0, 80),
(11, 'public_categories', 'cat_name', 'edit', 'name', 0, 80),
(12, 'public_categories', 'cat_alias', 'edit', 'alias', 0, 80),
(13, 'public_categories', 'cat_parent_id', 'id', 'parent_id', 0, 80),
(14, 'public_articles', 'article_id', 'id', 'id', 0, 50),
(15, 'public_articles', 'article_name', 'edit', 'name', 0, 50),
(16, 'public_articles', 'article_alias', 'edit', 'alias', 0, 50),
(17, 'public_articles', 'article_text', 'edit', 'text', 0, 50),
(18, 'hrefs_articles_to_categories', 'href_cat_id', 'id', 'cat_id', 0, 50),
(19, 'hrefs_articles_to_categories', 'href_article_id', 'id', 'article_id', 0, 50),
(20, 'public_sessions_data', 'sess_data_user_data', 'json', 'session_data', 0, 0),
(38, 'public_articles_new_test', 'ant_name', 'VARCHAR(100)', NULL, 40, 60),
(39, 'public_articles_new_test', 'ant_alias', 'VARCHAR(100)', NULL, 40, 60),
(40, 'public_articles_new_test', 'ant_email', 'email', NULL, 40, 60),
(41, 'public_articles_new_test', 'ant_data', 'json', NULL, 40, 60),
(42, 'public_users', 'u_id', 'id', 'id', 0, 90),
(43, 'public_users', 'u_name', 'varchar(40)', 'Name', 0, 50),
(44, 'public_users', 'u_soname', 'varchar(50)', 'Soname', 0, 50),
(45, 'public_users', 'u_settings', 'json', 'Settings', 0, 50),
(46, 'public_users', 'u_f_user_id', 'id', 'user_id', 0, 40);

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
(3, 'public_articles_new_test', 40, 60, 40, 60),
(4, 'public_users', 0, 50, 0, 50);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=238 ;

--
-- Дамп даних таблиці `syst_sessions`
--

INSERT INTO `syst_sessions` (`sess_id`, `sess_f_user_id`, `sess_user_token`, `sess_user_last_ip`, `sess_user_data`, `sess_user_last_activity`) VALUES
(237, 0, '79980daf182428c366c51755e7f340db', '127.0.0.1', '6XnsVk/qXMM1+S02+wjRI92iZB0fkGyQk4IQq9JGWQkyf2VdgbiFnpCl8DcMmyexOKGtWX/aaHM/k26x4Nha4w', '2013-06-11 08:00:40');

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
(1, '0:05:0.0', '2013-06-11 07:57:09', '0:01:0.0', 'ababagalamaga');

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
  `user_f_group_id` int(11) NOT NULL DEFAULT '2',
  `user_reg_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_login` (`user_login`,`user_email`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

--
-- Дамп даних таблиці `syst_users`
--

INSERT INTO `syst_users` (`user_id`, `user_login`, `user_email`, `user_pass`, `user_is_active`, `user_f_group_id`, `user_reg_date`) VALUES
(1, 'admin', 'admin@admin.com', 'abLEFxdWWYR3c', 1, 1, '0000-00-00 00:00:00'),
(2, 'user', 'user@user.com', 'df7f48cfa90519dc72aa72c9c8e869b3', 1, 3, '0000-00-00 00:00:00'),
(3, 'test', 'test@mail', '763259646ecb5234653b19809bacc972', 1, 3, '2013-06-06 07:17:11'),
(5, 'some_user', 'some@some.net', 'df7f48cfa90519dc72aa72c9c8e869b3', 1, 2, '2013-05-22 13:29:18'),
(6, 'some2_user', 'some2@some.net', 'df7f48cfa90519dc72aa72c9c8e869b3', 0, 2, '2013-05-22 13:35:58'),
(13, '', 'evgen300@i.ua', '763259646ecb5234653b19809bacc972', 1, 2, '2013-06-07 12:15:23');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
