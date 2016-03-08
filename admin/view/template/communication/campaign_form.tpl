<?php echo $header; ?>

<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div style="width:100%">
    <div class="box" style="width:73%;float:left">
      <div class="heading">
        <h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
        <div class="buttons">
          <?php
          	if(!isset($this->request->get['communication_campaign_id'])){            
          ?>
         	 <a href="javascript://" onclick="set_schedule();" class="button"><?php echo $button_schedule; ?></a> <a href="javascript://" onclick="set_send()" class="button" id="btnSendSave"><?php echo $button_draft_save; ?></a>
          <?php
           } else {   ?> 

             <a href="javascript://" onclick="set_edit_send()" class="button" id="btnSendSave"><?php echo $button_schedule; ?></a> 
             <a href="javascript://" onclick="set_edit()" class="button" id="btnEdit"><?php echo $button_edit; ?></a>  
              
          <?php } ?>
        	  <a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a> </div>
      </div>
      <div class="content">
        <div class="throw_error"></div>
        <form method="post" enctype="multipart/form-data" id="form" name="form">
          <?php  if(isset($this->request->get['ty']) && $this->request->get['ty'] =='schedule') { ?>
          <table class="form" style="background:#ADD5ED">
            <tr>
              <td>Delivery date </td>
              <td><input type="text" id="delivery_date" name="delivery_date"   value="<?php echo (isset($delivery_date) && $delivery_date != '' && $delivery_date != '0000-00-00')?$delivery_date:''; ?>"/></td>
              <td>Delivery Time </td>
              <td><input type="text" id="delivery_time" name="delivery_time" value="<?php echo (isset($delivery_time) && $delivery_time != '' && $delivery_time != '00:00:00')?$delivery_time:''; ?>"/></td>
            </tr>
            <tr>
              <td></td>
              <td style="display:none"><input type="checkbox"  value="1" name="birthday" id="birthday" <?php echo $birthday=='1' ? ' checked="checked"' : ''; ?>  /> Birthday Wishes</td>            
              <?php if(isset($message_type) && $message_type =="notification") { ?>  
             	<td>Notification Setting </td>
                <td>
                	<select id="setting_id" name="setting_id">                                       	
                        <?php
                        	foreach($notificaion_setting_info as $notificaion_setting_info){
                            	$st = '';
                                if(isset($setting_id) && $setting_id == $notificaion_setting_info['communication_notification_setting_id']) {
                                	$st = ' selected="selected"';
                                }
                            	echo '<option value="'.$notificaion_setting_info['communication_notification_setting_id'].'" '.$st.'>'.$notificaion_setting_info['subject'].'</option>';
                            }
                        ?>

                    </select>
                </td>
             <?php } else { ?>
	             <td colspan="2"></td>
             <?php } ?>
            </tr>
          </table>
          <?php  }  ?>
          <table class="form" id="campaign">
            <tr>
              <td><span class="required">*</span> <?php echo $entry_message_type; ?></td>
              <td><select id="message_type" name="message_type">
                  <option value="">--- Please Select ---</option>
                  <?php foreach($message_type_val as $val){ 
                
               		$st='';
                	if(isset($message_type_val) && $message_type == $val ){  
	                    $st =' selected="selected"';
                    } 
                    else if(isset($this->request->get['type']) && !empty($this->request->get['type']) && $this->request->get['type'] == $val) 
                    {   $st =' selected="selected"'; }
                ?>
                  <option value="<?php echo $val; ?>" <?php echo $st; ?>><?php echo $val; ?></option>
                  <?php } ?>
                </select>
                <?php if ($error_message_type) { ?>
                <span class="error"><?php echo $error_message_type; ?></span>
                <?php } ?>
                <img src="view/image/campaign_loding.gif" id="loding_nt" style="display:none" /></td>
            </tr>
            
            <tr id="tr_sender">
            	<td> Sender </td>
                <td id="td_sender"><select id="sender" name="sender">
                		<option value="">--Please Select--</option>
                	</select>
                 </td>
            </tr>
            
            <tr>
              <td><span class="required">*</span> <?php echo $entry_communication_template_id; ?></td>
              <td><div id="template_name_ajax">
                  <select id="communication_template_id" name="communication_template_id">
                    <option value="">--- Please Select ---</option>
                    <?php foreach($campaign_template as $campaign_template)
                {  
               		$st='';
                	if(isset($campaign_template) && $campaign_template['communication_template_id'] == $communication_template_id ){  
                    $st =' selected="selected"';
                 } 
                ?>
                    <option value="<?php echo $campaign_template['communication_template_id']; ?>" <?php echo $st; ?>><?php echo $campaign_template['name']; ?></option>
                    <?php } ?>
                  </select>
                </div>
                <?php if ($error_communication_template_id) { ?>
                <span class="error"><?php echo $error_communication_template_id; ?></span>
                <?php } ?></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_user_group; ?></td>
              <td  id="view_customer_group_id"><select name="user_group" id="user_group">
                  <option value=""></option>
                </select>
                <?php if ($error_user_group) { ?>
                <span class="error"><?php echo $error_user_group; ?></span>
                <?php } ?>
                <img src="view/image/campaign_loding.gif" id="loding_us" style="display:none" /></td>
            </tr>
            <tr id="tr_total" style="display:none">
              <td> Number of Users </td>
              <td><strong id="total_users" style="color:#FF0000"> TOTAL :  0 </strong></td>
            </tr>
            <tr>
              <td><span class="required">*</span> <?php echo $entry_subject; ?></td>
              <td><input type="text" id="subject" name="subject" value="<?php echo $subject; ?>" style="width:530px;"/>
                <?php if ($error_subject) { ?>
                <span class="error"><?php echo $error_subject; ?></span>
                <?php } ?></td>
            </tr>
            <?php if(isset($message_type) && $message_type == "sms") { ?>
            <tr id="sms_msg">
              <td><span class="required">*</span> <?php echo $entry_message; ?></td>
              <td><textarea id="sms_message" name="sms_message" cols="100" rows="8"><?php echo $message; ?></textarea></td>
            </tr>
            <?php } else if(isset($message_type) && ($message_type == "notification" || $message_type == "email") ) { ?>
            <tr id="email_notification_msg">
              <td><span class="required">*</span> <?php echo $entry_message; ?></td>
              <td><textarea id="email_notification_message" name="email_notification_message" cols="100" rows="8"><?php echo $message; ?></textarea></td>
            </tr>
            <?php } else { ?>
            <tr id="sms_msg" style="display:none">
              <td><span class="required">*</span> <?php echo $entry_message; ?></td>
              <td><textarea id="sms_message" name="sms_message" cols="100" rows="8"><?php echo $message; ?></textarea></td>
            </tr>
            <tr id="email_notification_msg"  style="display:none">
              <td><span class="required">*</span> <?php echo $entry_message; ?></td>
              <td><textarea id="email_notification_message" name="email_notification_message" cols="100" rows="8"><?php echo $message; ?></textarea></td>
            </tr>
            <?php } ?>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select id="status" name="status">
                  <?php if($status=='1'){ ?>
                  <option value="1" selected="selected">Enabled</option>
                  <?php }else{ ?>
                  <option value="1">Enabled</option>
                  <?php } ?>
                  <?php if($status=='0'){ ?>
                  <option value="0" selected="selected">Disabled</option>
                  <?php } else { ?>
                  <option value="0">Disabled</option>
                  <?php } ?>
                </select></td>
            </tr>
          </table>
        
        </form>
      </div>
    </div>
    <div class="box" style="width:25%;float:right">
      <div class="heading">
        <h1><img src="view/image/category.png" alt="" />Tag</h1>
      </div>
      <div class="content">
        <table class="form">
          <tr>
            <td colspan="2"><h3> <span>Tag List </span></h3></td>
          </tr>
          <tbody id="view_tagList">
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/jquery.ui.timepicker.js?v=0.3.3"></script>
<?php echo $footer; ?> 
<script type="text/javascript"><!--
$(document).ready(function() {
	$('#delivery_date').datepicker({dateFormat: 'yy-mm-dd'});
	$('#delivery_time').timepicker( {
		showAnim: 'blind'
	} );
});
//--></script> 
<script language="javascript">
	function set_send(){ 
		<?php if(!isset($this->request->get['communication_campaign_id'])) { ?>
			$("#form").attr("action","<?php echo HTTP_SERVER; ?>index.php?route=communication/campaign/insert&token=<?php echo $token; ?>");			
		<?php } else { ?>
			 
			$("#form").attr("action","<?php echo HTTP_SERVER; ?>index.php?route=communication/campaign/update&communication_campaign_id=<?php echo $this->request->get['communication_campaign_id']; ?>&token=<?php echo $token; ?>");			
		<?php } ?>
		$('#form').submit();
	}
	function set_schedule(){
		
		<?php if(!isset($this->request->get['communication_campaign_id'])) { ?>
			$("#form").attr("action","<?php echo HTTP_SERVER; ?>index.php?route=communication/campaign/insertSchedule&token=<?php echo $token; ?>");			
		<?php } else { ?>
			$("#form").attr("action","<?php echo HTTP_SERVER; ?>index.php?route=communication/campaign/updateSchedule&communication_campaign_id=<?php echo $this->request->get['communication_campaign_id']; ?>&token=<?php echo $token; ?>");			
		<?php } ?>
		$('#form').submit();
	}
	
	function set_edit() {		
		$("#form").attr("action","<?php echo HTTP_SERVER; ?>index.php?route=communication/campaign/update&communication_campaign_id=<?php echo $this->request->get['communication_campaign_id']; ?>&token=<?php echo $token; ?>&ty=schedule");		
		$('#form').submit();
	}
	
	function set_copy(){		
		$("#form").attr("action","<?php echo HTTP_SERVER; ?>index.php?route=communication/campaign/copy_data&communication_campaign_id=<?php echo $this->request->get['communication_campaign_id']; ?>&token=<?php echo $token; ?>");		
		$('#form').submit();
	}
	
	function set_edit_send(){		
		$("#form").attr("action","<?php echo HTTP_SERVER; ?>index.php?route=communication/campaign/edit_send&communication_campaign_id=<?php echo $this->request->get['communication_campaign_id']; ?>&token=<?php echo $token; ?>");		
		$('#form').submit();
	} 
	
