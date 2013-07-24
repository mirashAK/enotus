<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/**
 * CodeIgniter
 *
 * An open source application development framework for PHP 5.1.6 or newer
 *
 * @package     CodeIgniter
 * @author      Olekandr Kulykov
 * @since       Version 1.1
 * @filesource
 */

// ------------------------------------------------------------------------

/**
 * Flx_URI Class
 *
 * Extends CI_URI class to get first uri segment as language pointer
 *
 * @package     CodeIgniter
 * @subpackage  Libraries
 * @category    URI
 * @author      Olekandr Kulykov
 */
 
class Flx_URI extends CI_URI
{
/**
  * Current language
  *
  * @var string
  * @access public
  */
  var $lang = '';
  
  function _fetch_uri_string()
  {
    parent::_fetch_uri_string();

    $uri_array = array();
    foreach (explode("/", preg_replace("|/*(.+?)/*$|", "\\1", $this->uri_string)) as $seg_pos => $val)
    {
        // Filter segments for security
        $val = trim($this->_filter_uri($val));
        
        if ($seg_pos == 0 && strlen($val)<=3 && strlen($val)>=2)
        {
            $this->lang = $val;
        }
        elseif ($val != '')
        {
            $uri_array[] = $val;
        }
    }
    $this->uri_string = implode('/', $uri_array);
  }
  
} 

/* End of file Flx_URI.php */
/* Location: ./application/core/Flx_URI.php */