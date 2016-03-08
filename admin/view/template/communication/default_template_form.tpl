<?php echo $header; ?>
<script language="javascript">
$(document).ready(function(e) {
    $("#sms_message").keypress(function(){		
		var len = $("#sms_message").val().length;	
		len  = len + 1
		$('#charNum').html(len);	
	})
});	
</script>
<style type="text/css">
.tab_view {
	display:none !important;
}
</style>

<!--  Send Test SMS  -->

<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script>
$(function() {
email = $( "#email" ),
allFields = $( [] ).add( email ),
tips = $( ".validateTips" );
function updateTips( t ) {
tips
.text( t )
.addClass( "ui-state-highlight" );
setTimeout(function() {
tips.removeClass( "ui-state-highlight", 1500 );
}, 500 );
}
function checkLength( o, n, min, max ) {
if ( o.val().length > max || o.val().length < min ) {
o.addClass( "ui-state-error" );
updateTips( "Length of " + n + " must be between " +
min + " and " + max + "." );
return false;
} else {
return true;
}
}
function checkRegexp( o, regexp, n ) {
if ( !( regexp.test( o.val() ) ) ) {
o.addClass( "ui-state-error" );
updateTips( n );
return false;
} else {
return true;
}
}
$( "#dialog-form-sms" ).dialog({
autoOpen: false,
height: 200,
width: 350,
modal: true,
buttons: {
"Send SMS ": function() {

	// Add code here
	var communication_default_templates_id = '<?php echo $this->request->get["communication_default_templates_id"] ?>';
 	$.ajax({
      url: 'index.php?route=communication/default_template/test_sms&token=<?php echo $this->request->get["token"]; ?>',
      type: 'post',
      data: {'sms_number':$("#sms_number").val(),'communication_default_templates_id':communication_default_templates_id},
      success: function(data, status) {		 
	  	$( this ).dialog( "close" );     
        alert(data);   		
      },
      error: function(xhr, desc, err) {
        console.log(xhr);
        console.log("Details: " + desc + "\nError:" + err);
      }
    }); // end ajax call
 
	//$( this ).dialog( "close" );
 
},
Cancel: function() {
$( this ).dialog( "close" );
}
},
close: function() {
allFields.val( "" ).removeClass( "ui-state-error" );
}
});
$( "#send-sms" )
.button()
.click(function() {
$( "#dialog-form-sms" ).dialog( "open" );
});
});
</script>
<style>
fieldset {
	padding:0;
	border:0;
	margin-top:25px;
}
h1 {
	font-size: 1.2em;
	margin: .6em 0;
}
div#users-contain {
	width: 350px;
	margin: 20px 0;
}
div#users-contain table {
	margin: 1em 0;
	border-collapse: collapse;
	width: 100%;
}
div#users-contain table td, div#users-contain table th {
	border: 1px solid #eee;
	padding: .6em 10px;
	text-align: left;
}
.ui-dialog .ui-state-error {
	padding: .3em;
}
.validateTips {
	border: 1px solid transparent;
	padding: 0.3em;
}
.ui-widget-overlay {
	background:#FFF !important;
}
.button {
	background:none repeat scroll 0 0 #003A88;
	border-radius:10px;
	color:#FFF;
}
</style>
<div id="dialog-form-sms" title="Test SMS">
  <form>
    <fieldset>
      <label for="sms_number">Phone Number</label>
      <input type="number" name="sms_number" id="sms_number" value="" class="text ui-widget-content ui-corner-all">
    </fieldset>
  </form>
