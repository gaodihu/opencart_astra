<?php
class ControllerModuleMagikastra extends Controller {
    private $error = array(); // This is used to set the errors, if any.
 
    public function index() {
        // Loading the language file of magikastra
        $this->load->language('module/magikastra'); 
     
        // Set the title of the page to the heading title in the Language file i.e., Hello World
        $this->document->setTitle(strip_tags($this->language->get('heading_title')));
     
        // Load the Setting Model  (All of the OpenCart Module & General Settings are saved using this Model )
        $this->load->model('setting/setting');
     
        // Start If: Validates and check if data is coming by save (POST) method
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            // Parse all the coming data to Setting Model to save it in database.

            $this->model_setting_setting->editSetting('magikastra', $this->request->post);
     
            // To display the success text on data save
            $this->session->data['success'] = $this->language->get('text_success');
     
            // Redirect to the Module Listing
            $this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }
     
        // Assign the language data for parsing it to view
        $data['heading_title'] = $this->language->get('heading_title');
     
        $data['text_edit']    = $this->language->get('text_edit');
        $data['text_yes']    = $this->language->get('text_yes');
        $data['text_no']    = $this->language->get('text_no');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_content_top'] = $this->language->get('text_content_top');
        $data['text_content_bottom'] = $this->language->get('text_content_bottom');      
        $data['text_column_left'] = $this->language->get('text_column_left');
        $data['text_column_right'] = $this->language->get('text_column_right');
     
        $data['entry_code'] = $this->language->get('entry_code');
        $data['entry_layout'] = $this->language->get('entry_layout');
        $data['entry_position'] = $this->language->get('entry_position');
        $data['entry_status'] = $this->language->get('entry_status');
        $data['entry_sort_order'] = $this->language->get('entry_sort_order');
     
        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['button_add_module'] = $this->language->get('button_add_module');
        $data['button_remove'] = $this->language->get('button_remove');
         
        // This Block returns the warning if any
        if (isset($this->error['warning'])) {
            $data['error_warning'] = $this->error['warning'];
        } else {
            $data['error_warning'] = '';
        }
     
        // This Block returns the error code if any
        if (isset($this->error['code'])) {
            $data['error_code'] = $this->error['code'];
        } else {
            $data['error_code'] = '';
        }     
     
        // Making of Breadcrumbs to be displayed on site
        $data['breadcrumbs'] = array();
        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );
        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_module'),
            'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        $data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('module/magikastra', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
          
        $data['action'] = $this->url->link('module/magikastra', 'token=' . $this->session->data['token'], 'SSL'); // URL to be directed when the save button is pressed
     
        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'); // URL to be redirected when cancel button is pressed
              
        // This block checks, if the hello world text field is set it parses it to view otherwise get the default 
        // hello world text field from the database and parse it
        
$config_data = array(
        
        'magikastra_address',
        'magikastra_phone',
        'magikastra_email',
        'magikastra_fb',
        'magikastra_twitter',
        'magikastra_gglplus',
        'magikastra_rss',
        'magikastra_pinterest',
        'magikastra_linkedin',
        'magikastra_youtube',
        'magikastra_powerby',
        'magikastra_home_option',
        'magikastra_quickview_button',
        'magikastra_scroll_totop',
        'magikastra_sale_label',
        'magikastra_sale_labeltitle',
        'magikastra_sale_labelcolor',
        'magikastra_menubar_cb',
        'magikastra_menubar_cbtitle',
        'magikastra_menubar_cbcontent',
        'magikastra_vmenubar_cb',
        'magikastra_vmenubar_cbtitle',
        'magikastra_vmenubar_cbcontent',
        'magikastra_product_ct',
        'magikastra_product_cttitle',
        'magikastra_product_ctcontent',
        'magikastra_product_ct2',
        'magikastra_product_ct2title',
        'magikastra_product_ct2content',
        'magikastra_newsletter',
        'magikastra_newslettercontent',
        'magikastra_footer_cb',
        'magikastra_footer_cbcontent',
        'magikastra_body_bg',
        'magikastra_body_bg_ed',
        'magikastra_fontcolor',
        'magikastra_fontcolor_ed',
        'magikastra_linkcolor',
        'magikastra_linkcolor_ed',
        'magikastra_linkhovercolor',
        'magikastra_linkhovercolor_ed',
        'magikastra_headerbg',
        'magikastra_headerbg_ed',
        'magikastra_headerlinkcolor',
        'magikastra_headerlinkcolor_ed',
        'magikastra_headerlinkhovercolor',
        'magikastra_headerlinkhovercolor_ed',
        'magikastra_headerclcolor',
        'magikastra_headerclcolor_ed',
        'magikastra_mmbgcolor',
        'magikastra_mmbgcolor_ed',
        'magikastra_mmlinkscolor',
        'magikastra_mmlinkscolor_ed',
        'magikastra_mmlinkshovercolor',
        'magikastra_mmlinkshovercolor_ed',
        'magikastra_mmslinkscolor',
        'magikastra_mmslinkscolor_ed',
        'magikastra_mmslinkshovercolor',
        'magikastra_mmslinkshovercolor_ed',
        'magikastra_buttoncolor',
        'magikastra_buttoncolor_ed',
        'magikastra_buttonhovercolor',
        'magikastra_buttonhovercolor_ed',
        'magikastra_pricecolor',
        'magikastra_pricecolor_ed',
        'magikastra_oldpricecolor',
        'magikastra_oldpricecolor_ed',
        'magikastra_newpricecolor',
        'magikastra_newpricecolor_ed',
        'magikastra_footerbg',
        'magikastra_footerbg_ed',
        'magikastra_footerlinkcolor',
        'magikastra_footerlinkcolor_ed',
        'magikastra_footerlinkhovercolor',
        'magikastra_footerlinkhovercolor_ed',
        'magikastra_powerbycolor',
        'magikastra_powerbycolor_ed',
        'magikastra_fonttransform',
        'magikastra_productpage_cb',
        'magikastra_productpage_cbcontent',
        'magikastra_headercb_ed',
        'magikastra_headercb_content',
        'magikastra_footer_fb',
        'magikastra_footer_fbcontent',
        'magikastra_animation_effect'
        );

foreach ($config_data as $conf) {
            if (isset($this->request->post[$conf])) {
                $data[$conf] = $this->request->post[$conf];
                
            } else {
                $data[$conf] = $this->config->get($conf);

            }
        } 

 
   
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('module/magikastra.tpl', $data));

    }

    /* Function that validates the data when Save Button is pressed */
    protected function validate() {
 
        // Block to check the user permission to manipulate the module
        if (!$this->user->hasPermission('modify', 'module/magikastra')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
 
        /* End Block*/
 
        // Block returns true if no error is found, else false if any error detected
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
}