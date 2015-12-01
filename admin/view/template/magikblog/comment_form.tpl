<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-category" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_form; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-mgkblogcomment" class="form-horizontal">

          <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-user"><?php echo $entry_author; ?></label>
            <div class="col-sm-10">
              <input type="text" name="user" value="<?php echo $user; ?>" placeholder="<?php echo $entry_author; ?>" id="input-user" class="form-control" />
              <?php  if ($error_user) { ?>
              <div class="text-danger"><?php echo $error_user; ?></div>
              <?php } ?>
            </div>
          </div>
	   
 <div class="form-group required">
            <label class="col-sm-2 control-label" for="input-blog"><span data-toggle="tooltip" title="<?php echo $help_blog; ?>"><?php echo $entry_blog; ?></span></label>
            <div class="col-sm-10">
              <input type="text" name="blog" value="<?php echo $blog; ?>" placeholder="<?php echo $entry_blog; ?>" id="input-blog" class="form-control" />
              <input type="hidden" name="blog_id" value="<?php echo $blog_id; ?>" />
              <?php if ($error_blog) { ?>
              <div class="text-danger"><?php echo $error_blog; ?></div>
              <?php } ?>
            </div>
          </div>
 
	<div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-comment"><?php echo $entry_comment; ?></label>
                    <div class="col-sm-10">
                      <textarea name="comment" placeholder="<?php echo $entry_comment; ?>" id="input-comment" class="form-control"><?php echo $comment; ?></textarea>
              
		    <?php  if ($error_comment) { ?>
		    <div class="text-danger"><?php echo $error_comment; ?></div>
		    <?php } ?>
                    </div>
           </div>
<div class="form-group required">
            <label class="col-sm-2 control-label" for="input-name"><?php echo $entry_rating; ?></label>
            <div class="col-sm-10">
              <label class="radio-inline">
                <?php if ($rating == 1) { ?>
                <input type="radio" name="rating" value="1" checked="checked" />
                1
                <?php } else { ?>
                <input type="radio" name="rating" value="1" />
                1
                <?php } ?>
              </label>
              <label class="radio-inline">
                <?php if ($rating == 2) { ?>
                <input type="radio" name="rating" value="2" checked="checked" />
                2
                <?php } else { ?>
                <input type="radio" name="rating" value="2" />
                2
                <?php } ?>
              </label>
              <label class="radio-inline">
                <?php if ($rating == 3) { ?>
                <input type="radio" name="rating" value="3" checked="checked" />
                3
                <?php } else { ?>
                <input type="radio" name="rating" value="3" />
                3
                <?php } ?>
              </label>
              <label class="radio-inline">
                <?php if ($rating == 4) { ?>
                <input type="radio" name="rating" value="4" checked="checked" />
                4
                <?php } else { ?>
                <input type="radio" name="rating" value="4" />
                4
                <?php } ?>
              </label>
              <label class="radio-inline">
                <?php if ($rating == 5) { ?>
                <input type="radio" name="rating" value="5" checked="checked" />
                5
                <?php } else { ?>
                <input type="radio" name="rating" value="5" />
                5
                <?php } ?>
              </label>
              <?php if ($error_rating) { ?>
              <div class="text-danger"><?php echo $error_rating; ?></div>
              <?php } ?>
            </div>
          </div>
	  <div class="form-group">
                <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
                <div class="col-sm-10">
                  <select name="status" id="input-status" class="form-control">
                    <?php if ($status) { ?>
                    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                    <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                    <option value="1"><?php echo $text_enabled; ?></option>
                    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </div>
              </div>
         
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
$('#input-answer<?php echo $language['language_id']; ?>').summernote({
	height: 300
});
<?php } ?>
//--></script> 
  <script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script>
<script type="text/javascript"><!--
$('input[name=\'blog\']').autocomplete({
	'source': function(request, response) {
		$.ajax({
			url: 'index.php?route=magikblog/comment/autocomplete&token=<?php echo $token; ?>&article_name=' +  encodeURIComponent(request),
			dataType: 'json',			
			success: function(json) {
				response($.map(json, function(item) {
					return {
						label: item['name'],
						value: item['blog_id']
					}
				}));
			}
		});
	},
	'select': function(item) {
		$('input[name=\'blog\']').val(item['label']);
		$('input[name=\'blog_id\']').val(item['value']);		
	}	
});
//--></script>
</div>
<?php echo $footer; ?>