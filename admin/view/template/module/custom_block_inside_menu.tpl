<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-custom_block_inside_menu" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
        <h1><?php echo $heading_title; ?></h1>
        <ul class="breadcrumb">
          <?php foreach ($breadcrumbs as $breadcrumb) { ?>
          <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
          <?php } ?>
        </ul>
      </div>
    </div>
    <div class="container-fluid">
      <?php if ($error_warning) { ?>
      <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
        <button type="button" class="close" data-dismiss="alert">&times;</button>
      </div>
      <?php } ?>
      <div class="panel panel-default">
        <div class="panel-heading">
          <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
        </div>
        <div class="panel-body">
          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-custom_block_inside_menu" class="form-horizontal">

            <table id="module" class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td class="text-left"><?php echo "Category"; ?></td>
                <?php /*?> <td class="text-left"><?php echo $entry_position; ?></td>
                <td class="text-right"><?php echo $entry_status; ?></td><?php */?>
                <td class="text-right"><?php echo "Right Block content"; ?></td>
                <td class="text-right"><?php echo "Bottom Block content"; ?></td>
                <td></td>
              </tr>
            </thead>
           
              <?php $module_row = 0; ?>
              <?php foreach ($modules as $module) { ?>
               <tbody id="module-row<?php echo $module_row; ?>">
              <tr>
                <td>
                  <select name="custom_block_inside_menu_module[<?php echo $module_row; ?>][category_id]" class="form-control">
                  <?php foreach ($top_categories as $category) { ?>
                  <?php if ($category['category_id'] == $module['category_id']) { ?>
                  <option value="<?php echo $category['category_id']; ?>" selected="selected"><?php echo $category['name']; ?></option>
                  <?php } else {?>
                  <option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
                  <?php }} ?>
                </select>
                </td>
<?php /* ?>                <td>
                  <select name="custom_block_inside_menu_module[<?php echo $module_row; ?>][position]" class="form-control">
                  <?php if ($module['position'] == 'top') { ?>
                  <option value="top" selected="selected"><?php echo $text_content_top; ?></option>
                  <?php } else { ?>
                  <option value="top"><?php echo $text_content_top; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'bottom') { ?>
                  <option value="bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                  <?php } else { ?>
                  <option value="bottom"><?php echo $text_content_bottom; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'right') { ?>
                  <option value="right" selected="selected"><?php echo $text_content_right; ?></option>
                  <?php } else { ?>
                  <option value="right"><?php echo $text_content_right; ?></option>
                  <?php } ?>
                </select>
                </td>
                <td>
                  <select name="custom_block_inside_menu_module[<?php echo $module_row; ?>][status]" class="form-control">
                  <?php if ($module['status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select>
                </td><?php */ ?>
                <td align="right">
                  <textarea name="custom_block_inside_menu_module[<?php echo $module_row; ?>][r_content]" placeholder="Enetr text here" class="form-control"><?php echo $module["r_content"]; ?></textarea>
                </td>


                <td align="right">
                  <textarea name="custom_block_inside_menu_module[<?php echo $module_row; ?>][b_content]" placeholder="Enetr text here" class="form-control"><?php echo $module["b_content"]; ?></textarea>
                </td>

                <td class="text-left"><button type="button" onclick="$('#module-row<?php echo $module_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
              </tr>
              <?php $module_row++; ?>
              <?php } ?>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="3"></td>
                <td class="text-left"><button type="button" onclick="addModule();" data-toggle="tooltip" title="<?php echo $button_module_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
              </tr>
            </tfoot>
          </table>

          </form>
        </div>
      </div>
    </div>



  </div>

    <script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {  
  html  = '<tbody id="module-row' + module_row + '">';
  
  html += '  <tr>';
  html += '    <td><select class="form-control" name="custom_block_inside_menu_module[' + module_row + '][category_id]">';
  <?php foreach ($top_categories as $category) { ?>
  html += '      <option value="<?php echo $category['category_id']; ?>"><?php echo addslashes($category['name']); ?></option>';
  <?php } ?>
  html += '    </select></td>';

//  html += '    <td><select  class="form-control" name="custom_block_inside_menu_module[' + module_row + '][position]">';
//  html += '      <option value="top"><?php echo $text_content_top; ?></option>';
  // html += '      <option value="bottom"><?php echo $text_content_bottom; ?></option>';
  // html += '      <option value="right"><?php echo $text_content_right; ?></option>';
  // html += '    </select></td>';

  // html += '    <td><select class="form-control" name="custom_block_inside_menu_module[' + module_row + '][status]">';
  // html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
  // html += '      <option value="0"><?php echo $text_disabled; ?></option>';
  // html += '    </select></td>';

  html += '<td align="right"><textarea class="form-control" name="custom_block_inside_menu_module[' + module_row + '][r_content]" placeholder="Enetr text here" class="form-control"></textarea></td>';

  html += '<td align="right"><textarea class="form-control" name="custom_block_inside_menu_module[' + module_row + '][b_content]" placeholder="Enetr text here" class="form-control"></textarea></td>';

  html += '<td  class="left"><button type="button" onclick="$(\'#module-row' + module_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
  html += '  </tr>';
  html += '</tbody>';
  
  $('#module tfoot').before(html);

  
  module_row++;
}
//--></script> 
  <?php echo $footer; ?>