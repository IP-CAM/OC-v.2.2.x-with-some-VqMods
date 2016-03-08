<?php echo $header; ?>
<style type="text/css">
.template_button {
	background:#C5521A !important;
}
</style>
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
              <td class="left"><?php echo $column_template_name ?></td>
              <td class="left"><?php  echo $column_user_group; ?></td>
              <td class="left"><?php echo $column_subject; ?></td>
              <td class="left"><?php echo $column_view; ?></td> 
              <td class="right"><?php echo $column_action	; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if (isset($campaign)) { ?>
            <?php foreach ($campaign as $campaign) { ?>
            <tr>
              <td class="left"><?php echo $campaign['communication_template_id']; ?></td>
              <td class="left"><?php echo $campaign['user_group']; ?></td>
              <td class="left"><?php echo $campaign['subject']; ?></td>
              <td class="center" style="color:#006600;font-weight:bold"><?php echo $campaign['total_view']; ?></td> 
              <td class="right"><?php foreach ($campaign['action'] as $action) { ?>
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
      </form>
      <div class="pagination"><?php echo $pagination; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>