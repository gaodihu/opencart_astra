<?php
class ModelModuleMagikslider extends Model {
	public function getInfo($module_id) {
		$magikslider_image_data = array();

		$magikslider_image_query = $this->db->query("SELECT * FROM " . DB_PREFIX . "module WHERE module_id = '" . (int)$module_id . "' ");
        $info = $magikslider_image_query->rows;
        $magikslider = unserialize($info[0]['setting']);
		foreach ($magikslider['magikslider_image'] as $magikslider_image) {

			foreach ($magikslider_image['magikslider_image_description'] as $key => $value) {
				$description[$key]=array('description'=>$value['description']);
				}
			foreach ($magikslider_image['magikslider_image_title'] as $key => $value) {
			$title[$key]=array('title'=>$value['title']);
			}	

			$magikslider_image_data[] = array(
				'magikslider_image_title'       => $title,
				'link'                          => $magikslider_image['link'],
				'image'                         => $magikslider_image['image'],
				'magikslider_image_description' => $description				
			);
		}

		return $magikslider_image_data;
	}
}?>