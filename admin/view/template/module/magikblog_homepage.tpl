<?php echo $header; ?>

<?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-magikbloghomepage" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
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
	  <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-magikbloghomepage" class="form-horizontal">
	    <div class="tab-pane">
	      
	      <div class="tab-content">
		  <div class="form-group">
			<label class="col-sm-3 control-label" for="input-magikbloghomepage_ed"><?php echo $entry_homepagestatus; ?></label>
			<div class="col-sm-9">
			    <select name="magikblog_homepage_status" id="input-magikbloghomepage_ed" class="form-control">
			    <?php if ($magikblog_homepage_status) { ?>
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
		  <label class="col-sm-3 control-label" for="input-postcount"><?php echo $entry_postcount; ?></label>
		  <div class="col-sm-9">
		    <input type="text" name="magikblog_homepage_postcount" value="<?php echo $magikblog_homepage_postcount; ?>" placeholder="<?php echo $entry_postcount; ?>" id="input-postcount" class="form-control" />
		  </div>
		</div>

		<div class="form-group">
                <label class="col-sm-3 control-label" for="input-ignorepost"><?php echo $entry_ignorepost; ?></label>
                <div class="col-sm-9">
                  <input type="text" name="magikblog_homepage_ignorepost" value="<?php echo $magikblog_homepage_ignorepost; ?>" placeholder="<?php echo $entry_ignorepost; ?>" id="input-ignorepost" class="form-control" />
                </div>
              </div>
 <div class="form-group">
		  <label class="col-sm-3 control-label" for="input-descriptionlimit"><?php echo $entry_descriptionlimit; ?></label>
		  <div class="col-sm-9">
		    <input type="text" name="magikblog_homepage_descriptionlimit" value="<?php echo $magikblog_homepage_descriptionlimit; ?>" placeholder="<?php echo $entry_descriptionlimit; ?>" id="input-descriptionlimit" class="form-control" />
		  </div>
		</div>


<div class="form-group">
                <label class="col-sm-3 control-label" for="input-parent"><?php echo $entry_ignorecategory; ?></label>
                <div class="col-sm-9">
		    <div class="well well-sm" style="height: 150px; overflow: auto;">
		      <?php if(count($parentcategory) == 0){ ?>
		       <div class="checkbox">

                      <label>
                        <?php if (in_array(0, $magikblog_homepage_article_category)) { ?>
                        <!--<input type="checkbox" name="question_category[]" value="0" checked="checked" />-->
                        <?php echo $text_default_category; ?>
                        <?php } else { ?>
                        <!--<input type="checkbox" name="question_category[]" value="0" />-->
                        <?php echo $text_default_category; ?>
                        <?php } ?>
                      </label>
                    </div>
		  <?php } ?>
		      <?php foreach ($parentcategory as $_parentcategory) { ?>
			<div class="checkbox">
			  <label>
			    <?php if (in_array($_parentcategory['category_id'], $magikblog_homepage_article_category)) { ?>
			    <input type="checkbox" name="magikblog_homepage_article_category[]" value="<?php echo $_parentcategory['category_id']; ?>" checked="checked" />
			    <?php echo $_parentcategory['name']; ?>
			    <?php } else { ?>
			    <input type="checkbox" name="magikblog_homepage_article_category[]" value="<?php echo $_parentcategory['category_id']; ?>" />
			    <?php echo $_parentcategory['name']; ?>
			    <?php } ?>
			  </label>
			</div>
		      <?php } ?>
		    </div>
                </div>
              </div>


	      <div class="form-group">
                <label class="col-sm-3 control-label" for="input-hideimage"><?php echo $entry_hideimage; ?></span></label>
                <div class="col-sm-9">
                  <div class="checkbox">
                    <label>
                      <?php if ($magikblog_homepage_hideimage) { ?>
                      <input type="checkbox" name="magikblog_homepage_hideimage" value="1" checked="checked" id="input-hideimage" />
                      <?php } else { ?>
                      <input type="checkbox" name="magikblog_homepage_hideimage" value="1" id="input-hideimage" />
                      <?php } ?>
                      &nbsp; </label>
                  </div>
                </div>
              </div>

	      <div class="form-group">
                <label class="col-sm-3 control-label" for="input-hidetitle"><?php echo $entry_hidetitle; ?></span></label>
                <div class="col-sm-9">
                  <div class="checkbox">
                    <label>
                      <?php if ($magikblog_homepage_hidetitle) { ?>
                      <input type="checkbox" name="magikblog_homepage_hidetitle" value="1" checked="checked" id="input-hidetitle" />
                      <?php } else { ?>
                      <input type="checkbox" name="magikblog_homepage_hidetitle" value="1" id="input-hidetitle" />
                      <?php } ?>
                      &nbsp; </label>
                  </div>
                </div>
              </div>
	      <div class="form-group">
                <label class="col-sm-3 control-label" for="input-hidedescription"><?php echo $entry_hidedescription; ?></span></label>
                <div class="col-sm-9">
                  <div class="checkbox">
                    <label>
                      <?php if ($magikblog_homepage_hidedescription) { ?>
                      <input type="checkbox" name="magikblog_homepage_hidedescription" value="1" checked="checked" id="input-hidedescription" />
                      <?php } else { ?>
                      <input type="checkbox" name="magikblog_homepage_hidedescription" value="1" id="input-hidedescription" />
                      <?php } ?>
                      &nbsp; </label>
                  </div>
                </div>
              </div>
	      <div class="form-group">
                <label class="col-sm-3 control-label" for="input-hidedate"><?php echo $entry_hidedate; ?></span></label>
                <div class="col-sm-9">
                  <div class="checkbox">
                    <label>
                      <?php if ($magikblog_homepage_hidedate) { ?>
                      <input type="checkbox" name="magikblog_homepage_hidedate" value="1" checked="checked" id="input-hidedate" />
                      <?php } else { ?>
                      <input type="checkbox" name="magikblog_homepage_hidedate" value="1" id="input-hidedate" />
                      <?php } ?>
                      &nbsp; </label>
                  </div>
                </div>
              </div>

	      <div class="form-group">
                <label class="col-sm-3 control-label" for="input-resizeimage"><?php echo $entry_resizeimage; ?></span></label>
                <div class="col-sm-9">
                  <div class="checkbox">
                    <label>
                      <?php if ($magikblog_homepage_resizeimage) { ?>
                      <input type="checkbox" name="magikblog_homepage_resizeimage" value="1" checked="checked" id="input-resizeimage" />
                      <?php } else { ?>
                      <input type="checkbox" name="magikblog_homepage_resizeimage" value="1" id="input-resizeimage" />
                      <?php } ?>
                      &nbsp; </label>
                  </div>
                </div>
              </div>


	      <div class="form-group required">
                <label class="col-sm-3 control-label" for="input-resizeimagewidth"><?php echo $entry_imageblog; ?></label>
                <div class="col-sm-9">
                  <div class="row">
                    <div class="col-sm-6">
                      <input type="text" name="magikblog_homepage_resizeimagewidth" value="<?php echo $magikblog_homepage_resizeimagewidth; ?>" placeholder="<?php echo $entry_resizeimagewidth; ?>" id="input-resizeimagewidth" class="form-control" />
                    </div>
                    <div class="col-sm-6">
                      <input type="text" name="magikblog_homepage_resizeimageheight" value="<?php echo $magikblog_homepage_resizeimageheight; ?>" placeholder="<?php echo $entry_resizeimageheight; ?>" class="form-control" />
                    </div>
                  </div>
		<?php if ($error_image_blog) { ?>
                  <div class="text-danger"><?php echo $error_image_blog; ?></div>
                  <?php } ?>
                </div>
              </div>


	      </div>
	    </div>
	  </form>
	</div>
      </div>
  </div>
</div> 
  
    
<?php echo $footer; ?> 
