<?php
/*
	
	Developer Name 		:  Parthiv R Shah
	Date 				: 19-06-2014
	Last Modified By  	:  Parthiv R Shah
	Last Modified Date 	: 19-06-2014 11:20 AM
	
*/

class ModelCommunicationReportSmsDetails extends Model 
{  

	public function getTotalReportSmsDetails($communication_campaign_id) {	 
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_sms_send_details WHERE communication_campaign_id = $communication_campaign_id ");
		return $query->row['total'];
	} 

	public function getReportSmsDetails($data = array(),$communication_campaign_id) {
		
		$sql = "SELECT * FROM " . DB_PREFIX . "communication_sms_send_details WHERE communication_campaign_id = $communication_campaign_id AND customer_id != 0 ";																																					  
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
	
	public function getCustomerDetails($customer_id) { 			
		$query = $this->db->query("SELECT firstname,lastname,telephone FROM " . DB_PREFIX . "customer WHERE customer_id = $customer_id ");	
		return $query->row;
	}
	
	public function getResultSend($communication_campaign_id) {	 		
		$query = $this->db->query("SELECT COUNT(status) as total FROM " . DB_PREFIX . "communication_sms_send_details WHERE communication_campaign_id = $communication_campaign_id AND status = 1  AND customer_id != 0");	
		return $query->row['total'];		
	}
	public function getResultNotSend($communication_campaign_id) {	 		
		$query = $this->db->query("SELECT COUNT(status) as total FROM " . DB_PREFIX . "communication_sms_send_details WHERE communication_campaign_id = $communication_campaign_id AND status = 0  AND customer_id != 0");	
		return $query->row['total'];		
	}
}
?>