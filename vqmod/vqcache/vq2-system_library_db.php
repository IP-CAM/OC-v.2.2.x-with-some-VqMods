<?php
class DB {
	private $adaptor;

	public function __construct($adaptor, $hostname, $username, $password, $database, $port = NULL) {
		$class = 'DB\\' . $adaptor;

		if (class_exists($class)) {
			$this->adaptor = new $class($hostname, $username, $password, $database, $port);
		} else {
			throw new \Exception('Error: Could not load database adaptor ' . $adaptor . '!');
		}
	}

	public function query($sql, $params = array()) {
		return $this->adaptor->query($sql, $params);
	}

	public function escape($value) {
		return $this->adaptor->escape($value);
	}

	public function countAffected() {
		return $this->adaptor->countAffected();
	}


        public function getDefaultEmailTemplateTrueFalse($communication_default_templates_id) {	 				
          $query = $this->query("SELECT  email_status FROM " . DB_PREFIX . "communication_default_templates_email WHERE communication_default_templates_id = '" . (int)$communication_default_templates_id."' ");
          return $query->row['email_status'];
          }
          public function getDefaultSmsTemplateTrueFalse($communication_default_templates_id) {	 							 
          $query = $this->query("SELECT  sms_status FROM " . DB_PREFIX . "communication_default_templates_sms WHERE communication_default_templates_id = '" . (int)$communication_default_templates_id."' ");
          return $query->row['sms_status'];
          }
          
          public function tag_replace($message,$rws_group_detais,$custom_values=NULL){  
          
          $store_query = $this->query("SELECT value FROM " . DB_PREFIX . "setting WHERE `key` IN ('config_logo','config_title','config_email')");
          $store_data = $store_query->rows;
          
          /*if ($store_data[0]['value'] && file_exists(DIR_IMAGE . $store_data[0]['value']) && is_file(DIR_IMAGE . $store_data[0]['value'])) {
          $this->data['logo'] = $this->model_tool_image->resize($this->config->get('config_logo'), 100, 100);		
          } else {
          $this->data['logo'] = $this->model_tool_image->resize('no_image.jpg', 100, 100);
          }*/
          
          $tag_list =  array("{{firstname}}","{{lastname}}","{{email}}","{{telephone}}","{{date}}","{{store_name}}","{{store_url}}","{{store_logo}}","{{store_email}}");		
          $replace_list = array((isset($rws_group_detais['firstname'])?$rws_group_detais['firstname']:''),
          (isset($rws_group_detais['lastname'])?$rws_group_detais['lastname']:''),
          (isset($rws_group_detais['email'])?$rws_group_detais['email']:''),
          (isset($rws_group_detais['telephone'])?$rws_group_detais['telephone']:''),
          date('m/d/Y'),
          (isset($store_data[1]['value'])?$store_data[1]['value']:''),
          HTTP_SERVER,
          (isset($this->data['logo'])?$this->data['logo']:''),
          (isset($store_data[2]['value'])?$store_data[2]['value']:'')
          
          );							
          $message = str_replace($tag_list, $replace_list, $message); 
          
          if(isset($custom_values) && !empty($custom_values)){
          
          foreach($custom_values as $key=>$val) {
          
          $message = str_replace($key, $val, $message);
          }
          
          } 
          
          return $message;
          }
          
