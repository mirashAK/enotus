<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Flx_Controller extends CI_Controller {

  protected $view_data = array();
  
  function __construct()
  {
    parent::__construct();
    $this->view_data['scripts'] = array();
    require_once APPPATH.'libraries/Form_Builder.php';
  }
  
  protected function parse_in($view_name)
  {
    if (!empty($this->parser))
      return $this->parser->parse($view_name, $this->view_data, TRUE);
  }

  protected function parse_out($view_name)
  {
    if (!empty($this->parser))
      $this->parser->parse($view_name, $this->view_data);
  }

  protected function set_language($user_lang = null)
  {
    $this->config->load('languages');
    $lang = '';
    if (empty($user_lang))
    {
      if (empty($this->uri->lang))
      {
        if ($this->config->item('lang_check_browser')) $lang =  get_browser_lang();
      } 
      else $lang = $this->uri->lang;
    
      if (!in_array($lang, $this->config->item('lang_supported')))
      {
        $ru_regions = $this->config->item('lang_ru_region');
        if (!empty($ru_regions) && in_array($lang, $ru_regions)) $lang = 'ru';
        else $lang = $this->config->item('language');
      }
      $this->config->set_item('language', $lang);
    
      if ($this->config->item('lang_redirect') && (empty($this->uri->lang) || $lang !== $this->uri->lang))
        redirect(sub_url((!$this->config->item('lang_url_include')?$lang.'/':'').uri_string()), 'refresh');
    }
    else
    {
    $this->config->set_item('language', $user_lang);
    
    if ($this->config->item('lang_redirect') && (empty($this->uri->lang) || $user_lang !== $this->uri->lang))
        redirect(sub_url((!$this->config->item('lang_url_include')?$user_lang.'/':'').uri_string()), 'refresh');
    }
  }
  
  protected function add_script($script_name)
  {
    if (!empty($this->view_data['res_js'])) $script_name = $this->view_data['res_js'].'/'.trim( $script_name,'/');
    
    if (!array_key_exists('scripts', $this->view_data)) $this->view_data['scripts'] = array();
      
    $this->view_data['scripts'][] = array('script'=>'<script src="'.$script_name.'"></script>');
  }
  
}

class Default_Controller extends Flx_Controller
{
  function __construct()
    {
      parent::__construct();
      $this->load->database('default');
      $this->load->library('user_lib', array(), 'user');
      $this->set_language(/*$this->user->user_lang*/);
      $this->view_data['base_url'] = base_url();
      $this->view_data['sub_url'] = sub_url();
      $this->view_data['res_url'] = res_url();
    }
}

class Test_Controller extends Flx_Controller
{
  function __construct()
    {
      parent::__construct();
      $this->load->database('test');
      $this->load->library('user_lib', array(), 'user');
      $this->set_language(/*$this->user->user_lang*/);
      $this->view_data['base_url'] = base_url();
      $this->view_data['sub_url'] = sub_url();
      $this->view_data['res_url'] = res_url();
     }
}


class Admin_Controller extends Default_Controller
{    
    function __construct() {
      parent::__construct();
      
      $this->view_data['site_title'] = 'Fleksa';
      $this->view_data['site_metadata'] = '';
      $this->view_data['site_header'] = '';
      $this->view_data['site_footer'] = '';
      $this->view_data['site_body'] = '';
    }
}

class Front_Controller extends Default_Controller
{
    function __construct()
    {
      parent::__construct();
      
      //$this->load->library('session');
//       if ((int)$this->user->user_id !== 0 && !empty($this->user->user_login) && $this->config->item('sub_domain') !== $this->user->user_login)
//       {
//         $this->config->set_item('sub_domain', $this->user->user_login);
//         redirect(sub_url(uri_string()), 'refresh');
//       }

      $this->lang->load('site/titles', lang());
      $this->lang->load('site/forms', lang());
      $this->view_data['lang'] = $this->lang->language;
      
      $this->load->model('users_mdl');
      
      $this->view_data['site_title'] = 'StarTask';
      $this->view_data['site_metadata'] = '';
      $this->view_data['site_metadata_description'] = '';
      $this->view_data['site_metadata_keywords'] = '';
      $this->view_data['site_header'] = '';
      $this->view_data['site_footer'] = '';
      $this->view_data['site_body'] = '';
      
      $this->view_data['res_js'] = res_url('resources/js/');
      $this->view_data['res_css'] = res_url('resources/css/');
      $this->view_data['res_img'] = res_url('resources/img/');
      
      $this->lang->load('social', $this->config->item('language'));
      $this->view_data['social_description'] = $this->lang->line('social_description');
      $this->view_data['language'] = lang();
      
      if ($this->user->user_id === 0)
        $this->view_data['sign_links'] = $this->parse_in('layouts/'.lang().'/sign_links');
      else $this->view_data['sign_links'] = $this->parse_in('layouts/'.lang().'/user_links');
      
      $this->view_data['header'] = $this->parse_in('layouts/'.$this->config->item('language').'/header_view');
      $this->view_data['footer'] = $this->parse_in('layouts/'.$this->config->item('language').'/footer_view');
    }
}


/* End of file Flx_Controller.php */
/* Location: ./application/core/Flx_Controller.php */