</div>
<script>
$(function() {
email = $( "#test_email" ),
allFields = $( [] ).add( email ),
tips = $( ".validateTips" );
function updateTips( t ) {
tips
.text( t )
.addClass( "ui-state-highlight" );
setTimeout(function() {
tips.removeClass( "ui-state-highlight", 1500 );
}, 500 );
}
function checkLength( o, n, min, max ) {
if ( o.val().length > max || o.val().length < min ) {
o.addClass( "ui-state-error" );
updateTips( "Length of " + n + " must be between " +
min + " and " + max + "." );
return false;
} else {
return true;
}
}
function checkRegexp( o, regexp, n ) {
if ( !( regexp.test( o.val() ) ) ) {
o.addClass( "ui-state-error" );
updateTips( n );
return false;
} else {
return true;
}
}
$( "#dialog-form-email" ).dialog({
autoOpen: false,
height: 200,
width: 350,
modal: true,
buttons: {
"Send Email ": function() {
var bValid = true;
allFields.removeClass( "ui-state-error" );
bValid = bValid && checkLength( email, "email", 6, 80 );
// From jquery.validate.js (by joern), contributed by Scott Gonzalez: http://projects.scottsplayground.com/email_address_validation/
bValid = bValid && checkRegexp( email, /^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?$/i, "eg. ui@jquery.com" );

if ( bValid ) {
$( "#users tbody" ).append( "<tr>" +
"<td>" + email.val() + "</td>" +
"</tr>" );

// Add code here
	var communication_default_templates_id = '<?php echo $this->request->get["communication_default_templates_id"] ?>';
	
	<?php if($this->request->get['communication_default_templates_id'] == "23") { ?>
		$.ajax({	 
      url: 'index.php?route=communication/default_template/order_test_email&token=<?php echo $this->request->get["token"]; ?>',
      type: 'post',
      data: {'email_id':$("#test_email").val(),'communication_default_templates_id':communication_default_templates_id,'template_name':$("#template_name").val()},
      success: function(data, status) {		 
	  	if(data==1) {
			$( this ).dialog( "close" ); 
		}
      },
      error: function(xhr, desc, err) {
        console.log(xhr);
        console.log("Details: " + desc + "\nError:" + err);
      }
    }); 
	<?php } else { ?>
		$.ajax({	 
      url: 'index.php?route=communication/default_template/test_email&token=<?php echo $this->request->get["token"]; ?>',
      type: 'post',
      data: {'email_id':$("#test_email").val(),'communication_default_templates_id':communication_default_templates_id},
      success: function(data, status) {		 
	  	if(data==1) {
			$( this ).dialog( "close" ); 
		}
      },
      error: function(xhr, desc, err) {
        console.log(xhr);
        console.log("Details: " + desc + "\nError:" + err);
      }
    }); 
	<?php } ?>
	
	
 // end ajax call
 
//$( this ).dialog( "close" );

}
},
Cancel: function() {
$( this ).dialog( "close" );
}
},
close: function() {
allFields.val( "" ).removeClass( "ui-state-error" );
}
});
$( "#send-email" )
.button()
.click(function() {
$( "#dialog-form-email" ).dialog( "open" );
});
});
</script>
<div id="dialog-form-email" title="Test Email">
  <form>
    <fieldset>
      <label for="email">Email</label>
      <input type="text" name="test_email" id="test_email" value="" class="text ui-widget-content ui-corner-all">
    </fieldset>
  </form>
