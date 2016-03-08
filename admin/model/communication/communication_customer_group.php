<?php
class ModelCommunicationCommunicationCustomerGroup extends Model {
	
	
	public function addCustomerGroup($data) {
		
		 
		
		$user_ids = '';
		if($data['user_group'] =="customer_group"){
			$user_ids = (int)$data['customer_group_id'];			
		}else if($data['user_group'] =="customer"){			
			$user_ids = serialize($data['customer']);
		}else if($data['user_group'] =="affiliate"){
			$user_ids = serialize($data['affiliate']);
		}else if($data['user_group'] =="product"){
			$user_ids = serialize($data['product']);
		}else if($data['user_group'] =="customer_group_campaign"){
			$user_ids = serialize($data['customer_group_campaign']);
		}else if($data['user_group'] =="country"){
			$user_ids = serialize($data['country_id']);
		}else if($data['user_group'] =="state"){
			$user_ids = serialize($data['state_id']);
		}else if($data['user_group'] =="reject_customer"){
			$user_ids = serialize($data['reject_customer']);
		}else if($data['user_group'] =="reject_affiliate"){
			$user_ids = serialize($data['reject_affiliate']);
		}	 
		
		 
		
		$this->db->query("INSERT INTO " . DB_PREFIX . "communication_customer_group SET  message_type = '".serialize($data['message_type'])."' , title = '".$this->db->escape($data['title'])."' , user_group = '".$this->db->escape($data['user_group'])."' , group_id = '" . $user_ids . "' , status = '".$this->db->escape($data['status'])."'  , date_added=NOW() , is_deleted=1");
		$this->cache->delete('communication_customer_group');
	}




    public function editCommunicationCustomerGroup($communication_customer_group_id, $data) {
		
		
		/*echo "<xmp>";
		print_r($data);
		echo "</xmp>";*/

		
		$user_ids = '';
		if($data['user_group'] =="customer_group"){
			$user_ids = (int)$data['customer_group_id'];			
		}else if($data['user_group'] =="customer"){
			$user_ids = serialize($data['customer']);
		}else if($data['user_group'] =="affiliate"){
			$user_ids = serialize($data['affiliate']);
		}else if($data['user_group'] =="product"){
			$user_ids = serialize($data['product']);
		}else if($data['user_group'] =="customer_group_campaign"){
			$user_ids = serialize($data['customer_group_campaign']);
		}else if($data['user_group'] =="country"){
			$user_ids = serialize($data['country_id']);
		}else if($data['user_group'] =="state"){
			$user_ids = serialize($data['state_id']);
		}else if($data['user_group'] =="reject_customer"){
			$user_ids = serialize($data['reject_customer']);
		}else if($data['user_group'] =="reject_affiliate"){
			$user_ids = serialize($data['reject_affiliate']);
		}	
		
		//echo "UPDATE " . DB_PREFIX . "communication_customer_group SET  message_type = '".serialize($data['message_type'])."', title = '".$this->db->escape($data['title'])."'  , user_group = '".$this->db->escape($data['user_group'])."' , group_id = '" . $user_ids . "' , status = '".$this->db->escape($data['status'])."'  , date_modified=NOW()   where communication_customer_group_id='".$communication_customer_group_id."' ";
		//die;
		 
		$this->db->query("UPDATE " . DB_PREFIX . "communication_customer_group SET  message_type = '".serialize($data['message_type'])."', title = '".$this->db->escape($data['title'])."'  , user_group = '".$this->db->escape($data['user_group'])."' , group_id = '" . $user_ids . "' , status = '".$this->db->escape($data['status'])."'  , date_modified=NOW()   where communication_customer_group_id='".$communication_customer_group_id."' ");
		$this->cache->delete('communication_customer_group');
	}
		
	public function getAffiliateById($affiliate_id ) {	  
		$query = $this->db->query("SELECT affiliate_id,firstname,lastname FROM " . DB_PREFIX . "affiliate  WHERE affiliate_id  = '" . (int)$affiliate_id  . "'");
		return $query->row;
	} 	
		
	public function deleteCommunicationGroup($communication_customer_group_id) {
		$this->db->query("UPDATE " . DB_PREFIX . "communication_customer_group SET is_deleted = 0 WHERE communication_customer_group_id = '" . (int)$communication_customer_group_id . "'");
		$this->cache->delete('communication_customer_group');
	}
	
