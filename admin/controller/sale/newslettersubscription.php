<?php
class ControllerSaleNewslettersubscription extends Controller {
	private $error = array();

	public function index() { 
		$this->load->language('sale/newslettersubscription');
		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('sale/newslettersubscription');
		$this->getList();
	}


	public function edit() {

		$this->load->language('sale/newslettersubscription');
		$this->document->setTitle($this->language->get('heading_title'));
		$this->load->model('sale/newslettersubscription');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validateForm()) {
			$this->model_sale_newslettersubscription->editNewslettersubscription($this->request->get['subscription_id'], $this->request->post);

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

			$this->response->redirect($this->url->link('sale/newslettersubscription', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getForm();
	}

	public function delete() {
		$this->load->language('sale/newslettersubscription');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('sale/newslettersubscription');

		if (isset($this->request->post['selected']) && $this->validateDelete()) {
			foreach ($this->request->post['selected'] as $subscription_id) {
				$this->model_sale_newslettersubscription->deleteNewslettersubscription($subscription_id);
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

			$this->response->redirect($this->url->link('sale/newslettersubscription', 'token=' . $this->session->data['token'] . $url, 'SSL'));
		}

		$this->getList();
	}

	protected function getList() {
		
		if (isset($this->request->get['sort'])) {
			$sort = $this->request->get['sort'];
		} else {
			$sort = 'r.create_time';
		}

		if (isset($this->request->get['order'])) {
			$order = $this->request->get['order'];
		} else {
			$order = 'DESC';
		}

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

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
			'href' => $this->url->link('sale/newslettersubscription', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);
		
		$data['add'] = $this->url->link('sale/newslettersubscription/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		$data['delete'] = $this->url->link('sale/newslettersubscription/delete', 'token=' . $this->session->data['token'] . $url, 'SSL');
		//1
		$data['newslettersubscriptions'] = array();

		$filter_data = array(
			'sort'              => $sort,
			'order'             => $order,
			'start'             => ($page - 1) * $this->config->get('config_limit_admin'),
			'limit'             => $this->config->get('config_limit_admin')
		);
//1
		$newslettersubscription_total = $this->model_sale_newslettersubscription->getTotalNewslettersubscriptions($filter_data);

		$results = $this->model_sale_newslettersubscription->getNewslettersubscriptions($filter_data);

		$this->load->language('sale/newslettersubscription');
		foreach ($results as $result) {
			$data['newslettersubscriptions'][] = array(
				'subscription_id'  => $result['subscription_id'],
				'email'     => $result['email'],
				'status'     => ($result['status']) ? $this->language->get('text_yes') : $this->language->get('text_no'),
				'date_added' => date($this->language->get('date_format_short'), strtotime($result['create_time'])),
				'edit'       => $this->url->link('sale/newslettersubscription/edit', 'token=' . $this->session->data['token'] . '&subscription_id=' . $result['subscription_id'] . $url, 'SSL')
				
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
		$data['column_email'] = $this->language->get('column_email');
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

		if ($order == 'ASC') {
			$url .= '&order=DESC';
		} else {
			$url .= '&order=ASC';
		}

		if (isset($this->request->get['page'])) {
			$url .= '&page=' . $this->request->get['page'];
		}

		$data['sort_status'] = $this->url->link('sale/newslettersubscription', 'token=' . $this->session->data['token'] . '&sort=r.status' . $url, 'SSL');
		$data['sort_date_added'] = $this->url->link('sale/newslettersubscription', 'token=' . $this->session->data['token'] . '&sort=r.create_time' . $url, 'SSL');
		$data['sort_email'] = $this->url->link('sale/newslettersubscription', 'token=' . $this->session->data['token'] . '&sort=r.email' . $url, 'SSL');

		$url = '';

		if (isset($this->request->get['sort'])) {
			$url .= '&sort=' . $this->request->get['sort'];
		}

		if (isset($this->request->get['order'])) {
			$url .= '&order=' . $this->request->get['order'];
		}

		$pagination = new Pagination();
		$pagination->total = $newslettersubscription_total;
		$pagination->page = $page;
		$pagination->limit = $this->config->get('config_limit_admin');
		$pagination->url = $this->url->link('sale/newslettersubscription', 'token=' . $this->session->data['token'] . $url . '&page={page}', 'SSL');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($newslettersubscription_total) ? (($page - 1) * $this->config->get('config_limit_admin')) + 1 : 0, ((($page - 1) * $this->config->get('config_limit_admin')) > ($newslettersubscription_total - $this->config->get('config_limit_admin'))) ? $newslettersubscription_total : ((($page - 1) * $this->config->get('config_limit_admin')) + $this->config->get('config_limit_admin')), $newslettersubscription_total, ceil($newslettersubscription_total / $this->config->get('config_limit_admin')));

		$data['sort'] = $sort;
		$data['order'] = $order;

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('sale/newslettersubscription.tpl', $data));
	}

	protected function getForm() {
		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_form'] = !isset($this->request->get['subscription_id']) ? $this->language->get('text_add') : $this->language->get('text_edit');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['column_subscription'] = $this->language->get('column_subscription');
		$data['column_email'] = $this->language->get('column_email');
		$data['column_status'] = $this->language->get('column_status');
		$data['entry_answer'] = $this->language->get('entry_answer');
		$data['text_publish'] = $this->language->get('text_publish');
		$data['entry_subscription_read_only'] = $this->language->get('entry_subscription_read_only');
		$data['entry_author'] = $this->language->get('entry_author');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_delete'] = $this->language->get('button_delete');

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

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
			'href' => $this->url->link('sale/newslettersubscription', 'token=' . $this->session->data['token'] . $url, 'SSL')
		);
		
		if (!isset($this->request->get['subscription_id'])) {
			$data['action'] = $this->url->link('sale/newslettersubscription/add', 'token=' . $this->session->data['token'] . $url, 'SSL');
		} else {
			$data['action'] = $this->url->link('sale/newslettersubscription/edit', 'token=' . $this->session->data['token'] . '&subscription_id=' . $this->request->get['subscription_id'] . $url, 'SSL');
		}

		$data['cancel'] = $this->url->link('sale/newslettersubscription', 'token=' . $this->session->data['token'] . $url, 'SSL');

		$this->load->model('sale/newslettersubscription');

		if (isset($this->request->get['subscription_id']) && ($this->request->server['REQUEST_METHOD'] != 'POST')) {
			$newslettersubscription_info = $this->model_sale_newslettersubscription->getNewslettersubscription($this->request->get['subscription_id']);
		}
		  
		$data['token'] = $this->session->data['token'];

		if (isset($this->request->post['email'])) {
			$data['email'] = $this->request->post['email'];
		} elseif (!empty($newslettersubscription_info)) {
			$data['email'] = $newslettersubscription_info['email'];
		} else {
			$data['email'] = '';
		}

		if (isset($this->request->post['status'])) {
			$data['status'] = $this->request->post['status'];
		} elseif (!empty($newslettersubscription_info)) {
			$data['status'] = $newslettersubscription_info['status'];
		} else {
			$data['status'] = '';
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('sale/newslettersubscription_form.tpl', $data));
	}


	protected function validateForm() {
		if (!$this->user->hasPermission('modify', 'sale/newslettersubscription')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

	return !$this->error;
	}

	protected function validateDelete() {
		if (!$this->user->hasPermission('modify', 'sale/newslettersubscription')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}

		return !$this->error;
	}
}