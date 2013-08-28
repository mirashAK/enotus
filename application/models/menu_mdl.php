<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Menu_mdl extends Flx_Model { 
  
  public function get_sub_menu($item_name)
  {
    $sub_query = "(SELECT `menu_id` FROM `public_menus` WHERE menu_item_name LIKE '$item_name')";
    return $this->full_array($this->user, 'public_menus', "`menu_item_parent` = $sub_query", 'menu_item_order ASC');
  }
  
  public function get_breadcrumb_route($uri)
  {
    return $this->row_array($this->user, 'public_menus', "menu_item_link LIKE '$uri'");
  }
}
