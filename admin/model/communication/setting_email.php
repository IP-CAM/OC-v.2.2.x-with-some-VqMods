<?php
/*
	Company Name : http://opcrat.com/ 
	Developer Name : Parthiv Shah
	Date : 05-06-2014  10:00 PM
	
*/
class ModelCommunicationSettingEmail extends Model { 


	public function addCommunicationSettingSms($data) {	 
	if($data['default_gateway'] == 1){		
		$this->db->query("UPDATE " . DB_PREFIX . "communication_setting_email SET default_gateway = '0' ");	
	}
	$this->db->query("INSERT INTO " . DB_PREFIX . "communication_setting_email SET mail_protocol = '" . $this->db->escape($data['mail_protocol']) . "' , host = '" . $this->db->escape($data['host']) . "' , username = '" . $this->db->escape($data['username']) . "'  , password = '" . $this->db->escape($data['password']) . "' , port = '" . $this->db->escape($data['port']) . "' , smtp_timeout = '" . (int) $data['smtp_timeout'] . "' , default_gateway = '" . (int) $data['default_gateway'] . "' , status = '" . (int)$data['status'] . "'  ");
		$this->cache->delete('communication_setting_email');
	}

	public function editCommunicationSettingSms($communication_setting_email_id, $data) {
	
	if($data['default_gateway'] == 1){		
		$this->db->query("UPDATE " . DB_PREFIX . "communication_setting_email SET default_gateway = '0' ");	
	}	 
		$this->db->query("UPDATE " . DB_PREFIX . "communication_setting_email SET mail_protocol = '" . $this->db->escape($data['mail_protocol']) . "' , host = '" . $this->db->escape($data['host']) . "' , username = '" . $this->db->escape($data['username']) . "'  , password = '" . $this->db->escape($data['password']) . "'  , port = '" . $this->db->escape($data['port']) . "' , smtp_timeout = '" . (int) $data['smtp_timeout'] . "'  , default_gateway = '" . (int) $data['default_gateway'] . "'  ,  status = '" . (int)$data['status'] . "'   WHERE communication_setting_email_id = '" . (int)$communication_setting_email_id . "'");
		$this->cache->delete('communication_setting_email');
	}

	public function deleteCommunicationSettingSms($communication_setting_email_id) {
		$this->db->query("UPDATE " . DB_PREFIX . "communication_setting_email SET is_deleted = 0 WHERE communication_setting_email_id = '" . (int)$communication_setting_email_id . "'");
		$this->cache->delete('communication_setting_email');
	}
	
	public function getCommunicationSettingsSms($communication_setting_email_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "communication_setting_email WHERE communication_setting_email_id = '" . (int)$communication_setting_email_id . "'");
		return $query->row;
	}
	
	public function getCommunicationSettingsSmss($data = array()) {
		 
			$sql = "SELECT * FROM " . DB_PREFIX . "communication_setting_email ";

			$sort_data = array(
				'communication_setting_email_id',
				'host',
				'username',
				'default_gateway',
				'status'
			);	

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY communication_setting_email_id";	
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
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_setting_email");
		return $query->row['total'];
	}	 


}

?>