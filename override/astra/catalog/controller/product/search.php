<?php
class astra_ControllerProductSearch extends ControllerProductSearch {

public function preRender( $template_buffer, $template_name, &$data ) {
        if ($template_name != $this->config->get('config_template').'/template/product/search.tpl') {
            return parent::preRender( $template_buffer, $template_name, $data );
        }
       
        // add new controller variables
        $this->load->language( 'product/search' );
        $data['text_quickview'] = $this->language->get('text_quickview');
        
        // call parent method
        return parent::preRender( $template_buffer, $template_name, $data );
    }
} 
