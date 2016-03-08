e<?php echo $header; ?>
<link rel="stylesheet" href="view/stylesheet/jquery-ui-1.10.0.custom.min.css" type="text/css" />
<link rel="stylesheet" href="view/stylesheet/jquery.ui.timepicker.css?v=0.3.3" type="text/css" />
<script type="text/javascript" src="view/javascript/ui-1.10.0/jquery.ui.core.min.js"></script>
<script type="text/javascript" src="view/javascript/jquery.ui.timepicker.js?v=0.3.3"></script>


<!-- Dialog Box -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<style>
 
label, input {
	display:block;
}
input.text {
	margin-bottom:12px;
	width:95%;
	padding: .4em;
}
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
.ui-widget-overlay{
	background:#FFF !important;	
}
#create-user{
	background:none repeat scroll 0 0 #003A88;
	border-radius:10px;
	color:#FFF;
}
</style>
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
	var communication_campaign_id = '<?php echo $this->request->get["communication_campaign_id"] ?>';
 	$.ajax({
      url: 'index.php?route=communication/email_campaign_setting/test_email&token=<?php echo $token; ?>',
      type: 'post',
      data: {'email_id':$("#email").val(),'communication_campaign_id':communication_campaign_id},
      success: function(data, status) {		 	  	  
        alert(data);   		
		$( this ).dialog( "close" ); 
      },
      error: function(xhr, desc, err) {
        console.log(xhr);
        console.log("Details: " + desc + "\nError:" + err);
      }
    }); // end ajax call
 
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
$( "#create-user" )
.button()
.click(function() {
$( "#dialog-form" ).dialog( "open" );
});
});
</script>

