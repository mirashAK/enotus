<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Auth_mdl extends Flx_Model
{  
  public function get_user_reg_signature()
  {
    return $this->get_table_signature($this->user, 'public_users');
  }
}