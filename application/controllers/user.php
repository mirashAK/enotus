<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed'); 

class User extends Front_Controller
{
  function __construct()
  {
    parent::__construct();
    $this->view_data['breadcrumbs'] = $this->menu_lib->create_bradcrumbs($this->lang->line('menu_item_user'));
    $this->view_data['user_tabs_items'] = $this->menu_lib->create_user_tabs();
    $this->view_data['user_tabs'] = $this->parse_in('layouts/common/user_tabs_view');
  }
  
  public function index()
  {
    $this->redirect(sub_url('user/journal'));
  }
  
  
  public function journal()
  {
    $this->view_data['site_title'] = $this->lang->line('title_user_journal');
    
    $this->view_data['site_body'] = $this->parse_in(lang().'/user_journal_view');
    
    $this->parse_out('main_view');
  }

  public function tariff()
  {
    $this->view_data['site_title'] = $this->lang->line('title_user_tariff');
    
    $this->view_data['site_body'] = $this->parse_in(lang().'/user_tariff_view');
    
    $this->parse_out('main_view');
  }
  
  public function history()
  {
    $this->view_data['site_title'] = $this->lang->line('title_user_history');
    
    $this->view_data['site_body'] = $this->parse_in(lang().'/user_history_view');
    
    $this->parse_out('main_view');
  }
  
  public function settings()
  {
    $this->view_data['site_title'] = $this->lang->line('title_user_settings');

    $this->view_data['site_body'] = $this->parse_in(lang().'/user_settings_view');
    
    $this->parse_out('main_view');
  }
}