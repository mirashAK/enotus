<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

$config['flx_auth_form'] = array (
          'type'    =>array('user_email'=>'email', 'user_pass'=>'pass'),
          'require' =>array('user_email', 'user_pass'),
          'unique' =>array('user_email'),
        );
        
$config['flx_reg_form'] = array (
          'type'    =>array('user_email'=>'email', 'user_pass'=>'pass', 'user_re_pass'=>'re_pass'),
          'require' =>array('user_email', 'user_pass'),
          'unique' =>array('user_email'),
        );

$config['flx_ch_pass_form_email'] = array (
          'type'    =>array('user_email'=>'email'),
          'require' =>array('user_email'),
        );
        
$config['flx_ch_pass_form'] = array (
          'caption'=>array('user_pass'=>'passwd', 'user_re_pass'=>'password'),
          'type'    =>array('user_pass'=>'pass', 'user_re_pass'=>'re_pass'),
          'require' =>array('user_pass', 'user_re_pass'),
        );