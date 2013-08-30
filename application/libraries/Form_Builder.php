<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Form_Builder
{
  protected $form_data = null;
  protected $CI = null;
  
  public $xhr_answer = null;
  public $errors = array();
  
  function __construct()
  {
    $this->CI =& get_instance();
    $this->CI->load->helper('form_builder_helper');
    $this->CI->load->library('xhr_answer');
    $this->xhr_answer = & $this->CI->xhr_answer;
  }

  public static function factory ($flx_form_name = '', $flx_form_action = '')
  {
    $CI =& get_instance();
    $CI->config->load('flx_forms');
    
    $config_item_name = 'flx_'.strtolower($flx_form_name);
    $config = $CI->config->item($config_item_name);

    if (empty($config))
    {
      $form = new Flx_DB_Form ();
      $form->name = $flx_form_name;
      $form->action = $flx_form_action;
    }
    else
    { 
      $form = new Flx_Custom_Form ();
      $form->name = $flx_form_name;
      $form->action = $flx_form_action;
      $form->get_config($config);
    }
    return $form;
  }
  
  function __set($name, $value)
  {
    switch ($name)
    { 
      case 'form_data':
        if (is_array($value)) $this->get_data_array($value);
        elseif (is_object($value)) $this->get_data_object($value);
        break;
      case 'name':
        $this->name($value);
        break;
      case 'action':
        $this->action($value);
        break;
      default:
        if (array_key_exists($name, $this->form_data['value'])) $this->form_data['value'][$name] = $value;
    }
    return true;
  }
  
  function __get($name)
  {
    if (array_key_exists($name, $this->form_data)) return $this->form_data[$name];
    if (array_key_exists($name, $this->form_data['value'])) return $this->form_data['value'][$name];
  }
  
  public function name($form_name)
  {
    $this->form_data['form']['name'] = $form_name;
  }
  
  public function action($form_action)
  {
    $this->form_data['form']['action'] = $form_action;
  }
  
  function add_error($field_name, $value)
  {
    $this->errors[$field_name][] = $value;
  }
  
  public function get_data_array($provided_data = null)
  {
    //var_export($provided_data);echo('<br/>');echo('<br/>');
    $xhr_request = array();
    if (!empty($provided_data))
    {
      if (is_array($provided_data) && !array_key_exists('value', $provided_data))        
        $provided_data = array('value'=>$provided_data);
      
      foreach ($provided_data as $key=>$value)
        if (array_key_exists($key, $this->form_data) && is_array($provided_data[$key])) $this->form_data[$key] = array_merge($this->form_data[$key], $provided_data[$key]);
        else $this->form_data[$key] = $provided_data[$key];

      $is_xhr_request = $this->CI->input->is_ajax_request();
      if ($is_xhr_request == true) parse_str($this->CI->input->post($this->form_data['form']['name']), $xhr_request);
      
      foreach ($provided_data['value'] as $field=>$value)
      {
        $this->form_data['name'][$field] = $this->form_data['form']['name']."_$field";
        if ($is_xhr_request == true)
        {
          if (array_key_exists($this->form_data['form']['name']."_$field", $xhr_request))
            $this->form_data['value'][$field] = trim($xhr_request[$this->form_data['form']['name']."_$field"]);
          else
            $this->form_data['value'][$field] = $provided_data['value'][$field];
        }
        else
        {
          $posted_field = trim($this->CI->input->post($this->form_data['form']['name']."_$field"));
          if (!empty($posted_field))
            $this->form_data['value'][$field] = $posted_field;
          else
            $this->form_data['value'][$field] = $provided_data['value'][$field];
        }
      }
      if(!empty($provided_data['is_new'])) $this->form_data['is_new'] = $provided_data['is_new'];
      else $this->form_data['is_new'] = false;
    }
    //var_export($this->form_data); echo('<br/>');echo('<br/>');
  }
  
  public function get_data_object($provided_data = null)
  {
    $xhr_request = array();
    if (!empty($provided_data))
    {
      $this->form_data = array_merge($this->form_data, (array)$provided_data);
      
      foreach ($this->form_data as $key=>$value) $this->form_data[$key] = (array)$value;
      if(array_key_exists('dict', $this->form_data))
        foreach ($this->form_data['dict'] as $key=>$value) $this->form_data['dict'][$key] = (array)$value;
        
      $is_xhr_request = $this->CI->input->is_ajax_request();
      if ($is_xhr_request == true) parse_str($this->CI->input->post($this->form_data['form']['name']), $xhr_request);
      
      foreach ($provided_data->value as $field=>$value)
      {
        $this->form_data['name'][$field] = $this->form_data['form']['name']."_$field";
        
        if ($is_xhr_request == true)
        {
          if (array_key_exists($this->form_data['name'][$field], $xhr_request))
            $this->form_data['value'][$field] = trim($xhr_request[$this->form_data['name'][$field]]);
          else
            $this->form_data['value'][$field] = $provided_data->value->$field;
        }
        else
        {
          $posted_field = trim($this->CI->input->post($this->form_data['name'][$field]));
          if (!empty($posted_field))
            $this->form_data['value'][$field] = $posted_field;
          else
            $this->form_data['value'][$field] = $provided_data->value->$field;
        }
        
      }
      if(!empty($provided_data->is_new)) $this->form_data['is_new'] = $provided_data->is_new;
      else $this->form_data['is_new'] = false;
    }
    //var_export($this->form_data);
  }
  
  public function validate($custom_config = array())
  {
    $errors_arr = array();
    $pass = '';
    if ($this->check_request() === true)
    {
      foreach($this->form_data['type'] as $key=>$value)
        switch ($value)
        {
          case 'email':
              if (strlen($this->form_data['value'][$key]) == 0)
              {
                $errors_arr[$this->form_data['caption'][$key]][] = 'empty';
                break;
              }
              if (!preg_match("/.+\@.+\..+/", $this->form_data['value'][$key])) $errors_arr[$this->form_data['caption'][$key]][] = 'not email';
          break;
          case 'subdomain':
              if ($this->form_data['require'][$key] == true && strlen($this->form_data['value'][$key]) == 0)
              { 
                $errors_arr[$this->form_data['caption'][$key]][] = 'empty';
                break;
              }
              $this->form_data['value'][$key] = strtolower ($this->form_data['value'][$key]);
              if (strlen($this->form_data['value'][$key]) > 0 && !preg_match("/^[a-z0-9]+$/", $this->form_data['value'][$key])) $errors_arr[$this->form_data['caption'][$key]][] = 'forbidden chars';
          break;
          case 'pass':
              $pass = $this->form_data['value'][$key];
              if (strlen($this->form_data['value'][$key]) == 0) $errors_arr[$this->form_data['caption'][$key]][] = 'empty';
          break;
          case 're_pass':
              if (strlen($this->form_data['value'][$key]) == 0)
              {
                $errors_arr[$this->form_data['caption'][$key]][] = 'empty';
                break;
              }
              if ($this->form_data['value'][$key] !== $pass) $errors_arr[$this->form_data['caption'][$key]][] = 'password mismatch';
          break;
          default:
              if ($this->form_data['require'][$key] == true && strlen($this->form_data['value'][$key]) == 0)
              {
                $errors_arr[$this->form_data['caption'][$key]][] = 'empty';
                break;
              }
        }
      if (empty($errors_arr)) return true;
      else
      {
        $this->errors = $errors_arr;
        return false;
      }
    }
    else
    {
      $this->errors['Validation'] = 'Wrong request';
      return false;
    }
  }
  
  protected function types_transform_to_HTML()
  {
    if (is_array($this->form_data['type']))
      foreach ($this->form_data['type'] as $key=>$value)
        switch ($value)
        {
        case 'email': case 'edit': case 'phone':
            $this->form_data['HTML_type'][$key] = 'text';
            break;
        case 'pass': case 're_pass':
            $this->form_data['HTML_type'][$key] = 'password';
            break;
        default:
            $this->form_data['HTML_type'][$key] = 'text';
        }
        
    if (!empty($this->form_data['r_only']) && is_array($this->form_data['r_only']))
      foreach ($this->form_data['r_only'] as $key=>$value)
        if ($value) $this->form_data['r_only'][$key] = 'disabled';
        else $this->form_data['r_only'][$key] = '';
  }
  
  protected function check_request()
  {
    if ($this->CI->input->is_ajax_request() == true)
    {
      if ($this->CI->input->post($this->form_data['form']['name']) !==  false) return true;
      else return false;
    }
    else
      foreach ($this->form_data['type'] as $field=>$value)
        if ($this->CI->input->post($this->form_data['form']['name']."_$field") !==  false) return true;
        
    return false;
  }
  
  public function draw_form($view_name = null, &$view_data = null)
  {
    if (!empty($view_data)) $this->form_data = array_merge($this->form_data, $view_data);
    $view_string = '';
    // Пропарсим view на предмет вывода справочника
    if (!empty($this->form_data['dict']) && !empty($view_name))
    {
      $l_d = $this->CI->parser->l_delim;
      $r_d = $this->CI->parser->r_delim;
    
      $view_string = $this->CI->load->view($view_name, $this->form_data, true);
      foreach ($this->form_data['dict'] as $key=>$val_array)
      { 
        // Set default value
        if (empty($this->form_data['value'][$key])) $this->form_data['value'][$key] = 1;
        
        switch ($this->form_data['type'][$key]) 
        {
          case 'radio':
          
            $label_pattern = '<label[^>]*for\s*=\s*\"??[^\" >]*?'.$key.'[^\" >]*?\"??[^>]*>[^<]*<\/label>';
            $radio_pattern = '<input[^>]*name\s*=\s*\"??[^\" >]*?'.$key.'[^\" >]*?\"??[^>]*/>';
            $inside_pattern = '<label[^>]*>[^<]*'.$radio_pattern.'[^<]*<\/label>';
            $result_arr = array();
            $replace_string = false;
            if (0 !== preg_match ('~(<p[^>]*>)*?\s*'.$inside_pattern.'[^<]*(<\/p>)*?(<br\s*?\/>)*?~siU', $view_string, $result_arr)) $replace_string = $result_arr[0];
            elseif (0 !== preg_match ('~(<p[^>]*>)*?\s*'.$radio_pattern.'[^<]*'.$label_pattern.'[^<]*(<\/p>)*?(<br\s*?\/>)*?~siU', $view_string, $result_arr)) $replace_string = $result_arr[0];
            elseif (0 !== preg_match ('~(<p[^>]*>)*?\s*'.$label_pattern.'[^<]*'.$radio_pattern.'[^<]*(<\/p>)*?(<br\s*?\/>)*?~siU', $view_string, $result_arr)) $replace_string =  $result_arr[0];
            
            if ($replace_string !== false)
            {
              $new_string = '';
              foreach ($val_array['value'] as $id=>$value)
              {
                $search  = array(
                    '/'.$l_d.'caption:'.$key.$r_d.'/',
                    '/'.$l_d.'id:'.$key.$r_d.'/',
                    '/'.$l_d.'value:'.$key.$r_d.'/',
                    '/'.$l_d.'checked:'.$key.$r_d.'/',
                );
                $replace = array(
                    $value,
                    $key.'_'.$id,
                    $id,
                    ($this->form_data['value'][$key] == $id?'checked':''),
                );
                $new_string .= preg_replace ( $search , $replace , $replace_string );
               }
              $view_string = str_replace ( $replace_string , $new_string , $view_string);
            }
          break;
          
          case 'select':
            $select_pattern = '<option[^>]*value\s*=\s*\"??[^\" >]*?'.$key.'[^\" >]*?\"??[^>]*>[^<]*<\/option>';
           
            $replace_string = false;
            if (0 !== preg_match ('~'.$select_pattern.'~siU', $view_string, $result_arr)) $replace_string = $result_arr[0];

            if ($replace_string !== false)
            {
              $new_string = '';
              foreach ($val_array['value'] as $id=>$value)
              {
                $search  = array(
                    '/'.$l_d.'caption:'.$key.$r_d.'/',
                    '/'.$l_d.'id:'.$key.$r_d.'/',
                    '/'.$l_d.'value:'.$key.$r_d.'/',
                    '/'.$l_d.'selected:'.$key.$r_d.'/',
                );
                $replace = array(
                    $value,
                    $key.'_'.$id,
                    $id,
                    ($this->form_data['value'][$key] == $id?'selected="selected"':''),
                );
                $new_string .= preg_replace ( $search , $replace , $replace_string );
               }
              $view_string = str_replace ( $replace_string , $new_string , $view_string);
            }
          break;
          
          case 'array':
              foreach ($val_array['value'] as $id=>$value)
              {/*echo($value); echo('<br/>');*/}
          break;
          
          case 'multi':
              foreach ($val_array['value'] as $id=>$value)
              {/*echo($value); echo('<br/>');*/}
          break;
         }
      }
    }
    $this->types_transform_to_HTML();
    

    $this->form_data['dict'] = '';
    
    if ($this->CI->input->is_ajax_request() === true)
    {
      if (!empty($this->errors))
      {
        $this->xhr_answer->valid = false;
        $this->xhr_answer->errors = $this->errors;
      }
      if (!empty($view_string)) $this->xhr_answer->view = $this->CI->parser->parse_string($view_string, $this->form_data, true);
      elseif (!empty($view_name)) $this->xhr_answer->view = $this->CI->parser->parse($view_name, $this->form_data, true);
      $this->xhr_answer->send();
    }
    else
    {
      if (!empty($view_string)) return $this->CI->parser->parse_string($view_string, $this->form_data, true);
      elseif (!empty($view_name)) return $this->CI->parser->parse($view_name, $this->form_data, true);
      else return '';
    }
  }
  
  public function get_values()
  {
    $result = '';
    foreach ($this->form_data['value'] as $key => $value)
      if ($key !== 'r_only' && $key !== 'owner' && array_key_exists($key, $this->form_data['type']))
        if ($this->form_data['r_only'][$key] !== true)
          $result .= '\"'.$key.'\":\"'.$value.'\",';
        
    return $result;
  }

}

class Flx_DB_Form extends Form_Builder
{
  function __construct()
  {
    parent::__construct();
  }
}

class Flx_Custom_Form extends Form_Builder
{
  function __construct()
  {
    parent::__construct();
  }
 
  public function get_config($config_data = null)
  {
    if (isset($config_data['type']))
      foreach ($config_data['type'] as $field=>$field_type)
      {
        $prepared_arr['type'][$field] = $field_type;
        $prepared_arr['caption'][$field] = (isset($config_data['caption'][$field])) ? $config_data['caption'][$field] : $field;
        $prepared_arr['require'][$field] = (isset($config_data['require']) && in_array($field, $config_data['require'])) ? true : false;
        $prepared_arr['unique'][$field] = (isset($config_data['unique']) && in_array($field, $config_data['unique'])) ? true : false;
        $prepared_arr['value'][$field] = (isset($config_data['value'][$field])) ? $config_data['value'][$field] : '';
        $prepared_arr['r_only'][$field] = (isset($config_data['r_only']) && in_array($field, $config_data['r_only'])) ? true : false;
        if (isset($config_data['dict'][$field])) $prepared_arr['dict'][$field] = $config_data['dict'][$field];
      }
    $this->get_data_array($prepared_arr);
  }
  
}
