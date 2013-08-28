<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Auth_mdl extends Flx_Model
{  
  public function get_user_reg_signature()
  {
    return $this->get_table_signature($this->user, 'public_users');
  }
  
  public function check_route_permission($uri)
  {
    $db_result = $this->row_object($this->user, 'public_menus', "menu_item_link = '$uri'");
    if ($db_result->value === false) return false;
    return true;
  }
}