<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/***********************************************************************************
Функция getRealIpAddr: получение IP адреса подключившегося
Возвращает:
  IP адрес в виде строки
***********************************************************************************/
function getRealIpAddr()
{
    if (!empty($_SERVER['HTTP_CLIENT_IP']))   //check ip from share internet
      $ip=$_SERVER['HTTP_CLIENT_IP'];
    elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))   //to check ip is pass from proxy
      $ip=$_SERVER['HTTP_X_FORWARDED_FOR'];
    else
      $ip=$_SERVER['REMOTE_ADDR'];
    return $ip;
}

/***********************************************************************************
Функция get_browser_lang: получение предпочитаемого языка для браузера клиента
Возвращает:
  язык в двухбуквенном виде
***********************************************************************************/
function get_browser_lang()
{
  $langs = array();
  if (isset($_SERVER['HTTP_ACCEPT_LANGUAGE']))
  {
    // Разбить строку в соответствии со значением q
    preg_match_all('/([a-z]{1,8}(-[a-z]{1,8})?)\s*(;\s*q\s*=\s*(1|0\.[0-9]+))?/i',
    $_SERVER['HTTP_ACCEPT_LANGUAGE'], $lang_parse);
    if (count($lang_parse[1]))
    {
      // создать список если "en" => 0.8
      $langs = array_combine($lang_parse[1], $lang_parse[4]);
      // установить значение в 1 для всех без q
      $k = sizeof($langs);
      foreach ($langs as $lang => $val)
      {
        if ($val === '') {$langs[$lang] = 1; $k--;}
      }
      // сортировка списка на основе значения
      if ($k) arsort($langs, SORT_NUMERIC);
    }
  }
  // извлечь самый приоритетный
  foreach ($langs as $lang => $val) { break; }
    if (stristr($lang,"-")) {$tmp = explode("-",$lang); $lang = $tmp[0]; }
    
  return $lang;
}

/**
* sub_url
* Form uri with subdomain
 *
 * @access  public
 * @return  string
 */
if ( ! function_exists('sub_url'))
{
    function sub_url($uri = '',  $include_lang = true)
    {
        $CI =& get_instance();
        return $CI->config->sub_url($uri, $include_lang);
    }
}

/**
* res_url
* Form uri with subdomain
 *
 * @access  public
 * @return  string
 */
if ( ! function_exists('res_url'))
{
    function res_url($uri = '')
    {
        $CI =& get_instance();
        return $CI->config->res_url($uri);
    }
}


/**
* sub_domain
* Returns sub domain name from URL string.
 *
 * @access  public
 * @return  string
 */
if ( ! function_exists('sub_domain'))
{
    function sub_domain()
    {
        $CI =& get_instance();
        return $CI->config->sub_domain();
    }
}

/**
* lang
* Shortcut to curr language
 *
 * @access  public
 * @return  string
 */
if ( ! function_exists('lang'))
{
    function lang()
    {
        $CI =& get_instance();
        return $CI->config->lang();
    }
}


