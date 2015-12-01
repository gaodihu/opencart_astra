<div class="side-nav-categories">
  <div class="block-title"><?php echo $heading_title; ?></div>
  <div class="box-content box-category">
    <ul id="magicat">

    <?php $cnt=1;$cat_cnt=count($categories); foreach ($categories1 as $category) { ?>
    <li class="level0- level0<?php if ($category['children']) {  echo ' open'; }?><?php if($cnt==$cat_cnt) echo " last";?><?php if($cnt==1) echo " first";?>">
      <span class="magicat-cat"><a href="<?php echo $category['href']; ?>"><span><?php echo $category['name']; ?></span></a></span> 
      <ul style="display: none;" >
        <?php foreach ($category['children'] as $child) { ?>
        <li class="level1- level1">
          <span class="magicat-cat"><a href="<?php echo $child['href']; ?>"><span><?php echo $child['name']; ?></span></a></span>   
        </li>
        <?php } ?>
      </ul>       
    </li>
    <?php $cnt++; } ?>

   </ul>
  </div>
</div>