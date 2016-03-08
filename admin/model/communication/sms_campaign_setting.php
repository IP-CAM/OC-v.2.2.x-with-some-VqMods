<?php
/*
	
	Developer Name 		:  Parthiv R Shah
	Last Modified Date 	: 11-06-2014 5:24 PM
	Last Modified By  	:  Parthiv R Shah
	Last Modified Date 	: 11-06-2014 5:24 PM
	
*/
class ModelCommunicationSmsCampaignSetting extends Model
{
	public function addSetting($data)
	{	 
		$this->db->query("DELETE FROM " . DB_PREFIX . "communication_setting_sms");
		if (isset($data['sms_setting'])) {
			foreach ($data['sms_setting'] as $sms_setting) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "communication_setting_sms SET  api_key = '" . $this->db->escape($sms_setting['api_key']) . "' , username = '" . $this->db->escape($sms_setting['username']) . "'  , password = '" . $this->db->escape($sms_setting['password']) . "' , default_gateway = '" . (int)$sms_setting['default_gateway'] . "' , status = '" . (int)$sms_setting['status'] . "'  ");
			}
		}
		
		// Add General Setting in Database. 
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_setting_sms_general");
		if($query->row['total'] > 0)
		{
			$this->db->query("UPDATE " . DB_PREFIX . "communication_setting_sms_general SET default_template = '" . $data['default_template'] . "' , default_customer_group = '" . $data['default_customer_group']  . "' ");				
		}
		else
		{
			$this->db->query("INSERT INTO " . DB_PREFIX . "communication_setting_sms_general SET  default_template = '" . $data['default_template'] . "' , default_customer_group = '" . $data['default_customer_group']  . "' ");	
		} 

		if(isset($data['from_number']) && trim($data['from_number']) != "") {  
		
			$this->db->query("INSERT INTO " . DB_PREFIX . "communication_setting_sms_from SET  from_number = '" .  $this->db->escape($data['from_number']) . "' , date_added = NOW() ");
		}
		
		$this->cache->delete('setting');
	}
  
	public function getSeetingById() 
	{
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_sms");
		return $query->row;
	}  
	public function getCommnicationCampaignSmsDefaultSetting() {		 
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_sms WHERE default_gateway = '1' ");
		return $query->row;
	}
	
	public function getCommnicationCampaignEmailDefaultSetting() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_email WHERE default_gateway = '1' ");
		return $query->row;
	}
	
	public function getTemplateList(){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_template_email");
		return $query->rows;
	}
	
	public function getCustomerGroup() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_customer_group WHERE message_type LIKE '%sms%' ");
		return $query->rows;
	}
	
	public function getCommnicationSettingEmailGeneral() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_sms_general");
		return $query->row;
	}
	public function getFrom(){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_sms_from");
		return $query->rows;
	}
 
}
?>