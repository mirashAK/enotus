<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed'); 

class Main extends Front_Controller
{
  public function index()
  {
    $this->view_data['site_title'] = $this->lang->line('title_main_page');
    
    $this->view_data['site_header'] .= $this->parse_in(lang().'/carousel_view');
    
    $this->parse_out('main_view');
  }
}