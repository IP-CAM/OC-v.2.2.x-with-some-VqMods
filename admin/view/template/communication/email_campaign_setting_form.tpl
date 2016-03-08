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
      <div class="buttons"> <a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a> <a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a> </div>
    </div>
    <div class="content">
      <div id="tabs" class="htabs"> <a href="#tab-general">General</a> <a href="#tab-protocol">Protocol</a> <a href="#tab-from">Sender</a> </div>
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
                    	if(isset($default_customer_group)  && $default_customer_group == $customer_list['communication_customer_group_id'] )
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
              <td class="center" colspan="10"><?php echo $text_no_results; ?></td>
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
        <div id="tab-from">
          <table class="form">
            <tr>
              <td>Sender  Email id</td>
              <td><input type="text" id="from_name" name="from_name"/></td>
            </tr>
          </table>
          <br />
          <br />
          <table class="list">
            <thead>
              <tr>
                <td class="left" width="60%">From</td>
                <td class="left" width="20%">Date Time </td>
              </tr>
            </thead>
            <tbody>
              <?php if(!empty($from_list)){
             			foreach($from_list as $from_list) { ?>
              <tr>
                <td class="left"><?php echo $from_list['from_name']; ?></td>
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
    html += '    <td class="left"><select id="email_setting[' + setting_row + '][mail_protocol]" name="email_setting[' + setting_row +'][mail_protocol]">';
	html += '    <option value="mail">Mail</option><option value="smtp">SMTP</option></td>';
    html += '    <td class="left"><input type="text" name="email_setting[' + setting_row + '][host]" id="email_setting[' + setting_row + '][host]" value="" size="50" /></td>';		
    html += '    <td class="left"><input type="text" name="email_setting[' + setting_row + '][username]" id="email_setting[' + setting_row + '][username]" value="" size="20" /></td>';
    html += '    <td class="left"><input type="text" name="email_setting[' + setting_row + '][password]" id="email_setting[' + setting_row + '][password]" value="" size="20" /></td>';
	html += '    <td class="left"><input type="text" name="email_setting[' + setting_row + '][port]" id="email_setting[' + setting_row + '][port]" value="" size="20" /></td>';
	html += '    <td class="left"><input type="text" name="email_setting[' + setting_row + '][smtp_timeout]" id="email_setting[' + setting_row + '][smtp_timeout]" value="" size="20" /></td>';	
	html += '    <td class="left"><input type="checkbox"   class="checkItem"  name="email_setting[' + setting_row + '][default_gateway]" id="email_setting[' + setting_row + '][default_gateway]" value="1"/>Default</td>';
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