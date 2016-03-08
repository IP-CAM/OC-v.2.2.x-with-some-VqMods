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
      <h1><img src="view/image/total.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><?php echo $entry_start_date; ?></td>
            <td><input type="date" name="cumulative_discount_start_date" value="<?php echo $cumulative_discount_start_date; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_end_date; ?></td>
            <td><input type="date" name="cumulative_discount_end_date" value="<?php echo $cumulative_discount_end_date; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_total; ?></td>
            <td><input type="text" name="cumulative_discount_total" value="<?php echo $cumulative_discount_total; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_min_prod; ?></td>
            <td><input type="text" name="cumulative_discount_min_prod" value="<?php echo $cumulative_discount_min_prod; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_discount; ?></td>
            <td><input type="text" name="cumulative_discount_discount" value="<?php echo $cumulative_discount_discount; ?>" /></td>
          </tr>
          <tr>
            <td><?php echo $entry_discount_item; ?></td>
            <td><select name="cumulative_discount_discount_item">
                <?php foreach ($discount_items as $discount_item) { ?>
                <?php if ($discount_item['item_id'] == $cumulative_discount_discount_item) { ?>
                <option value="<?php echo $discount_item['item_id']; ?>" selected="selected"><?php echo $discount_item['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $discount_item['item_id']; ?>"><?php echo $discount_item['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_order_status; ?></td>
            <td><select name="cumulative_discount_order_status_id">
                <option value="0">-</option>
                <?php foreach ($order_statuses as $order_status) { ?>
                <?php if ($order_status['order_status_id'] == $cumulative_discount_order_status_id) { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected"><?php echo $order_status['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_status; ?></td>
            <td><select name="cumulative_discount_status">
                <?php if ($cumulative_discount_status) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_sort_order; ?></td>
            <td><input type="text" name="cumulative_discount_sort_order" value="<?php echo $cumulative_discount_sort_order; ?>" size="1" /></td>
          </tr>
        </table>
      </form>
	  <div style="margin-top:25px;border-top:1px dashed #ccc;padding-top:15px;text-align:center;"><? echo $text_help; ?></div>
    </div>
  </div>
</div>
<?php echo $footer; ?>