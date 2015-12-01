<?php  
class google_site_verification_ControllerCommonHeader extends astra_ControllerCommonHeader {

	// overridden method
	public function preRender( $template_buffer, $template_name, &$data ) {
		// only modify if controller uses the 'header.tpl' template
		if (!$this->endsWith( $template_name, '/template/common/header.tpl' )) {
			return parent::preRender( $template_buffer, $template_name, $data );
		}
	
		// add data for Google site verifaction
		$data['google_site_verification'] = '';
		if (!isset($this->request->get['route'])) {
			$data['google_site_verification'] = html_entity_decode($this->config->get('config_google_site_verification'));
		} else if ($this->request->get['route'] == 'common/home') {
			$data['google_site_verification'] = html_entity_decode($this->config->get('config_google_site_verification'));
		}
		
		// modify template buffer to include Google site verifaction
		if ($data['google_site_verification']) {
			$template_buffer = str_replace( 
				'<?php echo $google_analytics; ?>', 
				'<?php echo $google_analytics; ?>'."\n".'<?php echo $google_site_verification; ?>'."\n",
				$template_buffer
			);
		}
		
		// call parent method
		return parent::preRender( $template_buffer, $template_name, $data );
	}

	
	private function endsWith( $haystack, $needle ) {
		if (strlen( $haystack ) < strlen( $needle )) {
			return false;
		}
		return (substr( $haystack, strlen($haystack)-strlen($needle), strlen($needle) ) == $needle);
	}

}
?>