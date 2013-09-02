<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Auth extends Front_Controller
{ 
  function __construct()
  {
    parent::__construct();

      $this->load->model('users_mdl');
      $this->load->library('emailer_lib', array(), 'emailer');
  }

  public function xhr_reg()
  {
    $reg_form = Form_Builder::factory('reg_form');
    $reg_form->form_data = $this->auth_mdl->get_user_reg_signature();
    if ($reg_form->validate() == true)
    { 
      $token = $this->user->add_user($reg_form->user_email, $reg_form->user_pass, $reg_form->user_email, array('u_f_country'=>$reg_form->u_f_country, 'u_name'=>$reg_form->u_name, 'u_lang'=>lang()));
      $this->emailer->send_registration_email($reg_form->user_email, $token);
      $this->view_data['user_email'] = $reg_form->user_email;
      $reg_form->xhr_answer->view = $this->parse_in('layouts/messages/modal_reg_success_mess');
    }
    $reg_form->draw_form();
  }

  public function reg()
  {
    if ($this->input->get('token') == false) $this->redirect(sub_url());

    $result = $this->user->reg_user();
    
    if ($result !== false)
    {
      $this->redirect(sub_url());
    }
    else $this->redirect(sub_url());
  }
  
  public function xhr_auth()
  {
    $auth_form = Form_Builder::factory('auth_form');
    if ($auth_form->validate() == true)
    {
        $result = $this->user->do_auth($auth_form->user_email, $auth_form->user_pass);

        if ($result === false)
        { 
          if ($this->user->error_code == '-2') $auth_form->errors[$auth_form->name['user_pass']][] = $this->user->error;
          if ($this->user->error_code == '-1') $auth_form->errors[$auth_form->name['user_pass']][] = $this->user->error;
        }
        else
        {
          // Create header controls
          $this->view_data['main_menu_items'] = $this->menu_lib->create_main_menu();
          $this->view_data['user_menu_items'] = $this->menu_lib->create_user_menu();
          $this->view_data['user_public'] = (array)$this->user->user_public;
          $this->view_data['user_controls_panel'] = $this->parse_in(lang().'/header_user_reg_view'); 
          $auth_form->xhr_answer->view = $this->parse_in(lang().'/header_inside_view');
        }
    }
    $auth_form->draw_form();
  }
  
  public function logout()
  {
    $this->user->logout();
    $this->redirect(sub_url());
  }
  
  public function restoration()
  {
    $this->view_data['site_title'] = $this->lang->line('title_auth_restoration');
    
    $res_pass_form = Form_Builder::factory('ch_pass_email_form', sub_url('auth/xhr_send_ch_pass_email'));
    
    $this->view_data['site_body'] = $res_pass_form->draw_form('layouts/forms/ch_pass_email_form', $this->view_data);
    
    $this->parse_out('main_view');
  }

  public function xhr_send_ch_pass_email()
  { 
    $res_pass_form = Form_Builder::factory('ch_pass_email_form');
    
    if ($res_pass_form->validate() == true)
    { 
      $token = $this->user->token_passwd($res_pass_form->user_email);
      $this->emailer->send_ch_pass_email($res_pass_form->user_email, $token);
      $this->view_data['user_email'] = $res_pass_form->user_email;
      $res_pass_form->xhr_answer->view = $this->parse_in('layouts/messages/ch_pass_email_mess');
    }
    $res_pass_form->draw_form();
  }
  
  public function change_pass()
  {
    if ($this->input->get('token') == false) $this->redirect(sub_url('auth/restoration'));
    $this->user_session->pass_reset_token = $this->input->get('token');
  
    $this->view_data['site_title'] = $this->lang->line('title_auth_change_pass');
    
    $res_pass_form = Form_Builder::factory('ch_pass_form', sub_url('auth/xhr_ch_pass'));
    
    $this->view_data['site_body'] = $res_pass_form->draw_form('layouts/forms/ch_pass_form', $this->view_data);
    
    $this->parse_out('main_view');
  }
  
  public function xhr_ch_pass()
  { 
    if ($this->user_session->pass_reset_token == false) $this->redirect(sub_url('auth/restoration'));

    $res_pass_form = Form_Builder::factory('ch_pass_form');
    
    if ($res_pass_form->validate() == true)
    { 
      $this->user->reset_passwd($this->user_session->pass_reset_token, $res_pass_form->user_pass);
      $res_pass_form->xhr_answer->redirect = sub_url();
      $this->user_session->pass_reset_token = '';
    }
    $res_pass_form->draw_form();
  }
}