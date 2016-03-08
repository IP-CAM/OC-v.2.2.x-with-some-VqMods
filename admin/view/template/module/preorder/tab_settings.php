<table class="table">

<tr>
	<td class="col-xs-3"><h5><strong><?php echo $text_button_name; ?></strong></h5></td>
    <td>
      <div class="col-xs-4">
         <?php foreach ($languages as $language) : ?>
            <div class="input-group" style="margin:10px auto;">
              <div class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></div>
              <input placeholder="<?php echo $text_pre_order; ?>" class="form-control" type="text" name="preorder[ButtonName][<?php echo $language['language_id']; ?>]" value="<?php echo !empty($data['preorder']['ButtonName'][$language['language_id']]) ? $data['preorder']['ButtonName'][$language['language_id']] : $text_pre_order; ?>" />
            </div>
          <?php endforeach; ?>
      </div>
    </td>
</tr>
<tr>
	<td class="col-xs-3"><h5><strong><?php echo $text_date_note; ?></strong></h5>
    <span class="help"><?php echo $text_date_note_help; ?></span>
    </td>
    <td>
      <div class="col-xs-8">
         <?php foreach ($languages as $language) : ?>
            <div class="input-group" style="margin:10px auto;">
              <div class="input-group-addon"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /></div>
              <input placeholder="<?php echo $text_date_note_example; ?>" class="form-control" type="text" name="preorder[DateNote][<?php echo $language['language_id']; ?>]" value="<?php echo !empty($data['preorder']['DateNote'][$language['language_id']]) ? $data['preorder']['DateNote'][$language['language_id']] : ''; ?>" />
            </div>
          <?php endforeach; ?>
      </div>
    </td>
</tr>
  <tr>
    <td class="col-xs-3">
      <h5><strong><?php echo $text_admin_notification; ?></strong></h5>
      <span class="help"><?php echo $text_admin_notification_help; ?></span>
    </td>
    <td>
      <div class="col-xs-4">
          <select name="preorder[Notifications]" class="preorderNotifications form-control">
              <option value="yes" <?php echo ((isset($data['preorder']['Notifications']) && $data['preorder']['Notifications'] == 'yes')) ? 'selected=selected' : '' ?>><?php echo $text_enabled; ?></option>
             <option value="no" <?php echo ((isset($data['preorder']['Notifications']) && $data['preorder']['Notifications'] == 'no')) ? 'selected=selected' : '' ?>><?php echo $text_disabled; ?></option>
          </select>
      </div>
    </td>
  </tr>  
   <tr>
<td class="col-xs-3">
    <h5><strong><?php echo $text_email; ?></strong></h5>
    <span class="help"><?php echo $text_email_help; ?></span>
</td>
<td>
<div class="col-xs-12">
      <ul class="nav nav-tabs">
          <?php $i=0; foreach ($languages as $language) { ?>
            <li <?php if ($i==0) echo 'class="active"'; ?>><a href="#emailtab-<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>"/> <?php echo $language['name']; ?></a></li>
          <?php $i++; }?>
      </ul>
      <div class="tab-content">
        <?php $i=0; foreach ($languages as $language) { ?>
                <div id="emailtab-<?php echo $language['language_id']; ?>" language-id="<?php echo $language['language_id']; ?>" class="row-fluid tab-pane language <?php if ($i==0) echo 'active'; ?>">
                    <div class="row">
                        <div class="col-md-8">
                            <h5><strong><?php echo $text_email_subject; ?></strong></h5>
                       
                            <input name="preorder[EmailSubject][<?php echo $language['code']; ?>]" class="input-xxlarge form-control" type="text" value="<?php echo (isset($data['preorder']['EmailSubject'][$language['code']])) ? $data['preorder']['EmailSubject'][$language['code']] : $text_pre_order ?>" />
                         </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-md-12">
                            <textarea id="email_text_<?php echo $language['code']; ?>" name="preorder[EmailText][<?php echo $language['code']; ?>]" style="height:80px;"  class="preorderEmailText form-control"><?php echo (isset($data['preorder']['EmailText'][$language['code']])) ?        $data['preorder']['EmailText'][$language['code']] : $text_email_body; ?>
                          </textarea>
                        </div>
                    </div>
                </div>
            <?php $i++; } ?>
      </div>
  </div>
 
</td>
</tr>
<tr>
<td class="col-xs-3"><h5><strong><?php echo $text_custom_css; ?></strong></h5></td>
<td>
  <div class="col-xs-4">
      <textarea name="preorder[CustomCSS]" class="preorderCustomCSS form-control"><?php echo (isset($data['preorder']['CustomCSS'])) ? $data['preorder']['CustomCSS'] : '' ?>
      </textarea>
  </div>
</td>
</tr>
</table>
<?php $token = $_GET['token']; ?>
<!--<script type="text/javascript">
<?php /* foreach ($languages as $language) { ?>
  $('#description_<?php echo $language['code']; ?>').summernote({
          height:300
  });
  $('#email_text_<?php echo $language['code']; ?>').summernote({
          height:300
  });
<?php } */?>
</script>-->
<script type="text/javascript" ><?php foreach ($languages as $language) { ?>
CKEDITOR.replace('email_text_<?php echo $language['code']; ?>', { 
    filebrowserBrowseUrl: 'index.php?route=common/filemanager&token' + getURLVar('token'),
    filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=' + getURLVar('token'),
    filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=' + getURLVar('token'),
    filebrowserUploadUrl: 'index.php?route=common/filemanager&token=' + getURLVar('token'),
    filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=' + getURLVar('token'),
    filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=' + getURLVar('token') 
	<?php }; ?>
});
</script>