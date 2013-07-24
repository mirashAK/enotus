<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

function draw_partial_input (&$form_data, $field_name)
{
  return 'name="'.$form_data['name'][$field_name].'" type="'.$form_data['type'][$field_name].'" id="'.$form_data['caption'][$field_name].'" value="'.$form_data['value'][$field_name].'"';
}

function draw_partial_label ($field_id)
{

}

function draw_radiobox ($field_id)
{

}