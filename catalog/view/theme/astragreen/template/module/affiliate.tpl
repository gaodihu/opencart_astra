<div class="block block-account">
  <div class="block-title">
  <?php echo $heading_title;?>
  </div>
<div class="block-content">
  <ul>
  <?php if (!$logged) { ?>
  <li><a href="<?php echo $login; ?>" class=""><?php echo $text_login; ?></a></li>
  <li><a href="<?php echo $register; ?>" class=""><?php echo $text_register; ?></a></li> 
  <li><a href="<?php echo $forgotten; ?>" class=""><?php echo $text_forgotten; ?></a></li>
  <?php } ?>
  <li><a href="<?php echo $account; ?>" class=""><?php echo $text_account; ?></a></li>
  <?php if ($logged) { ?>
  <li><a href="<?php echo $edit; ?>" class=""><?php echo $text_edit; ?></a></li> 
  <li><a href="<?php echo $password; ?>" class=""><?php echo $text_password; ?></a></li>
  <?php } ?>
  <li><a href="<?php echo $payment; ?>" class=""><?php echo $text_payment; ?></a></li>
  <li><a href="<?php echo $tracking; ?>" class=""><?php echo $text_tracking; ?></a></li> 
  <li><a href="<?php echo $transaction; ?>" class=""><?php echo $text_transaction; ?></a></li>
  <?php if ($logged) { ?>
  <li><a href="<?php echo $logout; ?>" class=""><?php echo $text_logout; ?></a></li>
  <?php } ?>
  </ul>
</div>
</div>