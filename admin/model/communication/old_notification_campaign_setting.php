<?php
/*
	
	Developer Name 		:  Parthiv R Shah
	Last Modified Date 	: 11-06-2014 5:24 PM
	Last Modified By  	:  Parthiv R Shah
	Last Modified Date 	: 11-06-2014 5:24 PM
	
*/
class ModelCommunicationNotificationCampaignSetting extends Model
{
	public function addSetting($communication_campaign_id,$data)
	{
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_notification_setting WHERE communication_campaign_id = '".$communication_campaign_id."' ");
		if($query->row['total'] > 0)
		{
		 	$this->db->query("UPDATE " . DB_PREFIX . "communication_notification_setting SET state_date = '" . $data['state_date'] . "' , end_date = '" . $data['end_date']  . "' , notification_url = '" . $this->db->escape($data['notification_url'])  . "'  , permission = '" . (isset($data['permission']) ? serialize($data['permission']) : '') ."' , animate_show_speed = '" .$data['animate_show_speed']."' , animate_hide_speed = '" .$data['animate_hide_speed']."' , message_show_time = '" .$data['message_show_time']."' , time_duration = '" .$data['time_duration']."'  ,    birthday = '" . $data['birthday'] . "' , z_index = '" .(int)$data['z_index']."' , position= '".$data['position']."' , date_modified = NOW() WHERE communication_campaign_id = '" . (int)$communication_campaign_id . "'");				
		}
		else
		{
			$this->db->query("INSERT INTO " . DB_PREFIX . "communication_notification_setting SET communication_campaign_id = '".$communication_campaign_id."' , state_date = '" . $data['state_date'] . "' , end_date = '" . $data['end_date']  . "' , notification_url = '" . $this->db->escape($data['notification_url'])  . "'  , permission = '" . (isset($data['permission']) ? serialize($data['permission']) : '') ."' , animate_show_speed = '" .$data['animate_show_speed']."' , animate_hide_speed = '" .$data['animate_hide_speed']."' , message_show_time = '" .$data['message_show_time']."' , time_duration = '" .$data['time_duration']."'  ,    birthday = '" . $data['birthday'] . "' , z_index = '" .(int)$data['z_index']."' , position= '".$data['position']."' , date_added = NOW()  ");	
		}
		$this->cache->delete('setting');
	}
  
	public function getSeetingById($communication_campaign_id) 
	{
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_notification_setting WHERE communication_campaign_id = '" . (int)$communication_campaign_id . "'");
		return $query->row;
	}  
 
}
?>