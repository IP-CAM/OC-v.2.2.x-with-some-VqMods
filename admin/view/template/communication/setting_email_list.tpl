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
      <h1><img src="view/image/payment.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a href="<?php echo $insert; ?>" class="button"><?php echo $button_insert; ?></a><a onclick="$('form').submit();" class="button"><?php echo $button_delete; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>
              <td width="1" style="text-align: center;"><input type="checkbox" onclick="$('input[name*=\'selected\']').attr('checked', this.checked);" /></td>
               
              <td class="left"><?php if ($sort == 'host') { ?>
                <a href="<?php echo $sort_host; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_host; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_host; ?>"><?php echo $column_host; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'username') { ?>
                <a href="<?php echo $sort_username; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_username; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_username; ?>"><?php echo $column_username; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'default') { ?>
                <a href="<?php echo $sort_default; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_email_default; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_default; ?>"><?php echo $column_email_default; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'status') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_email_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_email_status; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_email_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if (isset($communicationSettingSms) && !empty($communicationSettingSms)) { ?>
            <?php foreach ($communicationSettingSms as $communicationSettingSms) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($communicationSettingSms['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $communicationSettingSms['communication_setting_email_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $communicationSettingSms['communication_setting_email_id']; ?>" />
                <?php } ?></td>
               
              <td class="left"><?php echo $communicationSettingSms['host']; ?></td>
              <td class="left"><?php echo $communicationSettingSms['username']; ?></td>
              <td class="left"><?php echo (isset($communicationSettingSms['default_gateway']) && $communicationSettingSms['default_gateway'] != 0) ? 'Default' : '' ; ?></td>
              <td class="left"><?php echo (isset($communicationSettingSms['status']) && $communicationSettingSms['status'] != 0) ? 'Enabled' : 'Disabled' ; ?></td>
              <td class="right"><?php foreach ($communicationSettingSms['action'] as $action) { ?>
                [ <a href="<?php echo $action['href']; ?>"><?php echo $action['text']; ?></a> ]
                <?php } ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="7"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
        <div class="pagination"><?php echo $pagination; ?></div>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?> 