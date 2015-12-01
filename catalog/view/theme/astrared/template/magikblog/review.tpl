<div class="comments-wrapper">
<?php if ($comments) { ?>
<h3> <?php echo $text_comments;?> </h3>
<ul class="commentlist">
<?php foreach ($comments as $comment) { ?>
<li class="comment">
<div class="comment-wrapper">
  <div class="comment-author vcard">

    <span class="author"><?php echo $comment['user']; ?></span>
  </div>
<div class="comment-meta"><?php echo $comment['created_at']; ?></div>
<div class="comment-body"> <?php echo $comment['comment']; ?> </div>

  <div class="comment-body"> 
  <div class="rating">
                          <div class="ratings">
                          <div class="rating-box">
                          <?php for ($i = 1; $i <= 5; $i++) { ?>
                          <?php if ($comment['rating'] < $i) { ?>
                          <span class="fa fa-stack"><i class="fa fa-star-o fa-stack-2x"></i></span>
                          <?php } else { ?>
                          <span class="fa fa-stack"><i class="fa fa-star fa-stack-2x"></i><i class="fa fa-star-o fa-stack-2x"></i></span>
                          <?php } ?>
                          <?php } ?>
                          </div>
                          </div>
                          </div><!-- rating -->
  </div>
</div>
</li>


<?php } ?>
</ul>
<div class="text-right"><?php echo $pagination; ?></div>
<?php } else { ?>
<p><?php echo $text_no_comments; ?></p>
<?php } ?>
</div>