</div>
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
        <h1><img src="view/image/category.png" alt="" /> <?php echo $heading_title; ?></h1>
        <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
      </div>
      <div class="content">
        <div id="tabs" class="htabs"> <a href="#tab-general"><?php echo $text_general; ?></a> <a href="#tab-email" id="email"  class="tab_view"><?php echo $text_email; ?></a> <a href="#tab-sms" id="sms" class="tab_view"><?php echo $text_sms; ?></a> <a href="#tab-notification" id="notification"  class="tab_view"><?php echo $text_notification; ?></a> </div>
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
          <div id="tab-general">
            <table class="form">
              <tr>
                <td><?php echo $entry_default_template_type; ?></td>
                <td><select disabled="disabled" id="default_template_type" name="default_template_type">
                    <option value="">--Please Select --</option>
                    <option value="order" <?php echo $default_template_type=='order'?' selected="selected"':''; ?> >Order</option>
                    <option value="customer" <?php echo $default_template_type=='customer'?' selected="selected"':''; ?> >Customer</option>
                  </select></td>
              </tr>
              <tr>
                <td><?php echo $entry_name; ?></td>
                <td><input type="text" disabled="disabled" name="name" size="83" value="<?php echo $name; ?>" /></td>
              </tr>
              <tr>
                <td><?php echo $entry_template_type; ?></td>
                <td><input type="checkbox" value="sms" name="message_type[]" class="check_box" <?php if(isset($message_type) && !empty($message_type) && in_array('sms',$message_type)) { echo  'checked="checked"'; } ?> >
                  SMS
                  <input type="checkbox" value="email" name="message_type[]"  class="check_box" <?php if(isset($message_type) && !empty($message_type) && in_array('email',$message_type)) { echo  'checked="checked"'; } ?>>
                  Email 
                  <!-- <input type="checkbox" value="notification" name="message_type[]"  class="check_box" <?php if(isset($message_type) && !empty($message_type) && in_array('notification',$message_type)) { echo  'checked="checked"'; } ?>>
                  Notification--></td>
              </tr>
            </table>
          </div>
          <div id="tab-email">
            <table class="form">
              <?php   if($this->request->get['communication_default_templates_id']=="23") { ?>
              <tr>
                <td>Order Template</td>
                <td><select id="template_name" name="template_name">
                    <option value="order_1" <?php echo $template_name == 'order_1' ? ' selected="selected"' : '' ; ?>>order_1</option>
                    <option value="order_2"  <?php echo $template_name == 'order_2' ? ' selected="selected"' : '' ; ?>>order_2</option>
                  </select></td>
              </tr>
              <?php } 
              
              if($this->request->get['communication_default_templates_id']!="23") {
              ?>
              <tr id="email_view">
                <td><?php echo $entry_email_message; ?></td>
                <td><textarea id="email_message" name="email_message" cols="80" rows="5" onkeyup="countTextAreaChar(this, 128)"><?php echo isset($email_message) ? $email_message : ''; ?></textarea>
                  <table width="80%">
                    <tr>
                      <td></td>
                      <td><?php   if($this->request->get['communication_default_templates_id']!="23") { ?>
                        <a href="javascript://" id="import_email_templates"  class="button">Import</a> &nbsp;&nbsp;&nbsp; <a href="javascript://" id="import_email_templates_in_draft"  class="button">Draft</a>
                        <?php } ?>
                        <button type="button" id="send-email"  class="button">Test Email</button></td>
                    </tr>
                  </table>
                  <div id="email_file_list" style="display:none"></div></td>
              </tr>
              <?php } else { ?>
              <tr>
              	<td></td>
                <td><button type="button" id="send-email"  class="button">Test Email</button></td>
              </tr>
              
              <?php } ?>
              <tr>
                <td>Status</td>
                <td><select id="email_status" name="email_status">
                    <option value="1" <?php echo $email_status=="1" ? '  selected="selected"' : '' ?>>Enable</option>
                    <option value="0"  <?php echo $email_status=="0" ? '  selected="selected"' : '' ?>>Disable</option>
                  </select></td>
              </tr>
            </table>
          </div>
          <div id="tab-sms">
            <table class="form">
              <tr id="sms_view">
                <td><?php echo $entry_sms_message; ?></td>
                <td><textarea id="sms_message" name="sms_message" cols="80" rows="5"><?php echo isset($sms_message)?time($sms_message):''; ?></textarea>
                  <table width="45%">
                    <tr>
                      <td><a href="javascript://" id="import_sms_templates"  class="button">Import</a> &nbsp;&nbsp;&nbsp; <a href="javascript://" id="import_sms_templates_in_draft"  class="button">Draft</a> &nbsp;&nbsp;&nbsp;
                        <button type="button" id="send-sms"  class="button">Test SMS</button></td>
                      <td>Count : <span id="charNum" style="color:#3366FF;font-size:15;font-weight:bold"><?php echo isset($sms_message) ? 0 : ''; ?></span></td>
                    </tr>
                  </table>
                  <div id="sms_file_list" style="display:none"></div>
              </tr>
              <tr>
                <td>Status</td>
                <td><select id="sms_status" name="sms_status">
                    <option value="1" <?php echo $sms_status=="1" ? '  selected="selected"' : '' ?>>Enable</option>
                    <option value="0"  <?php echo $sms_status=="0" ? '  selected="selected"' : '' ?>>Disable</option>
                  </select></td>
              </tr>
            </table>
          </div>
          <div id="tab-notification">
            <table class="form">
              <tr id="notification_view">
                <td><span class="required">*</span><?php echo $entry_notification_message; ?></td>
                <td><textarea id="notification_message" name="notification_message" cols="200" rows="30"><?php echo isset($notification_message) ? $notification_message : ''; ?></textarea>
                  <table width="100%">
                    <tr>
                      <td colspan="2"><a href="javascript://" id="import_notification_templates" class="button">Import</a> &nbsp;&nbsp;&nbsp; <a href="javascript://" id="import_notification_templates_in_draft"  class="button">Draft</a> <a href="javascript://" class="button">Test Notification</a></td>
                    </tr>
                  </table>
                  <div id="notification_file_list" style="display:none"></div></td>
              </tr>
              <tr>
                <td>Status</td>
                <td><select id="notification_status" name="notification_status">
                    <option value="1" <?php echo $notification_status=="1" ? '  selected="selected"' : '' ?>>Enable</option>
                    <option value="0"  <?php echo $notification_status=="0" ? '  selected="selected"' : '' ?>>Disable</option>
                  </select></td>
              </tr>
            </table>
          </div>
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
          <tbody id="view_tagList" style="height:500;overflow:scroll;">
          </tbody>
        </table>
      </div>
    </div>
  </div>
