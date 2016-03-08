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
    </div>
    <div class="content">
      <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="list">
          <thead>
            <tr>
              <td class="left"><?php if ($sort == 'default_template_type') { ?>
                <a href="<?php echo $sort_default_template_type; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_default_template_type; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_default_template_type; ?>"><?php echo $column_default_template_type; ?></a>
                <?php } ?></td>
              <td class="left"><?php if ($sort == 'name') { ?>
                <a href="<?php echo $sort_name; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_name; ?></a>
                <?php } else { ?>
                <a href="<?php echo $sort_name; ?>"><?php echo $column_name; ?></a>
                <?php } ?></td>
               
              <td class="right"><?php echo $column_action; ?></td>
            </tr>
          </thead>
          <tbody>
            <?php if (isset($communicationDefaultTemplate) && !empty($communicationDefaultTemplate)) { ?>
            <?php foreach ($communicationDefaultTemplate as $communicationDefaultTemplate) { ?>
            <tr>
              <td class="left"><?php echo $communicationDefaultTemplate['default_template_type']; ?></td>
              <td class="left"><?php echo $communicationDefaultTemplate['name']; ?></td>
               
              <td class="right"><?php foreach ($communicationDefaultTemplate['action'] as $action) { ?>
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