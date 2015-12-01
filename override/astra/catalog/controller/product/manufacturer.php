<?php
class astra_ControllerProductManufacturer extends ControllerProductManufacturer {

public function preRender( $template_buffer, $template_name, &$data ) {
        if ($template_name != $this->config->get('config_template').'/template/product/manufacturer_info.tpl') {
            return parent::preRender( $template_buffer, $template_name, $data );
        }
       
        // add new controller variables
        $this->load->language( 'product/manufacturer' );
        $data['text_quickview'] = $this->language->get('text_quickview');
        
        // call parent method
        return parent::preRender( $template_buffer, $template_name, $data );
    }
} 
