<?php echo $header; ?>

<div id="content">
<div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
</div>
<div class="box">
  <div class="heading">
    <h1><img src="view/image/mail.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table id="mail" class="form">
        <tr>
          <td><?php echo $entry_message_type; ?></td>
          <td><input type="checkbox" name="message_type[]" value="sms" <?php if(isset($message_type) && !empty($message_type) && in_array('sms',$message_type)) { echo  'checked="checked"'; } ?> >
            SMS
            <input type="checkbox" name="message_type[]" value="email" <?php if(isset($message_type) && !empty($message_type) && in_array('email',$message_type)) { echo  'checked="checked"'; } ?>>
            Email
            <input type="checkbox" name="message_type[]" value="notification" <?php if(isset($message_type) && !empty($message_type) && in_array('notification',$message_type)) { echo  'checked="checked"'; } ?>>
            Notification </td>
        </tr>
        <tr>
          <td><span class="required"> * </span><?php echo $entry_title; ?></td>
          <td><input type="text" name="title" id="title" size="80" value="<?php echo $title; ?>" />
            <?php if ($error_title) { ?>
            <span class="error"><?php echo $error_title; ?></span>
            <?php } ?></td>
        </tr>
        <tr>
          <td><span class="required">*</span> <?php echo $entry_user_group; ?></td>
          <td><select name="user_group" id="dropdown">
              <option value="">--- Please Select ---</option>
              <option value="customer_all" <?php echo $user_group=='customer_all'?' selected="selected"':''; ?>><?php echo $text_customer_all; ?></option>
