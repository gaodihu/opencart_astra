<?php echo $header; global $config; ?>
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
<div class="container">
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
      <?php if ($products) { ?>
      <div class="toolbar">
        <div class="sorter">
          <div class="view-mode">
            <button type="button" id="grid-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_grid; ?>"><i class="fa fa-th"></i></button>
            <button type="button" id="list-view" class="btn btn-default" data-toggle="tooltip" title="<?php echo $button_list; ?>"><i class="fa fa-th-list"></i></button>
            
            <a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a>
          </div>
        </div>

        <div id="sort-by">
          <label class="left"><?php echo $text_sort; ?></label>
          <select id="input-sort" class="form-control" onchange="location = this.value;">
            <?php foreach ($sorts as $sorts) { ?>
            <?php if ($sorts['value'] == $sort . '-' . $order) { ?>
            <option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
        </div>

        <div class="pager">
          <div id="limiter">
            <label><?php echo $text_limit; ?></label>
            <select id="input-limit" class="form-control" onchange="location = this.value;">
            <?php foreach ($limits as $limits) { ?>
            <?php if ($limits['value'] == $limit) { ?>
            <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
            <?php } else { ?>
            <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
            <?php } ?>
            <?php } ?>
          </select>
          </div>
        </div>


      </div><!-- toolbar -->

      <div class="row">
        <?php foreach ($products as $product) { ?>
         <div class="product-layout product-list col-xs-12">
          <div class="product-thumb col-item">
              
            <div class="image item-img">
            
              <div class="item-img-info"> 
              <a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>" class="product-image"> 
              <?php if ($product['thumb']) { ?>  
              <img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>"> 
              <?php } ?>
              </a>

              <?php if($config->get('magikastra_sale_label')==1) { 
              if ($product['price'] && $product['special']) { ?>
              <div class="sale-label sale-top-right">
              <?php echo $config->get('magikastra_sale_labeltitle'); ?>
              </div>
              <?php } } ?>

              <?php if($this->config->get('magikastra_quickview_button') == 1) { ?>
              <div class="item-box-hover">
              <div class="box-inner">
              <div class="product-detail-bnt"><a onclick="callQuickView('index.php?route=product/quickview&amp;product_id=<?php echo $product['product_id']; ?>');" title="<?php echo $text_quickview; ?>" class="button detail-bnt"><span><?php echo $text_quickview; ?></span></a></div>
              </div>
              </div>
              <?php } ?>

              </div>

            </div>


            <div class="item-info">
              <div class="caption info-inner">
                <div class="item-title"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
                 <div class="pro-desc"><p><?php echo $product['description']; ?></p></div> 
                
                        <div class="item-content">
                          <?php //if ($product['rating']) { ?>
                          <div class="rating">
                          <div class="ratings">
                          <div class="rating-box">
                          <?php for ($i = 1; $i <= 5; $i++) { ?>
                          <?php if ($product['rating'] < $i) { ?>
                          <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                          <?php } else { ?>
                          <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                          <?php } ?>
                          <?php } ?>
                          </div>
                          </div>
                          </div><!-- rating -->
                          <?php // }?>

                          <?php if ($product['price']) { ?>
                          <div class="item-price">
                          <div class="price-box"> 
                          <?php if (!$product['special']) { ?>
                          <span class="regular-price"><span class="price"><?php echo $product['price']; ?></span></span> 
                          <?php } else { ?>
                          <span class="old-price"><span class="price"><?php echo $product['price']; ?></span></span> 
                          <span class="special-price"><span class="price"><?php echo $product['special']; ?></span></span> 
                          <?php } ?>
                          <?php /* if ($product['tax']) { ?>
                          <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
                          <?php } */?>
                          </div>
                          </div>
                          <?php } ?>

                        </div><!--item-content--> 
              </div><!-- info-inner -->

                        <div class="actions">
                        <span class="add-to-links"> 
                        <a onclick="wishlist.add('<?php echo $product['product_id']; ?>');" class="link-wishlist" title="<?php echo $button_wishlist; ?>"><span><?php echo $button_wishlist; ?></span></a>
                        <button onclick="cart.add('<?php echo $product['product_id']; ?>');" title="<?php echo $button_cart; ?>" class="button btn-cart"><span><?php echo $button_cart; ?></span></button>
                        <a onclick="compare.add('<?php echo $product['product_id']; ?>');" class="link-compare" title="<?php echo $button_compare; ?>"><span><?php echo $button_compare; ?></span></a>
                        </span>
                        </div><!-- actions -->

            </div><!-- item-info -->
          </div>
        </div>
        <?php } ?>
      </div>


      <div class="row">
        <div class="bottom_pagination">
        <div class="col-sm-6 text-left"><?php echo $pagination; ?></div>
        <div class="col-sm-6 text-right"><?php echo $results; ?></div>
        </div>
      </div>
        

        
      <?php } else { ?>
      <p><?php echo $text_empty; ?></p>
      <div class="buttons">
        <div class="pull-right"><a href="<?php echo $continue; ?>"><button class="button"><?php echo $button_continue; ?></button></a></div>
      </div>
      <?php } ?>
      </div>
    <?php echo $column_right; ?></div>
</div><?php echo $content_bottom; ?></div>
<?php echo $footer; ?>