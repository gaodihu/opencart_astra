<?php global $config;
$facebookurl=$config->get('magikastra_fb');
$twitterurl=$config->get('magikastra_twitter');
$gplusurl=$config->get('magikastra_gglplus');
$rssurl=$config->get('magikastra_rss');
$pintresturl=$config->get('magikastra_pinterest');
$linkedinurl=$config->get('magikastra_linkedin');
$youtubeurl=$config->get('magikastra_youtube');
?>
<footer class="footer bounceInUp animated">
  <?php if($manufacturers) { ?>
<div class="brand-logo">
  <div class="container">
      <div class="slider-items-products">
          <div id="brand-logo-slider" class="product-flexslider hidden-buttons">
            <div class="slider-items slider-width-col6"> 
              <?php foreach ($manufacturers as $_manufacturer) { ?>
              <!-- Item -->
              <div class="item"> 
                <a href="<?php echo str_replace('&', '&amp;', $_manufacturer['href']); ?>">
                  <img src="<?php echo $_manufacturer['manufacturer_image']?>" alt="<?php echo $_manufacturer['name']?>">
                </a>
              </div>
              <!-- End Item -->
              <?php }?>
            </div><!-- slider-items slider-width-col6 -->
          </div><!-- brand-logo-slider -->
      </div><!-- slider-items-products -->
  </div><!-- container -->
</div><!-- brand-logo -->
<?php } ?>

<div class="footer-top">
    <div class="container">
      <div class="row">
        <div class="col-xs-12">
          <div class="block-subscribe">
            <div class="newsletter">
                  <?php if($config->get('newslettersubscription_status')==1) {
                      echo $newslettersubscription; } ?>
            </div>
          </div>
        </div>
      </div>
    </div>

</div><!-- footer-top -->

