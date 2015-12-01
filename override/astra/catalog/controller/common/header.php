<?php
class astra_ControllerCommonHeader extends ControllerCommonHeader {

public function preRender( $template_buffer, $template_name, &$data ) {
        if ($template_name != $this->config->get('config_template').'/template/common/header.tpl') {
            return parent::preRender( $template_buffer, $template_name, $data );
        }
       
        // add new controller variables


            $this->load->language( 'common/header' );

            $data['text_menu'] = $this->language->get( 'text_menu' );
            $data['text_home'] = $this->language->get('text_home');
            $data['text_welcome'] = sprintf($this->language->get('text_welcome'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
            $data['text_logged'] = sprintf($this->language->get('text_logged'), $this->url->link('account/account', '', 'SSL'), $this->customer->getFirstName(), $this->url->link('account/logout', '', 'SSL'));
            $data['text_blog'] = $this->language->get( 'text_blog' );
            $data['blog']=$this->url->link('magikblog/article', '', 'SSL');


            $this->load->model('catalog/category');
            $this->load->model('catalog/product');

        // for only Top Categories
        
        $data['categories1'] = array();
        $categories_1 = $this->model_catalog_category->getCategories(0);
        
        foreach ($categories_1 as $category_1) {
            if($category_1['top']){
             $level_2_data = array();
             
             $categories_2 = $this->model_catalog_category->getCategories($category_1['category_id']);
             
             foreach ($categories_2 as $category_2) {
                $level_3_data = array();
                
                $categories_3 = $this->model_catalog_category->getCategories($category_2['category_id']);
                
                foreach ($categories_3 as $category_3) {
                   $level_3_data[] = array(
                      'name' => $category_3['name'],
                                           'column'   => $category_3['column'] ? $category_3['column'] : 1,
                      'href' => $this->url->link('product/category', 'path=' . $category_1['category_id'] . '_' . $category_2['category_id'] . '_' . $category_3['category_id']),
                      'category_id'=> $category_3['category_id']
                   );
                }
                
                $level_2_data[] = array(
                   'name'     => $category_2['name'],
                   'children' => $level_3_data,
                   'href'     => $this->url->link('product/category', 'path=' . $category_1['category_id'] . '_' . $category_2['category_id']),
                   'category_id'=> $category_2['category_id']   
                );               
             }
             
             $data['categories1'][] = array(
                'name'     => $category_1['name'],
                'children' => $level_2_data,
                'column'   => $category_1['column'] ? $category_1['column'] : 1,
                'href'     => $this->url->link('product/category', 'path=' . $category_1['category_id']),
                'category_id'=> $category_1['category_id']
             );
          } 
        }

      
        // call parent method
        return parent::preRender( $template_buffer, $template_name, $data );
    }
}