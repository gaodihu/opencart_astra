<?php echo $header; ?>
  <div class="breadcrumbs">
  <div class="container">
  <div class="row">
  <div class="col-xs-12">
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
  </div>

<div class="main-container wow bounceInUp animated">
  <div class="main container">
  <div class="col-main">
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?>"><?php echo $content_top; ?>
      <div class="page-title"><h2><?php echo $heading_title; ?></h2></div>
      <?php echo $description; ?></div>
    <?php echo $column_right; ?></div>
  </div>
</div>
</div><?php echo $content_bottom; ?>
<?php echo $footer; ?>