<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
* Use this class to generate class
* that can content not initialized poperties
*/

class safeClass
{ 

  function __construct($data = null)
  {
    if (!empty($data))
    {
      if (!is_array($data)) $data = (array)$data;
      foreach ($data as $key=>$value)
        $this->$key = $value;
    }
  }
  
  /**
    * __get
    *
    * @param   string
    * @access private
    */
  function __get($key)
  {
    if (isset($this->$key))
      return $this->$key;
    else
      return false;
  }
  
}