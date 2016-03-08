<?php
/*
	Company Name : http://opcrat.com/ 
	Developer Name : Parthiv Shah
	Date : 13-06-2014  11:50 AM
	
*/
class ModelCommunicationDefaultTemplate extends Model {
	  
	public function editCommunicationDefaultTemplateEmail($communication_default_templates_id,$data) {
	  
		  
		 $this->db->query("UPDATE " . DB_PREFIX . "communication_default_templates SET  message_type = '".serialize($data['message_type'])."'  , date_modified = NOW()  WHERE communication_default_templates_id = '" . (int)$communication_default_templates_id . "'");
		 
		 
		 // Check SMS Data 
		 if(in_array("sms",$data['message_type'])) {
			 			 
			 $query = $this->db->query("SELECT COUNT(*) as total FROM  " . DB_PREFIX . "communication_default_templates_sms WHERE communication_default_templates_id = '".$communication_default_templates_id."'"); 
			 if($query->row['total']>0){
				 echo "UPDATE " . DB_PREFIX . "communication_default_templates_sms SET message = '".$this->db->escape($data['sms_message'])."' , sms_status = '".(int)$data['sms_status']."' WHERE communication_default_templates_id = '". $communication_default_templates_id ."' ";
				$this->db->query("UPDATE " . DB_PREFIX . "communication_default_templates_sms SET message = '".$this->db->escape($data['sms_message'])."' , sms_status = '".(int)$data['sms_status']."' WHERE communication_default_templates_id = '". $communication_default_templates_id ."' ");
			 }else{
				$this->db->query("INSERT INTO  " . DB_PREFIX . "communication_default_templates_sms SET  communication_default_templates_id = '". $communication_default_templates_id ."'  , message = '".$this->db->escape($data['sms_message'])."' , sms_status = '".(int)$data['sms_status']."' ");
			 }
		 } 
		 
		 // Check Email Data 
		 if(in_array("email",$data['message_type'])) {
			 			 
			 $query = $this->db->query("SELECT COUNT(*) as total FROM  " . DB_PREFIX . "communication_default_templates_email WHERE communication_default_templates_id = '".$communication_default_templates_id."'"); 
			 if($query->row['total']>0){
				$this->db->query("UPDATE " . DB_PREFIX . "communication_default_templates_email SET message = '".$this->db->escape($data['email_message'])."' , template_name = '".$this->db->escape($data['template_name'])."' , email_status = '".(int)$data['email_status']."' WHERE communication_default_templates_id = '". $communication_default_templates_id ."' ");
			 }else{
				$this->db->query("INSERT INTO  " . DB_PREFIX . "communication_default_templates_email SET  communication_default_templates_id = '". $communication_default_templates_id ."' , template_name = '".$this->db->escape($data['template_name'])."'  , message = '".$this->db->escape($data['email_message'])."' , email_status = '".(int)$data['email_status']."' ");
			 }
		 } 
		 
		 // Check Notification Data 
		 if(in_array("notification",$data['message_type'])) {
			 			 
			 $query = $this->db->query("SELECT COUNT(*) as total FROM  " . DB_PREFIX . "communication_default_templates_notification WHERE communication_default_templates_id = '".$communication_default_templates_id."'"); 
			 if($query->row['total']>0){
				$this->db->query("UPDATE " . DB_PREFIX . "communication_default_templates_notification SET message = '".$this->db->escape($data['notification_message'])."' , notification_status = '".(int)$data['notification_status']."' WHERE communication_default_templates_id = '". $communication_default_templates_id ."' ");
			 }else{
				$this->db->query("INSERT INTO  " . DB_PREFIX . "communication_default_templates_notification SET  communication_default_templates_id = '". $communication_default_templates_id ."'  , message = '".$this->db->escape($data['notification_message'])."'  , notification_status = '".(int)$data['notification_status']."' ");
			 }
		 } 
		 
		 
		 
		 
		$this->cache->delete('communication_default_templates');
	} 
	
	public function getCommunicationTemplates($communication_default_templates_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_default_templates WHERE communication_default_templates_id = '" . (int)$communication_default_templates_id . "'");
		return $query->row;
	}
	public function getCommunicationTemplatesSms($communication_default_templates_id) {
		 
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_default_templates_sms WHERE communication_default_templates_id = '" . (int)$communication_default_templates_id . "'");
		return $query->row;
	}
	public function getCommunicationTemplatesEmail($communication_default_templates_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_default_templates_email WHERE communication_default_templates_id = '" . (int)$communication_default_templates_id . "'");
		return $query->row;
	}
	public function getCommunicationTemplatesNotification($communication_default_templates_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_default_templates_notification WHERE communication_default_templates_id = '" . (int)$communication_default_templates_id . "'");
		return $query->row;
	}
	
