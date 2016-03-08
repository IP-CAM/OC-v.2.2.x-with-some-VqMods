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
         	<td><span class="required">*</span><?php echo $entry_mail_protocol; ?></td>
            <td>
            	<select id="mail_protocol" name="mail_protocol">
                	<option value="mail"  <?php echo (isset($mail_protocol) && $mail_protocol == 'mail')? 'selected="selected"' : '';  ?>  >Mail</option>
                    <option value="smtp" <?php echo (isset($mail_protocol) && $mail_protocol == 'smtp')? 'selected="selected"' : '';  ?>>SMTP</option>                                  
                </select>
            </td>
         </tr>
         	
          <tr>
            <td><span class="required">*</span><?php echo $entry_smstp_host; ?></td>
            <td><input type="text" name="host" value="<?php echo $host; ?>" size="100" /><?php if ($error_host) { ?>
              <span class="error"><?php echo $error_host; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span><?php echo $entry_smtp_username; ?></td>
            <td><input type="text" name="username" value="<?php echo $username; ?>" size="100" /><?php if ($error_username) { ?>
              <span class="error"><?php echo $error_username; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span><?php echo $entry_smtp_password; ?></td>
            <td><input type="text" name="password" value="<?php echo $password; ?>" size="100"/><?php if ($error_password) { ?>
              <span class="error"><?php echo $error_password; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span><?php echo $entry_smtp_port; ?></td>
            <td><input type="text" name="port" value="<?php echo $port; ?>" size="100"/><?php if ($error_port) { ?>
              <span class="error"><?php echo $error_port; ?></span>
              <?php } ?></td>
          </tr>
          <tr>
            <td><span class="required">*</span><?php echo $entry_smtp_timeout; ?></td>
            <td><input type="text" name="smtp_timeout" value="<?php echo $smtp_timeout; ?>" size="100"/><?php if ($error_smtp_timeout) { ?>
              <span class="error"><?php echo $error_smtp_timeout; ?></span>
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