<div class="footer-middle">
    <div class="container">
      <div class="row">
          <div class="col-md-3 col-sm-4 footer-column-1">
            <?php if($config->get('magikastra_footer_cb')==1){ ?>
            <div class="footer-logo">
            <?php echo html_entity_decode($config->get('magikastra_footer_cbcontent'));?>
            </div>
            <?php } ?>
            
            <?php // echo $text_contact; ?>
            <div class="contacts-info">

            <?php if ($config->get('magikastra_address')) { ?>
            <address>
            <i class="add-icon"></i><?php echo $config->get('magikastra_address'); ?>
            </address>

            <?php if ($config->get('magikastra_phone')) { ?>
            <div class="phone-footer">
            <i class="phone-icon"></i><?php echo $config->get('magikastra_phone'); ?>
            </div>
            <?php } ?>

            <?php if ($config->get('magikastra_email')){ ?>  
            <div class="email-footer">
            <i class="email-icon"> </i>
            <a href="mailto:<?php echo $config->get('magikastra_email'); ?>"><?php echo $config->get('magikastra_email'); ?></a>
            </div>
            <?php } ?>

            <?php } ?>
            </div>

          </div>

          <div class="col-md-2 col-sm-4">
            <?php if ($informations) { ?>
            <h4><?php echo $text_information; ?></h4>
            <ul class="links">
            <?php $i=0;$cnt=count($informations); foreach ($informations as $information) { ?>
            <li class="<?php if($i==0){echo 'first';} if($i==$cnt){echo 'last';} ?>"><a href="<?php echo $information['href']; ?>"><?php echo $information['title']; ?></a></li>
            <?php $i++;} ?>
            </ul>
            <?php } ?>  
          </div>

          <div class="col-md-2 col-sm-4">
            <h4><?php echo $text_service; ?></h4>
            <ul class="links">
            <li class="first"><a href="<?php echo $contact; ?>"><?php echo $text_contact; ?></a></li>
            <li><a href="<?php echo $return; ?>"><?php echo $text_return; ?></a></li>
            <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
            <li><a href="<?php echo $order; ?>"><?php echo $text_order; ?></a></li>
            <li><a href="<?php echo $sitemap; ?>"><?php echo $text_sitemap; ?></a></li>
            <li class="last"><a href="<?php echo $account; ?>" title="<?php echo $text_account; ?>"><?php echo $text_account; ?></a></li>
            </ul> 
          </div>

          <div class="col-md-2 col-sm-4">
            <div class="info-line">  
            <h4><?php echo $text_extra; ?></h4>
            <ul class="links">
            <li class="first"><a href="<?php echo $manufacturer; ?>"><?php echo $text_manufacturer; ?></a></li>
            <li><a href="<?php echo $voucher; ?>"><?php echo $text_voucher; ?></a></li>
            <li><a href="<?php echo $affiliate; ?>"><?php echo $text_affiliate; ?></a></li>
            <li><a href="<?php echo $wishlist; ?>"><?php echo $text_wishlist; ?></a></li>
            <?php if($this->config->get('magikblog_status')==1) {    ?>
            <li><a href="<?php echo $blog; ?>"><?php echo $text_blog; ?></a></li>
            <?php } ?>
            <li class="last"><a href="<?php echo $special; ?>"><?php echo $text_special; ?></a></li>
            </ul>
            </div>
          </div>

          <div class="col-md-3 col-sm-4">
              <div class="social">
              <?php if($facebookurl!='' || $twitterurl!='' || $gplusurl!='' || $rssurl!='' || $pintresturl!='' || $linkedinurl!='' || $youtubeurl!='') { ?>
              <h4><?php echo $text_follow_us;?></h4>
              <?php } ?>
              <ul class="link">
              <?php if($facebookurl!='') { ?>
              <li class="fb pull-left"><a href="<?php echo $facebookurl; ?>" target="_blank"></a></li>
              <?php } ?>
              <?php if($twitterurl!='') { ?>
              <li class="tw pull-left"><a href="<?php echo $twitterurl; ?>" target="_blank"></a></li>
              <?php } ?>
              <?php if($gplusurl!='') { ?>
              <li class="googleplus pull-left"><a href="<?php echo $gplusurl; ?>" target="_blank"></a></li>
              <?php } ?>
              <?php if($rssurl!='') { ?>
              <li class="rss pull-left"><a href="<?php echo $rssurl; ?>" target="_blank"></a></li>
              <?php } ?>
              <?php if($pintresturl!='') { ?>
              <li class="pintrest pull-left"><a href="<?php echo $pintresturl; ?>" target="_blank"></a></li>
              <?php } ?>
              <?php if($linkedinurl!='') { ?>
              <li class="linkedin pull-left"><a href="<?php echo $linkedinurl; ?>" target="_blank"></a></li>
              <?php } ?>
              <?php if($youtubeurl!='') { ?>
              <li class="youtube pull-left"><a href="<?php echo $youtubeurl; ?>" target="_blank"></a></li>
              <?php } ?>
              </ul>
              </div>

              <div class="payment-accept">
              <h4><?php echo $text_we_accept;?></h4>
              <div>
              <img alt="payment1" src="catalog/view/theme/astragrey/image/payment-1.png"> 
              <img alt="payment2" src="catalog/view/theme/astragrey/image/payment-2.png"> 
              <img alt="payment3" src="catalog/view/theme/astragrey/image/payment-3.png"> 
              <img alt="payment4" src="catalog/view/theme/astragrey/image/payment-4.png">
              </div>
              </div>
          </div>
      </div>
    </div>
</div><!-- footer-middle -->

<div class="footer-bottom">
  <div class="container">
  <div class="row">   
      <div class="col-xs-12 coppyright">
      <?php
        if(trim($config->get('magikastra_powerby')) != '') {
          echo html_entity_decode($config->get('magikastra_powerby'));
        } else {
          echo $powered;
        }
      ?>
      </div>  
  </div>
  </div>
</div><!-- footer-bottom -->

</footer>

<?php if($config->get('magikastra_scroll_totop')!=1) { ?>
<script type="text/javascript">
$(window).load(function() {
$('body #toTop').remove();
});
</script>
<?php }?>

<!--
OpenCart is open source software and you are free to remove the powered by OpenCart if you want, but its generally accepted practise to make a small donation.
Please donate via PayPal to donate@opencart.com
//-->

<!-- Theme created by Welford Media for OpenCart 2.0 www.welfordmedia.co.uk -->

</body></html>