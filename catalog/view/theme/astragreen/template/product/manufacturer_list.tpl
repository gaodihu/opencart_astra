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


<div class="main-container col1-layout">
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
      <?php if ($categories) { ?>
      <p><strong><?php echo $text_index; ?></strong>
        <?php foreach ($categories as $category) { ?>
        &nbsp;&nbsp;&nbsp;<a href="index.php?route=product/manufacturer#<?php echo $category['name']; ?>"><?php echo $category['name']; ?></a>
        <?php } ?>
      </p>
      <?php foreach ($categories as $category) { ?>
      <h2 id="<?php echo $category['name']; ?>"><?php echo $category['name']; ?></h2>
      <?php if ($category['manufacturer']) { ?>
      <?php foreach (array_chunk($category['manufacturer'], 4) as $manufacturers) { ?>
      <div class="row">
        <?php foreach ($manufacturers as $manufacturer) { ?>
        <div class="col-sm-3"><a href="<?php echo $manufacturer['href']; ?>"><?php echo $manufacturer['name']; ?></a></div>
        <?php } ?>
      </div>
      <?php } ?>
      <?php } ?>
      <?php } ?>
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons clearfix">
        <div class="pull-right"><a href="<?php echo $continue; ?>" class="btn btn-primary"><?php echo $button_continue; ?></a></div>
      </div>
      <?php } ?>
      </div>
    <?php echo $column_right; ?></div>
</div>
</div><?php echo $content_bottom; ?>
</div>
<?php echo $footer; ?>