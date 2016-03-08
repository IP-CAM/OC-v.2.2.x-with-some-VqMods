<?php
/*
	
	Developer Name 		:  Parthiv R Shah
	Last Modified Date 	: 11-06-2014 5:24 PM
	Last Modified By  	:  Parthiv R Shah
	Last Modified Date 	: 11-06-2014 5:24 PM
	
*/
class ModelCommunicationNotificationCampaignSetting extends Model
{
	public function addNotification($data)
	{
		if($data['default_notification']==1){
			$this->db->query("UPDATE  " . DB_PREFIX . "communication_setting_notification SET default_notification='0' ");
		}
		
		$this->db->query("INSERT INTO " . DB_PREFIX . "communication_setting_notification SET  subject = '" . $data['subject'] . "'  , notification_url = '" . $this->db->escape($data['notification_url'])  . "'  , permission = '" . (isset($data['permission']) ? serialize($data['permission']) : '') ."' , animate_show_speed = '" .$data['animate_show_speed']."' , animate_hide_speed = '" .$data['animate_hide_speed']."' , message_show_time = '" .$data['message_show_time']."' , time_duration = '" .$data['time_duration']."'   , z_index = '" .(int)$data['z_index']."' , position= '".$data['position']."' , default_notification='".(int)$data['default_notification']."'  , date_added = NOW()  ");	
	   $this->cache->delete('setting');
	}
	
	public function editNotification($communication_notification_setting_id,$data)
	{
		
		if($data['default_notification']==1)
		{
			$this->db->query("UPDATE  " . DB_PREFIX . "communication_setting_notification SET default_notification='0' ");
		}
		
		$this->db->query("UPDATE  " . DB_PREFIX . "communication_setting_notification SET  subject = '" . $data['subject'] . "'  , notification_url = '" . $this->db->escape($data['notification_url'])  . "'  , permission = '" . (isset($data['permission']) ? serialize($data['permission']) : '') ."' , animate_show_speed = '" .$data['animate_show_speed']."' , animate_hide_speed = '" .$data['animate_hide_speed']."' , message_show_time = '" .$data['message_show_time']."' , time_duration = '" .$data['time_duration']."'   , z_index = '" .(int)$data['z_index']."' , position= '".$data['position']."' , default_notification='".(int)$data['default_notification']."' , date_modified = NOW() WHERE communication_notification_setting_id = '".$communication_notification_setting_id."' ");	
		$this->cache->delete('setting');
	}
  
	public function getSeetingById($communication_notification_setting_id) 
	{
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_notification WHERE communication_notification_setting_id = '" . (int)$communication_notification_setting_id . "'");
		return $query->row;
	}  

	public function getNotification($data = array()) {
		
		$sql = "SELECT * FROM " . DB_PREFIX . "communication_setting_notification WHERE 1=1  ";																																					  

		$sort_data = array(
			'subject',
			'date_added'
		);	

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY communication_notification_setting_id";	
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}			

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}																																							  
 
		$query = $this->db->query($sql);			
		return $query->rows;	
	}	
	
	public function getTotalNotification() {	 
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_setting_notification ");
		return $query->row['total'];
	} 
	
}
?>