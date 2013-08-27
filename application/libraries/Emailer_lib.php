<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Emailer_lib
{

  protected $CI = null;
  protected $HTML_headers = '';
  protected $view_data = array();
  
  function __construct()
  {
    $this->CI =& get_instance();
    
    $this->view_data['site_name'] = str_replace('http://', '', base_url());
    $this->view_data['base_url'] = base_url();
    $this->view_data['sub_url'] = sub_url();
    $this->view_data['res_url'] = res_url();
    
    // HTML headers
    $this->HTML_headers = 'MIME-Version: 1.0' . "\r\n";
    $this->HTML_headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
    $this->HTML_headers .= 'Content-Transfer-Encoding: 8bit' . "\r\n";
    $this->HTML_headers .= 'From: Startask <invite@startask.com>' . "\r\n";
    $this->HTML_headers .= "Reply-To: invite@startask.com\r\n";
  }
  
  public function send_ws_invite_email ($email, $verify_url, $workspace)
  {
    $this->CI->lang->load('site/emails', lang());
    $subject = '=?UTF-8?B?' . base64_encode( $this->CI->lang->line('ws_invite_subject')) . "?=";
    
    $this->view_data['verify_url'] = $verify_url;
    $this->view_data['user_name'] = $this->CI->user->user_name;
    $this->view_data['workspace'] = $workspace;
    
    $message = $this->CI->parser->parse('email/'.lang().'/ws_invite_email', $this->view_data, true);

    // Sending email
    mail($email, $subject, $message,  $this->HTML_headers);
  }
  
  public function send_reg_email($email, $verify_url)
  {
    $this->CI->lang->load('site/emails', lang());
    $subject = '=?UTF-8?B?' . base64_encode( $this->CI->lang->line('registration_email_subject')) . "?=";
    
    $this->view_data['verify_url'] = $verify_url;
    $message = $this->CI->parser->parse('email/'.lang().'/reg_email', $this->view_data, true);
    
    // Sending email
    mail($email, $subject, $message, $this->HTML_headers);
  }
 
  public function send_restoration_email ($email, $verify_url)
  {
    $this->CI->lang->load('site/emails', lang());
    $subject = '=?UTF-8?B?' . base64_encode( $this->CI->lang->line('restoration_email_subject')) . "?=";
    
    $this->view_data['verify_url'] = $verify_url;
    $message = $this->CI->parser->parse('email/'.lang().'/restore_pass_email', $this->view_data, true);

    // Sending email
    mail($email, $subject, $message, $this->HTML_headers);
  }
  
}