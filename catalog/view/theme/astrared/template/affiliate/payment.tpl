<?php echo $header; ?>
  <div class="breadcrumbs">
  <div class="container">
  <div class="row">
  <div class="col-xs-12">
    <ul>
    <?php $b_i=0; $b_cnt=count($breadcrumbs); foreach ($breadcrumbs as $breadcrumb) { ?>
    <li><?php if($b_i!=0) {?><span>—› </span><?php } ?>
      <?php if($b_i==($b_cnt-1)){ ?>
      <strong><?php echo $breadcrumb['text']; ?></strong><?php } 
      else { ?>
      <a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
      <?php }?>
    </li>
    <?php $b_i++ ;} ?>
  </ul>
  </div>
  </div>
  </div>
  </div>

<div class="main-container col2-right-layout wow bounceInUp animated">
<div class="main container">
  <div class="row"><?php echo $column_left; ?>
    <?php if ($column_left && $column_right) { ?>
    <?php $class = 'col-sm-6'; ?>
    <?php } elseif ($column_left || $column_right) { ?>
    <?php $class = 'col-sm-9'; ?>
    <?php } else { ?>
    <?php $class = 'col-sm-12'; ?>
    <?php } ?>
    <div id="content" class="<?php echo $class; ?> col-main"><?php echo $content_top; ?>
      <div class="page-title"><h1><?php  echo $heading_title; ?></h1></div>
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" class="form-horizontal">
        <fieldset>
          <legend><?php echo $text_your_payment; ?></legend>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-tax"><?php echo $entry_tax; ?></label>
            <div class="col-sm-10">
              <input type="text" name="tax" value="<?php echo $tax; ?>" placeholder="<?php echo $entry_tax; ?>" id="input-tax" class="form-control" />
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label"><?php echo $entry_payment; ?></label>
            <div class="col-sm-10">
              <div class="radio">
                <label>
                  <?php if ($payment == 'cheque') { ?>
                  <input type="radio" name="payment" value="cheque" checked="checked" />
                  <?php } else { ?>
                  <input type="radio" name="payment" value="cheque" />
                  <?php } ?>
                  <?php echo $text_cheque; ?></label>
              </div>
              <div class="radio">
                <label>
                  <?php if ($payment == 'paypal') { ?>
                  <input type="radio" name="payment" value="paypal" checked="checked" />
                  <?php } else { ?>
                  <input type="radio" name="payment" value="paypal" />
                  <?php } ?>
                  <?php echo $text_paypal; ?></label>
              </div>
              <div class="radio">
                <label>
                  <?php if ($payment == 'bank') { ?>
                  <input type="radio" name="payment" value="bank" checked="checked" />
                  <?php } else { ?>
                  <input type="radio" name="payment" value="bank" />
                  <?php } ?>
                  <?php echo $text_bank; ?></label>
              </div>
            </div>
          </div>
          <div class="form-group payment" id="payment-cheque">
            <label class="col-sm-2 control-label" for="input-cheque"><?php echo $entry_cheque; ?></label>
            <div class="col-sm-10">
              <input type="text" name="cheque" value="<?php echo $cheque; ?>" placeholder="<?php echo $entry_cheque; ?>" id="input-cheque" class="form-control" />
            </div>
          </div>
          <div class="form-group payment" id="payment-paypal">
            <label class="col-sm-2 control-label" for="input-paypal"><?php echo $entry_paypal; ?></label>
            <div class="col-sm-10">
              <input type="text" name="paypal" value="<?php echo $paypal; ?>" placeholder="<?php echo $entry_paypal; ?>" id="input-paypal" class="form-control" />
            </div>
          </div>
          <div class="payment" id="payment-bank">
            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-bank-name"><?php echo $entry_bank_name; ?></label>
              <div class="col-sm-10">
                <input type="text" name="bank_name" value="<?php echo $bank_name; ?>" placeholder="<?php echo $entry_bank_name; ?>" id="input-bank-name" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-bank-branch-number"><?php echo $entry_bank_branch_number; ?></label>
              <div class="col-sm-10">
                <input type="text" name="bank_branch_number" value="<?php echo $bank_branch_number; ?>" placeholder="<?php echo $entry_bank_branch_number; ?>" id="input-bank-branch-number" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-bank-swift-code"><?php echo $entry_bank_swift_code; ?></label>
              <div class="col-sm-10">
                <input type="text" name="bank_swift_code" value="<?php echo $bank_swift_code; ?>" placeholder="<?php echo $entry_bank_swift_code; ?>" id="input-bank-swift-code" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-bank-account-name"><?php echo $entry_bank_account_name; ?></label>
              <div class="col-sm-10">
                <input type="text" name="bank_account_name" value="<?php echo $bank_account_name; ?>" placeholder="<?php echo $entry_bank_account_name; ?>" id="input-bank-account-name" class="form-control" />
              </div>
            </div>
            <div class="form-group">
              <label class="col-sm-2 control-label" for="input-bank-account-number"><?php echo $entry_bank_account_number; ?></label>
              <div class="col-sm-10">
                <input type="text" name="bank_account_number" value="<?php echo $bank_account_number; ?>" placeholder="<?php echo $entry_bank_account_number; ?>" id="input-bank-account-number" class="form-control" />
              </div>
            </div>
          </div>
        </fieldset>
        <div class="buttons clearfix">
          <div>
            <a class="left" href="<?php echo $back; ?>"><button class="button" type="button"><?php echo $button_back; ?></button></a>
            <button type="submit" class="button continue pull-right"><?php echo $button_continue; ?></button>
          </div>
        </div>
      </form>
      </div>
    <?php echo $column_right; ?></div>
</div><?php echo $content_bottom; ?>
</div>
<script type="text/javascript"><!--
$('input[name=\'payment\']').on('change', function() {
    $('.payment').hide();

    $('#payment-' + this.value).show();
});

$('input[name=\'payment\']:checked').trigger('change');
//--></script>
<script type="text/javascript">
 $('#column-right').attr('class','col-sm-3 col-xs-12 sidebar');
</script>
<?php echo $footer; ?>