<?php echo $header; ?>

<?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-mgkblog" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-mgkblog" class="form-horizontal">
	    <div class="tab-pane">
	      <ul class="nav nav-tabs" id="language">
              <?php foreach ($languages as $language) { ?>
              <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
              <?php } ?>
            </ul>
	      <div class="tab-content">
		  
		   <?php foreach ($languages as $language) { ?>
		      <div class="tab-pane panel-heading" id="language<?php echo $language['language_id']; ?>">
			  <div class="form-group">
			    <label class="col-sm-2 control-label" for="input-metatitle<?php echo $language['language_id']; ?>"><?php echo $entry_metatitle; ?></label>
			    <div class="col-sm-10">
			    <input name="magikblog_description[<?php echo $language['language_id']; ?>][metatitle]" cols="40" rows="5" id="input-metatitle<?php echo $language['language_id']; ?>" placeholder="<?php echo $entry_metatitle; ?>" value="<?php echo isset($magikblog_description[$language['language_id']]) ? $magikblog_description[$language['language_id']]['metatitle'] : ''; ?>" class="form-control"/>
			    </div>
			  </div>
	
			  <div class="form-group">
			    <label class="col-sm-2 control-label" for="input-metakeyword<?php echo $language['language_id']; ?>"><?php echo $entry_metakeyword; ?></label>
			    <div class="col-sm-10">
			    <input name="magikblog_description[<?php echo $language['language_id']; ?>][metakeyword]" cols="40" rows="5" id="input-metakeyword<?php echo $language['language_id']; ?>" placeholder="<?php echo $entry_metakeyword; ?>" value="<?php echo isset($magikblog_description[$language['language_id']]) ? $magikblog_description[$language['language_id']]['metakeyword'] : ''; ?>" class="form-control"/>
			    </div>
			  </div>
			  <div class="form-group">
			    <label class="col-sm-2 control-label" for="input-metadescription<?php echo $language['language_id']; ?>"><?php echo $entry_metadescription; ?></label>
			    <div class="col-sm-10">
			      <textarea name="magikblog_description[<?php echo $language['language_id']; ?>][metadescription]" placeholder="<?php echo $entry_metadescription; ?>" id="input-metadescription<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($magikblog_description[$language['language_id']]) ? $magikblog_description[$language['language_id']]['metadescription'] : ''; ?></textarea>
			    </div>
			  </div>
			  <!--<div class="form-group">
			    <label class="col-sm-2 control-label" for="input-showcomment<?php //echo $language['language_id']; ?>"><?php //echo $entry_showcomment; ?></label>
			    <div class="col-sm-10">
			      <select name="magikblog_description[<?php //echo $language['language_id']; ?>][showcomment]" id="input-showcomment<?php //echo $language['language_id']; ?>" class="form-control">
				<?php //if ($magikblog_description[$language['language_id']]['showcomment']) { ?>
				<option value="1" selected="selected"><?php //echo $text_yes; ?></option>
				<option value="0"><?php //echo $text_no; ?></option>
				<?php //} else { ?>
				<option value="1"><?php //echo $text_yes; ?></option>
				<option value="0" selected="selected"><?php //echo $text_no; ?></option>
				<?php //} ?>
			      </select>
			    </div>
			  </div>-->
		      </div><!-- -->
		  <?php } ?>
