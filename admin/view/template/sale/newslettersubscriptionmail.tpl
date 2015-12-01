<?php echo $header; ?>

<?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
<!--        <button type="submit" form="form-newslettersubscriptionmail" data-toggle="tooltip" title="<?php //echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>-->
        <button id="button-send" data-loading-text="<?php echo $text_loading; ?>" data-toggle="tooltip" title="<?php echo $button_send; ?>" class="btn btn-primary" onclick="send('index.php?route=sale/newslettersubscriptionmail/send&token=<?php echo $token; ?>');"><i class="fa fa-envelope"></i></button>
       
 <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_mail_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
    </div>
  </div>
  <div class="container-fluid">
    <?php /* if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php }*/ ?>
    <div class="panel panel-default">
	<div class="panel-heading">
	  <h3 class="panel-title"><i class="fa fa-envelope"></i> <?php echo $text_mail; ?></h3>
	</div>

	<div class="panel-body">
	  <form  method="post" enctype="multipart/form-data" id="form-newslettersubscriptionmail" class="form-horizontal">
	<div class="form-group">
            <label class="col-sm-2 control-label" for="input-store"><?php echo $entry_store; ?></label>
            <div class="col-sm-10">
              <select name="store_id" id="input-store" class="form-control">
                <option value="0"><?php echo $text_default; ?></option>
                <?php foreach ($stores as $store) { ?>
                <option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>	
	  <div class="form-group">
            <label class="col-sm-2 control-label" for="input-to"><?php echo $entry_to; ?></label>
            <div class="col-sm-10">
              <select name="to" id="input-to" class="form-control">
                <option value="newsletter"><?php echo $text_newsletter; ?></option>
              </select>
            </div>
          </div>

	  <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-subject"><?php echo $entry_subject; ?></label>
            <div class="col-sm-10">
              <input type="text" name="subject" value="" placeholder="<?php echo $entry_subject; ?>" id="input-subject" class="form-control" />
            </div>
          </div>
          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-message"><?php echo $entry_message; ?></label>
            <div class="col-sm-10">
              <textarea name="message" placeholder="<?php echo $entry_message; ?>" id="input-message" class="form-control"></textarea>
            </div>
          </div>

	  </form>
	</div>
      </div>
  </div>
<script type="text/javascript"><!--
$('#input-message').summernote({
	height: 300
});
//--></script>
 <script type="text/javascript"><!--
// Customers
function send(url) {

	// Summer not fix
	$('textarea[name=\'message\']').val($('#input-message').code());
	
	$.ajax({
		url: url,
		type: 'post',
		data: $('#content select, #content input, #content textarea'),		
		dataType: 'json',
		beforeSend: function() {
			$('#button-send').button('loading');	
		},
		complete: function() {
			$('#button-send').button('reset');
		},				
		success: function(json) {

			$('.alert, .text-danger').remove();
			
			if (json['error']) {
				if (json['error']['warning']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error']['warning'] + '</div>');
				}
				
				if (json['error']['subject']) {
					$('input[name=\'subject\']').after('<div class="text-danger">' + json['error']['subject'] + '</div>');
				}	
				
				if (json['error']['message']) {
					$('textarea[name=\'message\']').parent().append('<div class="text-danger">' + json['error']['message'] + '</div>');
				}									
			}			
			
			if (json['next']) {
				if (json['success']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i>  ' + json['success'] + '</div>');
					
					send(json['next']);
				}		
			} else {
				if (json['success']) {
					$('#content > .container-fluid').prepend('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');
				}					
			}				
		}
	});
}
//--></script>
</div> 
  
    
<?php echo $footer; ?> 
