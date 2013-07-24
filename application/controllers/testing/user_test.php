<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class User_Test extends Test_Controller {

	public function index()
	{
      $this->load->library('list_builder');
      $this->load->model('users_mdl');
      
//       $this->list_builder->list_data = $this->users_mdl->get_users_list($this->user);
//       $this->list_builder->draw_table();
//       echo('<br/>');
//       $this->form_builder->form_data = $this->users_mdl->get_user($this->user);
//       $this->form_builder->draw_form();
      
      $this->parse_out('layouts/testing/user_test_view');
	}
	
}

/* End of file welcome.php */
/* Location: ./application/controllers/welcome.php */