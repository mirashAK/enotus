<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Company_mdl extends Flx_Model
{  
  public function get_company_data()
  {
    if (empty($this->user->user_public->u_f_company))
      return $this->get_table_signature($this->user, 'public_companies');
    else
      return $this->row_array($this->user, 'public_companies', 'pc_id = '. $this->user->user_public->u_f_company);
  }
  
  public function save_company_data($form)
  {
    return $this->save_table ($this->user, 'public_companies', $form, 'pc_id = '.$form->pc_id);
  }
}