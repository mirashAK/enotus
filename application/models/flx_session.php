<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Flx_Session
{
  private $sess_data = array ();
  private $CI = null;
  
  public $sess_token = null;
  public $sess_ip = null;
  public $sess_status = null;
  public $sess_last_activity = null;
  
  public function __construct()
  {
      log_message('debug', "Session Class Initialized");
      
      $this->CI =& get_instance();
      $this->CI->load->helper('string');
      $this->CI->load->library('encrypt');
      
      // Get user token from cookies
      $this->sess_token = $this->CI->input->cookie('user_token', TRUE);  
      if ($this->sess_token == FALSE) $this->sess_token = '';
      
      $this->sess_ip = getRealIpAddr();
  }
  
  function get_full_sess_data()
  { 
    return $this->sess_data;
  }
  
  function __get($name)
  { 
    if (array_key_exists($name, $this->sess_data)) return $this->sess_data[$name];
    else return false;
  }
  
  function __set($name, $value)
  { 
    $this->sess_data[$name] = $value;
  }
  
  public function get_user()
  {
    $final_result = array();
    $sql = 'CALL get_user (?,?);';
    $first_result = $this->CI->db->query($sql, array($this->sess_token, $this->sess_ip));

    if (!empty($first_result) && $first_result->num_rows() == 1)
    {
      // Получаем результат запроса стандартным методом CI
      $first_result = $first_result->row_array();
      $this->sess_status = (int)$first_result['Status'];
    }
    
    if ($this->CI->db->conn_id->next_result())
    {
      $second_result = $this->CI->db->conn_id->store_result();

      if (is_object($second_result) && mysqli_num_rows($second_result) > 0)
      {
        $second_result = mysqli_fetch_assoc($second_result);
        if ($this->sess_status !==  -1)
        {
          foreach ($second_result as $key=>$value)
            switch ($key) 
            {
              case 'user_token':
                  $this->sess_token = $value;
                  $this->CI->input->set_cookie('user_token', $this->sess_token, 31536000);
                  break;
              case 'last_activity':
                  $this->sess_last_activity = $value;
                  break;
              case 'session_data':
                  if (!empty($value)) $this->sess_data = json_decode($this->CI->encrypt->decode($value), true);
                  break;
              default:
                  $final_result[$key] = $value;
            }
        }
      }
      else 
      {
        $this->_clear_results();
      }
      $this->_clear_results();
    }
    return $final_result;
  }
  
  protected function set_session()
  {
    // Clear empty values from session
    $sess_data = array();
    foreach ($this->sess_data as $key=>$value)
    {
      if (!empty($value)) $sess_data[$key] = $value;
    }
    $this->sess_data['user_agent'] = trim(substr($this->CI->input->user_agent(), 0, 120));
    $sql = 'SELECT set_session (?,?,?);';
    $sql_result = $this->CI->db->query($sql, array($this->sess_token, $this->sess_ip, $this->CI->encrypt->encode(json_encode($sess_data))));
    return true;
  }
  
  public function save()
  {
    $this->set_session();
  }
  
  protected function _clear_results()
  {
    // Пройдёмся по всем результатам множественного запроса (на всякий случай)
    // и прочитаем их из буфера результатов, а заодно почистим.
    // Надо, чтобы не вываливалась ошибка “Command out of sync”
    while($this->CI->db->conn_id->next_result())
    {
      $junk_result = $this->CI->db->conn_id->store_result();
      if ($junk_result) mysqli_free_result ($junk_result);
    }
  }
  
}