</script>  
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
CKEDITOR.replace('email_notification_message', { 
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>'
});
//--></script> 
<script type="text/javascript">  
$('select[name=\'user_group\']').trigger('change');

function getCampaignType() {
	$("#loding_nt").show();
	var message_type = $("#message_type").val();	 
	var communication_template_id = '<?php echo isset($communication_template_id)?$communication_template_id:""; ?>';
	$.post('index.php?route=communication/campaign/getTemplateList&token=<?php echo $token; ?>',{communication_template_id:communication_template_id,message_type:message_type},function(data){		
		$('#template_name_ajax').html(data);		
		$("#loding_nt").hide();
		<?php if(!isset($_GET['communication_campaign_id'])){?>	
		$("#sms_msg").hide();
		$("#email_notification_msg").hide();
		$("#dropdown").trigger('change');
		<?php } ?> 
	}); 
	
}

function getSendFrom(){
	
	var message_type = $("#message_type").val();	  
	var sender =  '<?php echo isset($sender)?$sender:""; ?>';
	var communication_template_id = '<?php echo isset($communication_template_id)?$communication_template_id:""; ?>';
	if(message_type != "notification") {
		$.post('index.php?route=communication/campaign/getSender&token=<?php echo $token; ?>',{sender:sender,message_type:message_type},function(data){		
			
			$("#tr_sender").show();
			$("#td_sender").html(data);
			
			getCampaignType();
			getCustomerGroupList();
			
		}); 
	
	} else {
		$("#tr_sender").hide();
		getCampaignType();
		getCustomerGroupList();
	}
	
} 

