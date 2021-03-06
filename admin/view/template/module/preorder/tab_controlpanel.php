<table class="table">
   <tr>
    <td class="col-xs-3">
      <h5><strong><?php echo $text_module_settings; ?></strong></h5>
      <span class="help"><?php echo $text_module_settings_help; ?></span>
    </td>
    <td>
      <div class="col-xs-4">
          <select name="preorder[Enabled]" class="preorderEnabled form-control">
              <option value="yes" <?php echo (!empty($data['preorder']['Enabled']) && $data['preorder']['Enabled'] == 'yes') ? 'selected=selected' : '' ?>><?php echo $text_enabled; ?></option>
             <option value="no" <?php echo (empty($data['preorder']['Enabled']) || $data['preorder']['Enabled'] == 'no') ? 'selected=selected' : '' ?>><?php echo $text_disabled; ?></option>
          </select>
      </div>
   </td>
  </tr>
  <tr>
    <td class="col-xs-3">
      <h5><strong><?php echo $text_module_status ?></strong></h5>
      <span class="help"><?php echo $text_module_status_help; ?></span>
    </td>
    <td>
      <div class="col-xs-6">
      <?php foreach($stock_statuses as $stock_status) { ?>
      
          <div class="checkbox">
                    <label>
                      <input type="checkbox" name="preorder[<?php echo $stock_status['stock_status_id']?>]" value="yes" <?php echo isset($data['preorder'][$stock_status['stock_status_id']]) ? 'checked="checked"' : ''; ?>/> <?php echo $stock_status['name'] ?>
                    </label>
           </div>
       <?php } ?>
      </div>
   </td>
  </tr>
