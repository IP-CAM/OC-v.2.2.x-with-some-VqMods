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
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
<div class="box">
<div class="heading">
  <h1><img src="view/image/mail.png" alt="" /> <?php echo $heading_title; ?></h1>
   <div class="buttons"><a href="<?php echo $insert; ?>" class="button"><?php echo $button_insert; ?></a><a onclick="$('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
</div>
<div class="content">
<form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
<table class="list">
  <thead>
    <tr>
      <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
      <td class="left"><?php echo $column_subject; ?></td>
      <td class="left"><?php echo $column_date_added; ?></td>
      <td class="left"><?php echo "Default"; ?></td> 
      <td class="right"><?php echo $column_action; ?></td>
    </tr>
  </thead>
  <tbody>
    <?php if(isset($notification_campaign_setting) &&  count($notification_campaign_setting)>0) { ?>
    <?php foreach ($notification_campaign_setting as $notification_campaign_setting) { ?>
    <tr>
      <td style="text-align: center;"><?php if (isset($notification_campaign_setting['selected']) && $notification_campaign_setting['selected']) { ?>
        <input type="checkbox" name="selected[]" value="<?php echo $notification_campaign_setting['communication_customer_group_id']; ?>" checked="checked" />
        <?php } else { ?>
        <input type="checkbox" name="selected[]" value="<?php echo $notification_campaign_setting['communication_customer_group_id']; ?>" />
        <?php } ?></td>     
      <td><?php echo $notification_campaign_setting['subject']; ?></td>
      <td><?php echo $notification_campaign_setting['date_added']; ?></td>
      <td><?php echo $notification_campaign_setting['default_notification'] == 1 ? 'Default' : '' ; ?></td>       
      <td class="right"><?php foreach ($notification_campaign_setting['action'] as $action) { ?>
        [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
        <?php } ?></td>
    </tr>
    <?php } ?>
    <?php } else { ?>
    <tr>
      <td colspan='8' class="center"><?php echo $text_no_results; ?></td>
    </tr>
    <?php } ?>
  </tbody>
</table>
</div>
</div>
</div>
<script>
var count=0;

$('#parent').click(function(){
	
	if(count==0)
	 {
	 $(this).closest('table').find('input[type="checkbox"]').prop('checked', true);
	 count++;
	 }
	 else
	 {
	  $(this).closest('table').find('input[type="checkbox"]').prop('checked', false);
	  count=0;
	 }
});

$('#delete').click(function(){
	values=[];
	 values = $('input:checkbox:checked').map(function () {
   return $(this).val();
}).get();
//alert(values[0]);
if(values.length>0)
{
$.ajax({		
		url: "index.php?route=sale/mail_customer_group/delete&token=<?php echo $token; ?>",
		type: 'post',
		data: {values:values},			
		success: function(json) {
					window.location.reload();
					$('.box').before('<div class="success" style="display: none;">' + '<?php echo $delete_success; ?>' + '</div>');			
					$('.success').show().delay(8000).fadeOut();			
			}													
		
	});	
}
else
{
alert("Please select atleast 1checkbox");
}		
});

</script> 
<?php echo $footer; ?>