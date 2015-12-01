<!-- Slider -->
<div id="magik-slideshow" class="magik-slideshow">
  <div id="slider-elastic" class="slider slider-elastic elastic ei-slider">
    <ul class="ei-slider-large">
      
    <?php $cnt = 0; foreach ($slider as $slide) { ?>
    
    <style>#ms<?php echo $cnt?>{ cursor: pointer;}</style>
    <?php if(isset($slide['link']) && $slide['link']!='') { ?>
    <script type="text/javascript">
    $(document).ready(function(){
    $("#ms<?php echo $cnt?>").click(function() {
    window.open('<?php echo str_replace('&amp;', '&', $slide['link']); ?>','_blank');
    });   });  
    </script>
    <?php } ?>

      <li  id="ms<?php echo $cnt ?>" class="slide-1 slide align-"> 
        
        <img src="<?php echo $slide['image']?>" class="attachment-full" alt="<?php if($slide['title']) {echo $slide['title'];}?>" title="<?php if($slide['title']) {echo $slide['title'];}?>"/>
        
        <div class="ei-title">
          <?php if($slide['description']) { echo $slide['description'];}?>
        </div>

      </li>
    <?php $cnt++; } ?>

    </ul>
    <!-- ei-slider-large -->
    
    <ul class="ei-slider-thumbs">
      <li class="ei-slider-element"> Current </li>
      <?php foreach ($slider as $slide) { ?>
      <li> <a href="#"><?php if($slide['title']) {echo $slide['title'];}?></a> <img src="<?php echo $slide['image']?>" alt="<?php if($slide['title']) {echo $slide['title'];}?>" /> 
      </li>
      <?php } ?>

    </ul>
    <!-- ei-slider-thumbs -->
    <div class="shadow"></div>
  </div>
</div>
<!-- end Slider --> 
<script type="text/javascript">
jQuery(document).ready(function(jQuery){
jQuery('#slider-elastic.elastic').eislideshow({
easing      : 'easeOutExpo',
titleeasing : 'easeOutExpo',
titlespeed  : 1200,
autoplay    : true,
slideshow_interval : 3000,
speed       : 800,
animation   : 'sides'
});
});
</script>