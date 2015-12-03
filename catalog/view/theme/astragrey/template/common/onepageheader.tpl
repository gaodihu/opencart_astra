<!DOCTYPE html>
<!--[if IE]><![endif]-->
<!--[if IE 8 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie8"><![endif]-->
<!--[if IE 9 ]><html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>" class="ie9"><![endif]-->
<!--[if (gt IE 9)|!(IE)]><!-->
<html dir="<?php echo $direction; ?>" lang="<?php echo $lang; ?>">
<!--<![endif]-->
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1">
<title><?php echo $title; ?></title>
<base href="<?php echo $base; ?>" />
<?php if ($description) { ?>
<meta name="description" content="<?php echo $description; ?>" />
<?php } ?>
<?php if ($keywords) { ?>
<meta name="keywords" content= "<?php echo $keywords; ?>" />
<?php } ?>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<?php if ($icon) { ?>
<link href="<?php echo $icon; ?>" rel="icon" />
<?php } ?>
<?php foreach ($links as $link) { ?>
<link href="<?php echo $link['href']; ?>" rel="<?php echo $link['rel']; ?>" />
<?php } ?>
<script src="catalog/view/javascript/jquery/jquery-2.1.1.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/bootstrap/css/bootstrap.min.css" rel="stylesheet" media="screen" />
<script src="catalog/view/javascript/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<link href="catalog/view/javascript/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<!-- external css/js -->
<link href="catalog/view/theme/astragrey/js/fancybox/jquery.fancybox.css" rel="stylesheet">
<script src="catalog/view/theme/astragrey/js/fancybox/jquery.fancybox.js" type="text/javascript"></script>
<!-- external css/js end-->

<!-- Google Fonts // magik theme-->
<link href='https://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,300,700,800,400,600' rel='stylesheet' type='text/css'>
<!-- end font -->

<link href="//fonts.googleapis.com/css?family=Open+Sans:400,400i,300,700" rel="stylesheet" type="text/css" />
<?php global $config; ?>

<?php // external CSS magik theme  ?>
<?php if($config->get('magikastra_animation_effect')==1){ ?>
<link href="catalog/view/theme/astragrey/stylesheet/animate.css" rel="stylesheet">
<?php } ?>
<link href="catalog/view/theme/astragrey/stylesheet/stylesheet.css" rel="stylesheet">
<link href="catalog/view/theme/astragrey/stylesheet/font-awesome.css" rel="stylesheet">

<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/owl-carousel/owl.carousel.css">
<link href="catalog/view/theme/astragrey/stylesheet/style.css" rel="stylesheet">
<?php // external css end?>

<?php foreach ($styles as $style) { ?>
<link href="<?php echo $style['href']; ?>" type="text/css" rel="<?php echo $style['rel']; ?>" media="<?php echo $style['media']; ?>" />
<?php } ?>
<!-- <script src="catalog/view/javascript/common.js" type="text/javascript"></script> -->

<?php // External js magik theme ?>
<script src="catalog/view/theme/astragrey/js/parallax.js" type="text/javascript"></script>
<script src="catalog/view/theme/astragrey/js/common.js" type="text/javascript"></script>
<script src="catalog/view/theme/astragrey/js/common1.js" type="text/javascript"></script>
<script src="catalog/view/theme/astragrey/js/cloudzoom.js" type="text/javascript"></script>
<script src="catalog/view/javascript/jquery/owl-carousel/owl.carousel.min.js" type="text/javascript"></script>
<?php // external js end?>

<?php foreach ($scripts as $script) { ?>
<script src="<?php echo $script; ?>" type="text/javascript"></script>
<?php } ?>
<?php echo $google_analytics; ?>
<style type="text/css">

<?php if($config->get('magikastra_fonttransform')!=''){?>
body {font-family:<?php echo $config->get('magikastra_fonttransform'); ?>, sans-serif !important ;}
<?php }?>

/* sale label */
.sale-label {background:<?php echo "#".$config->get('magikastra_sale_labelcolor'); ?>}

/*Main color section */
<?php if($config->get('magikastra_body_bg_ed')==1) { ?>
body {background:<?php echo "#".$config->get('magikastra_body_bg')."! important"; ?> } <?php } ?>
<?php if($config->get('magikastra_fontcolor_ed')==1) { ?>
body {color:<?php echo "#".$config->get('magikastra_fontcolor'); ?> } <?php } ?>
<?php if($config->get('magikastra_linkcolor_ed')==1) { ?>
a,a:visited {color:<?php echo "#".$config->get('magikastra_linkcolor'); ?>} <?php } ?>
<?php if($config->get('magikastra_linkhovercolor_ed')==1) { ?>
a:hover {color:<?php echo "#".$config->get('magikastra_linkhovercolor'); ?>} <?php } ?>


/* header color section */ 
<?php if($config->get('magikastra_headerbg_ed')==1) { ?>
header { background-color: <?php echo "#".$config->get('magikastra_headerbg')."! important"; ?>;} <?php } ?>
<?php if($config->get('magikastra_headerlinkcolor_ed')==1) { ?>
header .toplinks div.links div a{color:<?php echo "#".$config->get('magikastra_headerlinkcolor')."! important"; ?>;} <?php } ?>
<?php if($config->get('magikastra_headerlinkhovercolor_ed')==1) { ?>
header .toplinks div.links div a:hover{color:<?php echo "#".$config->get('magikastra_headerlinkhovercolor')."! important"; ?>;} <?php } ?>
<?php if($config->get('magikastra_headerclcolor_ed')==1) { ?>
.block-currency,.block-language{color:<?php echo "#".$config->get('magikastra_headerclcolor')."! important"; ?>;} <?php } ?>

/*Top Menu */
/*background*/
<?php if($config->get('magikastra_mmbgcolor_ed')==1) { ?>
nav { background:<?php echo "#".$config->get('magikastra_mmbgcolor')."! important"; ?> } <?php } ?>
/*main menu links*/
<?php if($config->get('magikastra_mmlinkscolor_ed')==1) { ?>
#nav > li > a{ color:<?php echo "#".$config->get('magikastra_mmlinkscolor'); ?>; } <?php } ?>
/*main menu link hover*/
<?php if($config->get('magikastra_mmlinkshovercolor_ed')==1) { ?>
#nav > li > a:hover:nth-child(1), #nav > li > a.active:nth-child(1){color:<?php echo "#".$config->get('magikastra_mmlinkshovercolor')."! important"; ?>} <?php } ?>
<?php if($config->get('magikastra_mmslinkscolor_ed')==1) { ?>
#nav ul.level0 > li > a{color:<?php echo "#".$config->get('magikastra_mmslinkscolor'); ?>} <?php } ?>
/*sub links hover*/
<?php if($config->get('magikastra_mmslinkshovercolor_ed')==1) { ?>
#nav ul li a:hover{color:<?php echo "#".$config->get('magikastra_mmslinkshovercolor'); ?> } <?php } ?> 

/*buttons*/
<?php if($config->get('magikastra_buttoncolor_ed')==1) { ?>
button.button,.btn,#cart .btn-checkout,#cart .view-cart{background-color:<?php echo "#".$config->get('magikastra_buttoncolor')."! important"; ?> } <?php } ?>
<?php if($config->get('magikastra_buttonhovercolor_ed')==1) { ?>
button.button:hover,.btn:hover,#cart .btn-checkout:hover,#cart .view-cart:hover{box-shadow: <?php echo "inset 0 -40px 0 0 #".$config->get('magikastra_buttonhovercolor')."! important"; ?>; border: <?php echo "2px solid #".$config->get('magikastra_buttonhovercolor')."! important"; ?>; }
<?php } ?>


/*price*/
<?php if($config->get('magikastra_pricecolor_ed')==1) { ?>
.regular-price .price{ color:<?php echo "#".$config->get('magikastra_pricecolor'); ?> } <?php } ?>
<?php if($config->get('magikastra_oldpricecolor_ed')==1) { ?>
.old-price .price{ color:<?php echo "#".$config->get('magikastra_oldpricecolor')."! important"; ?> } <?php } ?>
<?php if($config->get('magikastra_newpricecolor_ed')==1) { ?>
.special-price .price{ color:<?php echo "#".$config->get('magikastra_newpricecolor'); ?> } <?php } ?>

/*footer*/
<?php if($config->get('magikastra_footerbg_ed')==1) { ?>
footer{background:<?php echo "#".$config->get('magikastra_footerbg')."! important"; ?> } <?php } ?>
<?php if($config->get('magikastra_footerlinkcolor_ed')==1) { ?>
.footer-middle .links li a{color: <?php echo "#".$config->get('magikastra_footerlinkcolor'); ?>} 
<?php } ?>
<?php if($config->get('magikastra_footerlinkhovercolor_ed')==1) { ?>
.footer-middle .links li a:hover{color: <?php echo "#".$config->get('magikastra_footerlinkhovercolor'); ?>} <?php } ?>
<?php if($config->get('magikastra_powerbycolor_ed')==1) { ?>
footer .coppyright {color: <?php echo "#".$config->get('magikastra_powerbycolor')."! important"; ?>} <?php } ?>

</style>
</head>


<body class="<?php echo $class; ?>">
  <header class="header-container">


    <div class="header container">
      <div class="row">

          <div class="col-lg-2 col-sm-3 col-md-2">
              <?php if ($logo) { ?>
              <a class="logo" href="<?php echo $home; ?>" title="<?php echo $name; ?>">
              <img src="<?php echo $logo; ?>" title="<?php echo $name; ?>" alt="<?php echo $name; ?>"/>
              </a>
              <?php } else { ?>
              <h1><a class="logo" href="<?php echo $home; ?>"><?php echo $name; ?></a></h1>
              <?php } ?> 
          </div>



      </div><!-- row -->
    </div><!-- header container -->

  </header><!-- header-container -->

<!-- menu bar code-->
<?php 
if(isset($this->request->get['path'])) {
    $path = $this->request->get['path'];
    $cats = explode('_', $path);
    $cat_id = $cats[0];
} 
else{
  $cat_id = 0;
}?>

<?php 
$this->load->model('setting/setting');
$cbim=$this->model_setting_setting->getSetting('custom_block_inside_menu');
$subcatimgs=$this->config->get('custom_subcategory_thumbnail_module');
$this->load->model('tool/image');
//echo "<prE>";
if (function_exists('search')) {}
else {
      function search($array, $key, $value)
      {
      $results = array();

      if (is_array($array)) {
      if (isset($array[$key]) && $array[$key] == $value) {
      $results[] = $array;
      }

      foreach ($array as $subarray) {
      $results = array_merge($results, search($subarray, $key, $value));
      }
      }

      return $results;
      }
}
if($cbim=='' || $cbim==null){$cbim=0;}?>
<!-- code end -->


<div id="mgkquickview">
<div id="magikloading" style="display:none;text-align:center;margin-top:400px;"><img src="catalog/view/theme/astragrey/image/loading.gif" alt="loading">
</div></div>