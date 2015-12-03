<?php echo $header; ?>
<div class="breadcrumbs">
    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <ul>
                    <?php $b_i=0; $b_cnt=count($breadcrumbs); foreach ($breadcrumbs as $breadcrumb) { ?>
                    <li><?php if($b_i!=0) {?><span> / </span><?php } ?>
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


<div class="main-container col1-layout">
    <div class="main container">
        <div class="col-main">
            <?php if ($error_warning) { ?>
            <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
                <button type="button" class="close" data-dismiss="alert">&times;</button>
            </div>
            <?php } ?>

            <div class="row">


                <div  class="col-sm-4">

                    <div class="panel-group" ">
                        <div class="panel panel-default" id="collapse-payment-address">
                            <div class="panel-heading">
                                <h4 class="panel-title"><?php echo $text_checkout_option; ?></h4>
                            </div>
                            <div class="panel-collapse " >
                                <div class="panel-body"></div>
                            </div>
                        </div>
                    </div>
                </div>

                <div  class="col-sm-4">

                    <div class="panel-group" >
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><?php echo $text_checkout_option; ?></h4>
                            </div>
                            <div class="panel-collapse" >
                                <div class="panel-body">dsfsadf</div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="content" class="col-sm-4">

                    <div class="panel-group" >
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h4 class="panel-title"><?php echo $text_checkout_option; ?></h4>
                            </div>
                            <div class="panel-collapse " >
                                <div class="panel-body">sadfsadfaf</div>
                            </div>
                        </div>
                    </div>
                </div>



            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        $.ajax({
            url: 'index.php?route=checkout/onepage/shipping_address',
            dataType: 'html',
            success: function(html) {
                $('#collapse-payment-address .panel-body').html(html);

                $('#collapse-payment-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_address; ?> <i class="fa fa-caret-down"></i></a>');

                $('a[href=\'#collapse-payment-address\']').trigger('click');
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });


    // Payment Address
    $(document).delegate('#button-payment-address', 'click', function() {
        $.ajax({
            url: 'index.php?route=checkout/payment_address/save',
            type: 'post',
            data: $('#collapse-payment-address input[type=\'text\'], #collapse-payment-address input[type=\'date\'], #collapse-payment-address input[type=\'datetime-local\'], #collapse-payment-address input[type=\'time\'], #collapse-payment-address input[type=\'password\'], #collapse-payment-address input[type=\'checkbox\']:checked, #collapse-payment-address input[type=\'radio\']:checked, #collapse-payment-address input[type=\'hidden\'], #collapse-payment-address textarea, #collapse-payment-address select'),
            dataType: 'json',
            beforeSend: function() {
                $('#button-payment-address').button('loading');
            },
            complete: function() {
                $('#button-payment-address').button('reset');
            },
            success: function(json) {
                $('.alert, .text-danger').remove();

                if (json['redirect']) {
                    location = json['redirect'];
                } else if (json['error']) {
                    if (json['error']['warning']) {
                        $('#collapse-payment-address .panel-body').prepend('<div class="alert alert-warning">' + json['error']['warning'] + '<button type="button" class="close" data-dismiss="alert">&times;</button></div>');
                    }

                    for (i in json['error']) {
                        var element = $('#input-payment-' + i.replace('_', '-'));

                        if ($(element).parent().hasClass('input-group')) {
                            $(element).parent().after('<div class="text-danger">' + json['error'][i] + '</div>');
                        } else {
                            $(element).after('<div class="text-danger">' + json['error'][i] + '</div>');
                        }
                    }

                    // Highlight any found errors
                    $('.text-danger').parent().parent().addClass('has-error');
                } else {
                <?php if ($shipping_required) { ?>
                        $.ajax({
                            url: 'index.php?route=checkout/shipping_address',
                            dataType: 'html',
                            success: function(html) {
                                $('#collapse-shipping-address .panel-body').html(html);

                                $('#collapse-shipping-address').parent().find('.panel-heading .panel-title').html('<a href="#collapse-shipping-address" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_shipping_address; ?> <i class="fa fa-caret-down"></i></a>');

                                $('a[href=\'#collapse-shipping-address\']').trigger('click');

                                $('#collapse-shipping-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_shipping_method; ?>');
                                $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_payment_method; ?>');
                                $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });
                    <?php } else { ?>
                        $.ajax({
                            url: 'index.php?route=checkout/payment_method',
                            dataType: 'html',
                            success: function(html) {
                                $('#collapse-payment-method .panel-body').html(html);

                                $('#collapse-payment-method').parent().find('.panel-heading .panel-title').html('<a href="#collapse-payment-method" data-toggle="collapse" data-parent="#accordion" class="accordion-toggle"><?php echo $text_checkout_payment_method; ?> <i class="fa fa-caret-down"></i></a>');

                                $('a[href=\'#collapse-payment-method\']').trigger('click');

                                $('#collapse-checkout-confirm').parent().find('.panel-heading .panel-title').html('<?php echo $text_checkout_confirm; ?>');
                            },
                            error: function(xhr, ajaxOptions, thrownError) {
                                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                            }
                        });
                    <?php } ?>

                    $.ajax({
                        url: 'index.php?route=checkout/payment_address',
                        dataType: 'html',
                        success: function(html) {
                            $('#collapse-payment-address .panel-body').html(html);
                        },
                        error: function(xhr, ajaxOptions, thrownError) {
                            alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
                        }
                    });
                }
            },
            error: function(xhr, ajaxOptions, thrownError) {
                alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
            }
        });
    });

</script>


<?php echo $footer; ?>