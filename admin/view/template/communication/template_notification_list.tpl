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
               
              <td class="left"><?php if ($sort == 'subject') { ?>
                <a href="<?php echo $sort_subject; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_subject; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_subject; ?>"><?php echo $column_subject; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'status') { ?>
                <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
                <?php } ?></td>
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if (isset($communicationTemplateSms) && !empty($communicationTemplateSms)) { ?>
            <?php foreach ($communicationTemplateSms as $communicationTemplateSms) { ?>
            <tr>
              <td style="text-align: center;"><?php if ($communicationTemplateSms['selected']) { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $communicationTemplateSms['communication_template_notification_id']; ?>" checked="checked" />
                <?php } else { ?>
                <input type="checkbox" name="selected[]" value="<?php echo $communicationTemplateSms['communication_template_notification_id']; ?>" />
                <?php } ?></td>
               
              <td class="left"><?php echo $communicationTemplateSms['subject']; ?></td>
              <td class="left"><?php echo (isset($communicationTemplateSms['status']) && $communicationTemplateSms['status'] != 0) ? 'Enabled' : 'Disabled' ; ?></td>
              <td class="right"><?php foreach ($communicationTemplateSms['action'] as $action) { ?>
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