<?php
/*
	
	Developer Name 		:  Parthiv R Shah
	Last Modified Date 	: 11-06-2014 5:24 PM
	Last Modified By  	:  Parthiv R Shah
	Last Modified Date 	: 11-06-2014 5:24 PM
	
*/
class ModelCommunicationSmsCampaignSetting extends Model
{
	public function addSetting($communication_campaign_id,$data)
	{
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_sms_setting WHERE communication_campaign_id = '".$communication_campaign_id."' ");
		if($query->row['total'] > 0)
		{
		 	$this->db->query("UPDATE " . DB_PREFIX . "communication_sms_setting SET sending_date = '" . $data['sending_date'] . "' , sending_time = '" . $data['sending_time']  . "'  , birthday = '" . $data['birthday'] . "' , date_modified = NOW() WHERE communication_campaign_id = '" . (int)$communication_campaign_id . "'");				
		}
		else
		{
			$this->db->query("INSERT INTO " . DB_PREFIX . "communication_sms_setting SET communication_campaign_id = '" . (int)$communication_campaign_id . "' , sending_date = '" . $data['sending_date'] . "' , sending_time = '" . $data['sending_time']  . "'  , birthday = '" . $data['birthday'] . "'   ");	
		}
		
		
		$this->db->query("DELETE FROM " . DB_PREFIX . "communication_setting_sms");
		if (isset($data['sms_setting'])) {
			foreach ($data['sms_setting'] as $sms_setting) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "communication_setting_sms SET  api_key = '" . $this->db->escape($sms_setting['api_key']) . "' , username = '" . $this->db->escape($sms_setting['username']) . "'  , password = '" . $this->db->escape($sms_setting['password']) . "' , default_gateway = '" . (int)$sms_setting['default_gateway'] . "' , status = '" . (int)$sms_setting['status'] . "'  ");
			}
		}
		
		
		
		$this->cache->delete('setting');
	}
  
	public function getSeetingById($communication_campaign_id) 
	{
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_sms_setting WHERE communication_campaign_id = '" . (int)$communication_campaign_id . "'");
		return $query->row;
	}  
	public function getCommnicationCampaignSmsDefaultSetting() {		 
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_sms WHERE default_gateway = '1' ");
		return $query->row;
	}
 
}
?>