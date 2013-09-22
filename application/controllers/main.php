<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed'); 

class Main extends Front_Controller
{

  public function _remap($method)
  {
    if (!empty($method) && $method!=='index') $this->static_page($method);
    else $this->index();
  }
  
  public function index()
  {
    $this->view_data['site_title'] = $this->lang->line('title_main_page');
    
    $this->view_data['site_header'] .= $this->parse_in(lang().'/carousel_view');
    $this->view_data['site_body'] = $this->parse_in(lang().'/front_content_view');
    
    $this->parse_out('main_view');
  }
  
  
  public function static_page($page_alias)
  {
    $this->load->model('static_pages_model', 'static_pages');
    
    $this->view_data['site_title'] = $this->lang->line('title_main_page');
    
    $this->view_data['breadcrumbs'] = $this->menu_lib->create_bradcrumbs();
    
    $page = $this->static_pages->get_page($page_alias, $this->user);
    
    if ($page->value !== false) $this->view_data['site_body'] = $page->value->static_page_text;
    
    $this->parse_out('main_view');
  }
  
}