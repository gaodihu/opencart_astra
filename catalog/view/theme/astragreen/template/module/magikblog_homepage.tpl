    <div class="blog-title">
      <h2><span><?php echo $heading_title; ?></span></h2>
    </div>

    <ul style="left: 0px; top: 0px;">
      <?php foreach ($postList as $_postList) { ?>

        <li>
        <?php if(!$hideimage) { ?>
        <div class="blog-l blog-img"> 
        <img src="<?php echo $_postList['thumb']; ?>" alt="<?php echo $_postList['name']; ?>" title="<?php echo $_postList['name']; ?>" class="img-responsive" />
        <div class="mask"> <a href="<?php echo $_postList['href']; ?>" class="info"><?php echo $text_readmore; ?></a> </div>
        </div>
        <?php } ?>

        <?php if(!$hidetitle) { ?>
        <h2><a href="<?php echo $_postList['href']; ?>" ><?php echo $_postList['name']; ?></a> </h2>
        <?php } ?>

        <?php if(!$hidedate) { ?>
        <h3><i class="icon-calendar"></i><?php echo $_postList['publish_date']; ?></h3>
        <?php } ?>
        <?php if(!$hidedescription) { ?>  
        <p><?php echo $_postList['description']; ?></p>
        <?php } ?>
        </li>

      <?php } ?>
    </ul>
  