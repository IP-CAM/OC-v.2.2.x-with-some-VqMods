<?php
/*
	
	Developer Name 		:  Parthiv R Shah
	Last Modified Date 	: 11-06-2014 5:24 PM
	Last Modified By  	:  Parthiv R Shah
	Last Modified Date 	: 11-06-2014 5:24 PM
	
*/
class ModelCommunicationEmailCampaignSetting extends Model
{
	public function addSetting($data)
	{
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "communication_setting_email");
		if (isset($data['email_setting'])) {
			foreach ($data['email_setting'] as $email_setting) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "communication_setting_email SET mail_protocol = '" . $this->db->escape($email_setting['mail_protocol']) . "' , host = '" . $this->db->escape($email_setting['host']) . "' , username = '" . $this->db->escape($email_setting['username']) . "'  , password = '" . $this->db->escape($email_setting['password']) . "' , port = '" . $this->db->escape($email_setting['port']) . "' , smtp_timeout = '" . (int)$email_setting['smtp_timeout'] . "' , default_gateway = '" . (int)$email_setting['default_gateway'] . "' , status = '" . (int)$email_setting['status']."'");
			}
		}
		
		// Add General Setting in Database. 
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_setting_email_general");
		if($query->row['total'] > 0)
		{
			$this->db->query("UPDATE " . DB_PREFIX . "communication_setting_email_general SET default_template = '" . $data['default_template'] . "' , default_customer_group = '" . $data['default_customer_group']  . "' ");				
		}
		else
		{
			$this->db->query("INSERT INTO " . DB_PREFIX . "communication_setting_email_general SET  default_template = '" . $data['default_template'] . "' , default_customer_group = '" . $data['default_customer_group']  . "' ");	
		} 

		if(isset($data['from_name']) && trim($data['from_name']) != "") {  
		
			$this->db->query("INSERT INTO " . DB_PREFIX . "communication_setting_email_from SET  from_name = '" .  $this->db->escape($data['from_name']) . "' , date_added = NOW() ");
		}
		
		$this->cache->delete('setting');
	}
  
	public function getSeetingById() 
	{
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_email_setting");
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
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_customer_group WHERE message_type LIKE '%email%' ");
		return $query->rows;
	}
	
	public function getCommnicationSettingEmailGeneral() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_email_general");
		return $query->row;
	}
	public function getFrom(){
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_email_from");
		return $query->rows;
	}
	
}
?>