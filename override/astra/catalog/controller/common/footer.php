<?php
class astra_ControllerCommonFooter extends ControllerCommonFooter {

public function preRender( $template_buffer, $template_name, &$data ) {
        if ($template_name != $this->config->get('config_template').'/template/common/footer.tpl') {
            return parent::preRender( $template_buffer, $template_name, $data );
        }
       
        // add new controller variables

        $this->load->language( 'common/footer' );
        $data['text_follow_us'] = $this->language->get( 'text_follow_us' );
        $data['text_we_accept'] = $this->language->get( 'text_we_accept' );
        $data['text_blog'] = $this->language->get( 'text_blog' );
        $data['blog']=$this->url->link('magikblog/article');

        $data['newslettersubscription'] = $this->load->controller('module/newslettersubscription');

        $this->load->model('catalog/manufacturer');
        $this->load->model('tool/image');

        $data['manufacturers'] = array();

        $results = $this->model_catalog_manufacturer->getManufacturers();

        foreach ($results as $result) {
            $data['manufacturers'][] = array(
                'manufacturer_image' => $this->model_tool_image->resize($result['image'],130,50),
                'name'            => $result['name'],
                'href'            => $this->url->link('product/manufacturer/info&manufacturer_id=' . $result['manufacturer_id'])
            );
        } 

        // call parent method
        return parent::preRender( $template_buffer, $template_name, $data );
    }
}