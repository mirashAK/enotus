<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Auth extends Front_Controller
{ 
  function __construct()
  {
    parent::__construct();

      $this->load->model('users_mdl');
      $this->load->model('auth_mdl');
      
  }

  public function xhr_reg()
  {
    $reg_form = Form_Builder::factory('reg_form');
    $reg_form->form_data = $this->auth_mdl->get_user_reg_signature();
    if ($reg_form->validate() == true)
    { 
      $token = $this->user->add_user($reg_form->user_email, $reg_form->user_pass, '', array('u_f_country'=>$reg_form->u_f_country, 'u_name'=>$reg_form->u_name));
      $this->_send_registration_email($reg_form->user_email, $token);
      //$reg_form->xhr_answer->view = 
    }
    else
    {
    }
      
    $reg_form->draw_form();
  }

  public function reg()
  {
    if ($this->input->get('token') == false) redirect(sub_url(), 'refresh');

    $result = $this->user->reg_user();
    
    if ($result !== false)
    {

    }
    else redirect(sub_url(), 'refresh');
  }
  
  public function xhr_auth()
  {
    $auth_form = Form_Builder::factory('auth_form');
    if ($auth_form->validate() == true)
    {
        $result = $this->user->do_auth($auth_form->user_email, $auth_form->user_pass);

        if ($result === false)
        {
          if ($this->user->error_code == '-2') $form->errors['password'][] = $this->user->error;
          if ($this->user->error_code == '-1') $form->errors['password'][] = $this->user->error;
        }
        else $auth_form->xhr_answer->redirect = sub_url();
    }
    $auth_form->draw_form();
    
  }

  private function _send_registration_email ($email, $token)
 {
    //$this->lang->load('site/emails', lang());
    $subject = '=?UTF-8?B?' . base64_encode( $this->lang->line('restoration_email_subject')) . "?=";
    
    $this->view_data['verify_url'] = sub_url('auth/reg').'?token='.$token;
    $message = $this->parse_in('layouts/email/reg_email');
    
    // Headers
    $headers = 'MIME-Version: 1.0' . "\r\n";
    $headers .= 'Content-type: text/html; charset=utf-8' . "\r\n";
    $headers .= 'Content-Transfer-Encoding: 8bit' . "\r\n";
    $headers .= 'From: Startask <invite@startask.com>' . "\r\n";
    $headers .= "Reply-To: invite@startask.com\r\n";

    // Sending email
    mail($email, $subject, $message, $headers);
 }

}