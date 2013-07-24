<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Session_Test extends Test_Controller {

	public function index()
	{
      //$this->load->library('session');
      $this->load->model('users_mdl');
      
      $auth_form = Form_Builder::factory('auth_form', sub_url('/testing/session_test/auth'));
      $reg_form = Form_Builder::factory('reg_form', sub_url('/testing/session_test/add_user'));
      
      $this->view_data['auth_form'] = $auth_form->draw_form('layouts/testing/forms/auth_form', $this->view_data);
      $this->view_data['reg_form'] = $reg_form->draw_form('layouts/testing/forms/reg_form', $this->view_data);
      
      if ($this->user_session->get_params)
      {
        $this->view_data['get_params'] = $this->user_session->get_params;
        $this->view_data['reg_form'] = $this->parse_in('layouts/testing/forms/success_view');
      }
      
      $this->view_data['user_token'] = $this->user->user_token;
      $this->view_data['user_ip'] = $this->user->user_ip;
      $this->view_data['sess_last_activity'] = $this->user_session->sess_last_activity;
      $this->view_data['user_dump'] = var_export($this->user, true);
      $this->view_data['session_dump'] = var_export($this->user_session->get_full_sess_data(), true);
      
      
      //$this->user_session->save();
      
      $this->parse_out('layouts/testing/sesssion_test_view');
	}
	
	public function auth()
    {
      $auth_form = Form_Builder::factory('auth_form');
      
      if ($auth_form->validate() == true)
      {
        $auth_result = $this->user->do_auth($auth_form->user_email, $auth_form->user_pass);
        if ($auth_result !== true) $auth_form->errors['user_email'][] = $auth_result; 
      }
      if ($this->input->is_ajax_request())
      {
        $auth_form->xhr_answer->redirect = sub_url('testing/session_test');
        $auth_form->draw_form('layouts/testing/forms/auth_form', $this->view_data);
      }
      else redirect(sub_url('testing/session_test'), 'refresh');
    }
    
    public function add_user()
    {
      $reg_form = Form_Builder::factory('reg_form');
      
      if ($reg_form->validate() === true)
      {
        if ($this->input->is_ajax_request())
        {
          $reg_form->xhr_answer->view = '<a href="'.sub_url('/testing/session_test/reg_user'.$this->user->add_user ($reg_form->user_email, $reg_form->user_pass)).'">Reg</a>';
          $reg_form->draw_form();
        }
      }
      else $reg_form->draw_form('layouts/testing/forms/auth_form', $this->view_data);
    }
    
    public function reg_user()
    {
      $token = $this->input->get('token');
      if (!empty($token))
      {
        $this->user_session->registered = $this->user->reg_user();
      }
      if ($this->user_session->registered == true)
        redirect(sub_url('testing/session_test'), 'refresh');
    }
    
    public function logout()
    {
      if ($this->user->logout() == true) redirect(sub_url('testing/session_test'), 'refresh');
    }
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */