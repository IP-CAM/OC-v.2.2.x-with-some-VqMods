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
      <h1><img src="view/image/category.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content"> 
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><span class="required">*</span><?php echo $entry_api_key; ?></td>
            <td><input type="text" name="api_key" size="100" value="<?php echo $api_key; ?>" />
             <?php if ($error_api_key) { ?>
              <span class="error"><?php echo $error_api_key; ?></span>
              <?php } ?>
            </td>
          </tr>
          <tr>
            <td><span class="required">*</span><?php echo $entry_sms_username; ?></td>
            <td><input type="text" name="username" size="100" value="<?php echo isset($username) ? $username : ''; ?>" />
             <?php if ($error_username) { ?>
              <span class="error"><?php echo $error_username; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span><?php echo $entry_sms_password; ?></td>
            <td><input type="text" name="password" size="100" value="<?php echo isset($password) ? $password : ''; ?>" />
             <?php if ($error_password) { ?>
              <span class="error"><?php echo $error_password; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td> </td>
            <td><input type="checkbox" name="default_gateway" value="1" <?php echo (isset($default_gateway) && $default_gateway != 0) ? 'checked="checked"' : ''; ?> /> Default</td>
          </tr>
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
</div>
<?php echo $footer; ?>