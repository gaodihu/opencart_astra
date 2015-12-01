<?php
class ControllerMagikblogCategory extends Controller {
	private $error = array();

	public function index() { 


		$this->load->language('magikblog/category');
		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('magikblog/category');

		$this->getList();

	}

	public function add() { 

		$this->language->load('magikblog/category');
		
		$this->load->model('magikblog/category');
		
		$this->document->setTitle($this->language->get('heading_title'));
		
		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) { 
			$this->model_magikblog_category->addBlogcategory($this->request->post);		
			
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
			
			$this->response->redirect($this->url->link('magikblog/category', 'token=' . $this->session->data['token'], 'SSL'));
		}

		$this->getForm();
	}
	public function edit() {

		$this->load->language('magikblog/category');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('magikblog/category');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			
			$this->model_magikblog_category->editBlogcategory($this->request->get['category_id'], $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');
			$url = '';
			if (isset($this->request->get['sort'])) { $url .= '&sort=' . $this->request->get['sort'];}
			if (isset($this->request->get['order'])) { $url .= '&order=' . $this->request->get['order'];}
			if (isset($this->request->get['page'])) { $url .= '&page=' . $this->request->get['page']; }
			$this->response->redirect($this->url->link('magikblog/category', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {

		$this->load->language('magikblog/category');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('magikblog/category');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $category_id) {
				$this->model_magikblog_category->deleteBlogcategory($category_id);
			}

			$this->session->data['delete_success'] = $this->language->get('text_delete_success');
			$url = '';
			if (isset($this->request->get['sort'])) { $url .= '&sort=' . $this->request->get['sort'];}
			if (isset($this->request->get['order'])) { $url .= '&order=' . $this->request->get['order'];}
			if (isset($this->request->get['page'])) { $url .= '&page=' . $this->request->get['page']; }
			$this->response->redirect($this->url->link('magikblog/category', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}
		$this->getList();
	}

	protected function getList() {
		
		if (isset($this->request->get['sort'])) { $sort = $this->request->get['sort'];
		} else { $sort = 'r.name'; }

		if (isset($this->request->get['order'])) { $order = $this->request->get['order'];
		} else { $order = 'ASC'; }

		if (isset($this->request->get['page'])) { $page = $this->request->get['page'];
		} else { $page = 1; }

		$url = '';

 		if (isset($this->request->get['sort'])) { $url .= '&sort=' . $this->request->get['sort']; }
		if (isset($this->request->get['order'])) { $url .= '&order=' . $this->request->get['order']; }
		if (isset($this->request->get['page'])) { $url .= '&page=' . $this->request->get['page'];}
		
		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('magikblog/category', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);
		
		$data['add'] = $this->url->link('magikblog/category/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('magikblog/category/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		
		$data['blogcategories'] = array();

		$filter_data = array(
			'sort'              => $sort,
			'order'             => $order,
			'start'             => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'             => $this->config->get('config_limit_admin')
		);

		$blogcategory_total = $this->model_magikblog_category->getTotalBlogcategories($filter_data);
	  
		$results = $this->model_magikblog_category->getBlogcategoryall(0);

		$this->load->language('magikblog/category');
		foreach ($results as $result) {
			$data['blogcategories'][] = array(
				'category_id'  => $result['category_id'],
				'name'  => $result['name'],
				'status'     => ($result['status']) ? $this->language->get('text_yes') : $this->language->get('text_no'),
				'display_order'  => $result['display_order'],
				'edit'       => $this->url->link('magikblog/category/edit', 'token=' . $this->session->data['token'] . '&category_id=' . $result['category_id'] . $url, 'SSL')
				
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
		$data['column_name'] = $this->language->get('column_name');
		$data['column_display_order'] = $this->language->get('column_display_order');
		$data['column_status'] = $this->language->get('column_status');
		$data['column_date_added'] = $this->language->get('column_date_added');
		$data['column_action'] = $this->language->get('column_action');
		$data['button_add'] = $this->language->get('button_add');
		$data['button_edit'] = $this->language->get('button_edit');
		$data['button_answer'] = $this->language->get('button_answer');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['text_delete_success'] = $this->language->get('text_delete_success');


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

		if ($order == 'ASC') { $url .= '&order=DESC'; } else { $url .= '&order=ASC'; }

		if (isset($this->request->get['page'])) { $url .= '&page=' . $this->request->get['page']; }

		$data['sort_name'] = $this->url->link('magikblog/category', 'token=' . $this->session->data['token'] . '&sort=r.name' . $url, 'SSL');
		$data['sort_status'] = $this->url->link('magikblog/category', 'token=' . $this->session->data['token'] . '&sort=r.status' . $url, 'SSL');
		$data['sort_display_order'] = $this->url->link('magikblog/category', 'token=' . $this->session->data['token'] . '&sort=r.display_order' . $url, 'SSL');
		
		$url = '';

		if (isset($this->request->get['sort'])) { $url .= '&sort=' . $this->request->get['sort']; }

		if (isset($this->request->get['order'])) { $url .= '&order=' . $this->request->get['order']; }

		$pagination = new Pagination();
		$pagination->total = $blogcategory_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('magikblog/category', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($blogcategory_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($blogcategory_total - $this->config->get('config_limit_admin'))) ? $blogcategory_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $blogcategory_total, ceil($blogcategory_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('magikblog/category.tpl', $data));
	}

	protected function getForm() {

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_form'] = !isset($this->request->get['category_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['text_publish'] = $this->language->get('text_publish');
		$data['text_none'] = $this->language->get('text_none');
		$data['text_default'] = $this->language->get('text_default');
		$data['text_separator'] = $this->language->get('text_separator');
		$data['column_status'] = $this->language->get('column_status');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_description'] = $this->language->get('entry_description');
		$data['entry_meta_title'] = $this->language->get('entry_meta_title');
		$data['entry_meta_description'] = $this->language->get('entry_meta_description');
		$data['entry_meta_keyword'] = $this->language->get('entry_meta_keyword');
		$data['entry_parent'] = $this->language->get('entry_parent');
		$data['entry_store'] = $this->language->get('entry_store');
		$data['entry_display_order'] = $this->language->get('entry_display_order');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_delete'] = $this->language->get('button_delete');
		$data['tab_general'] = $this->language->get('tab_general');
		$data['tab_data'] = $this->language->get('tab_data');

	
		//Error
		if (isset($this->error['warning'])) { $data['error_warning'] = $this->error['warning'];
		} else { $data['error_warning'] = ''; }

		if (isset($this->error['name'])) { $data['error_name'] = $this->error['name'];
		} else { $data['error_name'] = array(); }

		if (isset($this->error['meta_title'])) { $data['error_meta_title'] = $this->error['meta_title'];
		} else { $data['error_meta_title'] = array(); }

		$url = '';
		if (isset($this->request->get['sort'])) { $url .= '&sort=' . $this->request->get['sort']; }
		if (isset($this->request->get['order'])) { $url .= '&order=' . $this->request->get['order']; }
		if (isset($this->request->get['page'])) { $url .= '&page=' . $this->request->get['page']; }

		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('magikblog/category', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);
		
		if (!isset($this->request->get['category_id'])) {
			$data['action'] = $this->url->link('magikblog/category/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('magikblog/category/edit', 'token=' . $this->session->data['token'] . '&category_id=' . $this->request->get['category_id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link('magikblog/category', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->load->model('magikblog/category');

		if (isset($this->request->get['category_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) { 
			$category_info = $this->model_magikblog_category->getBlogcategory($this->request->get['category_id']);
		}
		
		$data['token'] = $this->session->data['token'];

		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();

		if (isset($this->request->post['category_description'])) {
			$data['category_description'] = $this->request->post['category_description'];
		} elseif (isset($this->request->get['category_id'])) {
			$data['category_description'] = $this->model_magikblog_category->getcategoryDescriptions($this->request->get['category_id']);
		} else {
			$data['category_description'] = array();
		}

		$data['parentcategory'] = $this->model_magikblog_category->getBlogcategoryall(0);

		if (isset($this->request->post['parent_id'])) {
			$data['parent_id'] = $this->request->post['parent_id'];
		} elseif (isset($category_info)) {
			$data['parent_id'] = $category_info['parent_id'];
		} else {
			$data['parent_id'] = '';
		}

		$this->load->model('setting/store');
		$data['stores'] = $this->model_setting_store->getStores();

		if (isset($this->request->post['category_store'])) {
			$data['category_store'] = $this->request->post['category_store'];
		} elseif (isset($this->request->get['category_id'])) { 
			$data['category_store'] = $this->model_magikblog_category->getBlogcategoryStores($this->request->get['category_id']);
		} else {
			$data['category_store'] = array(0);
		}

		if (isset($this->request->post['display_order'])) {
			$data['display_order'] = $this->request->post['display_order'];
		} elseif (!empty($category_info)) {
			$data['display_order'] = $category_info['display_order'];
		} else {
			$data['display_order'] = 0;
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($category_info)) {
			$data['status'] = $category_info['status'];
		} else {
			$data['status'] = true;
		}
		
		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('magikblog/category_form.tpl', $data));
	}

	protected function validateForm() {

		if (!$this->user->hasPermission('modify', 'magikblog/category')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		foreach ($this->request->post['category_description'] as $language_id => $value) {
			if ((utf8_strlen($value['name']) < 2) || (utf8_strlen($value['name']) > 255)) {
				$this->error['name'][$language_id] = $this->language->get('error_name');
			}

			if ((utf8_strlen($value['meta_title']) < 3) || (utf8_strlen($value['meta_title']) > 255)) {
				$this->error['meta_title'][$language_id] = $this->language->get('error_meta_title');
			}
		}

		return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'magikblog/category')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}