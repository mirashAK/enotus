<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Menu_lib
{
  /**
    * __get
    *
    * Allows models to access CI's loaded classes using the same
    * syntax as controllers.
    *
    * @param   string
    * @access private
    */
  function __get($key)
  {
      $CI =& get_instance();
      return $CI->$key;
  }
  
  function __construct()
  {
    $this->load->model('menu_mdl');
    $this->lang->load('site/menus', lang());
  }
  
  public function create_main_menu()
  {
    $menu_item_name = 'main_menu';
    $class_current = 'is-current';
    
    $menu = $this->menu_mdl->get_sub_menu($menu_item_name);
    
    if ($menu['values']) foreach ($menu['values'] as $key=>$menu_item)
    {
      $sub_items = $this->menu_mdl->get_sub_menu($menu_item['menu_item_name']);
      $menu['values'][$key]['current'] = '';
      if ($menu_item['menu_item_link'] == substr (uri_string() , 0 , strlen($menu_item['menu_item_link']))) $menu['values'][$key]['current'] = $class_current;
      elseif ($sub_items['values'] !== false)
        foreach($sub_items['values'] as $sub_item)
          if ($sub_item['menu_item_link'] == substr (uri_string() , 0 , strlen($sub_item['menu_item_link']))) $menu['values'][$key]['current'] = $class_current;
      
      $menu['values'][$key]['menu_item_name'] = $this->lang->line($menu_item['menu_item_name']); 
    }
    else $menu['values'] = array();
    
    return $menu['values'] ;
  }
  
   function create_bradcrumbs ()
  {
    $final_result = array();
    $class_current = 'is-current';
    
    $segments_array = $this->uri->segment_array();

    if (!empty($segments_array))
    {
      $final_result[0]['current'] = '';
      $final_result[0]['menu_item_name'] = $this->lang->line('menu_item_front_page');
      $final_result[0]['link_begin'] = '<a href="'.sub_url().'">';
      $final_result[0]['separator'] = '<i class="icon icon-bc-separator"></i>';
      $final_result[0]['link_end'] = '</a>';
      
      $path = '';
      $segments_array_length = count($segments_array);
      
      if (!empty($segments_array)) foreach ($segments_array as $key=>$segment)
      {
        $path .= $segment;
        $menu_item = $this->menu_mdl->get_breadcrumb_route($path);
        if ($menu_item['value'])
        {
          $menu_item = $menu_item['value'];
          $menu_item['menu_item_name'] = $this->lang->line($menu_item['menu_item_name']); 

          if ($key >= $segments_array_length)
          {
            $menu_item['current'] = $class_current;
            $menu_item['link_begin'] = '';
            $menu_item['separator'] = '';
            $menu_item['link_end'] = '';
          }
          else
          {
            $menu_item['current'] = '';
            $menu_item['link_begin'] = '<a href="'.sub_url($menu_item['menu_item_link']).'">';
            $menu_item['separator'] = '<i class="icon icon-bc-separator"></i>';
            $menu_item['link_end'] = '</a>';
          }
          $final_result[] = $menu_item;
          $path .= '/';
        }
        else break;
      }
    }
    return $this->parser->parse('layouts/common/breadcrumbs_view', array('breadcrumb_items' => $final_result), true);
  }
  
}