<br><br>
		  <div class="form-group">
			<label class="col-sm-2 control-label" for="input-mgkblog_ed"><?php echo $entry_status; ?></label>
			<div class="col-sm-10">
			    <select name="magikblog_status" id="input-mgkblog_ed" class="form-control">
			    <?php if ($magikblog_status) { ?>
			    <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
			    <option value="0"><?php echo $text_disabled; ?></option>
			    <?php } else { ?>
			    <option value="1"><?php echo $text_enabled; ?></option>
			    <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
			    <?php } ?>
			    </select>
			</div>
		  </div>
		  <div class="form-group">
			<label class="col-sm-2 control-label" for="input-mgkblogcommentstatus_ed"><?php echo $entry_allowcomment; ?></label>
			<div class="col-sm-10">
			    <label class="radio-inline">
			      <?php if ($magikblog_allow_comment) { ?>
			      <input type="radio" name="magikblog_allow_comment" value="1" checked="checked" />
			      <?php echo $text_yes; ?>
			      <?php } else { ?>
			      <input type="radio" name="magikblog_allow_comment" value="1" />
			      <?php echo $text_yes; ?>
			      <?php } ?>
			    </label>
			    <label class="radio-inline">
			      <?php if (!$magikblog_allow_comment) { ?>
			      <input type="radio" name="magikblog_allow_comment" value="0" checked="checked" />
			      <?php echo $text_no; ?>
			      <?php } else { ?>
			      <input type="radio" name="magikblog_allow_comment" value="0" />
			      <?php echo $text_no; ?>
			      <?php } ?>
			    </label>
			</div>
		  </div>
		  
		  <div class="form-group">
			<label class="col-sm-2 control-label" for="input-mgkblogcomment_ed"><?php echo $entry_allowguestcomment; ?></label>
			<div class="col-sm-10">
			    <label class="radio-inline">
			      <?php if ($magikblog_allow_guestcomment) { ?>
			      <input type="radio" name="magikblog_allow_guestcomment" value="1" checked="checked" />
			      <?php echo $text_yes; ?>
			      <?php } else { ?>
			      <input type="radio" name="magikblog_allow_guestcomment" value="1" />
			      <?php echo $text_yes; ?>
			      <?php } ?>
			    </label>
			    <label class="radio-inline">
			      <?php if (!$magikblog_allow_guestcomment) { ?>
			      <input type="radio" name="magikblog_allow_guestcomment" value="0" checked="checked" />
			      <?php echo $text_no; ?>
			      <?php } else { ?>
			      <input type="radio" name="magikblog_allow_guestcomment" value="0" />
			      <?php echo $text_no; ?>
			      <?php } ?>
			    </label>
			</div>
		  </div>
		  <div class="form-group">
			<label class="col-sm-2 control-label" for="input-mgkblogtagstatus_ed"><?php echo $entry_allowtag; ?></label>
			<div class="col-sm-10">
			    <label class="radio-inline">
			      <?php if ($magikblog_allow_tag) { ?>
			      <input type="radio" name="magikblog_allow_tag" value="1" checked="checked" />
			      <?php echo $text_yes; ?>
			      <?php } else { ?>
			      <input type="radio" name="magikblog_allow_tag" value="1" />
			      <?php echo $text_yes; ?>
			      <?php } ?>
			    </label>
			    <label class="radio-inline">
			      <?php if (!$magikblog_allow_tag) { ?>
			      <input type="radio" name="magikblog_allow_tag" value="0" checked="checked" />
			      <?php echo $text_no; ?>
			      <?php } else { ?>
			      <input type="radio" name="magikblog_allow_tag" value="0" />
			      <?php echo $text_no; ?>
			      <?php } ?>
			    </label>
			</div>
		  </div>
		  <div class="form-group">
			<label class="col-sm-2 control-label" for="input-mgkblogrssfeedstatus_ed"><?php echo $entry_allowblogfeed; ?></label>
			<div class="col-sm-10">
			    <label class="radio-inline">
			      <?php if ($magikblog_allow_rssfeed) { ?>
			      <input type="radio" name="magikblog_allow_rssfeed" value="1" checked="checked" />
			      <?php echo $text_yes; ?>
			      <?php } else { ?>
			      <input type="radio" name="magikblog_allow_rssfeed" value="1" />
			      <?php echo $text_yes; ?>
			      <?php } ?>
			    </label>
			    <label class="radio-inline">
			      <?php if (!$magikblog_allow_rssfeed) { ?>
			      <input type="radio" name="magikblog_allow_rssfeed" value="0" checked="checked" />
			      <?php echo $text_no; ?>
			      <?php } else { ?>
			      <input type="radio" name="magikblog_allow_rssfeed" value="0" />
			      <?php echo $text_no; ?>
			      <?php } ?>
			    </label>
			</div>
		  </div>


		  
	      </div><!-- tabcontent -->
	    </div>
	  </form>
	</div>
      </div>
  </div>
<script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script> 
</div> 
  
    
<?php echo $footer; ?> 