	public function getTagLists($email_type){		 
		$query = $this->db->query("SELECT * FROM  " . DB_PREFIX . "communication_tag_master WHERE tag_type = '".$email_type."'");	
		return $query->rows;		
	}
	
	public function getCommunicationTemplatesList($data = array()) {
		 
			$sql = "SELECT * FROM " . DB_PREFIX . "communication_default_templates   ";

			$sort_data = array(
				'default_template_type',
				'name' 
			);	

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY communication_default_templates_id";	
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
	
     public function getCommnicationCampaignEmailDefaultSetting() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_email WHERE default_gateway = '1' ");
		return $query->row;
	}
	
	public function getCommnicationCampaignSmsDefaultSetting() {		 
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_sms WHERE default_gateway = '1' ");
		return $query->row;
	}
	
	public function getTotalCommunicationTemplatesEmail() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_default_templates");
		return $query->row['total'];
	}	 
	
	public function getEmailDraftDetails($communication_default_templates_id){		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_default_templates_email WHERE communication_default_templates_id = '".$communication_default_templates_id."' ");
		return $query->row;		
	}
	
	public function getSmsDraftDetails($communication_default_templates_id){		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_default_templates_sms WHERE communication_default_templates_id = '".$communication_default_templates_id."' ");
		return $query->row;		
	}
	public function getNotificationDraftDetails($communication_default_templates_id){		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_default_templates_notification WHERE communication_default_templates_id = '".$communication_default_templates_id."' ");
		return $query->row;		
	}
	
	public function getCommnicationCampaignById($communication_default_templates_id) { 
		$query = $this->db->query("SELECT CDT.name , CDTE.* FROM " . DB_PREFIX . "communication_default_templates_email AS CDTE JOIN  " . DB_PREFIX . "communication_default_templates CDT ON CDT.communication_default_templates_id  =  CDTE.communication_default_templates_id AND CDTE.communication_default_templates_id = '" . (int)$communication_default_templates_id . "'");
		return $query->row;
	}
	
	public function getSmsDefaultTemplate($communication_default_templates_id) { 
 		$query = $this->db->query("SELECT CDT.name , CDTS.* FROM " . DB_PREFIX . "communication_default_templates_sms AS CDTS JOIN  " . DB_PREFIX . "communication_default_templates CDT ON CDT.communication_default_templates_id  =  CDTS.communication_default_templates_id AND CDTS.communication_default_templates_id = '" . (int)$communication_default_templates_id . "'");
		return $query->row;
	}
	
	
	public function sendSms($telephone, $message) {
				
		$request = "";
		$param["username"] = "delfoo";					    // YOUR LOGIN USERNAME
		$param["password"] = "Delfoo12";						// YOUR LOGIN PASSWORD
		$param["sendername"] = "DELFOO";						// YOUR SENDERID
		$param["mobile"] = "$telephone";						// Receiver Mobile NO
		$param["routetype"] = "1";							// Promotional Route: "0" ; Transactional Route: "1"
		$param["message"] = "$message";  // Receiver MSG
		
		
		foreach($param as $key=>$val){$request.= $key."=".urlencode($val); $request.= "&";}
		$request = substr($request, 0, strlen($request)-1);
		
		$host = "clients.smshorizon.in";    				
		$script = "/sms_api/sendsms.php";
		$request_length = strlen($request);
		$method = "POST";
		if ($method == "GET"){$script .= "?$request";}
		
		$header = "$method $script HTTP/1.1\r\n";
		$header .= "Host: $host\r\n";
		$header .= "Content-Type: application/x-www-form-urlencoded\r\n";
		$header .= "Content-Length: $request_length\r\n";
		$header .= "Connection: close\r\n\r\n";
		$header .= "$request\r\n";
		
		$socket = @fsockopen($host, 80, $errno, $errstr); 
		if ($socket)
		{ 
		fputs($socket, $header);
		while(!feof($socket)){$output[] = fgets($socket);}
		fclose($socket); 
		}  
	} 
	
	
}

?>