<div id="dialog-form" title="Test Email">   
  <form>
    <fieldset>
      <label for="email">Email</label>
      <input type="text" name="email" id="email" value="" class="text ui-widget-content ui-corner-all">
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
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
      <button id="create-user"  class="button">Test Email</button>
      <a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a> 
       </div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
       <div id="tabs" class="htabs"> <a href="#tab-general"><?php echo $tab_general; ?></a> <a href="#tab-setting"><?php echo $tab_setting; ?></a> </div>
        <div id="tab-general">
        <table class="form">
          <tr>
            <td><?php echo $entry_date; ?></td>
            <td><input type="text" name="sending_date"  readonly="readonly"	 value="<?php echo (isset($sending_date) && $sending_date != '' && $sending_date != '0000-00-00')?$sending_date:''; ?>" id="sending_date" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_time; ?></td>
            <td><input type="text" id="sending_time" readonly="readonly" name="sending_time" value="<?php echo (isset($sending_time) && $sending_time != '' && $sending_time != '00:00:00')?$sending_time:''; ?>" /></td>
          </tr> 
          <tr>
            <td><?php echo $entry_birthday; ?></td>
            <td><input type="checkbox" id="birthday" name="birthday" value="1"  <?php echo (isset($birthday) && $birthday == '1')? ' checked="checked"' : ''; ?>   /> Birthday Wishes</td>
          </tr> 
        </table>
        </div>
        <div id="tab-setting">
         <table id="setting" class="list">
            <thead>
              <tr>
                <td class="left">Mail Protocol</td>
                <td class="left">SMTP Host</td>
                <td class="left">SMTP Username</td>
                <td class="left">SMTP Password</td>                
                <td class="left">SMTP Port</td>
                <td class="left">SMTP Timeout</td>
                <td class="left">Default</td>
                <td class="left">Status</td>
                <td></td>
              </tr>
            </thead>
           
              <?php $setting_row = 0; ?>
              <?php if (isset($communicationSettingEmail) && !empty($communicationSettingEmail)) { ?>
              <?php foreach ($communicationSettingEmail as $communicationSettingEmail) { ?>
               <tbody id="setting-row<?php echo $setting_row; ?>">
              <tr>
               <td class="left"><select id="email_setting[<?php echo $setting_row; ?>][mail_protocol]" name="email_setting[<?php echo $setting_row; ?>][mail_protocol]">
                    <option value="mail" <?php echo (isset($communicationSettingEmail['mail_protocol']) && $communicationSettingEmail['mail_protocol'] == 'mail') ? 'selected="selected"' : '' ; ?>>Mail</option>
                    <option value="smtp" <?php echo (isset($communicationSettingEmail['mail_protocol']) && $communicationSettingEmail['mail_protocol'] == 'smtp') ? 'selected="selected"' : '' ; ?>>SMTP</option>
                  </select></td>
                <td class="left"><input type="text" id="email_setting[<?php echo $setting_row; ?>][host]" name="email_setting[<?php echo $setting_row; ?>][host]" value="<?php echo $communicationSettingEmail['host']; ?>" size="50" /></td>
                <td class="left"><input type="text" id="email_setting[<?php echo $setting_row; ?>][username]" name="email_setting[<?php echo $setting_row; ?>][username]" value="<?php echo $communicationSettingEmail['username']; ?>" size="20" /></td>
                <td class="left"><input type="text" id="email_setting[<?php echo $setting_row; ?>][password]" name="email_setting[<?php echo $setting_row; ?>][password]" value="<?php echo $communicationSettingEmail['password']; ?>" size="20" /></td>
                
                <td class="left"><input type="text" id="email_setting[<?php echo $setting_row; ?>][port]" name="email_setting[<?php echo $setting_row; ?>][port]" value="<?php echo $communicationSettingEmail['port']; ?>" size="20" /></td>
                <td class="left"><input type="text" id="email_setting[<?php echo $setting_row; ?>][smtp_timeout]" name="email_setting[<?php echo $setting_row; ?>][smtp_timeout]" value="<?php echo $communicationSettingEmail['smtp_timeout']; ?>" size="20" /></td>
                
                <td class="left"><input type="checkbox" id="email_setting[<?php echo $setting_row; ?>][default_gateway]" name="email_setting[<?php echo $setting_row; ?>][default_gateway]" value="1" class="checkItem" <?php echo (isset($communicationSettingEmail['default_gateway']) && $communicationSettingEmail['default_gateway'] != 0) ? 'checked="checked"' : '' ; ?> />
                  Default</td>
                <td class="left"><select id="email_setting[<?php echo $setting_row; ?>][status]" name="email_setting[<?php echo $setting_row; ?>][status]">
                    <option value="1" <?php echo (isset($communicationSettingEmail['status']) && $communicationSettingEmail['status'] == 1) ? 'selected="selected"' : '' ; ?>>Enabled</option>
                    <option value="0" <?php echo (isset($communicationSettingEmail['status']) && $communicationSettingEmail['status'] == 0) ? 'selected="selected"' : '' ; ?>>Disabled</option>
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
                <td colspan="8"></td>
                <td class="left"><a onclick="addSetting();" class="button"><?php echo "Add New"; ?></a></td>
              </tr>
            </tfoot>
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
    html += '    <td class="left"><select id="email_setting[' + setting_row + '][mail_protocol]" name="email_setting[' + setting_row +'][mail_protocol]">';
	html += '    <option value="mail">Mail</option><option value="smtp">SMTP</option></td>';
    html += '    <td class="left"><input type="text" name="email_setting[' + setting_row + '][host]" id="email_setting[' + setting_row + '][host]" value="" size="50" /></td>';		
    html += '    <td class="right"><input type="text" name="email_setting[' + setting_row + '][username]" id="email_setting[' + setting_row + '][username]" value="" size="20" /></td>';
    html += '    <td class="right"><input type="text" name="email_setting[' + setting_row + '][password]" id="email_setting[' + setting_row + '][password]" value="" size="20" /></td>';
	html += '    <td class="right"><input type="text" name="email_setting[' + setting_row + '][port]" id="email_setting[' + setting_row + '][port]" value="" size="20" /></td>';
	html += '    <td class="right"><input type="text" name="email_setting[' + setting_row + '][smtp_timeout]" id="email_setting[' + setting_row + '][smtp_timeout]" value="" size="20" /></td>';	
	html += '    <td class="right"><input type="checkbox"   class="checkItem"  name="email_setting[' + setting_row + '][default_gateway]" id="email_setting[' + setting_row + '][default_gateway]" value="1"/>Default</td>';
    html += '    <td class="left"><select id="email_setting[' + setting_row + '][status]" name="email_setting[' + setting_row +'][status]">';
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
<?php echo $footer; ?>