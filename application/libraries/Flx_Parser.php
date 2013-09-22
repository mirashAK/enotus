<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Flx_Parser extends CI_Parser
{
  var $arr_splitter = ':';

    /**
     *  Parse a tag pair
     *
     * Parses tag pairs:  {some_tag} string... {/some_tag}
     *
     * @access  private
     * @param   string (key)
     * @param   array (value)
     * @param   string (template)
     * @return  string (template)
     */
    function _parse_pair($variable, $data, $string)
    {
        if (FALSE === ($match = $this->_match_pair($string, $variable)))
        {
           
            if (is_array($data) && ( !isset($data[0]) || !is_array($data[0])))
              foreach ($data as $key => $val)
              { 
                $string = $this->_parse_single($variable.$this->arr_splitter.$key, $val, $string);
              }

            return $string;
        }

        $str = '';
        foreach ($data as $row)
        {
            $temp = $match['1'];
            foreach ($row as $key => $val)
            {
                if ( ! is_array($val))
                {
                    $temp = $this->_parse_single($key, $val, $temp);
                }
                else
                {
                    $temp = $this->_parse_pair($key, $val, $temp);
                }
            }

            $str .= $temp;
        }

        return str_replace($match['0'], $str, $string);
    }
    
    /**
     *  Parse a single key/value
     *
     * @access  private
     * @param   string
     * @param   string
     * @param   string
     * @return  string
     */
    function _parse_single($key, $val, $string)
    {   
//         if (is_array($key) || is_array($val) || is_array($string))
//         {
//           echo("<br/>\n");
//           echo ('key:'); var_export($key); echo("<br/>\n");
//           echo ('val:'); var_export($val); echo("<br/>\n");
//           echo ('string:'); var_export(htmlentities($string)); echo("<br/>\n");
//         }
        return str_replace($this->l_delim.$key.$this->r_delim, $val, $string);
    }
}