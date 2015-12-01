  <?php global $config;?>
    <div class="middle-slider container">
      <div class="row">
        <div class="col-md-12">
          <div class="bag-product-slider small-pr-slider wow bounceInUp animated">
            <div class="slider-items-products">
                <div class="new_title center">
                <h2><?php echo $category_name1; ?></h2>
                </div>

                <div id="bag-slider" class="product-flexslider hidden-buttons">
                  <?php if($categorywise_products1){ ?>
                  <div class="slider-items slider-width-col3"> 
                       <?php  foreach ($categorywise_products1 as $product) { ?>
                      <!-- Item -->
                      <div class="item">
                      <div class="col-item">

                      <div class="item-img">
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
                      <div class="info-inner">
                        
                        <div class="item-title">
                        <a title="<?php echo $product['name']; ?>" href="<?php echo $product['href']; ?>"> 
                        <?php echo $pro_name = (strlen($product['name'])>20) ? substr($product['name'], 0,20).'...' : $product['name']; ?>
                        </a>
                        </div><!--item-title-->

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

                      </div><!-- item-infor -->

                      </div><!-- col-item -->
                      </div><!-- item -->
                       <?php } ?>
                  </div><!-- slider-items slider-width-col3 -->
                  <?php } else { ?>
                  <?php echo $no_product_found; ?>
                  <?php }?>
                </div><!-- bag-slider -->
            </div><!-- slider-items-products -->
          </div><!-- bag-product-slider small-pr-slider wow bounceInUp animated -->
        </div>
      </div>
    </div>