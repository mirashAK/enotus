<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Emailer_lib
{

  protected $CI = null;
  protected $HTML_headers = '';
  protected $view_data = array();
  
  function __construct()
  {
    $this->CI =& get_instance();
    
    $this->view_data['site_name'] = preg_replace('~^http://|/\w{2}/?$~', '', base_url());
    $this->view_data['site_Name'] = ucfirst($this->view_data['site_name']);
    $this->view_data['base_url'] = base_url();
    $this->view_data['sub_url'] = sub_url();
    $this->view_data['res_url'] = res_url();
    $this->view_data['res_img'] = res_url('assets/img/');
    
    $this->CI->lang->load('site/emails', lang());
    
    // HTML headers
    $this->HTML_headers = 'MIME-Version: 1.0' . "\r\n";
    $this->HTML_headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
    $this->HTML_headers .= 'Content-Transfer-Encoding: 8bit' . "\r\n";
    $this->HTML_headers .= 'From: '.$this->view_data['site_name'].' <invite@'.$this->view_data['site_name'].'>' . "\r\n";
    $this->HTML_headers .= 'Reply-To: invite@'.$this->view_data['site_name']."\r\n";
  }
  

  public function send_registration_email ($email, $token)
  {
    //$this->lang->load('site/emails', lang());
    $subject = '=?UTF-8?B?' . base64_encode( $this->CI->lang->line('email_registration_subject')) . "?=";
    
    $this->view_data['verify_url'] = sub_url('auth/reg').'?token='.$token;
    $message = $this->CI->parser->parse('layouts/email/reg_email', $this->view_data, true);
    
    // Sending email
    mail($email, $subject, $message, $this->HTML_headers);
  }
  
  public function send_ch_pass_email ($email, $token)
  {
    //$this->lang->load('site/emails', lang());
    $subject = '=?UTF-8?B?' . base64_encode( $this->CI->lang->line('email_restoration_subject')) . "?=";
    
    $this->view_data['verify_url'] = sub_url('auth/change_pass').$token;
    $message = $this->CI->parser->parse('layouts/email/ch_pass_email', $this->view_data, true);
    
    // Sending email
    mail($email, $subject, $message, $this->HTML_headers);
  }
  
}