<!--              <option value="customer_all" <?php echo $user_group=='customer_all'?' selected="selected"':''; ?>><?php echo $text_customer_all; ?></option>-->
              <option value="customer_group" <?php echo $user_group=='customer_group'?' selected="selected"':''; ?>><?php echo $text_customer_group; ?></option>
              <option value="customer" <?php echo $user_group=='customer'?' selected="selected"':''; ?>><?php echo $text_customer; ?></option>
              <option value="affiliate_all" <?php echo $user_group=='affiliate_all'?' selected="selected"':''; ?>><?php echo $text_affiliate_all; ?></option>
              <option value="affiliate" <?php echo $user_group=='affiliate'?' selected="selected"':''; ?>><?php echo $text_affiliate; ?></option>
              <option value="product" <?php echo $user_group=='product'?' selected="selected"':''; ?>><?php echo $text_product; ?></option>
              <option value="country" <?php echo $user_group=='country'?' selected="selected"':''; ?>><?php echo $text_country; ?></option>
              <option value="state" <?php echo $user_group=='state'?' selected="selected"':''; ?>><?php echo $text_state; ?></option>
              <option value="reject_customer" <?php echo $user_group=='reject_customer'?' selected="selected"':''; ?>><?php echo $text_reject_customer; ?></option>
              <option value="reject_affiliate" <?php echo $user_group=='reject_affiliate'?' selected="selected"':''; ?>><?php echo $text_reject_affiliate; ?></option>
              <!-- <option value="url" <?php echo $user_group=='url'?' selected="selected"':''; ?>><?php echo $text_url; ?></option>-->
            </select>
            <?php if ($error_user_group) { ?>
            <span class="error"><?php echo $error_user_group; ?></span>
            <?php } ?>
            <img src="view/image/campaign_loding.gif" id="loding_us" style="display:none" /></td>
        </tr>
        <!-- Dispaly All Country -->
        <tbody id="to-customer-all" class="to">
          <tr>
            <td> All Customer Count </td>
            <td><strong style="color:#F00"><?php echo $total_count_customer ?></strong></td>
          </tr>
        </tbody>
        <!-- Dispaly All Affiliate -->
        <tbody id="to-affiliate-all" class="to">
          <tr>
            <td> All Affiliate Count </td>
            <td><strong style="color:#F00"><?php echo $total_count_affiliatest ?></strong></td>
          </tr>
        </tbody>
        <!-- Dispaly Customer Group -->
        <tbody id="to-customer-group" class="to">
          <tr>
            <td><?php echo $entry_customer_group; ?></td>
            <td><select name="customer_group_id">
                <?php foreach ($customer_groups as $customer_group) {
                  	 $selected = '';
                     if(isset($customer_group_id) && $customer_group_id == $customer_group['customer_group_id']){
                     	$selected ='  selected="selected"';
                     }
                   ?>
                <option value="<?php echo $customer_group['customer_group_id']; ?>" <?php echo $selected; ?>><?php echo $customer_group['name']; ?></option>
                <?php } ?>
              </select></td>
          </tr>
        </tbody>
        <tbody id="to-customer" class="to">
          <tr>
            <td><?php echo $entry_customer; ?></td>
            <td><input type="text" name="customers" value="" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><!--<div id="customer" class="scrollbox"></div>-->
              
              <div id="customer" class="scrollbox">
                <?php $class = 'odd'; ?>
                <?php if(isset($customer_available) && !empty($customer_available)) { ?>
                <?php for($i=0;$i<count($customer_available);$i++) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>"><?php echo isset($customer_available[$i]['firstname'])?$customer_available[$i]['firstname']:''; ?><img  src="view/image/delete.png"  alt=""  />
                  <input type="hidden" name="customer[]" id="customer-available" value="<?php echo $customer_available[$i]['customer_id']; ?>" />
                </div>
                <?php } ?>
                <?php } ?>
              </div></td>
          </tr>
          <tr>
            <td> Total Count : </td>
            <td><strong id="total_customer_count" style="color:#F00">COUNT :<?php echo isset($customer_available)?sizeof($customer_available):'0'; ?></strong></td>
          </tr>
        </tbody>
        <tbody id="to-affiliate" class="to">
          <tr>
            <td><?php echo $entry_affiliate; ?></td>
            <td><input type="text" name="affiliates" value="" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><!--<div id="affiliate" class="scrollbox"></div>-->
              
              <div id="affiliate" class="scrollbox">
                <?php $class = 'odd'; ?>
                <?php if(!empty($affiliate_available)) { ?>
                <?php 
                 for($i=0;$i<count($affiliate_available);$i++) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>"><?php echo $affiliate_available[$i]['firstname'].' '.$affiliate_available[$i]['lastname']; ?><img  src="view/image/delete.png"  alt=""  />
                  <input type="hidden" name="affiliate[]" id="affiliate-available" value="<?php echo $affiliate_available[$i]['affiliate_id']; ?>" />
                </div>
                <?php } ?>
                <?php } ?>
              </div></td>
          </tr>
          <tr>
            <td> Total Count : </td>
            <td><strong id="total_affiliate_count" style="color:#F00">COUNT :<?php echo isset($affiliate_available)?sizeof($affiliate_available):'0'; ?></strong></td>
          </tr>
        </tbody>
        <tbody id="to-product" class="to">
          <tr>
            <td><?php echo $entry_product; ?></td>
            <td><input type="text" name="products" value="" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><!--<div id="product" class="scrollbox"></div>-->
              
              <div id="product" class="scrollbox">
                <?php $class = 'odd'; ?>
                <?php if(!empty($product_available)) { ?>
                <?php for($i=0;$i<count($product_available);$i++) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>"><?php echo $product_available[$i]['name']; ?><img  src="view/image/delete.png"  alt=""  />
                  <input type="hidden" name="product[]" id="product-available" value="<?php echo $product_available[$i]['product_id']; ?>" />
                </div>
                <?php } ?>
                <?php } ?>
              </div></td>
          </tr>
          <tr>
            <td> Total Count : </td>
            <td><strong id="total_product_count" style="color:#F00">COUNT :<?php echo isset($product_available)?sizeof($product_available):'0'; ?></strong></td>
          </tr>
        </tbody>
        <tbody id="to-country" class="to">
          <tr>
            <td><?php echo $entry_country_id; ?></td>
            <td><div class="scrollbox">
                <?php 
                $country_edit_check_count = 0;
                $class = 'odd';                 
                foreach ($country as $country) {  
                ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <?php                     
                 	if(isset($country_id) && in_array($country['country_id'],$country_id)){  $country_edit_check_count++; ?>
                  <input type="checkbox" name="country_id[]" value="<?php echo $country['country_id']; ?>" checked="checked" onchange="count_country();" />
                  <?php echo $country['name']; ?>
                  <?php }else{ ?>
                  <input type="checkbox" name="country_id[]" value="<?php echo $country['country_id']; ?>" onchange="count_country();" />
                  <?php echo $country['name']; ?>
                  <?php }  ?>
                </div>
                <?php } ?>
              </div>
              <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a></td>
          </tr>
          <tr>
            <td> Total Count : </td>
            <td><strong  style="color:#F00">TOTAL : <?php echo $total_count_country ?></strong> &nbsp; || &nbsp; <strong id="total_country_count" style="color:#F00">COUNT :<?php echo isset($country_edit_check_count)?$country_edit_check_count:'0'; ?></strong></td>
          </tr>
        </tbody>
        <tbody id="to-state" class="to">
        <td><?php echo $entry_state_id; ?></td>
          <td><div class="scrollbox">
              <?php 
               $state_edit_check_count = 0;
              $class = 'odd'; 
                foreach ($state as $state) { ?>
              <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
              <div class="<?php echo $class; ?>">
                <?php  
                 	 if(isset($state_id) && in_array($state['zone_id'],$state_id)){ $state_edit_check_count++;?>
                <input type="checkbox" name="state_id[]" value="<?php echo $state['zone_id']; ?>" checked="checked" onchange="count_state();"  />
                <?php echo $state['name']; ?>
                <?php }else{ ?>
                <input type="checkbox" name="state_id[]" value="<?php echo $state['zone_id']; ?>" onchange="count_state();" />
                <?php echo $state['name']; ?>
                <?php }  ?>
              </div>
              <?php } ?>
            </div>
            <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a></td>
        <tr>
          <td> Total Count : </td>
          <td><strong  style="color:#F00">TOTAL : <?php echo $total_state_country ?></strong> &nbsp; || &nbsp; <strong id="total_state_count" style="color:#F00">COUNT :<?php echo isset($state_edit_check_count)?$state_edit_check_count:'0'; ?></strong></td>
        </tr>
          </tr>
        
          </tbody>
        
        <tbody id="to-reject-affiliate" class="to">
          <tr>
            <td><?php echo $text_reject_affiliate; ?></td>
            <td><input type="text" name="reject_affiliates" value="" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><!--<div id="affiliate" class="scrollbox"></div>-->
              
              <div id="reject_affiliate" class="scrollbox">
                <?php $class = 'odd'; ?>
                <?php if(!empty($reject_affiliate_available)) { ?>
                <?php for($i=0;$i<count($reject_affiliate_available);$i++) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>"><?php echo $reject_affiliate_available[$i]['firstname'].' '.$reject_affiliate_available[$i]['lastname']; ?><img  src="view/image/delete.png"  alt=""  />
                  <input type="hidden" name="reject_affiliates[]" id="reject_affiliate-available" value="<?php echo $reject_affiliate_available[$i]['affiliate_id']; ?>" />
                </div>
                <?php } ?>
                <?php } ?>
              </div></td>
          </tr>
          <tr>
            <td> Total Count : </td>
            <td><strong id="total_reject_affiliate_count" style="color:#F00">COUNT :<?php echo isset($reject_affiliate_available)?sizeof($reject_affiliate_available):'0'; ?></strong></td>
          </tr>
        </tbody>
        <tbody id="to-reject-customer" class="to">
          <tr>
            <td><?php echo $text_reject_customer; ?></td>
            <td><input type="text" name="reject_customers" value="" /></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><!--<div id="customer" class="scrollbox"></div>-->
              
              <div id="reject_customer" class="scrollbox">
                <?php $class = 'odd'; ?>
                <?php if(isset($reject_customer_available) && !empty($reject_customer_available)) { ?>
                <?php for($i=0;$i<count($reject_customer_available);$i++) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>"><?php echo isset($reject_customer_available[$i]['firstname'])?$reject_customer_available[$i]['firstname'].' '.$reject_customer_available[$i]['lastname']:''; ?><img  src="view/image/delete.png"  alt=""  />
                  <input type="hidden" name="reject_customer[]" id="reject-customer-available" value="<?php echo $reject_customer_available[$i]['customer_id']; ?>" />
                </div>
                <?php } ?>
                <?php } ?>
              </div></td>
          </tr>
          <tr>
            <td> Total Count : </td>
            <td><strong id="total_reject_customer_count" style="color:#F00">COUNT :<?php echo isset($reject_customer_available)?sizeof($reject_customer_available):'0'; ?></strong></td>
          </tr>
        </tbody>
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
<script language="javascript">
function count_country(){ 
   var $checkboxes = $('#to-country td input[type="checkbox"]');        
	$checkboxes.change(function(){
		var countCheckedCheckboxes = $checkboxes.filter(':checked').length;			 
		$("#total_country_count").html(" COUNT :"+countCheckedCheckboxes);	
	});
}