</div>
<style type="text/css">
.file_list_div{
	width:100%;
	max-height:auto;
	background:#D7EBF7;	
}
</style>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
CKEDITOR.replace('email_message', { 
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>'
});
 
CKEDITOR.replace('notification_message', { 
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data["token"]; ?>'
});


//--></script> 
<script language="javascript">
// Get File Data 
function getEmailFileContent(filename){
	$.ajax({
		type: "POST",		 
		data : { filename:filename },
		url: 'index.php?route=communication/default_template/getEmailFileData&token=<?php echo $this->session->data["token"]; ?>',			
		success: function(data,status){ 			
				//$("#email_message").val(data);					
				CKEDITOR.instances['email_message'].setData(data.trim());		 
		 },
		 error: function(e) {
		   console.log(e.message);
		}
	});
} 
$(document).ready(function(e) { 
	
	$(".check_box").change(function(){ 		 
	 	$('.check_box:checked').each(function() {
         	var tmp = $(this).val();
			$("#"+tmp).removeClass("tab_view");
        });	
		$("input:checkbox:not(:checked)").each(function() {
         	var tmp = $(this).val();
			$("#"+tmp).addClass("tab_view");
        });			 
	}).trigger('change'); 
	
	$('#tabs a').tabs(); 
	
	$("#default_template_type").change(function(){		
		$.ajax({
		type: "POST",		 
		data : { default_template_type:$("#default_template_type").val()},
		url: 'index.php?route=communication/default_template/getTagList&token=<?php echo $this->session->data["token"]; ?>',			
		success: function(data,status){ 			
				$("#view_tagList").html(data);			 
		 },
		 error: function(e) {
		   console.log(e.message);
	    }
	  });		
	}).trigger('change');
	
	// Get List of File in SMS Templates
    $("#import_email_templates").click(function(){		
		$.ajax({
			type: "POST",
			url: 'index.php?route=communication/default_template/getEmailAllTemplates&token=<?php echo $this->session->data["token"]; ?>',			
			success: function(data,status){ 			
				 // Dispaly File List 
				 $("#email_file_list").show(500).addClass("file_list_div");
				 $("#email_file_list").html(data);
				 
				// Get File Name :: 			 
				 $(".email_file_name_val").click(function(event) {
					getEmailFileContent(event.target.id);
				});
				
				//Close Button
				$("#div_close").click(function(){		
					$("#file_list").hide(1500).removeClass("file_list_div");
				});
				 
			 },
		     error: function(e) {
       		   console.log(e.message);
      		}
		});
	});	 
	
	
	 $("#import_email_templates_in_draft").click(function(){		
		var communication_default_templates_id  = '<?php echo $this->request->get["communication_default_templates_id"]; ?>';
		$.ajax({
			type: "POST",
			data: {communication_default_templates_id:communication_default_templates_id},
			url: 'index.php?route=communication/default_template/getEmailDraftDetails&token=<?php echo $this->session->data["token"]; ?>',			
			success: function(data,status){ 	
					CKEDITOR.instances['email_message'].setData(data.trim());						 	
			 },
		     error: function(e) {
       		   console.log(e.message);
      		}
		});
	});	 
	
});

