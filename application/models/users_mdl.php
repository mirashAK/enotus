<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Users_mdl extends Flx_Model
{  
  public function get_users_list(&$user)
  {
    return $this->full_objects($user, 'public_users');
  }
  
  public function get_user(&$user)
  {
    $result = $this->row_array($user, 'public_users', 'u_f_user_id='.$user->user_id);
    if ($result == false) $result = $this->get_table_signature($user, 'public_users');
    return $result;
  }
  
  public function get_user_signature(&$user)
  {
    return $this->get_table_signature($user, 'public_users');
  }
  
}