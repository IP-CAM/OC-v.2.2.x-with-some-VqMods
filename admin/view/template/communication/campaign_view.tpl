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
  <form id="form" name="form" method="post">
    <div style="width:100%">
      <div class="box" style="width:70%;float:left">
        <div class="heading">
          <h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
          <div class="buttons"> 
          <a href="javascript://" onclick="test_message_send()" class="button" id="btnTestMessage">Test Message</a> 
          <a href="javascript://" onclick="set_send()" class="button" id="btnSendSave"><?php echo $button_save; ?></a> 
          <a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a> 
          
         </div>          
        </div>
        <div class="content">
          <div class="throw_error"></div>
          <table class="form" id="campaign">
            <tr>
              <td><?php echo $entry_message_type; ?></td>
              <td><?php echo $message_type; ?>
                <input type="hidden" id="message_type" name="message_type" value="<?php echo $message_type; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_communication_template_id; ?></td>
              <td><?php echo $communication_template_id; ?></td>
            </tr>
            <tr>
              <td><?php echo $entry_user_group; ?></td>
              <td><?php echo $user_group; ?>
                <input type="hidden" id="user_group" name="user_group" value="<?php echo $user_group_id; ?>" /></td>
            </tr>
            <tr>
              <td> Number of Users </td>
              <td><strong id="total_users" style="color:#FF0000"> TOTAL : <?php echo $total_users; ?> </strong></td>
            </tr>
            <tr>
              <td><?php echo $entry_subject; ?></td>
              <td><?php echo $subject; ?>
                <input type="hidden" id="subject" name="subject" value="<?php echo $subject; ?>" /></td>
            </tr>
            <tr id="email_notification_msg">
              <td align="left" valign="top"><?php echo $entry_message; ?></td>
              <td  align="left" valign="top"><a href="javascript://" id="viewTemplate">View Template</a> <br />
                <br />
                <div id="view_template" style="display:none"> <?php echo html_entity_decode(nl2br($message), ENT_QUOTES, 'UTF-8'); ?> </div>
                <input type="hidden" id="message" name="message" value="<?php echo $message; ?>" /></td>
            </tr>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><?php if($status=='1'){ echo "Enabled"; } else if($status=='0'){ echo "Disabled"; } ?></td>
            </tr>
          </table>
        </div>
      </div>
      <?php if($delivery_date != "0000-00-00" || $delivery_time !="00:00:00" ) { ?>
      <div class="box" style="width:25%;float:right">
        <div class="heading">
          <h1>Schedule</h1>
        </div>
        <table class="form">
          <tr>
            <td>Delivery date </td>
            <td><?php echo $delivery_date != "0000-00-00" ? $delivery_date : '';  ; ?></td>
          </tr> 
            <td>Delivery Time </td>
            <td><?php echo $delivery_time != '00:00:00' ? $delivery_time : '' ; ?></td>
          </tr> 
        </table>
      </div>
      <?php } ?>
      <div class="box" style="width:25%;float:right">
        <div class="heading">
          <h1><?php echo ucfirst($message_type) ?> Setting</h1>
        </div>
        <?php if($message_type == "email"){   
      	 if(!empty($setting_array) && $setting_array['mail_protocol'] != "" &&  $setting_array['host'] != "" && $setting_array['username'] !="" && $setting_array['password'] !="" && $setting_array['port'] !=""  &&  $setting_array['smtp_timeout'] !=""  &&  $setting_array['smtp_timeout'] !="0" &&  $setting_array['port'] !="0"  ){
      ?>
        <table class="form">
          <tr>
            <td>Mail Protocol </td>
            <td><?php echo $setting_array['mail_protocol']; ?></td>
          </tr>
          <tr>
            <td>Host</td>
            <td><?php echo $setting_array['host']; ?></td>
          </tr>
          <tr>
            <td>User Name</td>
            <td><?php echo $setting_array['username'];?></td>
          </tr>
          <tr>
            <td>Password</td>
            <td><?php echo $setting_array['password'];?></td>
          </tr>
          <tr>
            <td>Port</td>
            <td><?php echo $setting_array['port'];?></td>
          </tr>
          <tr>
            <td>Smtp Timeout</td>
            <td><?php echo $setting_array['smtp_timeout']; ?></td>
          </tr>
        </table>
        <?php } else {?>
        <table class="form">
          <tr>
            <td colspan="2" style="color:red;"  align="center"><strong>Please select <strong>EMAIL</strong> protocol before send campaign</strong></td>
          </tr>
        </table>
        <script language="javascript">
			$("#btnSendSave").hide();
		</script>
        <?php } } else if($message_type == "sms") {
     	
         if(!empty($setting_array) && $setting_array['api_key'] != "" &&  $setting_array['username'] != "" && $setting_array['password'] !=""){
     
       ?>
        <table class="form">
          <tr>
            <td>Api Key</td>
            <td><?php echo $setting_array['api_key']; ?></td>
          </tr>
          <tr>
            <td>User Name</td>
            <td><?php echo $setting_array['username'];?></td>
          </tr>
          <tr>
            <td>Password</td>
            <td><?php echo $setting_array['password'];?></td>
          </tr>
        </table>
        <?php }  else { ?>
        <table class="form">
          <tr>
            <td colspan="2" style="color:red;"  align="center"><strong>Please select <strong>SMS</strong> protocol before send campaign</strong></td>
          </tr>
        </table>
        <script language="javascript">
			$("#btnSendSave").hide();
		</script>
        <?php } } else if($message_type == "notification") {  
     			 
		     	if(!empty($setting_array) && $setting_array['subject'] !="") {
     ?>
        <table class="form">
          <tr>
            <td>Subject</td>
            <td><?php echo $setting_array['subject']; ?></td>
          </tr>
        </table>
        <?php  } else { ?>
        <table class="form">
          <tr>
            <td colspan="2" style="color:red;"  align="center"><strong>Please select <strong>NOTIFICATION</strong> protocol before set campaign</strong></td>
          </tr>
        </table>
        <script language="javascript">
			$("#btnSendSave").hide();
		</script>
        <?php }   } ?>
      </div>
    </div>
  </form>
