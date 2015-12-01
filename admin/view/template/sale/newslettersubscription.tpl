<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="button" data-toggle="tooltip" title="<?php echo $button_delete; ?>" class="btn btn-danger" onclick="confirm('<?php echo $text_confirm; ?>') ? $('#form-newslettersubscription').submit() : false;"><i class="fa fa-trash-o"></i></button>
      </div>
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
    <?php if ($success) { ?>
    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-list"></i> <?php echo $text_list; ?></h3>
      </div>
      <div class="panel-body">

	  <form action="<?php echo $delete; ?>" method="post" enctype="multipart/form-data" id="form-newslettersubscription">
	     <div class="table-responsive">
		<table class="table table-bordered table-hover">
		  <thead>
		    <tr>
		      <td style="width: 1px;" class="text-center">
			  <input type="checkbox" onclick="$('input[name*=\'selected\']').prop('checked', this.checked);" />
		      </td>
		      <td class="text-left">
			  <?php if ($sort == 'r.email') { ?>
			      <a href="<?php echo $sort_email; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_email; ?></a>
			      <?php } else { ?>
			      <a href="<?php echo $sort_email; ?>"><?php echo $column_email; ?></a>
			  <?php } ?>
		      </td>
		      <td class="text-left">
			  <?php if ($sort == 'r.status') { ?>
			      <a href="<?php echo $sort_status; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_status; ?></a>
			      <?php } else { ?>
			      <a href="<?php echo $sort_status; ?>"><?php echo $column_status; ?></a>
			   <?php } ?>
		      </td>
		      <td class="text-left">
			  <?php if ($sort == 'r.create_time') { ?>
			      <a href="<?php echo $sort_date_added; ?>" class="<?php echo strtolower($order); ?>"><?php echo $column_date_added; ?></a>
			      <?php } else { ?>
			      <a href="<?php echo $sort_date_added; ?>"><?php echo $column_date_added; ?></a>
			   <?php } ?>
		      </td>
		      <td class="text-center"><?php echo $column_action; ?></td>
		    </tr>
                  </thead>
		  <tbody>
		      <?php if ($newslettersubscriptions) {  ?>

		      <?php foreach ($newslettersubscriptions as $newslettersubscription) { ?>
		      <tr>
			<td class="text-center"><?php if (in_array($newslettersubscription['subscription_id'], $selected)) { ?>
			  <input type="checkbox" name="selected[]" value="<?php echo $newslettersubscription['subscription_id']; ?>" checked="checked" />
			  <?php } else { ?>
			  <input type="checkbox" name="selected[]" value="<?php echo $newslettersubscription['subscription_id']; ?>" />
			  <?php } ?></td>
			<td class="text-left"><?php echo $newslettersubscription['email']; ?></td>
			<td class="text-left"><?php echo $newslettersubscription['status']; ?></td>
			<td class="text-left"><?php echo $newslettersubscription['date_added']; ?></td>
			<td class="text-center"><a href="<?php echo $newslettersubscription['edit']; ?>" data-toggle="tooltip" title="<?php echo $button_answer; ?>" class="btn btn-primary"><i class="fa fa-envelope"></i></a>
			</td>
		      </tr>
		      <?php } ?>
		      <?php } else { ?>
		      <tr>
			<td class="text-center" colspan="7"><?php echo $text_no_results; ?></td>
		      </tr>
		      <?php } ?>
              </tbody>
 </table>
          </div>
        </form>
        <div class="row">
          <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
          <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
    </div>
  </div>
 
</div>
<?php echo $footer; ?>