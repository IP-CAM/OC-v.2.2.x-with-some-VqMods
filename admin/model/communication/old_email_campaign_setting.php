<?php
/*
	
	Developer Name 		:  Parthiv R Shah
	Last Modified Date 	: 11-06-2014 5:24 PM
	Last Modified By  	:  Parthiv R Shah
	Last Modified Date 	: 11-06-2014 5:24 PM
	
*/
class ModelCommunicationEmailCampaignSetting extends Model
{
	public function addSetting($communication_campaign_id,$data)
	{
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_email_setting WHERE communication_campaign_id = '".$communication_campaign_id."' ");
		if($query->row['total'] > 0)
		{
		 	$this->db->query("UPDATE " . DB_PREFIX . "communication_email_setting SET sending_date = '" . $data['sending_date'] . "' , sending_time = '" . $data['sending_time']  . "'  , birthday = '" . $data['birthday'] . "' , date_modified = NOW() WHERE communication_campaign_id = '" . (int)$communication_campaign_id . "'");				
		}
		else
		{
			$this->db->query("INSERT INTO " . DB_PREFIX . "communication_email_setting SET communication_campaign_id = '" . (int)$communication_campaign_id . "' , sending_date = '" . $data['sending_date'] . "' , sending_time = '" . $data['sending_time']  . "'  , birthday = '" . $data['birthday'] . "' , date_added = NOW()  ");	
		}
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "communication_setting_email");
		if (isset($data['email_setting'])) {
			foreach ($data['email_setting'] as $email_setting) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "communication_setting_email SET mail_protocol = '" . $this->db->escape($email_setting['mail_protocol']) . "' , host = '" . $this->db->escape($email_setting['host']) . "' , username = '" . $this->db->escape($email_setting['username']) . "'  , password = '" . $this->db->escape($email_setting['password']) . "' , port = '" . $this->db->escape($email_setting['port']) . "' , smtp_timeout = '" . (int)$email_setting['smtp_timeout'] . "' , default_gateway = '" . (int)$email_setting['default_gateway'] . "' , status = '" . (int)$email_setting['status']."'");
			}
		}
		
		$this->cache->delete('setting');
	}
  
	public function getSeetingById($communication_campaign_id) 
	{
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_email_setting WHERE communication_campaign_id = '" . (int)$communication_campaign_id . "'");
		return $query->row;
	}  
	
	public function getCommnicationCampaignById($communication_campaign_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_campaign WHERE communication_campaign_id = '" . (int)$communication_campaign_id . "'");
		return $query->row;
	}
	
	public function getCommnicationCampaignEmailDefaultSetting() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_email WHERE default_gateway = '1' ");
		return $query->row;
	}
	
	
}
?>