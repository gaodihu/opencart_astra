<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>

<script src="catalog/view/javascript/jquery/magnific/jquery.magnific-popup.min.js" type="text/javascript"></script>
<script src="catalog/view/javascript/jquery/datetimepicker/moment.js" type="text/javascript"></script>
<script src="catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.js" type="text/javascript"></script>

<link href="catalog/view/javascript/jquery/magnific/magnific-popup.css" rel="stylesheet">
<link href="catalog/view/javascript/jquery/datetimepicker/bootstrap-datetimepicker.min.css" rel="stylesheet">

<!-- <script src="catalog/view/theme/astrared/js/common1.js" type="text/javascript"></script> -->
<script src="catalog/view/theme/astrared/js/cloudzoom.js" type="text/javascript"></script>

<script src="catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/owl-carousel/owl.carousel.css">

<link href="catalog/view/theme/astrared/js/fancybox/jquery.fancybox.css" rel="stylesheet">
<script src="catalog/view/theme/astrared/js/fancybox/jquery.fancybox.js" type="text/javascript"></script>
<script type="text/javascript">
jQuery(document).ready(function(){
  jQuery("#more-views-slider1 .slider-items").owlCarousel({
  autoplay : true,
  items : 3, //10 items above 1000px browser width
  itemsDesktop : [1024,2], //5 items between 1024px and 901px
  itemsDesktopSmall : [900,2], // 3 items betweem 900px and 601px
  itemsTablet: [600,2], //2 items between 600 and 0;
  itemsMobile : [320,1],
  navigation : true,
  navigationText : ["<a class=\"flex-prev\"></a>","<a class=\"flex-next\"></a>"],
  slideSpeed : 500,
  pagination : false
  });
});
  

</script>

<?php global $config;?>


