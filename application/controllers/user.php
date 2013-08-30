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

    $phones = $settings_form->pc_phones;
    if (empty($phones)) $settings_form->pc_phones = array(0=>'+38');
    
    $this->view_data['company_settings_form'] = $settings_form->draw_form('layouts/forms/company_settings_form', $this->view_data);

    $this->view_data['site_body'] = $this->parse_in(lang().'/user_settings_view');
    $this->view_data['site_title'] = $this->lang->line('title_user_settings');
    $this->parse_out('main_view');
  }
  
  public function xhr_save_company_settings()
  {
    $this->load->model('company_mdl');
    $settings_form = Form_Builder::factory('company_settings_form');
    $settings_form->form_data = $this->company_mdl->get_company_data();
    
    $phones = $settings_form->pc_phones;
    $tmp_phones = array();
    if (!empty($phones)) foreach ($phones as $key=>$value)
    {
      if (!empty($value))
      {
        $tmp_phones[] = $value;
        $this->view_data['phone_input_name'] = $settings_form->name['pc_phones']."[$key]";
        $this->view_data['phone_input_value'] = $value;
        $settings_form->xhr_answer->view .= $this->parse_in('layouts/forms/company_settings_phone_form');
      }
    }
    $settings_form->pc_phones = $tmp_phones;
    
    if ($settings_form->validate(array('pc_phones'=>array('type'=>'phone'))) == true)
    {
      $answer = $this->company_mdl->save_company_data($settings_form);
      if($answer!==false)
      {
        if (array_key_exists('inserted_id', $answer))
        {
          $this->user->user_public->u_f_company = $answer['inserted_id'];
          $settings_form->xhr_answer->update = array($settings_form->name['pc_id'] => $answer['inserted_id']);
        }
      }
    }
    $settings_form->draw_form();
  }
  
  public function xhr_add_company_phone()
  {
    $this->load->library('xhr_answer');
    $this->load->model('company_mdl');
    $settings_form = Form_Builder::factory('company_settings_form');
    $settings_form->form_data = $this->company_mdl->get_company_data();
    
    $phones = $settings_form->pc_phones;
    if (!empty($phones)) foreach ($phones as $key=>$value)
    {
      $this->view_data['phone_input_name'] = $settings_form->name['pc_phones']."[$key]";
      $this->view_data['phone_input_value'] = $value;
      $this->xhr_answer->view .= $this->parse_in('layouts/forms/company_settings_phone_form');
    }
    $this->view_data['phone_input_name'] = $settings_form->name['pc_phones'].'['.count($phones).']';
    $this->view_data['phone_input_value'] = '+38';
    $this->xhr_answer->view .= $this->parse_in('layouts/forms/company_settings_phone_form');
    $this->xhr_answer->send();
  }
}