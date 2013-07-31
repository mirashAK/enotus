<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Main_menu_model extends Flx_Model { 

  function __construct() {
      parent::__construct();
  }
  
  function get_main_menu (&$user)
  {
    $menu_id = 1;
    return $this->full_array($user, 'public_main_menu', $where="menu_item_parent = $menu_id", $order='menu_item_order ASC', $limit='');
  }
  
}
