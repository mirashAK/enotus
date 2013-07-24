-- phpMyAdmin SQL Dump
-- version 4.0.2
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Час створення: Чрв 11 2013 р., 12:02
-- Версія сервера: 5.5.30-log
-- Версія PHP: 5.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- База даних: `enotus_test`
--
CREATE DATABASE IF NOT EXISTS `enotus_test` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `enotus_test`;

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Дамп даних таблиці `public_users`
--

INSERT INTO `public_users` (`u_id`, `u_f_user_id`, `u_name`, `u_soname`, `u_settings`, `read_level`, `write_level`, `owner`) VALUES
(1, 3, 'Tester', 'Testovich', NULL, 0, 0, 0);

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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=237 ;

--
-- Дамп даних таблиці `syst_sessions`
--

INSERT INTO `syst_sessions` (`sess_id`, `sess_f_user_id`, `sess_user_token`, `sess_user_last_ip`, `sess_user_data`, `sess_user_last_activity`) VALUES
(236, 0, 'e99d17b81654ca8d608ee870b548b9b0', '127.0.0.1', 'Vs0gcPNf6cvd1LSDly4Nq3qZNXbrf87v2y4j5gYVWpd+TMgBvH7sCLUYmO52vRKj8IBd+33wK2Gb+puJniAL3Q', '2013-06-11 08:01:28');

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
(1, '0:05:0.0', '2013-06-11 08:01:04', '0:01:0.0', 'ababagalamaga');

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