function getDefaultTemplateCustomerGroup(){
	
	var message_type = $("#message_type").val();	  
	var communication_template_id = '<?php echo isset($communication_template_id)?$communication_template_id:""; ?>';
	if(message_type != "notification")
	{
		$.post('index.php?route=communication/campaign/getDefault&token=<?php echo $token; ?>',{communication_template_id:communication_template_id,message_type:message_type},function(data){		
			 var arr = Array();
			 arr = data.split('-');			 
			 $("#communication_template_id" ).delay( 800 );
			 $("#communication_template_id").val(arr[0]);
			 $("#user_group" ).delay( 1600 );
		  	 $("#user_group").val(arr[1]);
			 $("#user_group" ).delay( 1600 );
			 viewSubjectMessage();
		}); 
	}  
} 


function viewSubjectMessage(){		 

	$( "#communication_template_id" ).delay( 800 );
	 var message_type = $("#message_type").val();
	 var communication_template_id = $("#communication_template_id").val();
	 $.ajax({			 	
			url:"index.php?route=communication/campaign/getTemplateDetails&token=<?php echo $token; ?>",
			data:{message_type:message_type,communication_template_id:communication_template_id},
			type:"post",
			dataType: 'json',
			success: function(json) {								 				 
			$("#subject").val(json['subject']);
			if(message_type=="sms"){	
				$("#sms_msg").show(); 	
				$("#sms_message").val(json['message']);
			}else if(message_type == "notification" || message_type == "email"){
				$("#email_notification_msg").show();	 
				CKEDITOR.instances['email_notification_message'].setData(json['message']);
			}
		  },
		  error: function(e) {
			console.log(e.message);
		  } 
	});  
	 
}

