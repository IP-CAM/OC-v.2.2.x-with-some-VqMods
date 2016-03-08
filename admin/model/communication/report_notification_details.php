<?php
/*
	
	Developer Name 		:  Parthiv R Shah
	Date 				: 25-06-2014
	Last Modified By  	:  Parthiv R Shah
	Last Modified Date 	: 25-06-2014 03:30 PM
	
*/

class ModelCommunicationReportNotificationDetails extends Model 
{  

	public function getTotalReportNotificationDetails($communication_campaign_id) {	 
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "commnunication_notification_details WHERE communication_campaign_id = $communication_campaign_id ");
		return $query->row['total'];
	} 

	public function getReportNotificationDetails($data = array(),$communication_campaign_id) {
		
		$sql = "SELECT * FROM " . DB_PREFIX . "commnunication_notification_details WHERE communication_campaign_id = $communication_campaign_id ";																																					  
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
	public function getAffiliateDetails($affiliate_id){
		$query = $this->db->query("SELECT firstname,lastname,telephone FROM " . DB_PREFIX . "affiliate WHERE affiliate_id = $affiliate_id ");	
		return $query->row;
	}
	
	public function getTotalViewList($communication_campaign_id) {	 		
	 
		$query = $this->db->query("SELECT  COUNT(communication_campaign_id) as total  FROM " . DB_PREFIX . "commnunication_notification_details WHERE communication_campaign_id = $communication_campaign_id  ");	
		return $query->row['total'];		
	}
}
?>