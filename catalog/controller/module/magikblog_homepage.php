<?php  
class ControllerModuleMagikblogHomepage extends Controller {

	public function index() {

		$this->language->load('module/magikblog_homepage');

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_readmore'] = $this->language->get('text_readmore');

		$this->load->model('tool/image');
		$this->load->model('magikblog/category');
		$data['articles'] = array();

		$data['hideimage']=$this->config->get('magikblog_homepage_hideimage');
		$data['hidetitle']=$this->config->get('magikblog_homepage_hidetitle');
		$data['hidedescription']=$this->config->get('magikblog_homepage_hidedescription');
		$data['hidedate']=$this->config->get('magikblog_homepage_hidedate');
		$data['resizeimage']=$this->config->get('magikblog_homepage_resizeimage');
		$data['exclude_category']=$this->config->get('magikblog_homepage_article_category');

		if(!empty($data['exclude_category'])){
		    $data['exclude_category']=implode(",",$data['exclude_category']);
		}
		$filter_data = array(
			'filter_exclude_category'=>$data['exclude_category'],
			'start'       => $this->config->get('magikblog_homepage_ignorepost'),
			'limit'       => $this->config->get('magikblog_homepage_postcount')
		);

		$postList = $this->model_magikblog_category->getHomepageposts($filter_data); 

		foreach ($postList as $post_List) {
			if($data['resizeimage']){
			    if ($post_List['image']) {
						      $image = $this->model_tool_image->resize($post_List['image'], $this->config->get('magikblog_homepage_resizeimagewidth') ,$this->config->get('magikblog_homepage_resizeimageheight') );
					      } else {
						      $image = $this->model_tool_image->resize('placeholder.png', $this->config->get('magikblog_homepage_resizeimagewidth') , $this->config->get('magikblog_homepage_resizeimageheight'));
					      }
			}else{
				 if ($post_List['image']) {
						      $image = 'image/'.$post_List['image'];
					      } else {
						      $image = $this->model_tool_image->resize('placeholder.png', $this->config->get('magikblog_homepage_resizeimagewidth') , $this->config->get('magikblog_homepage_resizeimageheight'));
					      }
			}
			$data['postList'][] = array(
					'blog_id' => $post_List['blog_id'],
					'name'     => $post_List['name'],
					'thumb'     => $image,
					'publish_date'     => $post_List['publish_date'],
					'description' => utf8_substr(strip_tags(html_entity_decode($post_List['description'], ENT_QUOTES, 'UTF-8')), 0, $this->config->get('magikblog_homepage_descriptionlimit')) . '..',
					'href'     => $this->url->link('magikblog/article/view', 'mgkblogarticle_id=' . $post_List['blog_id'])
			);
		}

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/magikblog_homepage.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/magikblog_homepage.tpl', $data);
		} else {
			return $this->load->view('default/template/module/magikblog_homepage.tpl', $data);
		}

	}
}
?> 
