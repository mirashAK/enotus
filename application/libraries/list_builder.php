<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class List_Builder
{
  protected $list_data = Null;
  
  function __construct()
  {
  
  }
  
  public static function factory ()
  {
    return new List_Builder();
  }
  
  function __set($name, $value)
  {
    if ($name == 'list_data' && !empty($value))
      if (is_array($value)) $this->get_data_array($value);
      
      //elseif (is_object($value)) $this->get_data_object($value);
/*      
    if ($name == 'name' && !empty($value)) $this->name($value);
    if ($name == 'action' && !empty($value)) $this->action($value)*/;
      
    return true;
  }
//   
//   function __get($name)
//   {
//     if (array_key_exists($name, $this->list_data)) return $this->form_data[$name];
//     if (array_key_exists($name, $this->list_data['value'])) return $this->form_data['value'][$name];
//   }
  
  protected function get_data_array($provided_data)
  {
      foreach ($provided_data['type'] as $field=>$value)
      {
        $this->list_data['caption'][$field] = $provided_data['caption'][$field];
        $this->list_data['type'][$field] = $provided_data['type'][$field];
        if (array_key_exists('r_only', $provided_data))
          $this->list_data['r_only'][$field] = $provided_data['r_only'][$field];
      }
      var_export($this->list_data); echo('<br/>');
      
      $this->list_data = $provided_data;
      
      var_export($this->list_data);
      
  }
  
  public function draw_list ($view_name = null, &$view_data = null)
  {

  }

}