	public function getCommunicationCoustomerGroup($communication_customer_group_id) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_customer_group WHERE communication_customer_group_id = '" . (int)$communication_customer_group_id . "'");
		return $query->row;
	}
		
	public function getCommunicationCustomer($id) {
		$name=$this->db->query("SELECT * FROM " . DB_PREFIX . "customer where group_id='".$id."' ");
		return $name->row;
	}
	
	public function getTotalCommunicationCustomerGroup() {
		$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "communication_customer_group");
		return $query->row['total'];
	}	 
	   
	public function getCommunicationCoustomerGroups($data = array()) {
		 
			$sql = "SELECT * FROM " . DB_PREFIX . "communication_customer_group WHERE is_deleted = 1 ";

			$sort_data = array(
				'communication_customer_group_id',
				'user_group',			 
				'status'
			);	

			if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
				$sql .= " ORDER BY " . $data['sort'];	
			} else {
				$sql .= " ORDER BY communication_customer_group_id";	
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
	
	public function getCustomers($data = array()) {
		$sql = "SELECT *, CONCAT(c.firstname, ' ', c.lastname) AS name, cgd.name AS customer_group FROM " . DB_PREFIX . "customer c LEFT JOIN " . DB_PREFIX . "customer_group_description cgd ON (c.customer_group_id = cgd.customer_group_id) WHERE cgd.language_id = '" . (int)$this->config->get('config_language_id') . "'";

		$implode = array();

		if (!empty($data['filter_name'])) {
			$implode[] = "CONCAT(c.firstname, ' ', c.lastname) LIKE '%" . $this->db->escape($data['filter_name']) . "%'";
		}

		if (!empty($data['filter_email'])) {
			$implode[] = "c.email LIKE '" . $this->db->escape($data['filter_email']) . "%'";
		}

		if (isset($data['filter_newsletter']) && !is_null($data['filter_newsletter'])) {
			$implode[] = "c.newsletter = '" . (int)$data['filter_newsletter'] . "'";
		}	

		if (!empty($data['filter_customer_group_id'])) {
			$implode[] = "c.customer_group_id = '" . (int)$data['filter_customer_group_id'] . "'";
		}	

		if (!empty($data['filter_ip'])) {
			$implode[] = "c.group_id IN (SELECT group_id FROM " . DB_PREFIX . "customer_ip WHERE ip = '" . $this->db->escape($data['filter_ip']) . "')";
		}	

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$implode[] = "c.status = '" . (int)$data['filter_status'] . "'";
		}	

		if (isset($data['filter_approved']) && !is_null($data['filter_approved'])) {
			$implode[] = "c.approved = '" . (int)$data['filter_approved'] . "'";
		}	

		if (!empty($data['filter_date_added'])) {
			$implode[] = "DATE(c.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		if ($implode) {
			$sql .= " AND " . implode(" AND ", $implode);
		}

		$sort_data = array(
			'name',
			'c.email',
			'customer_group',
			'c.status',
			'c.approved',
			'c.ip',
			'c.date_added'
		);	

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY name";	
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
	
	public function displayCustomerGroups() {	 	 
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "communication_customer_group  WHERE status = '1' AND is_deleted = '1' ");
		return $query->rows;
	}
		
	public function getCustomerCount() {	 
	 	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer");
		return $query->row['total'];
	}
	
	public function getAffiliatesCount() {	 
	 	$query = $this->db->query("SELECT COUNT(*) AS total FROM " . DB_PREFIX . "affiliate");
		return $query->row['total'];
	}		
	
	public function getCustomerGroups($data = array()) {
		
		$sql = "SELECT * FROM " . DB_PREFIX . "customer_group cg LEFT JOIN " . DB_PREFIX . "customer_group_description cgd ON (cg.customer_group_id = cgd.customer_group_id) WHERE cgd.language_id = '" . (int)$this->config->get('config_language_id') . "'";
		
		$sort_data = array(
			'cgd.name',
			'cg.sort_order'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY cgd.name";	
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
	
	public function getCountryLists(){
		$query = $this->db->query("SELECT country_id,name FROM " . DB_PREFIX . "country  WHERE status = '1' ");
		return $query->rows;		
	}
	
	public function getAffiliateLists(){
		$query = $this->db->query("SELECT affiliate_id , firstname , lastname    FROM " . DB_PREFIX . "affiliate  WHERE status = '1' ");
		return $query->rows;		
	}
	
	public function getCustomerLists(){
		$query = $this->db->query("SELECT  customer_id , firstname , lastname FROM " . DB_PREFIX . "customer  WHERE status = '1' ");
		return $query->rows;		
	}
	
	
	public function getStateLists(){	 
		$query = $this->db->query("SELECT zone_id,name  FROM " . DB_PREFIX . "zone  WHERE status = '1' ");
		return $query->rows;		
	}
	
	public function getDataById($customer_id) {	 	 
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer  WHERE status = '1'  AND customer_id = '".$customer_id."' ");
		return $query->row;
	}
	
	public function getProductsById($product_id) {	  
		$query = $this->db->query("SELECT product_id,name FROM " . DB_PREFIX . "product_description  WHERE product_id = '" . (int)$product_id . "'");
		return $query->row;
	}
	 
}
?>