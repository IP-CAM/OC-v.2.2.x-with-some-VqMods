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
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"> <a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a> </div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"> <a href="#tab-general">General</a> <a href="#tab-protocol">Protocol</a> <a href="#tab-from">Sender </a> </div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <div id="tab-general">
          <table class="form">
            <tr>
              <td>Default Template </td>
              <td><select id="default_template" name="default_template">
                  <option value="">--Please select--</option>
                  <?php
                  	foreach($template_list as $template_list){ 
                    	$st = '';
                    	if(isset($default_template)  && $default_template == $template_list['communication_template_email_id'] )
                        {
                        	$st = ' selected="selected"';
                        }
                    ?>
                  <option value="<?php echo $template_list['communication_template_email_id']; ?>" <?php echo $st; ?>><?php echo $template_list['subject']; ?></option>
                  <?php }
                  ?>
                </select></td>
            </tr>
            <tr>
              <td>Default Customer Group</td>
              <td><select id="default_customer_group" name="default_customer_group">
                  <option value="">--Please select--</option>
                  <?php
                  	foreach($customer_list as $customer_list){ 
                    
                    $st = '';
                    	if(isset($default_template)  && $default_template == $customer_list['communication_customer_group_id'] )
                        {
                        	$st = ' selected="selected"';
                        }
                    
                    ?>
                  <option value="<?php echo $customer_list['communication_customer_group_id']; ?>"  <?php echo $st; ?>><?php echo $customer_list['title']; ?></option>
                  <?php }
                  ?>
                </select></td>
            </tr>
          </table>
        </div>
        <div id="tab-protocol">
          <table id="setting" class="list">
            <thead>
              <tr>
                <td class="left">API Key</td>
                <td class="left">User Name</td>
                <td class="left">Password</td>
                <td class="left">Sms Default</td>
                <td class="left">Status</td>
                <td></td>
              </tr>
            </thead>
            <?php $setting_row = 0; ?>
            <?php if (isset($communicationSettingSms) && !empty($communicationSettingSms)) { ?>
            <?php foreach ($communicationSettingSms as $communicationSettingSms) { ?>
            <tbody id="setting-row<?php echo $setting_row; ?>">
              <tr>
                <td class="left"><input type="text" id="sms_setting[<?php echo $setting_row; ?>][api_key]" name="sms_setting[<?php echo $setting_row; ?>][api_key]" value="<?php echo $communicationSettingSms['api_key']; ?>" size="50" /></td>
                <td class="left"><input type="text" id="sms_setting[<?php echo $setting_row; ?>][username]" name="sms_setting[<?php echo $setting_row; ?>][username]" value="<?php echo $communicationSettingSms['username']; ?>" size="20" /></td>
                <td class="left"><input type="text" id="sms_setting[<?php echo $setting_row; ?>][password]" name="sms_setting[<?php echo $setting_row; ?>][password]" value="<?php echo $communicationSettingSms['password']; ?>" size="20" /></td>
                <td class="left"><input type="checkbox" id="sms_setting[<?php echo $setting_row; ?>][default_gateway]" name="sms_setting[<?php echo $setting_row; ?>][default_gateway]" value="1" class="checkItem" <?php echo (isset($communicationSettingSms['default_gateway']) && $communicationSettingSms['default_gateway'] != 0) ? 'checked="checked"' : '' ; ?> />
                  Default</td>
                <td class="left"><select id="sms_setting[<?php echo $setting_row; ?>][status]" name="sms_setting[<?php echo $setting_row; ?>][status]">
                    <option value="1" <?php echo (isset($communicationSettingSms['status']) && $communicationSettingSms['status'] == 1) ? 'selected="selected"' : '' ; ?>>Enabled</option>
                    <option value="0" <?php echo (isset($communicationSettingSms['status']) && $communicationSettingSms['status'] == 0) ? 'selected="selected"' : '' ; ?>>Disabled</option>
                  </select></td>
                <td class="left"><a onclick="$('#setting-row<?php echo $setting_row; ?>').remove();" class="button"><?php echo "Remove"; ?></a></td>
              </tr>
            </tbody>
            <?php $setting_row++; ?>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="7"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
            <tfoot>
              <tr>
                <td colspan="5"></td>
                <td class="left"><a onclick="addSetting();" class="button"><?php echo "Add New"; ?></a></td>
              </tr>
            </tfoot>
          </table>
        </div>
        <div id="tab-from">
          <table class="form">
            <tr>
              <td>Sender Number</td>
              <td><input type="text" id="from_number" name="from_number"/></td>
            </tr>
          </table>
          <br />
          <br />
          <table class="list">
            <thead>
              <tr>
                <td class="left" width="60%">Number</td>
                <td class="left" width="20%">Date Time </td>
              </tr>
            </thead>
            <tbody>
              <?php if(!empty($from_list)){
             			foreach($from_list as $from_list) { ?>
              <tr>
                <td class="left"><?php echo $from_list['from_number']; ?></td>
                <td class="left"><?php echo $from_list['date_added']; ?></td>
              </tr>
              <?php       }             
             } ?>
            </tbody>
          </table>
        </div>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var setting_row = <?php echo $setting_row; ?>;

function addSetting() 
{
	html  = '<tbody id="setting-row' + setting_row + '">';
	html += '  <tr>'; 
    html += '    <td class="left"><input type="text" name="sms_setting[' + setting_row + '][api_key]" id="sms_setting[' + setting_row + '][api_key]" value="" size="50" /></td>';		
    html += '    <td class="left"><input type="text" name="sms_setting[' + setting_row + '][username]" id="sms_setting[' + setting_row + '][username]" value="" size="20" /></td>';
    html += '    <td class="left"><input type="text" name="sms_setting[' + setting_row + '][password]" id="sms_setting[' + setting_row + '][password]" value="" size="20" /></td>';
	html += '    <td class="left"><input type="checkbox"   class="checkItem"  name="sms_setting[' + setting_row + '][default_gateway]" id="sms_setting[' + setting_row + '][default_gateway]" value="1"/>Default</td>';
    html += '    <td class="left"><select id="sms_setting[' + setting_row + '][status]" name="sms_setting[' + setting_row +'][status]">';
	html += '    <option value="1">Enabled</option><option value="0">Disabled</option></td>';
	html += '    <td class="left"><a onclick="$(\'#setting-row' + setting_row + '\').remove();" class="button"><?php echo "Remove"; ?></a></td>';
	html += '  </tr>';	
    html += '</tbody>';
	$('#setting tfoot').before(html);
	setting_row++; 
	
	$('.checkItem').bind('click',function(event) {
	    $(".checkItem").removeAttr("checked");
		$(this).attr("checked", "checked");	
  	})
	
}
//--></script> 
<script type="text/javascript">
$(document).ready(function(e) {    
	 $('.checkItem').click(function () {    	 	 
		 $(".checkItem").removeAttr("checked");
		 $(this).attr("checked", "checked");	
	 });	 
});
</script> 
<script type="text/javascript"> 
$('#tabs a').tabs(); 
$(document).ready(function() {
	
	// Dispaly Date 
	$('#sending_date').datepicker({dateFormat: 'yy-mm-dd'});  	
	
	// Dispaly Time 
	$('#sending_time').timepicker( {
		showAnim: 'blind'
	} );
	  
});
</script> 
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
$( "#dialog-form" ).dialog({
autoOpen: false,
height: 200,
width: 350,
modal: true,
buttons: {
"Send SMS ": function() {

	// Add code here
	var communication_campaign_id = '<?php echo $this->request->get["communication_campaign_id"] ?>';
 	$.ajax({
      url: 'index.php?route=communication/sms_campaign_setting/test_sms&token=<?php echo $token; ?>',
      type: 'post',
      data: {'sms_number':$("#sms_number").val(),'communication_campaign_id':communication_campaign_id},
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
$( "#create-user" )
.button()
.click(function() {
$( "#dialog-form" ).dialog( "open" );
});
});
</script> 
<?php echo $footer; ?>