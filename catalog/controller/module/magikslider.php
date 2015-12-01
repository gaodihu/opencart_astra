<?php

class ControllerModuleMagikslider extends Controller {
	public function index($setting) {

		$this->load->model('tool/image');
		$this->document->addStyle('catalog/view/theme/'.$this->config->get('config_template').'/stylesheet/eislideshow.css');
		$this->document->addScript('catalog/view/theme/'.$this->config->get('config_template').'/js/eislideshow.js');
		$data = array();
		if (isset($setting['magikslider_image'])) {
			$slider = array();
			foreach ($setting['magikslider_image'] as $slide) {
			
 			$slider[] = array('title'=>html_entity_decode($slide['magikslider_image_title'][$this->config->get('config_language_id')]['title']),'link'=>$slide['link'],'image'=>$this->model_tool_image->resize($slide['image'], $setting['width'],$setting['height']),'description'=>html_entity_decode($slide['magikslider_image_description'][$this->config->get('config_language_id')]['description'])); 
			}
		}

		$data['slider'] = $slider;

			if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/magikslider.tpl')) {
				return $this->load->view($this->config->get('config_template') . '/template/module/magikslider.tpl', $data);
			} else {
				return $this->load->view('default/template/module/magikslider.tpl', $data);
			}
		}
}
	