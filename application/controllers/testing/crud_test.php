<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Crud_Test extends Test_Controller
{ 
  public function index()
  {
      $this->load->helper('url');
        
      $this->load->library('grocery_CRUD');
    
      $crud = new grocery_CRUD();
  
      $crud->set_table('public_users')
              ->set_subject('User');
              
      $crud->set_theme('flexigrid');
  
      $output = $crud->render();
  
      $this->load->view('example',$output);
  }
  
}