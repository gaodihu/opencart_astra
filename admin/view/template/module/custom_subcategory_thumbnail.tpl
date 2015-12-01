<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-custom_subcategory_thumbnail" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
          <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-custom_subcategory_thumbnail" class="form-horizontal">

            <table id="module" class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td class="text-left"><?php echo "Category"; ?></td>                              
                <td class="text-left"><?php echo "Thumbnail for Menu"; ?></td>
                <td></td>
              </tr>
            </thead>
           
              <?php $module_row = 0; ?>
              <?php foreach ($subcat_images as $module) { ?>
               <tbody id="module-row<?php echo $module_row; ?>">
              <tr>
                <td>
                  <select name="custom_subcategory_thumbnail_module[<?php echo $module_row; ?>][category_id]" class="form-control">
                  <?php foreach ($subcategories as $keycat => $valcategory) { ?>
                  <?php if ($keycat == $module['category_id']) { ?>
                  <option value="<?php echo $keycat; ?>" selected="selected"><?php echo $valcategory; ?></option>
                  <?php } else {?>
                  <option value="<?php echo $keycat; ?>"><?php echo $valcategory; ?></option>
                  <?php }} ?>
                </select>
                </td>                              
                <td class="text-left">                 
                     <a href="" id="thumb-image<?php echo $module_row; ?>" data-toggle="image" class="img-thumbnail"><img src="<?php echo $module['thumb']; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="custom_subcategory_thumbnail_module[<?php echo $module_row; ?>][image]" value="<?php echo $module['image']; ?>" id="input-image<?php echo $module_row; ?>" />
                </td>

                <td class="text-left"><button type="button" onclick="$('#module-row<?php echo $module_row; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>
              </tr>
              <?php $module_row++; ?>
              <?php } ?>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="2"></td>
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
  html += '    <td><select class="form-control" name="custom_subcategory_thumbnail_module[' + module_row + '][category_id]">';
  <?php foreach ($subcategories as $keycat => $valcategory) { ?>
  html += '      <option value="<?php echo $keycat; ?>"><?php echo addslashes($valcategory); ?></option>';
  <?php } ?>
  html += '    </select></td>';

  html += '<td class="text-left"><a href="" id="thumb-image'+ module_row +'" data-toggle="image" class="img-thumbnail"><img src="<?php echo $placeholder; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a><input type="hidden" name="custom_subcategory_thumbnail_module['+ module_row +'][image]" value="" id="input-image'+ module_row +'" /></td>';

  html += '<td  class="left"><button type="button" onclick="$(\'#module-row' + module_row + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
  html += '  </tr>';
  html += '</tbody>';
  
  $('#module tfoot').before(html);

  
  module_row++;
}
//--></script> 
  <?php echo $footer; ?>