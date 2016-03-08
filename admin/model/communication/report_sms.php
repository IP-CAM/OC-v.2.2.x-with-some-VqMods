<?php
/*
	
	Developer Name 		:  Parthiv R Shah
	Date 				: 19-06-2014
	Last Modified By  	:  Parthiv R Shah
	Last Modified Date 	: 19-06-2014 11:20 AM
	
*/

class ModelCommunicationReportSms extends Model 
{  

	public function getTotalReportSms($type=NULL) {
		$search = '';
		if($type !=""){
			$search = 'AND message_type = "'.$type.'" ';
		}
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_campaign WHERE is_deleted = 1 ");
		return $query->row['total'];
	} 

	public function getReportSms($data = array(),$type=NULL) {
		
		$search = '';
		if($type !=""){
			$search = 'AND message_type = "'.$type.'" ';
		}
		
		$sql = "SELECT * FROM " . DB_PREFIX . "communication_campaign WHERE is_deleted = '1' $search ";																																					  
		$sql .= " ORDER BY communication_campaign_id";	

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
	
	public function getUserGroupName($user_group_id) { 	
		$query = $this->db->query("SELECT title FROM " . DB_PREFIX . "communication_customer_group WHERE communication_customer_group_id = $user_group_id ");	
		return $query->row['title'];
	}
	
	public function getTemplateName($template_id) { 	
 		$query = $this->db->query("SELECT subject FROM " . DB_PREFIX . "communication_template_sms WHERE communication_template_sms_id = $template_id ");	
		return $query->row['subject'];
	}
	public function getResultSend($communication_campaign_id) {	 		
		$query = $this->db->query("SELECT COUNT(status) as total FROM " . DB_PREFIX . "communication_sms_send_details WHERE communication_campaign_id = $communication_campaign_id AND status = 1 ");	
		return $query->row['total'];		
	}
	public function getResultNotSend($communication_campaign_id) {	 		
		$query = $this->db->query("SELECT COUNT(status) as total FROM " . DB_PREFIX . "communication_sms_send_details WHERE communication_campaign_id = $communication_campaign_id AND status = 0 ");	
		return $query->row['total'];		
	}
}
?>