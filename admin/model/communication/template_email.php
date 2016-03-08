<?php
/*
	Company Name : http://opcrat.com/ 
	Developer Name : Parthiv Shah
	Date : 06-06-2014  12:00 PM
	
*/
class ModelCommunicationTemplateEmail extends Model {
	
	
	public function addCommunicationTemplateEmail($data) {	 
	$this->db->query("INSERT INTO " . DB_PREFIX . "communication_template_email SET email_type = '". $this->db->escape($data['email_type']) ."' , subject = '" . $this->db->escape($data['subject']) . "' , message = '" . $this->db->escape($data['message']) . "' , status = '" . (int)$data['status'] . "' , date_added = NOW() , is_deleted = 1 ");
		$this->cache->delete('communication_template_email');
	}

	public function editCommunicationTemplateEmail($communication_template_email_id, $data) {
	 
		$this->db->query("UPDATE " . DB_PREFIX . "communication_template_email SET email_type = '". $this->db->escape($data['email_type']) ."' , subject = '" . $this->db->escape($data['subject']) . "' , message = '" . $this->db->escape($data['message']) . "'  , status = '" . (int)$data['status'] . "' , date_modified = NOW()  WHERE communication_template_email_id = '" . (int)$communication_template_email_id . "'");
		$this->cache->delete('communication_template_email');
	}

	public function deleteCommunicationTemplateEmail($communication_template_email_id) {
		$this->db->query("UPDATE " . DB_PREFIX . "communication_template_email SET is_deleted = 0 WHERE communication_template_email_id = '" . (int)$communication_template_email_id . "'");
		$this->cache->delete('communication_template_email');
	}
	
	public function getCommunicationTemplatesEmail($communication_template_email_id) {
		$query = $this->db->query("SELECT DISTINCT * FROM " . DB_PREFIX . "communication_template_email WHERE communication_template_email_id = '" . (int)$communication_template_email_id . "'");
		return $query->row;
	}
	public function getTagLists($email_type){		 
		$query = $this->db->query("SELECT * FROM  " . DB_PREFIX . "communication_tag_master WHERE tag_type = '".$email_type."'");	
		return $query->rows;		
	}
 
	
	
	public function getCommunicationTemplatesEmails($data = array()) {
		 
			$sql = "SELECT * FROM " . DB_PREFIX . "communication_template_email WHERE is_deleted = 1 ";

			$sort_data = array(
				'communication_template_email_id',
				'subject',
				'message',
				'default_gateway',
				'status'
			);	

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY communication_template_email_id";	
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
	
	public function getTotalCommunicationTemplatesEmail() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_template_email");
		return $query->row['total'];
	}	 
	
}

?>