</table>
<table id="module" class="table table-bordered table-hover info">
  <thead>
    <tr class="table-header">
      <td class="left"><strong><?php echo $entry_layout_options; ?></strong></td>
      <td class="left"><strong><?php echo $entry_position_options; ?></strong></td>
      <td class="left"><strong><?php echo $entry_action_options; ?></strong></td>
    </tr>
  </thead>
  <?php $module_row = 0; ?>
  <?php if (!isset($modules['preorder_module'])) {
    $modules['preorder_module'] = array();} ?>
  <?php foreach ($modules['preorder_module'] as $module) { ?>
  <tbody id="module-row<?php echo $module_row; ?>">
    <tr>
      <td class="left col-xs-3">
        <div class="form-group modulePositioning">
            <label><?php echo $entry_status; ?></label>
            <select name="preorder_module[<?php echo $module_row; ?>][status]" class="form-control">
            <?php if ($module['status']) { ?>
            <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
            <option value="0"><?php echo $text_disabled; ?></option>
            <?php } else { ?>
            <option value="1"><?php echo $text_enabled; ?></option>
            <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
            <?php } ?>
          </select>
        </div>
        <div class="form-group modulePositioning">
            <label><?php echo $entry_layout; ?></label>
            <select name="preorder_module[<?php echo $module_row; ?>][layout_id]" class="form-control">
            <?php foreach ($layouts as $layout) { ?>
            <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
            <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
        </div>
        <div class="form-group modulePositioning">
            <label><?php echo $entry_sort_order; ?></label>
            <input class="form-control" type="number" name="preorder_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" />
        </div>
      </td>
      <td class="left">
        <div class="widgetPositionOpenCart">
            <div class="radio">
                <label for="buttonPos<?php echo $module_row; ?>_1">
                    <input <?php if ($module['position'] == 'content_top') echo 'checked="checked"'; ?> type="radio" style="width:auto" name="preorder_module[<?php echo $module_row; ?>][position]" id="buttonPos<?php echo $module_row; ?>_1" class="widgetPositionOptionBox" data-checkbox="#buttonPosCheckbox_<?php echo $module_row; ?>" value="content_top" />
                    <?php echo $text_content_top; ?>
                </label>
            </div>
            <div class="positionSampleBox">
                <label for="buttonPos<?php echo $module_row; ?>_1"><img class="img-thumbnail" src="view/image/preorder/content_top.png" title="<?php echo $text_content_top; ?>" border="0" /></label>
            </div>        
        </div>
        <div class="widgetPositionOpenCart">
            <div class="radio">
                <label for="buttonPos<?php echo $module_row; ?>_2">
                    <input <?php if ($module['position'] == 'content_bottom') echo 'checked="checked"'; ?> type="radio" style="width:auto" name="preorder_module[<?php echo $module_row; ?>][position]" id="buttonPos<?php echo $module_row; ?>_2" class="widgetPositionOptionBox" data-checkbox="#buttonPosCheckbox_<?php echo $module_row; ?>" value="content_bottom" />
                    <?php echo $text_content_bottom; ?>
                </label>
            </div>
            <div class="positionSampleBox ">
                <label for="buttonPos<?php echo $module_row; ?>_2"><img class="img-thumbnail" src="view/image/preorder/content_bottom.png" title="<?php echo $text_content_bottom; ?>" border="0" /></label>
            </div>
        </div>
        <div class="widgetPositionOpenCart">
            <div class="radio">
                <label for="buttonPos<?php echo $module_row; ?>_3">
                    <input <?php if ($module['position'] == 'column_left') echo 'checked="checked"'; ?> type="radio" style="width:auto" name="preorder_module[<?php echo $module_row; ?>][position]" id="buttonPos<?php echo $module_row; ?>_3" class="widgetPositionOptionBox" data-checkbox="#buttonPosCheckbox_<?php echo $module_row; ?>" value="column_left" />
                    <?php echo $text_column_left; ?>
                </label>
            </div>
            <div class="positionSampleBox">
                <label for="buttonPos<?php echo $module_row; ?>_3"><img class="img-thumbnail" src="view/image/preorder/column_left.png" title="<?php echo $text_column_left; ?>" border="0" /></label>
            </div>
        </div>
        <div class="widgetPositionOpenCart last">
            <div class="radio">
                <label for="buttonPos<?php echo $module_row; ?>_4">
                    <input <?php if ($module['position'] == 'column_right') echo 'checked="checked"'; ?> type="radio" style="width:auto" name="preorder_module[<?php echo $module_row; ?>][position]" id="buttonPos<?php echo $module_row; ?>_4" class="widgetPositionOptionBox" data-checkbox="#buttonPosCheckbox_<?php echo $module_row; ?>" value="column_right" />
                    <?php echo $text_column_right; ?>
                </label>
            </div>
            <div class="positionSampleBox">
                <label for="buttonPos<?php echo $module_row; ?>_4"><img class="img-thumbnail" src="view/image/preorder/column_right.png" title="<?php echo $text_column_right; ?>" border="0" /></label>
            </div>
        </div>
      </td>
      <td class="left" style="vertical-align:bottom;"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="btn btn-danger"><i class="fa fa-times"></i>&nbsp;<?php echo $button_remove; ?></a></td>
    </tr>
  </tbody>
  <?php $module_row++; ?>
  <?php } ?>
  <tfoot>
    <tr>
      <td colspan="2"></td>
      <td class="left"><a onclick="addModule();" class="btn btn-success"><i class="fa fa-plus"></i>&nbsp;<?php echo $button_add_module; ?></a></td>
    </tr>
  </tfoot>
</table>
    
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {
  	html  = '<tbody style="display:none;" id="module-row' + module_row + '">';
  	html += '  <tr>';
  	html += '    <td class="left col-xs-3">';
  	
  	html += '<div class="form-group modulePositioning">';
  	html += ' <label><?php echo $entry_status; ?></label>';
  	html += '    <select name="preorder_module[' + module_row + '][status]" class="form-control">';
	html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
	html += '      <option value="0"><?php echo $text_disabled; ?></option>';
	html += '    </select></div> ';
	
	html += '<div class="form-group modulePositioning">';
	html += '	<label><?php echo $entry_layout; ?></label>'
  	html += '  <select name="preorder_module[' + module_row + '][layout_id]" class="form-control">';
  	<?php foreach ($layouts as $layout) { ?>
  	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
  	<?php } ?>
	html += '    </select></div>';
	
  	html += '<div class="form-group modulePositioning"><label><?php echo $entry_sort_order; ?></label><input class="form-control" type="number" name="preorder_module['+ module_row + '][sort_order]" value="0" /></div>';
  	html += '    </td>';
  	html += '    <td class="left">';
 	html += '<div class="widgetPositionOpenCart"><div class="radio"><label for="buttonPos' + module_row + '_1"><input checked="checked" type="radio" style="width:auto" name="preorder_module[' + module_row + '][position]" id="buttonPos' + module_row + '_1" class="widgetPositionOptionBox" data-checkbox="#buttonPosCheckbox_' + module_row + '" value="content_top" /><?php echo $text_content_top; ?></label></div><div class="positionSampleBox"><label for="buttonPos' + module_row + '_1"><img class="img-thumbnail" src="view/image/preorder/content_top.png" title="<?php echo $text_content_top; ?>" border="0" /></label></div></div>';
  	html += '<div class="widgetPositionOpenCart"><div class="radio"><label for="buttonPos' + module_row + '_2"><input type="radio" style="width:auto" name="preorder_module[' + module_row + '][position]" id="buttonPos' + module_row + '_2" class="widgetPositionOptionBox" data-checkbox="#buttonPosCheckbox_' + module_row + '" value="content_bottom" /><?php echo $text_content_bottom; ?></label></div><div class="positionSampleBox"><label for="buttonPos' + module_row + '_2"><img class="img-thumbnail" src="view/image/preorder/content_bottom.png" title="<?php echo $text_content_bottom; ?>" border="0" /></label></div></div>';
  	html += '<div class="widgetPositionOpenCart"><div class="radio"><label for="buttonPos' + module_row + '_3"><input type="radio" style="width:auto" name="preorder_module[' + module_row + '][position]" id="buttonPos' + module_row + '_3" class="widgetPositionOptionBox" data-checkbox="#buttonPosCheckbox_' + module_row + '" value="column_left" /><?php echo $text_column_left; ?></label></div><div class="positionSampleBox"><label for="buttonPos' + module_row + '_3"><img class="img-thumbnail" src="view/image/preorder/column_left.png" title="<?php echo $text_column_left; ?>" border="0" /></label></div></div>';
  	html += '<div class="widgetPositionOpenCart last"><div class="radio"><label for="buttonPos' + module_row + '_4"><input type="radio" style="width:auto" name="preorder_module[' + module_row + '][position]" id="buttonPos' + module_row + '_4" class="widgetPositionOptionBox" data-checkbox="#buttonPosCheckbox_' + module_row + '" value="column_right" /><?php echo $text_column_right; ?></label></div><div class="positionSampleBox"><label for="buttonPos' + module_row + '_4"><img class="img-thumbnail" src="view/image/preorder/column_right.png" title="<?php echo $text_column_right; ?>" border="0" /></label></div></div>';
  	
  	html += '    </td>';
  	html += '    <td class="left" style="vertical-align:bottom;"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="btn btn-danger"><i class="fa fa-times"></i>&nbsp;<?php echo $button_remove; ?></a></td>';
  	html += '  </tr>';
 	html += '</tbody>';
  
  $('#module tfoot').before(html);
  $('#module-row' + module_row).fadeIn();
  
  module_row++;
}
//--></script>