<?php  
class ControllerModuleMagikblogCategory extends Controller {

	public function index() {

		$this->language->load('module/magikblog_category');

		$data['heading_title'] = $this->language->get('heading_title');

		$this->load->model('magikblog/category');
		$data['categoryList'] = array();
		$categoryList = $this->model_magikblog_category->categoryParentChildTree(); 

		foreach ($categoryList as $category) {
			$data['categoryList'][] = array(
					'category_id' => $category['category_id'],
					'name'     => $category['name'],
					'href'     => $this->url->link('magikblog/category', 'mgkblogcategory_id=' . $category['category_id'])
			);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/magikblog_category.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/magikblog_category.tpl', $data);
		} else {
			return $this->load->view('default/template/module/magikblog_category.tpl', $data);
		}

	}
}
?> 
