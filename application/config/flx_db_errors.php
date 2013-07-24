<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

$config['flx_db_common'] = array('COMMON_EMPTY_RESULT');

// DB errors 
// Format: $config['routine'] = array('error_code'=>'description(name)');

$config['flx_do_auth'] = array(
  '-3'=>'DO_AUTH_VAL_NOT_SET', /* do_auth : 'Some value not set' */
  '-2'=>'DO_AUTH_COMB_NOT_FOUND', /* do_auth : 'Combination not found' */
  '-1'=>'DO_AUTH_USER_NOT_ACTIVE', /* do_auth : 'User not activated' */
); 

$config['flx_add_user'] = array(
  '-2'=>'ADD_USER_EMPTY_EMAIL', /* add_user : 'Email  is empty' */
  '-1'=>'ADD_USER_EMPTY_PASS', /* add_user : 'Password  is empty' */
  '0' =>'ADD_USER_EMAIL_EXISTS', /* add_user : 'Email exists' */
); 

$config['flx_reg_user'] = array(
  '-2'=>'REG_USER_TOKEN_NOT_FOUND', /* reg_user : 'Reg token not found' */
  '-1'=>'REG_USER_EMPTY_USERDATA', /* reg_user : 'User data is empty' */
  '0' =>'REG_USER_ALREADY_REGISTERED', /* reg_user : 'User already registered' */
); 

$config['flx_reset_passwd'] = array(
  '-2'=>'RESET_PASSWD_TOKEN_NOT_FOUND', /* reset_passwd : 'Pass token not found' */
  '-1'=>'RESET_PASSWD_USER_NOT_FOUND', /* reset_passwd : 'User not found' */
); 

$config['flx_token_passwd'] = array(
  '-1'=>'TOKEN_PASSWD_EMPTY_EMAIL', /* token_passwd : 'Email is empty' */
  '0' =>'TOKEN_PASSWD_USER_NOT_FOUND', /* token_passwd : 'User not found' */
); 