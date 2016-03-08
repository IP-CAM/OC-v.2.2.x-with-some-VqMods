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
      <h1><img src="view/image/review.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"> <a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a> </div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table class="form">
          <tr>
            <td><?php echo $entry_subject; ?></td>
            <td colspan="3"><input type="text" name="subject"  	 value="<?php echo $subject; ?>" id="subject" style="width:350px;"/></td>
          </tr>
          <tr>
            <td><?php echo $entry_notification_url; ?></td>
            <td><textarea id="notification_url" name="notification_url" cols="60" rows="4"><?php echo $notification_url; ?></textarea></td>
            <td><?php echo $entry_notification_views; ?></td>
            <td><div class="scrollbox">
                <?php $class = 'odd'; ?>
                <?php foreach ($permissions as $permission) { ?>
                <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                <div class="<?php echo $class; ?>">
                  <?php if (isset($view_permission['access']) && !empty($view_permission['access']) && in_array($permission,$view_permission['access'])) { ?>
                  <input type="checkbox" name="permission[access][]" value="<?php echo $permission; ?>" checked="checked" />
                  <?php echo $permission; ?>
                  <?php } else { ?>
                  <input type="checkbox" name="permission[access][]" value="<?php echo $permission; ?>" />
                  <?php echo $permission; ?>
                  <?php } ?>
                </div>
                <?php } ?>
              </div>
              <a onclick="$(this).parent().find(':checkbox').attr('checked', true);"><?php echo $text_select_all; ?></a> / <a onclick="$(this).parent().find(':checkbox').attr('checked', false);"><?php echo $text_unselect_all; ?></a></td>
          </tr>
          <tr>
            <td><?php echo $entry_animate_show_speed; ?></td>
            <td><select id="animate_show_speed" name="animate_show_speed">
                <option value="">--- Please Select ---</option>
                <?php  for($animate_show_speed_val=500;$animate_show_speed_val<=10000;$animate_show_speed_val++){
                	$st='';
                	if(isset($animate_show_speed) && $animate_show_speed == $animate_show_speed_val){  
                    $st =' selected="selected"';
                    }
                 ?>
                <option value="<?php echo $animate_show_speed_val; ?>" <?php echo $st; ?>><?php echo $animate_show_speed_val; ?></option>
                <?php $animate_show_speed_val+=499; } ?>
              </select>
              ms</td>
            <td><?php echo $entry_animate_hide_speed; ?></td>
            <td><select id="animate_hide_speed" name="animate_hide_speed">
                <option value="">--- Please Select ---</option>
                <?php  for($animate_hide_speed_val=500;$animate_hide_speed_val<=10000;$animate_hide_speed_val++){
                	$st='';
                	if(isset($animate_hide_speed) && $animate_hide_speed == $animate_hide_speed_val){  
                    $st =' selected="selected"';
                    }
                 ?>
                <option value="<?php echo $animate_hide_speed_val; ?>" <?php echo $st; ?>><?php echo $animate_hide_speed_val; ?></option>
                <?php $animate_hide_speed_val+=499; } ?>
              </select>
              ms</td>
          </tr>
          <tr>
            <td><?php echo $entry_message_show_time; ?></td>
            <td><select id="message_show_time" name="message_show_time">
                <option value="">--- Please Select ---</option>
                <?php  for($message_show_time_val=500;$message_show_time_val<=10000;$message_show_time_val++){
                	$st='';
                	if(isset($message_show_time) && $message_show_time == $message_show_time_val){  
                    $st =' selected="selected"';
                    }
                 ?>
                <option value="<?php echo $message_show_time_val; ?>" <?php echo $st; ?>><?php echo $message_show_time_val; ?></option>
                <?php $message_show_time_val+=499; } ?>
              </select>
              ms</td>
            <td><?php echo $entry_time_duration ?></td>
            <td><select id="time_duration" name="time_duration">
                <?php  foreach($time_duration as $time_key=>$time_val){
              		 $st='';
                	if(isset($time_t) && $time_t == $time_key){  
                    $st =' selected="selected"';
                    }
                
                 ?>
                <option value="<?php echo $time_key; ?>" <?php echo $st; ?>><?php echo $time_val; ?></option>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_z_index; ?></td>
            <td><input type="number" id="z_index" name="z_index"  min="0" max="999999999"  value="<?php echo $z_index; ?>"/></td>
            <td><?php echo $entry_position; ?></td>
            <td><select id="position" name="position">
                <option value="">-- Please select -- </option>
                <option  value="top-left" <?php echo $position=="top-left"? 'selected="selected"' :'' ; ?> >top-left</option>
                <option  value="top-center" <?php echo $position=="top-center"? 'selected="selected"' :'' ; ?>>top-center</option>
                <option  value="top-right" <?php echo $position=="top-right"? 'selected="selected"' :'' ; ?>>top-right</option>
                <option  value="center-left" <?php echo $position=="center-left"? 'selected="selected"' :'' ; ?>>center-left</option>
                <option  value="center-center" <?php echo $position=="center-center"? 'selected="selected"' :'' ; ?>>center-center</option>
                <option  value="center-right" <?php echo $position=="center-right"? 'selected="selected"' :'' ; ?>>center-right</option>
                <option  value="bottom-left" <?php echo $position=="bottom-left"? 'selected="selected"' :'' ; ?>>bottom-left</option>
                <option  value="bottom-center" <?php echo $position=="bottom-center"? 'selected="selected"' :'' ; ?>>bottom-center</option>
                <option  value="bottom-right" <?php echo $position=="bottom-right"? 'selected="selected"' :'' ; ?>>bottom-right</option>
              </select></td>
          </tr>
          <tr>
            <td></td>
            <td colspan="3"><input type="checkbox" id="default_notification" name="default_notification" value="1" <?php echo ($default_notification==1)? ' checked="checked"' : ''; ?>  />
              Default </td>
          </tr>
        </table>
      </form>
    </div>
  </div>
</div>
<?php echo $footer; ?>