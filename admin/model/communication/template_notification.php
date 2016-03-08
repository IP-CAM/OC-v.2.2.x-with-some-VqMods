<?php
/*
	Company Name : http://opcrat.com/ 
	Developer Name : Parthiv Shah
	Date : 06-06-2014  12:00 PM
	
*/
class ModelCommunicationTemplateNotification extends Model {
	
	
	public function addCommunicationTemplateNotification($data) {	 
	$this->db->query("INSERT INTO " . DB_PREFIX . "communication_template_notification SET notification_type = '". $this->db->escape($data['notification_type']) ."' ,  subject = '" . $this->db->escape($data['subject']) . "' , message = '" . $this->db->escape($data['message']) . "' , status = '" . (int)$data['status'] . "' , date_added = NOW() , is_deleted = 1 ");
		$this->cache->delete('communication_template_notification');
	}

	public function editCommunicationTemplateNotification($communication_template_notification_id, $data) {
	 
		$this->db->query("UPDATE " . DB_PREFIX . "communication_template_notification SET notification_type = '". $this->db->escape($data['notification_type']) ."' , subject = '" . $this->db->escape($data['subject']) . "' , message = '" . $this->db->escape($data['message']) . "'  , status = '" . (int)$data['status'] . "' , date_modified = NOW()  WHERE communication_template_notification_id = '" . (int)$communication_template_notification_id . "'");
		$this->cache->delete('communication_template_notification');
	}

	public function deleteCommunicationTemplateNotification($communication_template_notification_id) {
		$this->db->query("UPDATE " . DB_PREFIX . "communication_template_notification SET is_deleted = 0 WHERE communication_template_notification_id = '" . (int)$communication_template_notification_id . "'");
		$this->cache->delete('communication_template_notification');
	}
	
	public function getCommunicationTemplatesSms($communication_template_notification_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "communication_template_notification WHERE communication_template_notification_id = '" . (int)$communication_template_notification_id . "'");
		return $query->row;
	}
	
	public function getTagLists($notification_type){		 
		$query = $this->db->query("SELECT * FROM  " . DB_PREFIX . "communication_tag_master WHERE tag_type = '".$notification_type."'");	
		return $query->rows;		
	}
	public function getCommunicationTemplatesSmss($data = array()) {
		 
			$sql = "SELECT * FROM " . DB_PREFIX . "communication_template_notification WHERE is_deleted = 1 ";

			$sort_data = array(
				'communication_template_notification_id',
				'subject',
				'message',
				'default_gateway',
				'status'
			);	

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY communication_template_notification_id";	
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
	
	public function getTotalCommunicationTemplatesSms() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_template_notification");
		return $query->row['total'];
	}	 
	
}

?>