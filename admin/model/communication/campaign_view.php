<?php
/*
	
	Developer Name 		:  Parthiv R Shah
	Date 				: 10-06-2014
	Last Modified By  	:  Parthiv R Shah
	Last Modified Date 	: 10-06-2014 11:20 AM
	
*/

class ModelCommunicationCampaignView extends Model 
{
  
	
	public function getCampaignSettingById($communication_campaign_id){		
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_campaign_setting  WHERE communication_campaign_id = '" . (int)$communication_campaign_id . "'");
		return $query->row;
	}
	 
	
	public function editCampaign($communication_campaign_id) {
		 
		$this->db->query("UPDATE " . DB_PREFIX . "communication_campaign SET campaign_status = '1' , date_modified = NOW() WHERE communication_campaign_id = '" . (int)$communication_campaign_id . "'");			
	}
	
	public function getEmailDefoultSetting() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_email WHERE default_gateway = '1'");
		return $query->row;		
	}
	
	public function getSmsDefoultSetting() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_sms WHERE default_gateway = '1'");
		return $query->row;		
	}
	
	public function getNotificationDefoultSetting() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_notification WHERE default_notification = '1'");
		return $query->row;		
	}
	
	public function copyCampaign($communication_campaign_id, $data) {
		$msg = '';
		if($data['message_type'] == "sms"){
			$msg = $this->db->escape($data['sms_message']);
		} else {
			$msg = $this->db->escape($data['email_notification_message']);
		}		
	  
		$this->db->query("INSERT INTO " . DB_PREFIX . "communication_campaign (message_type,communication_template_id,user_group,subject,message,status,date_added,is_deleted) SELECT message_type,communication_template_id,user_group,subject,message, 	status,NOW(),1 from   " . DB_PREFIX . "communication_campaign WHERE  communication_campaign_id = '".$communication_campaign_id."' ");
		
		return $this->db->getLastId();
	}



	public function deleteCampaign($communication_campaign_id) {
		$this->db->query("UPDATE " . DB_PREFIX . "communication_campaign SET is_deleted = '0'  WHERE communication_campaign_id = '" . (int)$communication_campaign_id . "'");
		$this->cache->delete('communication_campaign');
	}

	public function getCampaignById($communication_campaign_id) {	 
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_campaign  WHERE communication_campaign_id = '" . (int)$communication_campaign_id . "'");
		return $query->row;
	}
	public function getCustomerGroupCampaignById($communication_campaign_id)
	{	 	 
		$query = $this->db->query("SELECT communication_campaign_id FROM " . DB_PREFIX . "communication_campaign  WHERE communication_campaign_id = '" . (int)$communication_campaign_id . "'");
		return $query->row;
	}
	
	
	public function displayCustomerGroups($message_type) {		 
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_customer_group  WHERE status = '1' AND is_deleted = '1' AND message_type LIKE '%".$message_type."%'");
		return $query->rows;
	}
	
	public function getGroupName($communication_customer_group_id) {		 
		$query = $this->db->query("SELECT title FROM " . DB_PREFIX . "communication_customer_group  WHERE communication_customer_group_id = '".$communication_customer_group_id."' ");
		return $query->row['title'];
	}
	
	
	public function getAffiliateById($affiliate_id ) {	  
		$query = $this->db->query("SELECT affiliate_id,firstname,lastname FROM " . DB_PREFIX . "affiliate  WHERE affiliate_id  = '" . (int)$affiliate_id  . "'");
		return $query->row;
	} 
 

	public function getCampaigns($data = array(),$type=NULL) {
		
		$search = '';
		if($type !=""){
			$search = 'AND message_type = "'.$type.'" ';
		}
		
		$sql = "SELECT * FROM " . DB_PREFIX . "communication_campaign WHERE is_deleted = '1' $search ";																																					  

		$sort_data = array(
			'communication_campaign_id',
			'message_type',
			'user_group',
			'subject',
			'status'
		);	

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY communication_campaign_id";	
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

	public function getTotalCampaigns($type=NULL) {
		$search = '';
		if($type !=""){
			$search = 'AND message_type = "'.$type.'" ';
		}
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_campaign WHERE is_deleted = 1 ");
		return $query->row['total'];
	} 
	
	
	public function getTemplateDropDown($selected=NULL,$message_type=NULL) {			 
		if(isset($message_type) && $message_type != ""){
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_template_".$message_type." WHERE is_deleted = '1' AND status = '1'  ORDER BY subject ASC");				
			return $query->rows;	  
		}
		 
	}
	
	public function getTagLists($sms_type){		 
		$query = $this->db->query("SELECT * FROM  " . DB_PREFIX . "communication_tag_master WHERE tag_type = '".$sms_type."'");	
		return $query->rows;		
	}
	
	public function getTemplateDetails($message_type,$communication_template_id) {			
		$query = $this->db->query("SELECT subject  FROM " . DB_PREFIX . "communication_template_".$message_type." WHERE   is_deleted = '1' AND status = '1' AND communication_template_".$message_type."_id = '".$communication_template_id."'");			
		return $query->row['subject'];	  
	}
	 
	
	/*
		
		Developer Name : Parthiv R Shah
		Date : 10-06-2014
		This function use to get All Customer List.
	
	*/
	
	public function getCustomerLists($data = array()) {
		$sql = "SELECT * FROM " . DB_PREFIX . "customer  ";																																					  

		$sort_data = array(			 
			'firstname',
			'lastname',
			'email',
			'status'
		);	

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY customer_id";	
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

		//echo $sql;
		//die;
		$query = $this->db->query($sql);			
		return $query->rows;
	}
	
	/*
		
		Developer Name : Parthiv R Shah
		Date : 10-06-2014
		This function use to get Total Number of Customer.
	
	*/
	public function getTotalCustomers() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer");
		return $query->row['total'];
	} 
	
	
  /*
		
		Developer Name : Parthiv R Shah
		Date : 10-06-2014
		This function is user for get list of all user 
	
	*/
	public function getUsers($data = array()) {
		$sql = "SELECT * FROM `" . DB_PREFIX . "user`";

		$sort_data = array(
			'username',
			'status',
			'date_added'
		);	

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY username";	
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
	/*
		
		Developer Name : Parthiv R Shah
		Date : 10-06-2014
		This function is user for get Total number of User in system 
	
	*/
	
	public function getTotalUsers() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM `" . DB_PREFIX . "user`");
		return $query->row['total'];
	}
	
	public function getCommnicationCampaignSmsDefaultSetting() {		 
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_sms WHERE default_gateway = '1' ");
		return $query->row;
	}
	
	public function getStoreData(){
 		$query = $this->db->query("SELECT value FROM " . DB_PREFIX . "setting WHERE setting_id IN (286,240,237)");
		return $query->rows;
	}
	
	
	public function getGroupIdDetail($group_id){
		
		$query = $this->db->query("SELECT * FROM `". DB_PREFIX ."communication_customer_group` WHERE communication_customer_group_id = '".$group_id."' ");	 		 	
		if($query->row['user_group'] == "customer_all") {		 
			$all_customer = $this->db->query("SELECT customer_id as id , firstname , lastname , email , telephone FROM `". DB_PREFIX ."customer`");
			return $all_customer->rows;			
		} 
		
		if($query->row['user_group'] == "customer_group"){
			$group_id = $query->row['group_id'];
			$customer_group = $this->db->query("SELECT customer_id as id , firstname , lastname , email , telephone FROM `". DB_PREFIX ."customer` WHERE customer_group_id = '".$group_id."' ");
			return $customer_group->rows;
		}
		
		if($query->row['user_group'] == "customer"){
			$group_id = implode(",",unserialize($query->row['group_id']));			 
			$customer_group = $this->db->query("SELECT customer_id as id , firstname , lastname , email , telephone FROM `". DB_PREFIX ."customer` WHERE customer_id IN ($group_id) ");
			return $customer_group->rows;
		}
		
		if($query->row['user_group'] == "reject_customer"){
			$group_id = implode(",",unserialize($query->row['group_id']));			 
			$customer_group = $this->db->query("SELECT customer_id as id , firstname , lastname , email , telephone FROM `". DB_PREFIX ."customer` WHERE customer_id NOT IN ($group_id) ");
			return $customer_group->rows;
		}
		
		if($query->row['user_group'] == "affiliate_all") {		
			$all_affiliate = $this->db->query("SELECT affiliate_id as id , firstname , lastname , email , telephone FROM `". DB_PREFIX ."affiliate`");
			return $all_affiliate->rows;			
		} 
		
		if($query->row['user_group'] == "affiliate"){
			$group_id = implode(",",unserialize($query->row['group_id']));			 
			$affiliate_group = $this->db->query("SELECT affiliate_id as id , firstname , lastname , email , telephone FROM `". DB_PREFIX ."affiliate` WHERE affiliate_id  IN ($group_id) ");
			return $affiliate_group->rows;
		}
		 
		if($query->row['user_group'] == "reject_affiliate") { 
			if($query->row['group_id'] !="N;") {
				$group_id = implode(",",unserialize($query->row['group_id']));			 			
				$customer_group = $this->db->query("SELECT affiliate_id as id , firstname , lastname , email , telephone FROM `". DB_PREFIX ."affiliate` WHERE affiliate_id NOT IN ($group_id) ");
				return $customer_group->rows;
			}
		}  
		
		if($query->row['user_group'] == "country") {		
			$group_id = implode(",",unserialize($query->row['group_id']));			 		
			$all_customer = $this->db->query("SELECT c.customer_id as id , c.firstname , c.lastname , c.email , c.telephone FROM ". DB_PREFIX ."customer as c JOIN  ". DB_PREFIX ."address a ON c.customer_id = a.customer_id AND a.country_id IN ($group_id) ");
			return $all_customer->rows;			
		}
		
		if($query->row['user_group'] == "state") {		
			$group_id = implode(",",unserialize($query->row['group_id']));			 		 
			$all_customer = $this->db->query("SELECT c.customer_id as id , c.firstname , c.lastname , c.email , c.telephone FROM ". DB_PREFIX ."customer as c JOIN ". DB_PREFIX ."address a ON c.customer_id = a.customer_id AND a.zone_id IN ($group_id) ");
			return $all_customer->rows;			
		}
		
		if($query->row['user_group'] == "product") {		
			$pro_array = implode(",",unserialize($query->row['group_id']));		 		 
			$product_customer = $this->db->query("SELECT GROUP_CONCAT(DISTINCT(ord.customer_id)) as cust_id_list  FROM ". DB_PREFIX ."order AS ord  join ". DB_PREFIX ."order_product  AS ord_pro  ON ord.order_id = ord_pro.order_id WHERE ord_pro.product_id IN ($pro_array)");
			$product_wise_customer = $this->db->query("SELECT customer_id as id , firstname , lastname , email , telephone FROM `". DB_PREFIX ."customer` WHERE customer_id IN (".$product_customer->rows[0]['cust_id_list'].") ");
			return $product_wise_customer->rows;			
		}
	 
		
	}
 	public function getCommnicationCampaignEmailDefaultSetting() {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_setting_email WHERE default_gateway = '1' ");
		return $query->row;
	}
	
	
	public function getTotalNumberUsersGetMessage($communication_customer_group_id){					 
		$count = 0;
		$query = $this->db->query("SELECT * FROM `". DB_PREFIX ."communication_customer_group` WHERE communication_customer_group_id = '".$communication_customer_group_id."' ");
		if($query->row['user_group'] == "customer" || $query->row['user_group'] == "affiliate" || $query->row['user_group'] == "country" || $query->row['user_group'] == "state") {
			$count = sizeof(unserialize($query->row['group_id']));
		} else if($query->row['user_group'] == "customer_all"){
			$count_customer = $this->db->query("SELECT COUNT(*) AS total FROM `". DB_PREFIX ."customer`");
			$count = $count_customer->row['total'];
			
		} else if($query->row['user_group'] == "affiliate_all"){
			$count_affiliate = $this->db->query("SELECT COUNT(*) AS total FROM `". DB_PREFIX ."affiliate`");
			$count = $count_affiliate->row['total'];			
		} else if($query->row['user_group'] == "product"){
			$customer_id = array();
			$pro_array = implode(",",unserialize($query->row['group_id']));
			$count_product = $this->db->query("SELECT  DISTINCT(ord.customer_id)  FROM ". DB_PREFIX ."order AS ord  join ". DB_PREFIX ."order_product  AS ord_pro  ON ord.order_id = ord_pro.order_id WHERE ord_pro.product_id IN ($pro_array)");
			$count = count($count_product->rows);
		}  else if($query->row['user_group'] == "reject_customer"){
			$count_customer = $this->db->query("SELECT COUNT(*) AS total FROM `". DB_PREFIX ."customer`");
			$reject_count = sizeof(unserialize($query->row['group_id']));
			$count = ($count_customer->row['total']-$reject_count);			
		} else if($query->row['user_group'] == "reject_affiliate"){
			$count_affiliate = $this->db->query("SELECT COUNT(*) AS total FROM `". DB_PREFIX ."affiliate`");
			$reject_count = sizeof(unserialize($query->row['group_id']));
			$count = ($count_affiliate->row['total']-$reject_count);
		} else if($query->row['user_group'] == "customer_group"){
			$group_id = $query->row['group_id'];
			$customer_group = $this->db->query("SELECT COUNT(*) AS total FROM `". DB_PREFIX ."customer` WHERE customer_group_id = '".$group_id."' ");
			$count = $customer_group->row['total'];	
		}
		return $count;		
	}
	
	
	/*
		Add SMS Send Details 
	*/
		
	public function addSendSmsDetails($communication_campaign_id,$customer_id,$status) {  
	$this->db->query("INSERT INTO " . DB_PREFIX . "communication_sms_send_details SET communication_campaign_id = '" . (int)$communication_campaign_id . "', customer_id = '".(int)$customer_id."' , status = '" . (int)$status . "' , date_added = NOW() ");
	}
	
    public function addSendEmailDetails($communication_campaign_id,$customer_id,$status) {  
	$this->db->query("INSERT INTO " . DB_PREFIX . "communication_email_send_details SET communication_campaign_id = '" . (int)$communication_campaign_id . "', customer_id = '".(int)$customer_id."' , status = '" . (int)$status . "' , date_added = NOW() ");
	}
	
	public function getMaxId(){
		$query = $this->db->query("SELECT MAX(communication_sms_email_details_id) as max_id FROM  " . DB_PREFIX . "communication_email_send_details");
		return $query->row['max_id'];	
		
	}
	public function getMobileTestNumber($sender) { 
		$query = $this->db->query("SELECT  CSSF.from_number as from_number  FROM  ". DB_PREFIX ."communication_campaign CC  JOIN  ". DB_PREFIX ."communication_setting_sms_from  CSSF  ON  CSSF.communication_setting_email_from_id  =  CC.sender AND CSSF.communication_setting_email_from_id = '".$sender."' ");
		return  $query->row['from_number'];
	}
	
	public function getTestEmailId($sender) {
	 
		$query = $this->db->query("SELECT  CSEF.from_name as from_name  FROM  ". DB_PREFIX ."communication_campaign CC  JOIN  ". DB_PREFIX ."communication_setting_email_from  CSEF  ON  CSEF.communication_setting_email_from_id  =  CC.sender  AND CSEF.communication_setting_email_from_id = '".$sender."'  ");
		return  $query->row['from_name'];	
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