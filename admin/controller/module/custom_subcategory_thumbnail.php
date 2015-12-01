<?php
class ControllerModuleCustomSubcategoryThumbnail extends Controller {
    private $error = array(); // This is used to set the errors, if any.
 
    public function index() {
         // Loading the language file of custom_subcategory_thumbnail
        $this->load->language('module/custom_subcategory_thumbnail'); 
     
        // Set the title of the page to the heading title in the Language file i.e., Hello World
        $this->document->setTitle(strip_tags($this->language->get('heading_title')));
     
        // Load the Setting Model  (All of the OpenCart Module & General Settings are saved using this Model )
        $this->load->model('setting/setting');
     //print_r($_POST);exit;
        // Start If: Validates and check if data is coming by save (POST) method
        if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {

            // Parse all the coming data to Setting Model to save it in database.
            $this->model_setting_setting->editSetting('custom_subcategory_thumbnail', $this->request->post);
     
            // To display the success text on data save
            $this->session->data['success'] = $this->language->get('text_success');
     
            // Redirect to the Module Listing
            $this->response->redirect($this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'));
        }
     
        // Assign the language data for parsing it to view
        $data['heading_title'] = $this->language->get('heading_title');
     
        $data['text_edit']    = $this->language->get('text_edit');
        $data['text_enabled'] = $this->language->get('text_enabled');
        $data['text_disabled'] = $this->language->get('text_disabled');
        $data['text_content_top'] = $this->language->get('text_content_top');
        $data['text_content_bottom'] = $this->language->get('text_content_bottom');      
        $data['text_content_right'] = $this->language->get('text_content_right');      
        
        $data['entry_code'] = $this->language->get('entry_code');
        $data['entry_position'] = $this->language->get('entry_position');
        $data['entry_status'] = $this->language->get('entry_status');
        
        $data['button_save'] = $this->language->get('button_save');
        $data['button_cancel'] = $this->language->get('button_cancel');
        $data['button_module_add'] = $this->language->get('button_module_add');
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
            'href'      => $this->url->link('module/custom_subcategory_thumbnail', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
          
        $data['action'] = $this->url->link('module/custom_subcategory_thumbnail', 'token=' . $this->session->data['token'], 'SSL'); // URL to be directed when the save button is pressed
     
        $data['cancel'] = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'); // URL to be redirected when cancel button is pressed
              
        // This block checks, if the hello world text field is set it parses it to view otherwise get the default 
        // hello world text field from the database and parse it

        $this->load->model('module/custom_subcategory_thumbnail');
        $data['categories'] = array();
        $data['subcategories'] = array();       

        $this->load->model('catalog/category');
        $results=$this->model_catalog_category->getCategories();
       
        foreach ($results as $key => $value) {
            if($value['parent_id']==0)
            {              
                  $categories = $this->model_module_custom_subcategory_thumbnail->getCategories_custom($value['category_id']);
                  foreach ($categories as $key1 => $value1) {
                     $data['subcategories'][$value1['category_id']]= $value1['name'];
                  }             
            }    

        }
        

        $data['modules'] = array();
        $this->load->model('tool/image');

        $data['subcat_images']=array();

        if (isset($this->request->post['custom_subcategory_thumbnail_module'])) {
            $subcat_images = $this->request->post['custom_subcategory_thumbnail_module'];           
        } elseif ($this->config->get('custom_subcategory_thumbnail_module')) { 
            $subcat_images = $this->model_module_custom_subcategory_thumbnail->getSubCategoryImages('custom_subcategory_thumbnail_module');
        } 

        else {
            $subcat_images = array();
        }

        foreach ($subcat_images as $magikslider_image) {
            if (is_file(DIR_IMAGE . $magikslider_image['image'])) {
                $image = $magikslider_image['image'];
                $thumb = $magikslider_image['image'];
            } else {
                $image = '';
                $thumb = 'no_image.png';
            }

            $data['subcat_images'][] = array(

                'category_id'    => $magikslider_image['category_id'],               
                'image'          => $image,
                'thumb'          => $this->model_tool_image->resize($thumb, 160, 120)          

            );
        }    
        

        $data['placeholder'] = $this->model_tool_image->resize('no_image.png', 100, 100);

        
        $data['header'] = $this->load->controller('common/header');
        $data['column_left'] = $this->load->controller('common/column_left');
        $data['footer'] = $this->load->controller('common/footer');

        $this->response->setOutput($this->load->view('module/custom_subcategory_thumbnail.tpl', $data));

    }

    /* Function that validates the data when Save Button is pressed */
    protected function validate() {
 
        // Block to check the user permission to manipulate the module
        if (!$this->user->hasPermission('modify', 'module/custom_subcategory_thumbnail')) {
            $this->error['warning'] = $this->language->get('error_permission');
        }
 

        // Block returns true if no error is found, else false if any error detected
        if (!$this->error) {
            return true;
        } else {
            return false;
        }
    }
}