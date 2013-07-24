<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Flx_Hooks extends CI_Hooks
{ 
  function _call_hook($which = '')
  {
    if ($which == 'post_system')
    {
      $this->CI =& get_instance();
      $this->CI->user_session->save();
    }
    
    if ( ! $this->enabled OR ! isset($this->hooks[$which]))
    {
        return FALSE;
    }

    if (isset($this->hooks[$which][0]) AND is_array($this->hooks[$which][0]))
    {
        foreach ($this->hooks[$which] as $val)
        {
            $this->_run_hook($val);
        }
    }
    else
    {
        $this->_run_hook($this->hooks[$which]);
    }

    return TRUE;
  }
}
