<div class="block block-account">
  <div class="block-title">
  <?php echo $heading_title;?>
  </div>
  <div class="block-content">
  <ul>
  <?php if (!$logged) { ?>
  
  <li><a href="<?php echo $login; ?>" class=""><?php echo $text_login; ?></a> </li>
  <li><a href="<?php echo $register; ?>" class=""><?php echo $text_register; ?></a> </li>
  <li><a href="<?php echo $forgotten; ?>" class=""><?php echo $text_forgotten; ?></a></li>
  <?php } ?>
  
  <li><a href="<?php echo $account; ?>" class=""><?php echo $text_account; ?></a></li>
  <?php if ($logged) { ?>
  <li><a href="<?php echo $edit; ?>" class=""><?php echo $text_edit; ?></a> </li>
  <li><a href="<?php echo $password; ?>" class=""><?php echo $text_password; ?></a></li>
  <?php } ?>
  
  <li><a href="<?php echo $address; ?>" class=""><?php echo $text_address; ?></a> </li>
  <li><a href="<?php echo $wishlist; ?>" class=""><?php echo $text_wishlist; ?></a> </li>
  <li><a href="<?php echo $order; ?>" class=""><?php echo $text_order; ?></a> </li>
  <li><a href="<?php echo $download; ?>" class=""><?php echo $text_download; ?></a> </li>
  <li><a href="<?php echo $reward; ?>" class=""><?php echo $text_reward; ?></a> </li>
  <li><a href="<?php echo $return; ?>" class=""><?php echo $text_return; ?></a> </li>
  <li><a href="<?php echo $transaction; ?>" class=""><?php echo $text_transaction; ?></a> </li>
  <li><a href="<?php echo $newsletter; ?>" class=""><?php echo $text_newsletter; ?></a></li>
  <li><a href="<?php echo $recurring; ?>" class=""><?php echo $text_recurring; ?></a></li>
  <?php if ($logged) { ?>
  
  <li><a href="<?php echo $logout; ?>" class=""><?php echo $text_logout; ?></a></li>
  <?php } ?>
  </ul>
</div>
</div>