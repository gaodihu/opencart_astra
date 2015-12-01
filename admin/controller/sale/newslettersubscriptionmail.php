<?php
class ControllerSaleNewslettersubscriptionmail extends Controller {

	private $error = array(); // This is used to set the errors, if any.

	public function index() {
		$this->load->language('sale/newslettersubscriptionmail');

		$this->document->setTitle($this->language->get('heading_title'));

		$data['heading_title'] = $this->language->get('heading_title');
		$data['text_default'] = $this->language->get('text_default');
		$data['heading_mail_title'] = $this->language->get('heading_mail_title');
		$data['text_mail']    = $this->language->get('text_mail');
		$data['text_enabled'] = $this->language->get('text_enabled');
		$data['text_disabled'] = $this->language->get('text_disabled');
		$data['text_yes'] = $this->language->get('text_yes');
		$data['text_no'] = $this->language->get('text_no');
		$data['entry_store'] = $this->language->get('entry_store');
		$data['text_content_top'] = $this->language->get('text_content_top');
		$data['text_content_bottom'] = $this->language->get('text_content_bottom');      
		$data['text_column_left'] = $this->language->get('text_column_left');
		$data['text_column_right'] = $this->language->get('text_column_right');
		$data['entry_to'] = $this->language->get('entry_to');
		$data['entry_message'] = $this->language->get('entry_message');
		$data['entry_subject'] = $this->language->get('entry_subject');
		$data['text_newsletter'] = $this->language->get('text_newsletter');
		$data['text_loading'] = $this->language->get('text_loading');
		$data['entry_title'] = $this->language->get('entry_title');
		$data['entry_status'] = $this->language->get('entry_status');
		$data['button_save'] = $this->language->get('button_save');
		$data['button_send'] = $this->language->get('button_send');
		$data['button_cancel'] = $this->language->get('button_cancel');
		$data['button_add_module'] = $this->language->get('button_add_module');
		$data['button_remove'] = $this->language->get('button_remove');
		 $data['entry_subject'] = $this->language->get('entry_subject');
		$data['entry_message'] = $this->language->get('entry_message');
		$data['token'] = $this->session->data['token'];

		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('sale/newslettersubscriptionmail', 'token=' . $this->session->data['token'], 'SSL')
		);

		$data['cancel'] = $this->url->link('sale/newslettersubscriptionmail', 'token=' . $this->session->data['token'], 'SSL');

		$this->load->model('setting/store');

		$data['stores'] = $this->model_setting_store->getStores();
/*
		$this->load->model('sale/customer_group');

		$data['customer_groups'] = $this->model_sale_customer_group->getCustomerGroups();*/

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('sale/newslettersubscriptionmail.tpl', $data));
	}

	public function send() {

		$this->load->language('sale/newslettersubscriptionmail');

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {

			if (!$this->user->hasPermission('modify', 'sale/newslettersubscriptionmail')) {
				$json['error']['warning'] = $this->language->get('error_permission');
			}

			if (!$this->request->post['subject']) {
				$json['error']['subject'] = $this->language->get('error_subject');
			}

			if (!$this->request->post['message']) {
				$json['error']['message'] = $this->language->get('error_message');
			}
			if (!$json) {
				$this->load->model('setting/store');

				$store_info = $this->model_setting_store->getStore($this->request->post['store_id']);

				if ($store_info) {
					$store_name = $store_info['name'];
				} else {
					$store_name = $this->config->get('config_name');
				}

				$this->load->model('sale/newslettersubscription');

				if (isset($this->request->get['page'])) {
					$page = $this->request->get['page'];
				} else {
					$page = 1;
				}

				$email_total = 0;

				$emails = array();

				switch ($this->request->post['to']) {

				   case 'newsletter':

					$customer_data = array('start' => ($page - 1) * 10, 'limit' => 10);
					$email_total = $this->model_sale_newslettersubscription->getTotalNewslettersubscriptionsmail($customer_data);
					$results = $this->model_sale_newslettersubscription->getNewslettersubscriptionmail($customer_data);

					foreach ($results as $result) {
						$emails[] = $result['email'];
					}

				   break;
				}
		      
				if ($emails) {
					$start = ($page - 1) * 10;
					$end = $start + 10;

					if ($end < $email_total) {
						$json['success'] = sprintf($this->language->get('text_sent'), $start, $email_total);
					} else {
						$json['success'] = $this->language->get('text_success');
					}

					if ($end < $email_total) {
						$json['next'] = str_replace('&amp;', '&', $this->url->link('sale/newslettersubscription/send', 'token=' . $this->session->data['token'] . '&page=' . ($page + 1), 'SSL'));
					} else {
						$json['next'] = '';
					}

					$message  = '<html dir="ltr" lang="en">' . "\n";
					$message .= '  <head>' . "\n";
					$message .= '    <title>' . $this->request->post['subject'] . '</title>' . "\n";
					$message .= '    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">' . "\n";
					$message .= '  </head>' . "\n";
					$message .= '  <body>' . html_entity_decode($this->request->post['message'], ENT_QUOTES, 'UTF-8') . '</body>' . "\n";
					$message .= '</html>' . "\n";

					foreach ($emails as $email) {
						if (preg_match('/^[^\@]+@.*.[a-z]{2,15}$/i', $email)) {
							$mail = new Mail();
							$mail->protocol = $this->config->get('config_mail_protocol');
							$mail->parameter = $this->config->get('config_mail_parameter');
							$mail->smtp_hostname = $this->config->get('config_mail_smtp_hostname');
							$mail->smtp_username = $this->config->get('config_mail_smtp_username');
							$mail->smtp_password = html_entity_decode($this->config->get('config_mail_smtp_password'), ENT_QUOTES, 'UTF-8');
							$mail->smtp_port = $this->config->get('config_mail_smtp_port');
							$mail->smtp_timeout = $this->config->get('config_mail_smtp_timeout');

							$mail->setTo($email);
							$mail->setFrom($this->config->get('config_email'));
							$mail->setSender(html_entity_decode($store_name, ENT_QUOTES, 'UTF-8'));
							$mail->setSubject(html_entity_decode($this->request->post['subject'], ENT_QUOTES, 'UTF-8'));
							$mail->setHtml($message);
							$mail->send();
						}
					}

				}

			}
    

		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}
				
}