<?php
/*
	Company Name : http://opcrat.com/ 
	Developer Name : Parthiv Shah
	Date : 05-06-2014  10:00 PM
	
*/
class ModelCommunicationSettingSms extends Model {
	
	
	public function addCommunicationSettingSms($data) {	 
	
	if($data['default_gateway'] == 1){		
		$this->db->query("UPDATE " . DB_PREFIX . "communication_setting_sms SET default_gateway = '0' ");	
	}
	
	$this->db->query("INSERT INTO " . DB_PREFIX . "communication_setting_sms SET api_key = '" . $this->db->escape($data['api_key']) . "' , username = '" . $this->db->escape($data['username']) . "'  , password = '" . $this->db->escape($data['password']) . "' , default_gateway = '" . (int)$data['default_gateway'] . "' , status = '" . (int)$data['status'] . "'  ");
		$this->cache->delete('communication_setting_sms');
	}

	public function editCommunicationSettingSms($communication_setting_sms_id, $data) {

	if($data['default_gateway'] == 1){		
		$this->db->query("UPDATE " . DB_PREFIX . "communication_setting_sms SET default_gateway = '0' ");	
	}
	 
		$this->db->query("UPDATE " . DB_PREFIX . "communication_setting_sms SET api_key = '" . $this->db->escape($data['api_key']) . "' , username = '" . $this->db->escape($data['username']) . "'  , password = '" . $this->db->escape($data['password']) . "'  , default_gateway = '" . (int)$data['default_gateway'] . "'  ,  status = '" . (int)$data['status'] . "'   WHERE communication_setting_sms_id = '" . (int)$communication_setting_sms_id . "'");
		$this->cache->delete('communication_setting_sms');
	}

	public function deleteCommunicationSettingSms($communication_setting_sms_id) {
		$this->db->query("DELETE FROM  " . DB_PREFIX . "communication_setting_sms  WHERE communication_setting_sms_id = '" . (int)$communication_setting_sms_id . "'");
		$this->cache->delete('communication_setting_sms');
	}
	
	public function getCommunicationSettingsSms($communication_setting_sms_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "communication_setting_sms WHERE communication_setting_sms_id = '" . (int)$communication_setting_sms_id . "'");
		return $query->row;
	}
	
	public function getCommunicationSettingsSmss($data = array()) {
		 
			$sql = "SELECT * FROM " . DB_PREFIX . "communication_setting_sms ";

			$sort_data = array(
				'communication_setting_sms_id',
				'api_key',
				'username',
				'default_gateway',
				'status'
			);	

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY communication_setting_sms_id";	
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
	
	public function getTotalCommunicationSettingsSms() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_setting_sms");
		return $query->row['total'];
	}	 
	
}

?>