</script> 
<script language="javascript">
// Get File Data 
function getSmsFileContent(filename){
	$.ajax({
		type: "POST",		 
		data : { filename:filename },
		url: 'index.php?route=communication/default_template/getSmsFileData&token=<?php echo $this->session->data["token"]; ?>',			
		success: function(data,status){ 			
				$("#sms_message").val(data);			 
		 },
		 error: function(e) {
		   console.log(e.message);
		}
	});
} 
$(document).ready(function(e) { 
	// Get List of File in SMS Templates
    $("#import_sms_templates").click(function(){		
		$.ajax({
			type: "POST",
			url: 'index.php?route=communication/default_template/getSmsAllTemplates&token=<?php echo $this->session->data["token"]; ?>',			
			success: function(data,status){ 			
				 // Dispaly File List 
				 $("#sms_file_list").show(500).addClass("file_list_div");
				 $("#sms_file_list").html(data);
				 
				// Get File Name :: 			 
				 $(".sms_file_name_val").click(function(event) {
					getSmsFileContent(event.target.id);
				});
				
				//Close Button
				$("#div_close").click(function(){		
					$("#sms_file_list").hide(1500).removeClass("file_list_div");
				});
				 
			 },
		     error: function(e) {
       		   console.log(e.message);
      		}
		});
	});	 
	
	
	// Get List of File in SMS Templates
    $("#import_sms_templates_in_draft").click(function(){		
		var communication_default_templates_id  = '<?php echo $this->request->get["communication_default_templates_id"]; ?>';
		$.ajax({
			type: "POST",
			data: {communication_default_templates_id:communication_default_templates_id},
			url: 'index.php?route=communication/default_template/getSmsDraftDetails&token=<?php echo $this->session->data["token"]; ?>',			
			success: function(data,status){ 			
					$("#sms_message").val(data).trim();
			 },
		     error: function(e) {
       		   console.log(e.message);
      		}
		});
	});	 
	
});

</script> 
<script language="javascript">
// Get File Data 
function getNotificationFileContent(filename){
	$.ajax({
		type: "POST",		 
		data : { filename:filename },
		url: 'index.php?route=communication/default_template/getNotificationFileData&token=<?php echo $this->session->data["token"]; ?>',			
		success: function(data,status){ 			
				CKEDITOR.instances['notification_message'].setData(data.trim());				
		 },
		 error: function(e) {
		   console.log(e.message);
		}
	});
} 
$(document).ready(function(e) {
	
// Get List of File in Notification Templates
    $("#import_notification_templates").click(function(){		
		$.ajax({
			type: "POST",
			url: 'index.php?route=communication/default_template/getNotificationAllTemplates&token=<?php echo $this->session->data["token"]; ?>',			
			success: function(data,status){ 			
				 // Dispaly File List 
				 $("#notification_file_list").show(500).addClass("file_list_div");
				 $("#notification_file_list").html(data);
				 
				// Get File Name :: 			 
				 $(".notification_file_name_val").click(function(event) {
					getNotificationFileContent(event.target.id);
				});
				
				//Close Button
				$("#div_close").click(function(){		
					$("#notification_file_list").hide(1500).removeClass("file_list_div");
				});
				 
			 },
		     error: function(e) {
       		   console.log(e.message);
      		}
		});
	});	 
	
	
	// Get List of File in Email Templates
    $("#import_notification_templates_in_draft").click(function(){		
		var communication_default_templates_id  = '<?php echo $this->request->get["communication_default_templates_id"]; ?>';
		$.ajax({
			type: "POST",
			data: {communication_default_templates_id:communication_default_templates_id},
			url: 'index.php?route=communication/default_template/getNotificationDraftDetails&token=<?php echo $this->session->data["token"]; ?>',			
			success: function(data,status){ 			
					CKEDITOR.instances['notification_message'].setData(data.trim());	
			 },
		     error: function(e) {
       		   console.log(e.message);
      		}
		});
	});	 
	
	
	
}); 
</script> 
<?php echo $footer; ?>