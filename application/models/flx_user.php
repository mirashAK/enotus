<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Flx_User extends Flx_Model
{ 
  public function do_auth(&$user, $email, $pass)
  {
    $sql = "SELECT do_auth (?,?,?,?) AS 'new_token' ;";
    $first_result = $this->db->query($sql, array($email, $pass, $user->user_ip, $user->user_token));
    if (!empty($first_result) && $first_result->num_rows() == 1)
    {
      // Получаем результат запроса стандартным методом CI
      $first_result = $first_result->row_array();
      return $first_result['new_token'];
    }
    else return false;
  }
    
  public function add_user($email, $pass, $login = '', $user_data='')
  {
    $sql = "SELECT add_user (?,?,?,?) AS 'answer' ;";
    $first_result = $this->db->query($sql, array($login, $email, $pass, $user_data));
    
    if (!empty($first_result) && $first_result->num_rows() == 1)
    {
      // Получаем результат запроса стандартным методом CI
      $first_result = $first_result->row_array();
      $first_result = json_decode($first_result['answer'], true);
      
      if (array_key_exists('error_code', $first_result)) return $first_result['error_code'];
      else return $first_result['confirm_token'];
    }
    else return false;
  }
  
  public function reg_user(&$user, $reg_token)
  {
    $sql = "SELECT reg_user (?,?,?) AS 'answer';";
    if (!empty($user))
      $first_result = $this->db->query($sql, array($reg_token, $user->user_ip, $user->user_token));
    else
      $first_result = $this->db->query($sql, array($reg_token, '', ''));

    if (!empty($first_result) && $first_result->num_rows() == 1)
    {
      // Получаем результат запроса стандартным методом CI
      $first_result = $first_result->row_array();
      $first_result = json_decode($first_result['answer'], true);
      
      if (array_key_exists('error_code', $first_result)) return $first_result['error_code'];
      else return $first_result;
    }
    else return false;
  }
  
  
  public function get_public_user_data(&$user)
  { 
    $result = $this->row_array($user, 'public_users', 'u_f_user_id = '.$user->user_id);
    if ($result['value'] !== false) return $result['value'];
    return false;
  }
  
  public function save_public_user ($token, $ip, $u_f_user_id, $data, $user_id = null)
  {
    $tmp_user = new stdClass();
    $tmp_user->user_token = $token;
    $tmp_user->user_ip = $ip;

    if (empty($user_id)) $data['u_f_user_id'] = $u_f_user_id;
    $result_data = '';

    foreach($data as $key=>$value)
    $result_data .= '\"'.$key.'\":\"'.$value.'\",';
    
    if (empty($user_id))
      $this->save_table_custom($tmp_user, 'public_users', $result_data);
    else
      $this->save_table_custom($tmp_user, 'public_users', $result_data, 'u_f_user_id = '.$user_id);
    //var_export($this->db->last_query());
  }
  
  public function token_passwd($user_email)
  {
    $sql = "SELECT token_passwd (?) AS 'answer' ;";
    $first_result = $this->db->query($sql, array($user_email));
    
    if (!empty($first_result) && $first_result->num_rows() == 1)
    {
      // Получаем результат запроса стандартным методом CI
      $first_result = $first_result->row_array();
      $first_result = json_decode($first_result['answer'], true);
      
      if (array_key_exists('error_code', $first_result)) return $first_result['error_code'];
      else return $first_result['confirm_token'];
    }
    else return false;
  }
  
  public function reset_passwd(&$user, $pass_token, $new_passwd)
  {
    $sql = "SELECT reset_passwd (?,?,?,?) AS 'new_token' ;";
    
    if (!empty($user))
      $first_result = $this->db->query($sql, array($pass_token, $user->user_ip, $new_passwd, $user->user_token));
    else
      $first_result = $this->db->query($sql, array($pass_token, '', $new_passwd, ''));
    
    if (!empty($first_result) && $first_result->num_rows() == 1)
    {
      // Получаем результат запроса стандартным методом CI
      $first_result = $first_result->row_array();
      return $first_result['new_token'];
    }
    else return false;
  }
  
  public function logout(&$user)
  {
    $sql = "SELECT logout_user (?,?) AS 'new_token' ;";
    if (!empty($user))
    {
      $first_result = $this->db->query($sql, array($user->user_token, $user->user_ip));
      
      if (!empty($first_result) && $first_result->num_rows() == 1)
      {
        $first_result = $first_result->row_array();
        return $first_result['new_token'];
      }
    }
    else return false;
  }
 
  
//    public function save_user_settings(&$user)
//   {
//     if (!empty($user) && $user->user_id !== 0 && !empty($user->user_settings))
//     {
//       $sql = "UPDATE `public_users` SET `u_settings`= ? WHERE `u_f_user_id` = ? LIMIT 1;";
//       $first_result = $this->db->query($sql, array(json_encode($user->user_settings), $user->user_id));
//     }
//     if (!empty($user) && $user->user_id !== 0)
//     {
//       // Just for set user last active
//       $sql = "UPDATE `public_users` SET `u_last_active`= NOW() WHERE `u_f_user_id` = ? LIMIT 1;";
//       $first_result = $this->db->query($sql, $user->user_id);
//     }
//   }
}