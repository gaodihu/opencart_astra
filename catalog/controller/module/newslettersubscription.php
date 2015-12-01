<?php  
class ControllerModuleNewslettersubscription extends Controller {

	public function index() {

		$this->language->load('module/newslettersubscription');

		$data['heading_title'] = $this->language->get('heading_title');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/newslettersubscription.tpl')) {
			return $this->load->view($this->config->get('config_template') . '/template/module/newslettersubscription.tpl', $data);
		} else {
			//return $this->load->view('default/template/module/newslettersubscription.tpl', $data);
		}

	}
	
	public function addsubscriberemail() {

		$this->language->load('module/newslettersubscription');

		$this->load->model('module/newslettersubscription');
 		
		if(isset($this->request->get['email']))
		{
			$msg = $this->model_module_newslettersubscription->EmailSubmit(trim($this->request->get['email']));
		}
		echo $msg;
	}
}
?>