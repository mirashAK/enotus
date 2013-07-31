<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Static_pages extends Front_Controller {

  function __construct() {
      parent::__construct();
     $this->load->model('static_pages_model', 'model');
     $this->load->model('main_menu_model', 'main_menu');
  }

  public function _remap($method)
  {
    $page = array();
    $main_menu = array();
    if (!empty($method))
    {
      $page = $this->model->get_page($method, $this->user);
      $main_menu = $this->main_menu->get_main_menu($this->user);
    }

    if (empty($page)) redirect('home');
   
     $main_menu_items = $main_menu->values;
     
    $this->view_data['head_part'] = $this->parser->parse('layouts/header', array('base_url'=>base_url(), 'main_menu_items'=>$main_menu_items), true);
    $this->view_data['foot_part'] = $this->parser->parse('layouts/footer', array('base_url'=>base_url(), 'main_menu_items'=>$main_menu_items), true);
    
    if ($method == 'home')
      $this->view_data['carousel'] = $this->parser->parse('layouts/carousel', array('base_url'=>base_url()), true);
    else 
      $this->view_data['carousel'] = '';
      
    $this->view_data['main_content'] = $page->value->static_page_text;
    
    $this->view_data['modal_login'] = $this->parser->parse('layouts/modals/login', array(), true);
    $this->view_data['modal_registration'] = $this->parser->parse('layouts/modals/registration', array(), true);
    
    $this->parser->parse('layouts/main', $this->view_data);
  }

} 
