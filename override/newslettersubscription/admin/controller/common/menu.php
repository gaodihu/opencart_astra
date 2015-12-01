<?php
class newslettersubscription_ControllerCommonMenu extends ControllerCommonMenu {

    /* overridden method, this newly introduced function is always called
       before the final rendering
    */
    public function preRender( $template_buffer, $template_name, &$data ) {

        if ($template_name != 'common/menu.tpl') {
            return parent::preRender( $template_buffer, $template_name, $data );
        }

        // modify template file
        if($this->config->get('newslettersubscription_status')==1) {    
            $this->load->language('sale/newslettersubscription');
            $data['text_newsletter_subscription'] = $this->language->get('text_newsletter_subscription');
	    $data['text_newsletter_subscription_list'] = $this->language->get('text_newsletter_subscription_list');
	    $data['text_newsletter_subscription_mail'] = $this->language->get('text_newsletter_subscription_mail');
           $data['newsletter_subscription_list'] = $this->url->link('sale/newslettersubscription', 'token=' . $this->session->data['token'], 'SSL');
	    $data['newsletter_subscription_mail'] = $this->url->link('sale/newslettersubscriptionmail', 'token=' . $this->session->data['token'], 'SSL');
            $template_buffer = str_replace(


'<li><a class="parent"><?php echo $text_paypal ?></a>
        <ul>
          <li><a href="<?php echo $paypal_search ?>"><?php echo $text_paypal_search ?></a></li>
        </ul>
      </li>',

'<li><a class="parent"><?php echo $text_paypal ?></a>
        <ul>
          <li><a href="<?php echo $paypal_search ?>"><?php echo $text_paypal_search ?></a></li>
        </ul>
      </li><li><a class="parent"><?php echo $text_newsletter_subscription; ?></a>
        <ul>
          <li><a href="<?php echo $newsletter_subscription_list; ?>"><?php echo $text_newsletter_subscription_list; ?></a></li>
          <li><a href="<?php echo $newsletter_subscription_mail; ?>"><?php echo $text_newsletter_subscription_mail; ?></a></li>
        </ul>
      </li> ',
            

  
               
                $template_buffer
            );
            
        }    
        // call parent method
        return parent::preRender( $template_buffer, $template_name, $data );
    }
}
?> 