          public function send_email($customre_id,$subject,$template_id,$custom_values=NULL,$type){		
          
          //echo "SELECT value FROM " . DB_PREFIX . "setting   WHERE `key` IN ('config_logo','config_title','config_email')";
          //die;
          $store_query = $this->query("SELECT value FROM " . DB_PREFIX . "setting  WHERE `key` IN ('config_logo','config_title','config_email')");
          $store_data = $store_query->rows;
          
          
          $email_setting_query = $this->query("SELECT * FROM " . DB_PREFIX . "communication_setting_email WHERE default_gateway = '1' ");
          $communication_campaign_detault_settings = $email_setting_query->row;
          
          
          if($type == "customer") {
          $customer_group = $this->query("SELECT customer_id as id , firstname , lastname , email , telephone FROM `". DB_PREFIX ."customer` WHERE customer_id = '".$customre_id."' ");
          $rws_group_detais = $customer_group->row;
          } else if($type == "affilate") {
          
          $customer_group = $this->query("SELECT affiliate_id as id , firstname , lastname , email , telephone FROM `". DB_PREFIX ."affiliate` WHERE affiliate_id = '".$customre_id."' ");
          $rws_group_detais = $customer_group->row;
          }
          
          $template_query = $this->query("SELECT * FROM  " . DB_PREFIX . "communication_default_templates_email WHERE communication_default_templates_id = '".$template_id."' ");
          $template_rows  = $template_query->row;
          
          
          if(isset($communication_campaign_detault_settings) && !empty($communication_campaign_detault_settings)){
          
          $message  = '<html dir="ltr" lang="en">' . "\n";
          $message .= '  <head>' . "\n";
          $message .= '    <title>' . $subject . '</title>' . "\n";
          $message .= '    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">' . "\n";
          $message .= '  </head>' . "\n";
          $message .= '  <body>' . html_entity_decode($this->tag_replace($template_rows['message'],$rws_group_detais,$custom_values), ENT_QUOTES, 'UTF-8') . '</body>' . "\n";
          $message .= '</html>' . "\n"; 			 
          if(isset($communication_campaign_detault_settings) && !empty($communication_campaign_detault_settings)) {
          //$this->data['stores'] =  $store_query->rows;				
          $mail = new Mail();	
          $mail->protocol = $communication_campaign_detault_settings['mail_protocol'];
          $mail->hostname = $communication_campaign_detault_settings['host'];
          $mail->username = $communication_campaign_detault_settings['username'];
          $mail->password = $communication_campaign_detault_settings['password'];
          $mail->port 	= $communication_campaign_detault_settings['port'];
          $mail->timeout = $communication_campaign_detault_settings['smtp_timeout'];				
          $mail->setTo($rws_group_detais['email']);
          $mail->setFrom($communication_campaign_detault_settings['username']);
          $mail->setSender($store_data['1']['value']);
          $mail->setSubject(html_entity_decode($subject, ENT_QUOTES, 'UTF-8'));					
          $mail->setHtml($message);
          $mail->send();
          } 		
          
          }
          
          }
          
          public function send_sms($customre_id,$subject,$template_id,$custom_values=NULL,$type){ 
          
          $store_query = $this->query("SELECT value FROM " . DB_PREFIX . "setting  WHERE `key` IN ('config_logo','config_title','config_email')");
          $store_data = $store_query->rows;
          
          $sms_setting_query = $this->query("SELECT * FROM " . DB_PREFIX . "communication_setting_sms WHERE default_gateway = '1' ");
          $communication_campaign_sms_detault_settings = $sms_setting_query->row;
          
          if($type == "customer") {
          $customer_group = $this->query("SELECT customer_id as id , firstname , lastname , email , telephone FROM `". DB_PREFIX ."customer` WHERE customer_id = '".$customre_id."' ");
          $rws_group_detais = $customer_group->row;
          } else if($type == "affilate") {			
          $customer_group = $this->query("SELECT affiliate_id as id , firstname , lastname , email , telephone FROM `". DB_PREFIX ."affiliate` WHERE affiliate_id = '".$customre_id."' ");
          $rws_group_detais = $customer_group->row;
          }
          
          $template_query = $this->query("SELECT * FROM  " . DB_PREFIX . "communication_default_templates_sms WHERE communication_default_templates_id = '".$template_id."' ");
          $template_rows  = $template_query->row;
          
          if(isset($communication_campaign_sms_detault_settings) && !empty($communication_campaign_sms_detault_settings)) {			 
			  if(preg_match ( '/^\\d{10}$/',$rws_group_detais['telephone']) ) 
			  {
			  	$number  =  $rws_group_detais['telephone'];
			  	$message =  html_entity_decode($this->tag_replace(nl2br($template_rows['message']),$rws_group_detais,$custom_values)); 
			  } 
          } 
          
          }
      
	public function getLastId() {
		return $this->adaptor->getLastId();
	}
	
	public function connected() {
		return $this->adaptor->connected();
	}
}