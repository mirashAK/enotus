<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed'); 

class Main extends Front_Controller
{
  function __construct()
  {
    parent::__construct();

      $this->load->model('users_mdl');

      // tmp vars_defs
      $this->view_data['link_out'] = false;
      if ($this->user->user_id == 0) $this->view_data['auth'] = false;
      else $this->view_data['auth'] = true;
      $this->view_data['tariff'] = 'ok';
      
      $this->load->model('static_pages_model', 'static_pages');
      
      $this->view_data['main_menu_items'] = $this->menu_lib->create_main_menu();
      $this->view_data['breadcrumbs'] = '';
      
      $this->view_data['site_header'] = $this->parse_in(lang().'/header_view');
      $this->view_data['site_footer'] =  $this->parse_in(lang().'/footer_view');
  }
  
  public function _remap($method)
  {

    if ($this->user->user_id == 0)
    {
      $auth_form = Form_Builder::factory('auth_form', sub_url('auth/xhr_auth'));
      $this->view_data['site_footer'] .= $auth_form->draw_form('layouts/forms/modal_login_form', $this->view_data);
      
      $reg_form = Form_Builder::factory('reg_form', sub_url('auth/xhr_reg'));
      $reg_form->form_data = $this->auth_mdl->get_user_reg_signature();
      
      $this->view_data['site_footer'] .= $reg_form->draw_form('layouts/forms/modal_reg_form', $this->view_data);
    }
  
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
    $this->view_data['site_title'] = $this->lang->line('title_main_page');
    
    $this->view_data['breadcrumbs'] = $this->menu_lib->create_bradcrumbs();
    
    $page = $this->static_pages->get_page($page_alias, $this->user);
    
    $this->view_data['site_body'] = $page->value->static_page_text;
    
    $this->parse_out('main_view');
  }
  
}