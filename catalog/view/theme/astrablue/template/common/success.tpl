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


<div class="main-container col2-right-layout wow bounceInUp animated">
  <div class="main container">
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?> col-main"><?php echo $content_top; ?>
      <div class="page-title"><h1><?php echo $heading_title; ?></h1></div>
      <?php echo $text_message; ?>
      <div class="buttons">
        <div class=""><a href="<?php echo $continue; ?>" class=""><button class="button continue"><?php echo $button_continue; ?></button></a></div>
      </div>
      </div>
    <?php echo $column_right; ?></div>
</div>
</div><?php echo $content_bottom; ?>
<script type="text/javascript">
 $('#column-right').attr('class','col-sm-3 sidebar');
</script>
<?php echo $footer; ?>