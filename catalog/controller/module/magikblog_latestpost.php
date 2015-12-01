<?php  
class ControllerModuleMagikblogLatestpost extends Controller {

	public function index() {

		$this->language->load('module/magikblog_latestpost');
		$this->load->model('tool/image');

		$data['heading_title'] = $this->language->get('heading_title');

		$this->load->model('magikblog/category');
		$data['postList'] = array();
		$data['exclude_category']=$this->config->get('magikblog_latestpost_article_category');

		if(!empty($data['exclude_category'])){
		    $data['exclude_category']=implode(",",$data['exclude_category']);
		}
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$limit=$this->config->get('magikblog_latestpost_postcount');
		$filter_data = array(
			'filter_exclude_category'=>$data['exclude_category'],
			'start'       => ($page - 1) * $limit,
			'limit'       => $limit
		);

		$postList = $this->model_magikblog_category->getLatestposts($filter_data); 

		foreach ($postList as $post_List) {

			 if ($post_List['image']) {
						      $image = $this->model_tool_image->resize($post_List['image'],80,53);
					      } else {
						      $image = $this->model_tool_image->resize('placeholder.png',80,53);
					      }

			$data['postList'][] = array(
					'blog_id' => $post_List['blog_id'],
					'name'     => $post_List['name'],
					'href'     => $this->url->link('magikblog/article/view', 'mgkblogarticle_id=' . $post_List['blog_id']),
					'thumb'     => $image,
					'date'     => $post_List['publish_date']
			);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/magikblog_latestpost.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/magikblog_latestpost.tpl', $data);
		} else {
			return $this->load->view('default/template/module/magikblog_latestpost.tpl', $data);
		}

	}
}
?> 
