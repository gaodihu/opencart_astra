<?php
class astra_ControllerModuleFeatured extends ControllerModuleFeatured {

public function preRender( $template_buffer, $template_name, &$data ) {
        if ($template_name != $this->config->get('config_template').'/template/module/featured.tpl') {
            return parent::preRender( $template_buffer, $template_name, $data );
        }
       
        // add new controller variables
        $this->load->language( 'module/featured' );
        $data['text_quickview'] = $this->language->get('text_quickview');
        
        // call parent method
        return parent::preRender( $template_buffer, $template_name, $data );
    }
} 
