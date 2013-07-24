<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * Custom CodeIgniter Config Class
 *
 * This class contains functions that enable config files to be managed
 *
 */
class Flx_Config extends CI_Config {

    /**
     * Constructor
     *
     * Sets the $config data from the primary config.php file as a class variable
     * By maded changes will set 'base_url' and 'cookie_domain' values depend on 
     * 'base_url' by adding special characters
     *
     * @access   public
     * @param   string  the config file name
     * @param   boolean  if configuration values should be loaded into their own section
     * @param   boolean  true if errors should just return false, false if an error message should be displayed
     * @return  boolean  if the file was successfully loaded or not
     */
    function __construct()
    {
        $this->config =& get_config();
        log_message('debug', "Config Class Initialized");

        // Set the base_url automatically if none was provided
        if ($this->config['base_url'] == '')
        {
            if (isset($_SERVER['HTTP_HOST']))
            {
                $base_url = isset($_SERVER['HTTPS']) && strtolower($_SERVER['HTTPS']) !== 'off' ? 'https' : 'http';
                $base_url .= '://'. $_SERVER['HTTP_HOST'];
                $base_url .= str_replace(basename($_SERVER['SCRIPT_NAME']), '', $_SERVER['SCRIPT_NAME']);
            }

            else
            {
                $base_url = 'http://localhost/';
            }

            $this->set_item('base_url', $base_url);
        }
        // Convert base_url to http:// |https:// view
        else
        {
            if (isset($_SERVER['HTTP_HOST']))
            {
                $base_url = isset($_SERVER['HTTPS']) && strtolower($_SERVER['HTTPS']) !== 'off' ? 'https' : 'http';
                $base_url .= '://'. $this->config['base_url'].'/';
            }
            else
            {
                $base_url = 'http://localhost/';
            }
            
            if (FALSE != preg_match('/^(.+).'.$this->config['base_url'].'$/i', $_SERVER['HTTP_HOST'], $matches, PREG_OFFSET_CAPTURE))
              $this->set_item('sub_domain', $matches[1][0]);
            
            $this->set_item('cookie_domain', '.'.$this->config['base_url']);
            $this->set_item('base_url', $base_url);
            
            
        }
    }

  /**
    * Base URL
    * Returns base_url [. uri_string]
    *
    * @access public
    * @param   string  the URI string
    * @param   bool  include lang
    * @return string
    */
  function base_url($uri = '', $include_lang = true)
  {
    if ($this->config['lang_url_include'] == true && $include_lang == true)
      $uri = $this->config['language'].'/'.ltrim($this->_uri_string($uri), '/');

    return rtrim($this->slash_item('base_url').ltrim($this->_uri_string($uri), '/'), '/');
  }
    
    
  /**
    * Site URL
    * Returns base_url . index_page [. uri_string]
    *
    * @access  public
    * @param   string  the URI string
    * @return  string
    */
  function site_url($uri = '')
  {
    if ($this->config['lang_url_include'] == true)
      $uri = $this->config['language'].'/'.$uri;
      
    return parent::site_url($uri);
  }
  
  /**
    * Shortcut to curr language
    * Returns lang
    *
    * @access  public
    * @return  string
    */
  function lang()
  {
    return $this->config['language'];
  }
    
  /**
  * sub_domain
  * Returns sub_domain.base_url [. uri_string]
  *
  * @access  public
  * @return  string
  */
  function sub_domain()
  {
    return $this->config['sub_domain'];
  }
  
  /**
  * sub_url
  * Create url with subdomain and/or current lang
  *
  * @access  public
  * @param   string  the URI string
  * @param   bool  include lang
  * @return  string
  */
  function sub_url($uri = '', $include_lang = true)
  {
    if ($this->config['sub_domain'] !== false)
    {
      $base_url = isset($_SERVER['HTTPS']) && strtolower($_SERVER['HTTPS']) !== 'off' ? 'https' : 'http';
      $base_url .= '://'.$this->config['sub_domain'].$this->config['cookie_domain'].'/';
      $base_url .= rtrim((($this->config['lang_url_include'] == true && $include_lang == true )?$this->config['language'].'/':'').ltrim($this->_uri_string($uri), '/'), '/');
      return rtrim($base_url, '/');
    }
    else return rtrim($this->slash_item('base_url').(($this->config['lang_url_include'] == true && $include_lang == true )?$this->config['language'].'/':'').ltrim($this->_uri_string($uri), '/'), '/');
  } 
  
  /**
  * res_url
  * Create url without subdomain and lang for resources
  *
  * @access  public
  * @param   string  the URI string
  * @return  string
  */
  function res_url($uri = '')
  {
    return rtrim($this->slash_item('base_url').trim($this->_uri_string($uri), '/'), '/');
  } 

}
// END Flx_Config class

/* End of file Flx_Config.php */
/* Location: ./application/core/Flx_Config.php */