</div>
<?php echo $footer; ?> 
<script language="javascript"> 
	function set_send() { 
		var con = confirm("Are You sure you want to send this campaign !");
		if(con == true) {
			$("#form").attr("action","<?php echo HTTP_SERVER; ?>index.php?route=communication/campaign_view/update&communication_campaign_id=<?php echo $this->request->get['communication_campaign_id']; ?>&token=<?php echo $token; ?>");			
			$('#form').submit();
		}
	}
	
	function test_message_send() {
		
		var con = confirm("Are You sure you want to send test message !");
		if(con == true) {
			
			<?php 
			 if($message_type=="sms"){  
		?>	
		 
		 var communication_template_id = '<?php echo $this->request->get["communication_campaign_id"]; ?>';
		 $.ajax({			 	
				url:"index.php?route=communication/campaign_view/send_test_sms&token=<?php echo $token; ?>",
				data:{communication_template_id:communication_template_id},
				type:"post",
				dataType: 'html',
				success: function(data) {								 				 
			 	 alert(data);
			  },
			  error: function(e) {
				console.log(e.message);
			  } 
		});   
			
			 
		<?php 
			} else if ($message_type == "email") { 
		?>
			 
		 var communication_campaign_id = '<?php echo $this->request->get["communication_campaign_id"]; ?>';
		 $.ajax({			 	
				url:"index.php?route=communication/campaign_view/send_test_email&token=<?php echo $token; ?>",
				data:{communication_campaign_id:communication_campaign_id},
				type:"post",
				dataType: 'html',
				success: function(data) {								 				 
			 	 alert(data);
			  },
			  error: function(e) {
				console.log(e.message);
			  } 
		});   
			 
			 
			 
		<?php } else if ($message_type == "notification") {  ?>
			alert("notification");
	<?php  } ?>	
			
		} 				
		
	}

	$(document).ready(function(e) {
        $("#viewTemplate").click(function(){
			$("#view_template").slideToggle("slow",function(){ 
				if($("#viewTemplate").html() == "View Template"){
					$("#viewTemplate").html("Hide Template")
				} else if ($("#viewTemplate").html() == "Hide Template"){
					$("#viewTemplate").html("View Template")
				}
			});
		});
    });
</script> 