function getCustomerGroupList(){	
	
	var message_type = $("#message_type").val();
	var user_group = '<?php echo isset($user_group)?$user_group:""; ?>';
	$.ajax({		
		 url:"index.php?route=communication/campaign/getCustomerGroupList&token=<?php echo $token; ?>",
		  type: 'POST',
		  data: {message_type:message_type,user_group:user_group},
		  success: function(data) {
			$('#view_customer_group_id').html(data);
			<?php  if(!isset($this->request->get['communication_campaign_id'])) { ?>
				getDefaultTemplateCustomerGroup();							
			<?php } ?>
		  },
		  error: function(e) {
			//called when there is an error
			//console.log(e.message);
		  }		
		
	});
}
 
$(document).ready(function() { 		 

	$("#message_type").change(function(){		
		$.ajax({
		type: "POST",		 
		data : { sms_type:'customer'},
		url: 'index.php?route=communication/campaign/getTagList&token=<?php echo $this->session->data["token"]; ?>',			
		success: function(data,status){ 			
				$("#view_tagList").html(data);		
				getSendFrom();	 
		 },
		 error: function(e) {
		   console.log(e.message);
	    }
	  });		
	  
	   		
		<?php  
		if(!isset($_GET['communication_campaign_id'])){
		?>
		$("#dropdown option:first-child").attr("selected","selected");
		<?php } ?>
		if($("#message_type").val() == 'notification'){		
			$("#dropdown option[value='url']").removeAttr("disabled","disabled");
		}else{			
			$("#dropdown option[value='url']").attr("disabled","disabled");	
		} 
		
		/*if($("#message_type").val() == "notification"){
			$("#btnSendSave").html("Save");
		}else{
			<?php if(! isset($this->request->get['communication_campaign_id'])) { ?>	
			$("#btnSendSave").html("Draft (Save)");	
			<?php } ?>
		} */
	  
	  
	  
	}).trigger('change');

	/* Get Campaign Type Dropdown  */
	
	<?php 
		if(isset($_GET['communication_campaign_id'])){
	?>
		$("#message_type").trigger('change');
		
		if($("#message_type").val()=="sms"){	
			$("#sms_msg").show(); 	
		}else if($("#message_type").val() == "notification" || $("#message_type").val() == "email"){ 
			$("#email_notification_msg").show();	 
		}
	<?php } ?>
});
</script> 
<script language="javascript">
	$("#user_group").live( "change", function() {		
		if($("#user_group").val() != ""){
		 $.ajax({			 	
				url:"index.php?route=communication/campaign/getTotalUsers&token=<?php echo $token; ?>",
				data:{user_group:$(this).val()},
				type:"post",				
				success: function(data) {						 
				$("#total_users").html("TOTAL : "+data);
				$("#tr_total").show(1000);
			  },
			  error: function(e) {
				console.log(e.message);
			  } 
		});  
	}
		
	});	
</script> 
