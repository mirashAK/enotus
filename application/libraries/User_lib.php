<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class User_lib
{
  public $user_token = null;
  public $user_ip = null;
  public $user_last_activity = null;
  
  public function __construct()
  {
    $this->load->model('flx_session', 'user_session');
    $this->load->model('flx_user', 'flx_user_mdl');
    $this->load->library('encrypt');
    $this->_set_values();
  }
  
  public function do_auth ($email, $pass)
  {
    $pass = $this->_encrypt_pass($pass);
    
    $new_token = $this->flx_user_mdl->do_auth($this, $email, $pass);
    if ($this->flx_user_mdl->check_error($new_token, 'flx_do_auth') == true)
    {
      $this->user_session->sess_token = $new_token;
      $this->input->set_cookie('user_token', $new_token, 31536000);
      $this->_set_values();
      return true;
    }
    else return $this->flx_user_mdl->get_error_text($new_token, 'flx_do_auth');
  }
  
  public function add_user ($email, $pass, $login = '', $user_data = array())
  {
    $pass = $this->_encrypt_pass($pass);
    $user_data = $this->encrypt->encode(json_encode($user_data));
    $token = $this->flx_user_mdl->add_user($email, $pass, $login, $user_data);
    if ($this->flx_user_mdl->check_error($token, 'flx_add_user') == true)
    {
      return $token;
    }
    else return $this->flx_user_mdl->get_error_text($token, 'flx_add_user');
  }
  
  public function reg_user ()
  {
    $token = $this->input->get('token');
    if (!empty($token))
    {
      $result = $this->flx_user_mdl->reg_user($this, $token);
      
      if (!is_array($result) && $this->flx_user_mdl->check_error($result, 'flx_reg_user') == false)
        $this->flx_user_mdl->get_error_text($new_token, 'flx_reg_user');
      else 
      {
        $this->user_session->sess_token = $result['user_token'];
        $this->input->set_cookie('user_token', $result['user_token'], 31536000);
        $this->_set_values();
        
        if (array_key_exists('user_id', $result))
        { // Insert data into public_users table
          $this->flx_user_mdl->save_public_user($result['user_token'], $this->user->user_ip, $result['user_id'], json_decode($this->encrypt->decode($result['user_data']),true));
        }
        return true;
      }
    }
    else return false;
  }
  
  public function logout ()
  {
    $new_token = $this->flx_user_mdl->logout($this);
    if (!empty($new_token))
    {
      $this->user_session->sess_token = $new_token;
      $this->input->set_cookie('user_token', $new_token, 31536000);
      $this->_set_values();
      return true;
    }
    else return false;
  }
  
  public function token_passwd ($email)
  {
    $get_params = $this->flx_user_mdl->token_passwd($email);
    if ($this->flx_user_mdl->check_error($get_params, 'flx_token_passwd') == true)
    {
      return $get_params;
    }
    else $this->flx_user_mdl->get_error_text($get_params, 'flx_token_passwd');
  }
  
  public function reset_passwd ($token, $new_passwd)
  {
    if (!empty($token) && !empty($new_passwd))
    {
      $new_passwd = $this->_encrypt_pass($new_passwd);
      $new_token = $this->flx_user_mdl->reset_passwd($this, $token, $new_passwd);
      if ($this->flx_user_mdl->check_error($new_token, 'flx_reset_passwd') == true)
      {
        $this->user_session->sess_token = $new_token;
        $this->input->set_cookie('user_token', $new_token, 31536000);
        $this->_set_values();
        return true;
      }
      else $this->flx_user_mdl->get_error_text($new_token, 'flx_reset_passwd');
    }
    else return false;
  }
  
  protected function _encrypt_pass ($passwd)
  {
    return $this->encrypt->sha1($passwd);
  }
  
  protected function _set_values()
  {
    $result = $this->user_session->get_user();
    
    if ($this->user_session->sess_status !== -1)
      foreach ($result as $key=>$value)
      {
        if ($key!=='last_ip') $this->$key = $value;
        if ($key=='user_id') $this->$key = (int)$value;
      }
      
    $this->user_token = $this->user_session->sess_token;
    $this->user_ip = $this->user_session->sess_ip;
    $this->user_last_activity = $this->user_session->sess_last_activity;
    
    if ($this->user_id > 0)
      $this->user_public =  $this->flx_user_mdl->get_public_user_data($this);
      
    unset($result);
  }
  
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
  
}