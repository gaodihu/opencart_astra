<?php if ($modules) { ?>

<?php if (isset($this->request->get['route'])) { $route = $this->request->get['route'];  } else {  $route = 'common/home';  } ?>
<?php if($route=='common/home' || $route=='home') { $l='home'; } else { $l="nhome"; } ?>

<?php if($l=='home') { ?> <div class="pro-recommend col-xs-12 col-md-12 col-lg-6 wow bounceInLeft animated"> <?php } else { ?> <column id="column-left" class="col-sm-3 hidden-xs sidebar wow bounceInUp animated"> <?php } ?>


  <?php foreach ($modules as $module) { ?>
  <?php echo $module; ?>
  <?php } ?>


<?php if($l=='home') { ?> </div> <?php } else { ?> </column> <?php } ?>

<?php } ?>