<div class="magik-quickview">
        <div class="product-view">
          <div class="product-essential">
           

            <?php if ($thumb || $images) { ?>
<div class="product-img-box col-sm-4 col-xs-12 bounceInRight animated">
      
           <?php  if($config->get('magikinspire_sale_label')==1) { 
           if ($price && $special) { ?>
           <div class="sale-label new-top-left"><?php echo $config->get('magikinspire_sale_labeltitle'); ?></div>
           <?php } }  ?>

           <?php if ($thumb) { ?>
            <div class="product-image">
                    <div class="largeImg_wrap">
                      <div id="wrap" style="top:0px;z-index:700;position:relative;">
                        <a style="position: relative; display: block;" href="<?php echo $popup; ?>" class="cloud-zoom" id="zoom1" rel="position: 'inside'"> 
                          <img style="display: block;" src="<?php echo $popup; ?>" alt="" title=""> </a> 
                        </div>
                    </div>
            </div>
            <?php } ?>

            <?php if ($images || $thumb) { ?>
                  <div class="more-views">
                    <div class="slider-items-products">
                      <div id="more-views-slider1" class="product-flexslider hidden-buttons">
                        <div class="slider-items slider-width-col3"> 
                          
                          <?php if ($thumb) { ?>
                          <div class="item"> <a href="<?php echo $popup; ?>" class='cloud-zoom-gallery' rel="useZoom: 'zoom1', smallImage: '<?php echo $popup; ?>' "><img src="<?php echo $popup; ?>" alt="Image">
                          </a>
                          </div>
                          <?php } ?>
                          
                          <?php foreach ($images as $image) { ?>
                  <!-- Item -->
                  <div class="item"> <a href="<?php echo $image['popup']; ?>" class='cloud-zoom-gallery' rel="useZoom: 'zoom1', smallImage: '<?php echo $image['popup']; ?>' "><img src="<?php echo $image['popup']; ?>" alt="Image"></a> </div>
                  <!-- End Item -->  
                          <?php } ?>
                          
                        </div>
                      </div>
                    </div>
                  </div>
            <?php } ?>

            </div><!-- product-img-box col-lg-6 col-sm-6 col-xs-12 -->
            <?php } ?>
            
            <div class="product-shop col-sm-8 col-xs-12 bounceInUp animated">
              <div class="product-name">
              <h1><?php echo $heading_title; ?></h1>
              </div> 

              <?php if ($review_status) { ?>
              <div class="ratings">
                <div class="rating-box">
                  <div class="rating">
                  <?php for ($i = 1; $i <= 5; $i++) { ?>
                  <?php if ($rating < $i) { ?>
                  <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-1x"></i></span>
                  <?php } else { ?>
                  <span class="fa fa-stack"><i class="fa fa-star fa-stack-1x"></i><i class="fa fa-star-o fa-stack-1x"></i></span>
                  <?php } ?>
                  <?php } ?>
                  </div>
                </div>

               
              </div><!-- ratings -->
              <?php } ?>

              <p class="availability in-stock"><?php //echo $text_stock; ?><span><?php echo $stock; ?></span></p>
              
              <?php if ($price) { ?>
              <div class="price-block">
              <div class="price-box">
                <?php if (!$special) { ?>
                <p class="regular-price"><span class="price"><?php echo $price; ?></span></p>
                
                <?php } else {?>
                <p class="special-price"><span class="price"><?php echo $special; ?></span></p>
                  <p class="old-price"><span class="price"><?php echo $price; ?></span></p>
                  
                  
                  
                <?php } ?>
              </div>
              </div>
              
              <ul class="list-unstyled">
              <?php if ($tax) { ?>
              <li><?php echo $text_tax; ?> <?php echo $tax; ?></li>
              <?php } ?>
              <?php if ($points) { ?>
              <li><?php echo $text_points; ?> <?php echo $points; ?></li>
              <?php } ?>
              <?php if ($discounts) { ?>
              <li>
              <hr>
              </li>
              <?php foreach ($discounts as $discount) { ?>
              <li><?php echo $discount['quantity']; ?><?php echo $text_discount; ?><?php echo $discount['price']; ?></li>
              <?php } ?>
              <?php } ?>
              </ul>
              <?php } else {?>
              <p class="availability in-stock"><span><?php echo $stock; ?></span></p>
              <?php } ?>
              

             

              <ul class="list-unstyled">
              <?php if ($manufacturer) { ?>
              <li><?php echo $text_manufacturer; ?> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a></li>
              <?php } ?>
              <li><?php echo $text_model; ?> <?php echo $model; ?></li>
              <?php if ($reward) { ?>
              <li><?php echo $text_reward; ?> <?php echo $reward; ?></li>
              <?php } ?>
              <!-- <li><?php //echo $text_stock; ?> <?php //echo $stock; ?></li> -->
              </ul>

              <div id="product">
              <?php if ($options) { ?>
              <hr>
              <h3><?php echo $text_option; ?></h3>
              <?php foreach ($options as $option) { ?>
              <?php if ($option['type'] == 'select') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <select name="option[<?php echo $option['product_option_id']; ?>]" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($option['product_option_value'] as $option_value) { ?>
              <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
              <?php if ($option_value['price']) { ?>
              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
              <?php } ?>
              </option>
              <?php } ?>
              </select>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'radio') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
              <?php foreach ($option['product_option_value'] as $option_value) { ?>
              <div class="radio">
              <label>
              <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
              <?php echo $option_value['name']; ?>
              <?php if ($option_value['price']) { ?>
              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
              <?php } ?>
              </label>
              </div>
              <?php } ?>
              </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'checkbox') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
              <?php foreach ($option['product_option_value'] as $option_value) { ?>
              <div class="checkbox">
              <label>
              <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" />
              <?php echo $option_value['name']; ?>
              <?php if ($option_value['price']) { ?>
              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
              <?php } ?>
              </label>
              </div>
              <?php } ?>
              </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'image') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <div id="input-option<?php echo $option['product_option_id']; ?>">
              <?php foreach ($option['product_option_value'] as $option_value) { ?>
              <div class="radio">
              <label>
              <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" />
              <img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" class="img-thumbnail" /> <?php echo $option_value['name']; ?>
              <?php if ($option_value['price']) { ?>
              (<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
              <?php } ?>
              </label>
              </div>
              <?php } ?>
              </div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'text') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'textarea') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <textarea name="option[<?php echo $option['product_option_id']; ?>]" rows="5" placeholder="<?php echo $option['name']; ?>" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control"><?php echo $option['value']; ?></textarea>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'file') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label"><?php echo $option['name']; ?></label>
              <button type="button" id="button-upload<?php echo $option['product_option_id']; ?>" data-loading-text="<?php echo $text_loading; ?>" class="btn btn-default btn-block"><i class="fa fa-upload"></i> <?php echo $button_upload; ?></button>
              <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" id="input-option<?php echo $option['product_option_id']; ?>" />
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'date') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group date">
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
              <span class="input-group-btn">
              <button class="btn btn-default" type="button"><i class="fa fa-calendar"></i></button>
              </span></div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'datetime') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group datetime">
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="YYYY-MM-DD HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
              <span class="input-group-btn">
              <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
              </span></div>
              </div>
              <?php } ?>
              <?php if ($option['type'] == 'time') { ?>
              <div class="form-group<?php echo ($option['required'] ? ' required' : ''); ?>">
              <label class="control-label" for="input-option<?php echo $option['product_option_id']; ?>"><?php echo $option['name']; ?></label>
              <div class="input-group time">
              <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['value']; ?>" data-date-format="HH:mm" id="input-option<?php echo $option['product_option_id']; ?>" class="form-control" />
              <span class="input-group-btn">
              <button type="button" class="btn btn-default"><i class="fa fa-calendar"></i></button>
              </span></div>
              </div>
              <?php } ?>
              <?php } ?>
              <?php } ?>
              <?php if ($recurrings) { ?>
              <hr>
              <h3><?php echo $text_payment_recurring ?></h3>
              <div class="form-group required">
              <select name="recurring_id" class="form-control">
              <option value=""><?php echo $text_select; ?></option>
              <?php foreach ($recurrings as $recurring) { ?>
              <option value="<?php echo $recurring['recurring_id'] ?>"><?php echo $recurring['name'] ?></option>
              <?php } ?>
              </select>
              <div class="help-block" id="recurring-description"></div>
              </div>
              <?php } ?>
