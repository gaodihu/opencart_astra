<?php echo $header; ?>


  <div class="breadcrumbs breadcrumb">
  <div class="container">
  <div class="row">

    <ul>
    <?php $b_i=0; $b_cnt=count($breadcrumbs); foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><?php if($b_i!=0) {?><span>—› </span><?php } ?>
      <?php if($b_i==($b_cnt-1)){ ?>
      <strong><?php echo $breadcrumb['text']; ?></strong><?php } 
      else { ?>
      <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php }?>
    </li>
    <?php $b_i++ ;} ?>
  </ul>
  
  </div>
  </div>
  </div>


<div class="main-container col2-right-layout">
<div class="main container">

  <div class="row"><?php echo $column_left; ?>
      <?php if ($column_left && $column_right) { ?>
      <?php $class = 'col-sm-6'; ?>
      <?php } elseif ($column_left || $column_right) { ?>
      <?php $class = 'col-main col-sm-9 col-xs-12 wow bounceInUp animated'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php } ?>
      <div id="content" class="<?php echo $class; ?>">
		<div class="page-title">
		<h2><?php echo $heading_title;?></h2>
		</div>
      	<?php echo $content_top; ?>
	<div id="main" class="blog-wrapper">
	    <div id="primary" class="site-content">
	    	<div id="content" role="main">


	    		<article class="blog_entry clearfix">
				<?php if($articledetail) { ?>
				
					<header class="blog_entry-header clearfix">
						<div class="blog_entry-header-inner">
						<h2 class="blog_entry-title"> <?php echo $articledetail['name'];?> </h2>
						</div>
					</header>

				<div class="entry-content">
					<div class="featured-thumb">
						<img src="<?php echo $articledetail['thumb'];?>" alt="<?php echo $articledetail['name'];?>" titile="<?php echo $articledetail['name'];?>">
					</div>
					<div class="entry-content">
						<?php echo $articledetail['description'];?>
					</div>
				</div>

				<?php if ($tag_status) {
				if( !empty($articletags) ) { ?>
				<div class="blog-tags">
				<b><?php echo $this->language->get('text_tags');?></b>
				<?php foreach( $articletags as $tag => $tagLink ) { ?>
				<code><a href="<?php echo $tagLink; ?>" title="<?php echo $tag; ?>"><?php echo $tag; ?></a></code>
				<?php } ?>
				</div>
				<?php }
				} ?>

				<div class="entry-meta">
					<?php echo $publish_at_title;?>
					<time class="entry-date"><?php $mgkpublish_date = strtotime( $articledetail['publish_date'] );
			    echo $mysqldate = date( 'M d, Y', $mgkpublish_date );?></time>
				</div>
				
				<?php }  else { ?><h4><?php echo $text_no_pq_found;?></h4><?php } ?>
	    		</article>

		 <div class="comment-content wow bounceInUp animated"> 
		 	<div id="review"></div>

		<div class="comments-form-wrapper clearfix">
			
		    <?php if ($review_status) { ?>
		    
		    <form class="form-horizontal comment-form" id="form-review">
		      
		      <h3><?php echo $text_write; ?></h3>
		      <?php  if ($review_guest) { ?>


			<div class="field">
			<label for="name">
			<?php echo $entry_name; ?>
			<em class="required">*</em>
			</label>
			 <input type="text" name="name" value="" id="input-name" class="form-control input-text" />
			</div>

			<div class="clear"></div>

			<div class="field aw-blog-comment-area">
                        <label for="comment"><?php echo $text_comment; ?><em class="required">*</em></label>
                        <textarea name="text" cols="50" rows="5" id="input-review" class="form-control input-text"></textarea>
			  			<div class="help-block"><?php echo $text_note; ?></div>
            </div>

            
	      <div class="field">
			
			  <label class=""><?php echo $entry_rating; ?><em class="required">*</em></label>
			  &nbsp;&nbsp;&nbsp; <?php echo $entry_bad; ?>&nbsp;
			  <input type="radio" name="rating" value="1" class="input-text"/>
			  &nbsp;
			  <input type="radio" name="rating" value="2" class="input-text"/>
			  &nbsp;
			  <input type="radio" name="rating" value="3" class="input-text"/>
			  &nbsp;
			  <input type="radio" name="rating" value="4" class="input-text"/>
			  &nbsp;
			  <input type="radio" name="rating" value="5" class="input-text"/>
			  &nbsp;<?php echo $entry_good; ?>

		      </div> 


		      <?php if ($site_key) { ?>
			<div class="field">
			  <div class="col-sm-12">
			    <div class="g-recaptcha" data-sitekey="<?php echo $site_key; ?>"></div>
			  </div>
			</div>
		      <?php } ?>
		      <div class="buttons clearfix">
			<div>
			  <button type="button" id="button-review" data-loading-text="<?php echo $text_loading; ?>" class="bnt-comment"><span><?php echo $button_continue; ?></span></button>
			</div>
		      </div>
		      <?php } else { ?>
		      <?php echo $text_login; ?>
		      <?php } ?>
		    </form>
		    <?php }  ?> 
		</div><!-- comments-form-wrapper clearfix -->
		</div><!-- comment-content wow bounceInUp animated animated -->

	       </div><!-- <div id="content" role="main"> -->
	    </div><!-- <div id="primary" class="site-content"> -->
	</div><!-- <div id="main" class="blog-wrapper"> -->
	<?php echo $content_bottom; ?>
      </div>
      <?php echo $column_right; ?>
   </div>
</div>
</div><!-- main-container col2-right-layout -->
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=magikblog/article/review&mgkblogarticle_id=<?php echo $mgkblogarticle_id; ?>');

$('#button-review').on('click', function() {
	$.ajax({
		url: 'index.php?route=magikblog/article/write&mgkblogarticle_id=<?php echo $mgkblogarticle_id; ?>',
		type: 'post',
		dataType: 'json',
		data: $("#form-review").serialize(),
		beforeSend: function() {
			$('#button-review').button('loading');
		},
		complete: function() {
			$('#button-review').button('reset');
		},
		success: function(json) {
			$('.alert-success, .alert-danger').remove();

			if (json['error']) {
				$('#review').after('<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> ' + json['error'] + '</div>');
			}

			if (json['success']) {
				$('#review').after('<div class="alert alert-success"><i class="fa fa-check-circle"></i> ' + json['success'] + '</div>');

				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').prop('checked', false);
			}
		}
	});
});
</script>
<?php echo $footer; ?>