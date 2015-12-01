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
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-article" class="form-horizontal">
          <ul class="nav nav-tabs">
            <li class="active"><a href="#tab-general" data-toggle="tab"><?php echo $tab_general; ?></a></li>
            <li><a href="#tab-data" data-toggle="tab"><?php echo $tab_data; ?></a></li>
	    <li><a href="#tab-links" data-toggle="tab"><?php echo $tab_links; ?></a></li>
          </ul>
          <div class="tab-content">

            <div class="tab-pane active in" id="tab-general">
              <ul class="nav nav-tabs" id="language">
                <?php foreach ($languages as $language) { ?>
                <li><a href="#language<?php echo $language['language_id']; ?>" data-toggle="tab"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a></li>
                <?php } ?>
              </ul>
              <div class="tab-content">
                <?php foreach ($languages as $language) { ?>
                <div class="tab-pane" id="language<?php echo $language['language_id']; ?>">
                  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-article<?php echo $language['language_id']; ?>"><?php echo $entry_article; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="article_description[<?php echo $language['language_id']; ?>][articlename]" value="<?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['name'] : ''; ?>" placeholder="<?php echo $entry_article; ?>" id="input-article<?php echo $language['language_id']; ?>" class="form-control" />
                      <?php if (isset($error_article[$language['language_id']])) { ?>
                      <div class="text-danger"><?php echo $error_article[$language['language_id']]; ?></div>
                      <?php } ?>
                    </div>
                  </div>
                  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-description<?php echo $language['language_id']; ?>"><?php echo $entry_description; ?></label>
                    <div class="col-sm-10">
                      <textarea name="article_description[<?php echo $language['language_id']; ?>][description]" placeholder="<?php echo $entry_description; ?>" id="input-description<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['description'] : ''; ?></textarea>
                    </div>
                  </div>
		  <div class="form-group required">
                    <label class="col-sm-2 control-label" for="input-metatitle<?php echo $language['language_id']; ?>"><?php echo $entry_metatitle; ?></label>
                    <div class="col-sm-10">
                      <textarea name="article_description[<?php echo $language['language_id']; ?>][meta_title]" placeholder="<?php echo $entry_metatitle; ?>" id="input-metatitle<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['meta_title'] : ''; ?></textarea>
		      <?php if (isset($error_metatitle[$language['language_id']])) { ?>
                      <div class="text-danger"><?php echo $error_metatitle[$language['language_id']]; ?></div>
                      <?php } ?>
		    </div>
                  </div>
		  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-metatitle<?php echo $language['language_id']; ?>"><?php echo $entry_metadescription; ?></label>
                    <div class="col-sm-10">
                      <textarea name="article_description[<?php echo $language['language_id']; ?>][meta_description]" placeholder="<?php echo $entry_metadescription; ?>" id="input-metadescription<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['meta_description'] : ''; ?></textarea>
                    </div>
                  </div>
		  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-metakeyword<?php echo $language['language_id']; ?>"><?php echo $entry_metakeyword; ?></label>
                    <div class="col-sm-10">
                      <textarea name="article_description[<?php echo $language['language_id']; ?>][meta_keyword]" placeholder="<?php echo $entry_metakeyword; ?>" id="input-metakeyword<?php echo $language['language_id']; ?>" class="form-control"><?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['meta_keyword'] : ''; ?></textarea>
                    </div>
                  </div>
		  <div class="form-group">
                    <label class="col-sm-2 control-label" for="input-tag<?php echo $language['language_id']; ?>"><?php echo $entry_tag; ?></label>
                    <div class="col-sm-10">
                      <input type="text" name="article_description[<?php echo $language['language_id']; ?>][tag]" value="<?php echo isset($article_description[$language['language_id']]) ? $article_description[$language['language_id']]['tags'] : ''; ?>" placeholder="<?php echo $entry_tag; ?>" id="input-tag<?php echo $language['language_id']; ?>" class="form-control" />
                    </div>
                  </div>
                 </div>
                <?php } ?>
              </div>
            </div>

            <div class="tab-pane fade" id="tab-data">
	    <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_image; ?></label>
                <div class="col-sm-10"><a href="" id="thumb-image" data-toggle="image" class="img-thumbnail"><img src="<?php echo $thumb; ?>" alt="" title="" data-placeholder="<?php echo $placeholder; ?>" /></a>
                  <input type="hidden" name="image" value="<?php echo $image; ?>" id="input-image" />
                </div>
              </div>
             <div class="form-group">
                <label class="col-sm-2 control-label" for="input-author"><?php echo $entry_author; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="author" value="<?php echo $author; ?>" placeholder="<?php echo $entry_author; ?>" id="input-author" class="form-control" />
                </div>
              </div>
	      <div class="form-group">
                <label class="col-sm-2 control-label" for="input-publishdate"><?php echo $entry_publishdate; ?></label>
                <div class="col-sm-3">
                  <div class="input-group date">
                    <input type="text" name="publishdate" value="<?php echo $publishdate; ?>" placeholder="<?php echo $entry_publishdate; ?>" data-date-format="YYYY-MM-DD" id="input-publishdate" class="form-control" />
                    <span class="input-group-btn">
                    <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
                    </span></div>
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

	       <div class="form-group">
                <label class="col-sm-2 control-label" for="input-display-order"><?php echo $entry_display_order; ?></label>
                <div class="col-sm-10">
                  <input type="text" name="display_order" value="<?php echo $display_order; ?>" placeholder="<?php echo $entry_display_order; ?>" id="input-display-order" class="form-control" />
                </div>
              </div>

            </div>
            
	    <div class="tab-pane fade" id="tab-links">

             <div class="form-group">
                <label class="col-sm-2 control-label" for="input-parent"><?php echo $entry_category; ?></label>
                <div class="col-sm-10">
		    <div class="well well-sm" style="height: 150px; overflow: auto;">
		      <?php if(count($parentcategory) == 0){ ?>
		       <div class="checkbox">

                      <label>
                        <?php if (in_array(0, $article_category)) { ?>
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
			    <?php if (in_array($_parentcategory['category_id'], $article_category)) { ?>
			    <input type="checkbox" name="article_category[]" value="<?php echo $_parentcategory['category_id']; ?>" checked="checked" />
			    <?php echo $_parentcategory['name']; ?>
			    <?php } else { ?>
			    <input type="checkbox" name="article_category[]" value="<?php echo $_parentcategory['category_id']; ?>" />
			    <?php echo $_parentcategory['name']; ?>
			    <?php } ?>
			  </label>
			</div>
		      <?php } ?>
		    </div>
                </div>
              </div>

	      <div class="form-group">
                <label class="col-sm-2 control-label"><?php echo $entry_store; ?></label>
                <div class="col-sm-10">
                  <div class="well well-sm" style="height: 150px; overflow: auto;">
                    <div class="checkbox">

                      <label>
                        <?php if (in_array(0, $article_store)) { ?>
                        <input type="checkbox" name="article_store[]" value="0" checked="checked" />
                        <?php echo $text_default; ?>
                        <?php } else { ?>
                        <input type="checkbox" name="article_store[]" value="0" />
                        <?php echo $text_default; ?>
                        <?php } ?>
                      </label>
                    </div>

                    <?php foreach ($stores as $store) { ?>
                    <div class="checkbox">
                      <label>
                        <?php if (in_array($store['store_id'], $article_store)) { ?>
                        <input type="checkbox" name="article_store[]" value="<?php echo $store['store_id']; ?>" checked="checked" />
                        <?php echo $store['name']; ?>
                        <?php } else { ?>
                        <input type="checkbox" name="article_store[]" value="<?php echo $store['store_id']; ?>" />
                        <?php echo $store['name']; ?>
                        <?php } ?>
                      </label>
                    </div>
                    <?php } ?>
                  </div>
                </div>
              </div>

            </div>


          </div>
        </form>
      </div>
    </div>
  </div>
  <script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
$('#input-description<?php echo $language['language_id']; ?>').summernote({
	height: 300
});
<?php } ?>
//--></script> 
  <script type="text/javascript"><!--
$('.date').datetimepicker({
	pickTime: false
});

$('.time').datetimepicker({
	pickDate: false
});

$('.datetime').datetimepicker({
	pickDate: true,
	pickTime: true
});
//--></script> 
  <script type="text/javascript"><!--
$('#language a:first').tab('show');
//--></script></div>
<?php echo $footer; ?>