function count_state(){ 
   var $checkboxes = $('#to-state td input[type="checkbox"]');        
	$checkboxes.change(function(){
		var countCheckedCheckboxes = $checkboxes.filter(':checked').length;			 
		$("#total_state_count").html(" COUNT :"+countCheckedCheckboxes);	
	});
} 

$(document).ready(function(e) {
    count_country();
	count_state();
	 
});
</script> 
<script type="text/javascript">
$('select[name=\'user_group\']').bind('change', function() {
	$('#mail .to').hide();	
	$('#mail #to-' + $(this).attr('value').replace('_', '-')).show();
});
$('select[name=\'user_group\']').trigger('change');
</script> 
<script type="text/javascript"><!--
$.widget('custom.catcomplete', $.ui.autocomplete, {
	_renderMenu: function(ul, items) {
		var self = this, currentCategory = '';
		
		$.each(items, function(index, item) {
			if (item.category != currentCategory) {
				ul.append('<li class="ui-autocomplete-category">' + item.category + '</li>');
				
				currentCategory = item.category;
			}
			
			self._renderItem(ul, item);
		});
	}
});

$('input[name=\'customers\']').catcomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/customer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {	
				response($.map(json, function(item) {
					return {
						category: item.customer_group,
						label: item.name,
						value: item.customer_id
					}
				}));
			}
		});
		
	}, 
	select: function(event, ui) {
		$('#customer' + ui.item.value).remove();
		
		$('#customer').append('<div id="customer' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="customer[]" value="' + ui.item.value + '" /></div>');

		$('#customer div:odd').attr('class', 'odd');
		$('#customer div:even').attr('class', 'even');
		var count = $("div.even, div.odd", "#customer").length;
		$("#total_customer_count").html("COUNT : "+count);
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$('#customer div img').live('click', function() {
	$(this).parent().remove();
	var count = $("div.even, div.odd", "#customer").length;
		$("#total_customer_count").html("COUNT : "+count);
	$('#customer div:odd').attr('class', 'odd');
	$('#customer div:even').attr('class', 'even');	
});
//--></script> 
<script type="text/javascript"><!--	
$('input[name=\'affiliates\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/affiliate/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.affiliate_id
					}
				}));
			}
		});
		
	}, 
	select: function(event, ui) {
		$('#affiliate' + ui.item.value).remove();
		
		$('#affiliate').append('<div id="affiliate' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="affiliate[]" value="' + ui.item.value + '" /></div>');

		$('#affiliate div:odd').attr('class', 'odd');
		$('#affiliate div:even').attr('class', 'even');
	
		var count = $("div.even, div.odd", "#affiliate").length;
		$("#total_customer_count").html("COUNT : "+count);			
				
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$('#affiliate div img').live('click', function() {
	$(this).parent().remove();
	var count = $("div.even, div.odd", "#affiliate").length;
	$("#total_customer_count").html("COUNT : "+count);	
	$('#affiliate div:odd').attr('class', 'odd');
	$('#affiliate div:even').attr('class', 'even');	
});

$('input[name=\'products\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.product_id
					}
				}));
			}
		});
	}, 
	select: function(event, ui) {
		$('#product' + ui.item.value).remove();
		
		$('#product').append('<div id="product' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="product[]" value="' + ui.item.value + '" /></div>');

		$('#product div:odd').attr('class', 'odd');
		$('#product div:even').attr('class', 'even');
			
		var count = $("div.even, div.odd", "#product").length;
		$("#total_product_count").html("COUNT : "+count);		
					
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$('#product div img').live('click', function() {
	$(this).parent().remove();
	
	$('#product div:odd').attr('class', 'odd');
	$('#product div:even').attr('class', 'even');	
	
	var count = $("div.even, div.odd", "#product").length;
	$("#total_product_count").html("COUNT : "+count);		
	
});

 
 

//--></script> 
<script type="text/javascript"><!--	
$('input[name=\'reject_affiliates\']').autocomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/affiliate/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.affiliate_id
					}
				}));
			}
		});
		
	}, 
	select: function(event, ui) {
		$('#reject_affiliate' + ui.item.value).remove();
		
		$('#reject_affiliate').append('<div id="reject_affiliate' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="reject_affiliate[]" value="' + ui.item.value + '" /></div>');

		$('#reject_affiliate div:odd').attr('class', 'odd');
		$('#reject_affiliate div:even').attr('class', 'even');
	
		var count = $("div.even, div.odd", "#reject_affiliate").length;
		$("#total_reject_affiliate_count").html("COUNT : "+count);			
				
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$('#reject_affiliate div img').live('click', function() {
	$(this).parent().remove();
	var count = $("div.even, div.odd", "#reject_affiliate").length;
	$("#total_reject_affiliate_count").html("COUNT : "+count);	
	$('#reject_affiliate div:odd').attr('class', 'odd');
	$('#reject_affiliate div:even').attr('class', 'even');	
}); 

//--></script> 
<script type="text/javascript">  
$('#dropdown').change(function(){	
var s= $("#dropdown option:selected").text();
	if(s=='<?php echo $text_mail_customer_group; ?>')
	{		
		$('#mail #to-customer-group-campaign').show();						
	}
	//alert(s);
});

$('#template').change(function(){
	
	template_name= $("#template option:selected").text();
	
	
	//alert(template_name);
	if(template_name=='Custom')
	{		
		$('#custom-template').show();
		$('#users-template').hide();
		$('#users-preview').hide();		
		category_name=$("#category option:selected").text();
		
		//alert(category_id);				
	}
	else
	{		
		$('#users-preview').show();
		$('#users-template').show();
		$('#custom-template').hide();
		users_template_name=$("#users-template option:selected").text();		
		custom_template_name="";
	}
});
$('#custom-template').change(function(){

custom_template_name=$("#cus-temp option:selected").text();
custom_template_id=$("#cus-temp").val();

if(custom_template_name=='Select Templates')
{

$('#custom-preview').hide();
}
else
{
$('#custom-preview').show();
}

});


$('#users-template').change(function(){
users_template_name=$("#users-template option:selected").text();
$('#users-preview').show();
});


$('#users-preview').click(function() {
var editor_data=CKEDITOR.instances.message.getData();
$.colorbox({href:'index.php?route=sale/apply_template/userTemplatePreview&token=<?php echo $token; ?>&users_template_name='+users_template_name +'&editor_data='+encodeURIComponent(editor_data)});
});


$('#custom-preview').click(function() {
var editor_data=CKEDITOR.instances.message.getData();
$("#cboxBottomCenter").hide();
$("#cboxBottomLeft").hide();
$.colorbox({href:'index.php?route=sale/apply_template&token=<?php echo $token; ?>&custom_template_id='+custom_template_id +'&editor_data='+encodeURIComponent(editor_data)});
});
</script> 
<script language="javascript">
function getCampaignType()
{
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

function viewSubjectMessage(){		 
		 
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
 
$(document).ready(function() { 		 
	/* Get Campaign Type Dropdown  */
	$("#message_type").change(function()
	{
		getCampaignType();
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
		
	}).trigger('change'); 
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
<script type="text/javascript"><!--
$.widget('reject_customers.catcomplete', $.ui.autocomplete, {
	_renderMenu: function(ul, items) {
		var self = this, currentCategory = '';
		
		$.each(items, function(index, item) {
			if (item.category != currentCategory) {
				ul.append('<li class="ui-autocomplete-category">' + item.category + '</li>');
				
				currentCategory = item.category;
			}
			
			self._renderItem(ul, item);
		});
	}
});

$('input[name=\'reject_customers\']').catcomplete({
	delay: 500,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=sale/customer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {	
				response($.map(json, function(item) {
					return {
						category: item.customer_group,
						label: item.name,
						value: item.customer_id
					}
				}));
			}
		});
		
	}, 
	select: function(event, ui) {
		$('#reject_customer' + ui.item.value).remove();
		
		$('#reject_customer').append('<div id="reject_customer' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" name="reject_customer[]" value="' + ui.item.value + '" /></div>');

		$('#reject_customer div:odd').attr('class', 'odd');
		$('#reject_customer div:even').attr('class', 'even');
		var count = $("div.even, div.odd", "#reject_customer").length;
		$("#total_reject_customer_count").html("COUNT : "+count);
		return false;
	},
	focus: function(event, ui) {
      	return false;
   	}
});

$('#reject_customer div img').live('click', function() {
	$(this).parent().remove();
	var count = $("div.even, div.odd", "#reject_customer").length;
	$("#total_reject_customer_count").html("COUNT : "+count);
	$('#reject_customer div:odd').attr('class', 'odd');
	$('#reject_customer div:even').attr('class', 'even');	
});
//--></script> 
<?php echo $footer; ?> 