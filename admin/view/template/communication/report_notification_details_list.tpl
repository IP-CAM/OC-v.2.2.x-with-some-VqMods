<?php echo $header; ?>
<style type="text/css">
.template_button {
	background:#C5521A !important;
}
</style>
<!--Load the AJAX API--> 
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
      <h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
    </div>
    <div class="content">
      <form  method="post" enctype="multipart/form-data" id="form"> 
        <table class="list">
          <thead>
            <tr>
              <td class="left"><?php echo $column_customer_name ?></td>
              <td class="left"><?php  echo $column_telephone; ?></td>
              <td class="left"><?php echo $column_status; ?></td>
              <td class="left"><?php echo $column_date_time; ?></td>
              <td class="left"><?php echo $column_ip_address; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if (isset($report_notification_details)) { ?>
            <?php foreach ($report_notification_details as $report_notification_details) { ?>
            <tr>
              <td class="left"><?php echo $report_notification_details['customer_id']; ?></td>
              <td class="left"><?php echo $report_notification_details['telephone']; ?></td>
              <td class="left"><?php echo $report_notification_details['user_type']; ?></td>
              <td class="left"><?php echo $report_notification_details['date_added']; ?></td>
              <td class="left"><?php echo $report_notification_details['ip_address']; ?></td>
            </tr>
            <?php } ?>
            <?php } else { ?>
            <tr>
              <td class="center" colspan="7"><?php echo $text_no_results; ?></td>
            </tr>
            <?php } ?>
          </tbody>
        </table>
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>