<!--               <div class="form-group">
              <label class="control-label" for="input-quantity"><?php //echo $entry_qty; ?></label>
              <input type="text" name="quantity" value="<?php //echo $minimum; ?>" size="2" id="input-quantity" class="form-control" />
              <input type="hidden" name="product_id" value="<?php //echo $product_id; ?>" />
              <br />
              <button type="button" id="button-cart" data-loading-text="<?php //echo $text_loading; ?>" class="btn btn-primary btn-lg btn-block"><?php //echo $button_cart; ?></button>
              </div> -->
              <?php if ($minimum > 1) { ?>
              <div class="alert alert-info"><i class="fa fa-info-circle"></i> <?php echo $text_minimum; ?></div>
              <?php } ?>
              

          <div class="add-to-box">
                       
            <div class="add-to-cart">
              <label class="control-label" for="input-quantity"><?php echo $entry_qty; ?></label>
              <div class="pull-left">
                <div class="custom pull-left">
                    
                    <button class="reduced items-count" onclick="var result = document.getElementById('qty'); var qty = result.value; if( !isNaN( qty ) && qty > 0 ) result.value--;return false;" type="button">
                    <i class="icon-minus"> </i>
                    </button>
                    
                    <input type="text" name="quantity" value="<?php echo $minimum; ?>" size="2" id="qty" class="input-text qty" maxlength="12"/>
                    

                    <button class="increase items-count" onclick="var result = document.getElementById('qty'); var qty = result.value; if( !isNaN( qty )) result.value++;return false;" type="button">
                    <i class="icon-plus"> </i>
                    </button>


                    <input type="hidden" name="product_id" value="<?php echo $product_id; ?>" />
                </div>
                </div> 

                <div class="pull-left">
                  <button type="button" id="button-cart" data-loading-text="<?php echo $text_loading; ?>" class="button btn-cart"><span><?php echo $button_cart; ?></span></button>
                </div>
              
            </div>
            
          <div class="email-addto-box">
          <ul class="add-to-links">
          <li><a class="link-wishlist" title="<?php echo $button_wishlist; ?>" onclick="wishlist.add('<?php echo $product_id; ?>');">
          <span><?php echo $button_wishlist; ?></span>
          </a></li>
          <li><a class="link-compare"  title="<?php echo $button_compare; ?>" onclick="compare.add('<?php echo $product_id; ?>');">
          <span><?php echo $button_compare; ?></span>
          </a></li>
          </ul>
          </div>

          </div>

</div>


            </div><!-- product-shop -->
            
            
            
        
          
          </div><!-- product essential -->

       

        </div><!-- product-view -->
</div>

