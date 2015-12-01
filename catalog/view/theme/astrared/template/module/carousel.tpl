<div class="brand-logo wow bounceInUp animated">
    <div class="container">
      <div class="row">
      <div class="slider-items-products">
        <div id="brand-logo-slider<?php echo $module; ?>" class="product-flexslider hidden-buttons">
          <div class="slider-items slider-width-col6">
            
            <?php foreach ($banners as $banner) { ?>
            
            <?php if ($banner['link']) { ?>
            <!-- Item -->
            <div class="item"><a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></a> </div>
            <!-- End Item -->
            <?php } else { ?>
            <div class="item"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" class="img-responsive" /></div>
            <?php } ?>
            <?php } ?>

          </div><!-- slider-items slider-width-col6 -->
        </div>
      </div><!-- slider-items-products -->
      </div>

    </div><!-- container -->
  </div>

<script type="text/javascript"><!--
$("#brand-logo-slider<?php echo $module; ?> .slider-items").owlCarousel({
  autoplay : true,
  items : 6, //10 items above 1000px browser width
  itemsDesktop : [1024,4], //5 items between 1024px and 901px
  itemsDesktopSmall : [900,3], // 3 items betweem 900px and 601px
  itemsTablet: [600,2], //2 items between 600 and 0;
  itemsMobile : [320,1],
  navigation : true,
  navigationText : ["<a class=\"flex-prev\"></a>","<a class=\"flex-next\"></a>"],
  slideSpeed : 500,
  pagination : false      
});
--></script>