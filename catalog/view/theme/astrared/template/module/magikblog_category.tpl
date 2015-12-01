<div class="popular-posts widget widget_categories wow bounceInUp animated">
	<h3 class="widget-title">
	<span><?php echo $heading_title; ?></span>
	</h3>

      <ul>
	  <?php 
		foreach($categoryList as $key => $value){ ?>
		   <li> <a href="<?php echo $value['href'];?>"><?php echo $value['name'];?></a></li>
	  <?php } ?>
      </ul>
</div>



