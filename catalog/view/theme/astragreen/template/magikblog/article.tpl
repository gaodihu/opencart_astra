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
      <?php $class = 'col-main col-sm-9 col-xs-12 bounceInUp animated'; ?>
      <?php } else { ?>
      <?php $class = 'col-sm-12'; ?>
      <?php } ?>
      <div id="content" class="<?php echo $class; ?> mgk-blog">
      	<div class="page-title"><h2><?php echo $heading_title;?></h2></div>
      	<?php echo $content_top; ?>

	<div id="main" class="row blog-wrapper">
	    <div class="col-sm-12">
	    <?php if($articles) { ?>

	    <div id="primary" class="site-content">
	    	<div id="content" role="main">
		<?php foreach($articles as $_articles) { ?>
				
				<article class="blog_entry clearfix wow bounceInUp animated">
					<header class="blog_entry-header clearfix">
						<div class="blog_entry-header-inner">
							<h2 class="blog_entry-title">
							<a href="<?php echo $_articles['href'];?>" rel="bookmark"><?php echo $_articles['name'];?></a>
							</h2>
						</div>
					</header>

					<div class="entry-content">
						<div class="featured-thumb">
							<a title="<?php echo $_articles['name'];?>" href="<?php echo $_articles['href'];?>">
							<img src="<?php echo $_articles['thumb'];?>" alt="<?php echo $_articles['name'];?>" title="<?php echo $_articles['name'];?>">
							</a>
						</div><!-- featured-thumb -->

						<div class="entry-content">
							<p><?php echo $_articles['description'];?></p>
						</div><!-- entry-content -->
					
					<p>
						<a class="btn" href="<?php echo $_articles['href'];?>"><?php echo $text_read_more;?></a>
					</p>

					<?php if ($tag_status) {
					if( !empty($_articles['articletags']) ) { ?>
					<div class="blog-tags">
					<b><?php echo $this->language->get('text_tags');?></b>
					<?php foreach( $_articles['articletags'] as $tag => $tagLink ) { ?>
					<code><a href="<?php echo $tagLink; ?>" title="<?php echo $tag; ?>"><?php echo $tag; ?></a></code>
					<?php } ?>
					</div>
					<?php }
					} ?>


					</div><!-- entry-content -->

					<div class="entry-meta">
					<?php echo $publish_at_title;?>
					
					
					<time class="entry-date" datetime="2014-07-10T06:53:43+00:00"><?php $mgkpublish_date = strtotime( $_articles['publish_date'] );
				echo $mysqldate = date( 'M d, Y', $mgkpublish_date );?></time>
					.
					</div>

				</article>

		<?php } ?>
		    </div><!-- <div id="content" role="main"> -->
		</div>
		      
		<div class="row">
		  <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
		  <div class="col-sm-6 text-right"><?php echo $results; ?></div>
		</div>
	    <?php }  else { ?><h4><?php echo $text_no_pq_found;?></h4><?php } ?>
	    </div>
	</div>

	<?php echo $content_bottom; ?>
      </div>
      <?php echo $column_right; ?>
   		</div><!-- row -->
	</div><!-- main container -->
</div><!-- main-container col2-right-layout -->

<?php echo $footer; ?>