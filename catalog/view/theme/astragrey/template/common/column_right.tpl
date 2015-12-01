<?php if ($modules) { ?>

<?php if (isset($this->request->get['route'])) { $route = $this->request->get['route'];  } else {  $route = 'common/home';  } ?>
<?php if($route=='common/home' || $route=='home') { $l='home'; } else { $l="nhome"; } ?>

<?php if($l=='home') { ?> <div class="blog_post col-xs-12 col-md-12 col-lg-6 wow bounceInRight animated"> <?php } else { ?> <column id="column-right" class="col-sm-3 col-xs-12"> <?php } ?>

<?php if($route=='magikblog/article' || $route=='magikblog/article/tag' || $route=='magikblog/article/view' || $route=='magikblog/category' || $route=='magikblog') { ?> <div class="widget_wrapper13"> <?php }?>

  <?php foreach ($modules as $module) { ?>
  <?php echo $module; ?>
  <?php } ?>

<?php if($route=='magikblog/article' || $route=='magikblog/article/tag' || $route=='magikblog/article/view' || $route=='magikblog/category' || $route=='magikblog') { ?> </div> <?php }?>

<?php if($l=='home') { ?> </div> <?php } else { ?> </column> <?php } ?>

<?php } ?>
