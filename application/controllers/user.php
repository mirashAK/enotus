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
    $this->load->model('company_mdl');

    $settings_form = Form_Builder::factory('company_settings_form', sub_url('user/xhr_save_company_settings'));
    $settings_form->form_data = $this->company_mdl->get_company_data();
    
    $this->view_data['company_settings_form'] = $settings_form->draw_form('layouts/forms/company_settings_form', $this->view_data);

    $this->view_data['site_body'] = $this->parse_in(lang().'/user_settings_view');
    $this->view_data['site_title'] = $this->lang->line('title_user_settings');
    $this->parse_out('main_view');
  }
  
  public function xhr_save_company_settings()
  {
    $this->load->model('company_mdl');
    $settings_form = Form_Builder::factory('company_settings_form', sub_url('xhr_save_company_settings'));
    $settings_form->form_data = $this->company_mdl->get_company_data();
    
    if ($settings_form->validate() == true)
    {
      $answer = $this->company_mdl->save_company_data($settings_form);
      if($answer!==false)
      {
        if (array_key_exists('inserted_id', $answer))
        {
          $this->user->user_public->u_f_company = $answer['inserted_id'];
          $settings_form->xhr_answer->update = array($settings_form->name['pc_id'] => $answer['inserted_id']);
          $this->user->save_public();
        }
      }
    }
    $settings_form->draw_form();
  }
  
}