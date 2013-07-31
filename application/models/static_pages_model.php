<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Static_pages_model extends Flx_Model { 

  function __construct() {
      parent::__construct();
  }
  
  function get_page ($page_alias, &$user)
  {
    $page_alias = $this->db->escape_like_str($page_alias);
    return $this->row_object($user, 'public_static_pages', $where="static_page_alias LIKE '$page_alias'");
  }
}
