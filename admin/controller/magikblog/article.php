<?php
class ControllerMagikblogArticle extends Controller {
	private $error = array();

	public function index() { 
		$this->load->language('magikblog/article');
		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('magikblog/article');

		$this->getList();

	}

	public function edit() {

		$this->load->language('magikblog/article');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('magikblog/article');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) { 
			$this->model_magikblog_article->editArticle($this->request->get['blog_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('magikblog/article', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('magikblog/article');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('magikblog/article');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $blog_id) {
				$this->model_magikblog_article->deleteArticle($blog_id);
			}

			$this->session->data['delete_success'] = $this->language->get('text_delete_success');

			$url = '';

			if (isset($this->request->get['sort'])) {
				$url .= '&sort=' . $this->request->get['sort'];
			}

			if (isset($this->request->get['order'])) {
				$url .= '&order=' . $this->request->get['order'];
			}

			if (isset($this->request->get['page'])) {
				$url .= '&page=' . $this->request->get['page'];
			}

			$this->response->redirect($this->url->link('magikblog/article', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList() {
		
		if (isset($this->request->get['filter_article'])) {
			$filter_article = $this->request->get['filter_article'];
		} else {
			$filter_article = null;
		}

		if (isset($this->request->get['filter_status'])) {
			$filter_status = $this->request->get['filter_status'];
		} else {
			$filter_status = null;
		}

		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else { $sort = 'm.publish_date';}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else { $order = 'DESC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$url = '';
	
		if (isset($this->request->get['filter_article'])) {
			$url .= '&filter_article=' . urlencode(html_entity_decode($this->request->get['filter_article'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('magikblog/article', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);
		
		$data['add'] = $this->url->link('magikblog/article/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('magikblog/article/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		$data['articles'] = array();

		$filter_data = array(
			'filter_article'    => $filter_article,
			'filter_status'     => $filter_status,
			'sort'              => $sort,
			'order'             => $order,
			'start'             => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'             => $this->config->get('config_limit_admin')
		);
		
		$this->load->model('tool/image');
		$article_total = $this->model_magikblog_article->getTotalArticles($filter_data);

		$results = $this->model_magikblog_article->getArticles($filter_data);

		$this->load->language('magikblog/article');
		foreach ($results as $result) {

		    if (is_file(DIR_IMAGE . $result['image'])) { 
				$image = $this->model_tool_image->resize($result['image'], 40, 40);
 
			} else {
				$image = $this->model_tool_image->resize('no_image.png', 40, 40);
			}


			$data['articles'][] = array(
				'blog_id'  => $result['blog_id'],
				'name'     => $result['name'],
				'image'      => $image,
				'publish_date' => date($this->language->get('date_format_short'), strtotime($result['publish_date'])),
				'status'     => ($result['status']) ? $this->language->get('text_enabled') : $this->language->get('text_disabled'),
				'edit'       => $this->url->link('magikblog/article/edit', 'token=' . $this->session->data['token'] . '&blog_id=' . $result['blog_id'] . $url, 'SSL')
				
			);
		}

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_list'] = $this->language->get('text_list');
		$data['text_no_results'] = $this->language->get('text_no_results');
		$data['text_confirm'] = $this->language->get('text_confirm');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['column_image'] = $this->language->get('column_image');
		$data['column_name'] = $this->language->get('column_name');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_date_added'] = $this->language->get('column_date_added');
		$data['column_action'] = $this->language->get('column_action');
		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_answer'] = $this->language->get('button_answer');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['button_filter'] = $this->language->get('button_filter');
		$data['text_delete_success'] = $this->language->get('text_delete_success');
		$data['entry_article'] = $this->language->get('entry_article');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['token'] = $this->session->data['token'];

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];

			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->request->post['selected'])) {
			$data['selected'] = (array)$this->request->post['selected'];
		} else {
			$data['selected'] = array();
		}

		$url = '';

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_name'] = $this->url->link('magikblog/article', 'token=' . $this->session->data['token'] . '&sort=md.name' . $url, 'SSL');
		$data['sort_status'] = $this->url->link('magikblog/article', 'token=' . $this->session->data['token'] . '&sort=m.status' . $url, 'SSL');

		$url = '';
		if (isset($this->request->get['filter_article'])) {
			$url .= '&filter_article=' . urlencode(html_entity_decode($this->request->get['filter_article'], ENT_QUOTES, 'UTF-8'));
		}

		if (isset($this->request->get['filter_status'])) {
			$url .= '&filter_status=' . $this->request->get['filter_status'];
		}

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $article_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('magikblog/article', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($article_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($article_total - $this->config->get('config_limit_admin'))) ? $article_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $article_total, ceil($article_total / $this->config->get('config_limit_admin')));
	      
		$data['filter_article'] = $filter_article;
		$data['filter_status'] = $filter_status;
		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('magikblog/article.tpl', $data));
	}

	protected function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_form'] = !isset($this->request->get['blog_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_default'] = $this->language->get('text_default');
		$data['text_default_category'] = $this->language->get('text_default_category');
		$data['column_status'] = $this->language->get('column_status');
		$data['entry_articlename'] = $this->language->get('entry_articlename');
		$data['entry_article'] = $this->language->get('entry_article');
		$data['entry_description'] = $this->language->get('entry_description');
		$data['entry_metatitle'] = $this->language->get('entry_metatitle');
		$data['entry_metadescription'] = $this->language->get('entry_metadescription');
		$data['entry_metakeyword'] = $this->language->get('entry_metakeyword');
		$data['entry_tag'] = $this->language->get('entry_tag');
		$data['entry_image'] = $this->language->get('entry_image');
		$data['entry_author'] = $this->language->get('entry_author');
		$data['entry_publishdate'] = $this->language->get('entry_publishdate');
		$data['entry_seokeyword'] = $this->language->get('entry_seokeyword');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['entry_store'] = $this->language->get('entry_store');
		$data['entry_display_order'] = $this->language->get('entry_display_order');
		$data['entry_category'] = $this->language->get('entry_category');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_data'] = $this->language->get('tab_data');
		$data['tab_links'] = $this->language->get('tab_links');

		if (isset($this->error['warning'])) { $data['error_warning'] = $this->error['warning'];
		} else { $data['error_warning'] = '';}

		if (isset($this->error['articlename'])) { $data['error_article'] = $this->error['articlename'];
		} else { $data['error_article'] = array(); }

		if (isset($this->error['meta_title'])) { $data['error_metatitle'] = $this->error['meta_title'];
		} else { $data['error_metatitle'] = array(); }
		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}
 
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('magikblog/article', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);
		
		if (!isset($this->request->get['blog_id'])) {
			$data['action'] = $this->url->link('magikblog/article/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('magikblog/article/edit', 'token=' . $this->session->data['token'] . '&blog_id=' . $this->request->get['blog_id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link('magikblog/article', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->load->model('magikblog/article');

		if (isset($this->request->get['blog_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$article_info = $this->model_magikblog_article->getBlogarticle($this->request->get['blog_id']);
		}
		 
		$data['token'] = $this->session->data['token'];
		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();
		
		if (isset($this->request->post['article_description'])) {
			$data['article_description'] = $this->request->post['article_description'];
		} elseif (isset($this->request->get['blog_id'])) {
			$data['article_description'] = $this->model_magikblog_article->getarticleDescriptions($this->request->get['blog_id']);
		} else {
			$data['article_description'] = array();
		}

		$data['parentcategory'] = $this->model_magikblog_article->getBlogcategoryall(0);

		if (isset($this->request->post['article_category'])) { 
			$data['article_category'] = $this->request->post['article_category'];
		} elseif (isset($this->request->get['blog_id'])) {  
			$data['article_category'] = $this->model_magikblog_article->getBlogarticlecategory($this->request->get['blog_id']);

		} else {
			$data['article_category'] = array(0);
		}


		$this->load->model('setting/store');
		$data['stores'] = $this->model_setting_store->getStores();

		if (isset($this->request->post['article_store'])) { 
			$data['article_store'] = $this->request->post['article_store'];
		} elseif (isset($this->request->get['blog_id'])) {  
			$data['article_store'] = $this->model_magikblog_article->getBlogarticleStores($this->request->get['blog_id']);

		} else { 
			$data['article_store'] = array(0);
		}
		
		if (isset($this->request->post['author'])) {
			$data['author'] = $this->request->post['author'];
		} elseif (!empty($article_info)) {
			$data['author'] = $article_info['author'];
		} else {
			$data['author'] = '';
		}

		if (isset($this->request->post['image'])) {
			$data['image'] = $this->request->post['image'];
		} elseif (!empty($article_info)) {
			$data['image'] = $article_info['image'];
		} else {
			$data['image'] = '';
		}

		$this->load->model('tool/image');

		if (isset($this->request->post['image']) && is_file(DIR_IMAGE . $this->request->post['image'])) {
			$data['thumb'] = $this->model_tool_image->resize($this->request->post['image'], 100, 100);
		} elseif (!empty($article_info) && is_file(DIR_IMAGE . $article_info['image'])) {
			$data['thumb'] = $this->model_tool_image->resize($article_info['image'], 100, 100);
		} else {
			$data['thumb'] = $this->model_tool_image->resize('no_image.png', 100, 100);
		}

		$data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

		if (isset($this->request->post['publishdate'])) {
			$data['publishdate'] = $this->request->post['publishdate'];
		} elseif (!empty($article_info)) {
			$data['publishdate'] = ($article_info['publish_date'] != '0000-00-00') ? $article_info['publish_date'] : '';
		} else {
			$data['publishdate'] = date('Y-m-d');
		}


		if (isset($this->request->post['display_order'])) {
			$data['display_order'] = $this->request->post['display_order'];
		} elseif (!empty($article_info)) {
			$data['display_order'] = $article_info['display_order'];
		} else {
			$data['display_order'] = 0;
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($article_info)) {
			$data['status'] = $article_info['status'];
		} else {
			$data['status'] = true;
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('magikblog/article_form.tpl', $data));
	}
	public function add() { 
		$this->language->load('magikblog/article');
		
		$this->load->model('magikblog/article');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) { 
			$this->model_magikblog_article->addArticle($this->request->post);		
			
			$this->session->data['success'] = $this->language->get('text_success');
						
			$this->response->redirect($this->url->link('magikblog/article', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getForm();
	}

	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'magikblog/article')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		foreach ($this->request->post['article_description'] as $language_id => $value) {
			if ((utf8_strlen($value['articlename']) < 3) || (utf8_strlen($value['articlename']) > 255)) {
				$this->error['articlename'][$language_id] = $this->language->get('error_article');
			}
			if ((utf8_strlen($value['meta_title']) < 3) || (utf8_strlen($value['meta_title']) > 255)) {
				$this->error['meta_title'][$language_id] = $this->language->get('error_metatitle');
			}
		}
	return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'magikblog/article')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}