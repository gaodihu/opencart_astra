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
  <?php if ($success) { ?>
  <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
    <button type="button" class="close" data-dismiss="alert">&times;</button>
  </div>
  <?php } ?>
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?> col-main"><?php echo $content_top; ?>
      <div class="page-title"><h2><?php echo $heading_title; ?></h2></div>
      <?php if ($products) { ?>
      <div class="table-responsive">
      <table class="table table-bordered table-hover">
        <thead>
          <tr>
            <td class="text-center"><?php echo $column_image; ?></td>
            <td class="text-left"><?php echo $column_name; ?></td>
            <td class="text-left"><?php echo $column_model; ?></td>
            <td class="text-right"><?php echo $column_stock; ?></td>
            <td class="text-right"><?php echo $column_price; ?></td>
            <td class="text-right"><?php echo $column_action; ?></td>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($products as $product) { ?>
          <tr>
            <td class="text-center"><?php if ($product['thumb']) { ?>
              <a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
              <?php } ?></td>
            <td class="text-left"><a class="wishlist-title" href="<?php echo $product['href']; ?>"><b><?php echo $product['name']; ?></b></a></td>
            <td class="text-left"><?php echo $product['model']; ?></td>
            <td class="text-right"><?php echo $product['stock']; ?></td>
            <td class="text-right"><?php if ($product['price']) { ?>
              <div class="price">
                <?php if (!$product['special']) { ?>
                <?php echo $product['price']; ?>
                <?php } else { ?>
                <b><?php echo $product['special']; ?></b> <s><?php echo $product['price']; ?></s>
                <?php } ?>
              </div>
              <?php } ?></td>
            <td class="text-right"><button type="button" onclick="cart.add('<?php echo $product['product_id']; ?>');" data-toggle="tooltip" title="<?php echo $button_cart; ?>" class="button"><i class="fa fa-shopping-cart"></i></button>
              <a href="<?php echo $product['remove']; ?>" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class=""><button class="button"><i class="fa fa-times"></i></button></a></td>
          </tr>
          <?php } ?>
        </tbody>
      </table>
    </div><!-- table-responsive -->
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <?php } ?>
      <div class="buttons clearfix">
        <div class="pull-right"><a href="<?php echo $continue; ?>"><button class="button continue"><?php echo $button_continue; ?></button></a></div>
      </div>
      </div>
    <?php echo $column_right; ?></div>
</div><?php echo $content_bottom; ?>
</div>
<script type="text/javascript">
 $('#column-right').attr('class','col-sm-3 col-xs-12 sidebar');
</script>
<?php echo $footer; ?>