<script type="text/javascript"><!--
$('select[name=\'recurring_id\'], input[name="quantity"]').change(function(){
  $.ajax({
    url: 'index.php?route=product/product/getRecurringDescription',
    type: 'post',
    data: $('input[name=\'product_id\'], input[name=\'quantity\'], select[name=\'recurring_id\']'),
    dataType: 'json',
    beforeSend: function() {
      $('#recurring-description').html('');
    },
    success: function(json) {
      $('.alert, .text-danger').remove();

      if (json['success']) {
        $('#recurring-description').html(json['success']);
      }
    }
  });
});
//--></script>
<script type="text/javascript"><!--
$('#button-cart').on('click', function() {
  var qty_val=$('#qty').val();
 if(qty_val==0)
 {
    alert("Select quantity.");
   
 }
 else
 {
  $.ajax({
    url: 'index.php?route=checkout/cart/add',
    type: 'post',
    data: $('#product input[type=\'text\'], #product input[type=\'hidden\'], #product input[type=\'radio\']:checked, #product input[type=\'checkbox\']:checked, #product select, #product textarea'),
    dataType: 'json',
    beforeSend: function() {
      $('#button-cart').button('loading');
    },
    complete: function() {
      $('#button-cart').button('reset');
    },
    success: function(json) {
      $('.alert, .text-danger').remove();
      $('.form-group').removeClass('has-error');

      if (json['error']) {
        if (json['error']['option']) {
          for (i in json['error']['option']) {
            var element = $('#input-option' + i.replace('_', '-'));

            if (element.parent().hasClass('input-group')) {
              element.parent().after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
            } else {
              element.after('<div class="text-danger">' + json['error']['option'][i] + '</div>');
            }
          }
        }

        if (json['error']['recurring']) {
          $('select[name=\'recurring_id\']').after('<div class="text-danger">' + json['error']['recurring'] + '</div>');
        }

        // Highlight any found errors
        $('.text-danger').parent().addClass('has-error');
      }

      if (json['success']) {
        $('.breadcrumbs').after('<div class="alert alert-success">' + json['success'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');

        var myarr = [];
        var myarr = json['total'].split(" ");
          $('#cart #cart-total').text(myarr['0']);
        
        //$('#cart .header > a ').html('<span id="cart-total">' + myarr['0'] + '</span>');
        $('#cart .header > a > span:last-child').text(myarr['0']);

        $('html, body').animate({ scrollTop: 0 }, 'slow');

        $('#cart > ul').load('index.php?route=common/cart/info ul li');
      }
    }
  });
}
});
//--></script>
<script type="text/javascript"><!--
$('.date').datetimepicker({
  pickTime: false
});

$('.datetime').datetimepicker({
  pickDate: true,
  pickTime: true
});

$('.time').datetimepicker({
  pickDate: false
});

$('button[id^=\'button-upload\']').on('click', function() {
  var node = this;

  $('#form-upload').remove();

  $('body').prepend('<form enctype="multipart/form-data" id="form-upload" style="display: none;"><input type="file" name="file" /></form>');

  $('#form-upload input[name=\'file\']').trigger('click');

  if (typeof timer != 'undefined') {
      clearInterval(timer);
  }

  timer = setInterval(function() {
    if ($('#form-upload input[name=\'file\']').val() != '') {
      clearInterval(timer);

      $.ajax({
        url: 'index.php?route=tool/upload',
        type: 'post',
        dataType: 'json',
        data: new FormData($('#form-upload')[0]),
        cache: false,
        contentType: false,
        processData: false,
        beforeSend: function() {
          $(node).button('loading');
        },
        complete: function() {
          $(node).button('reset');
        },
        success: function(json) {
          $('.text-danger').remove();

          if (json['error']) {
            $(node).parent().find('input').after('<div class="text-danger">' + json['error'] + '</div>');
          }

          if (json['success']) {
            alert(json['success']);

            $(node).parent().find('input').attr('value', json['code']);
          }
        },
        error: function(xhr, ajaxOptions, thrownError) {
          alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
        }
      });
    }
  }, 500);
});
//--></script>
<script type="text/javascript"><!--
$('#review').delegate('.pagination a', 'click', function(e) {
  e.preventDefault();

    $('#review').fadeOut('slow');

    $('#review').load(this.href);

    $('#review').fadeIn('slow');
});

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').on('click', function() {
  $.ajax({
    url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
    type: 'post',
    dataType: 'json',
    data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : ''),
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

$(document).ready(function() {
  $('.thumbnails').magnificPopup({
    type:'image',
    delegate: 'a',
    gallery: {
      enabled:true
    }
  });
});
//--></script>