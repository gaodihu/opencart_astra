<?php
class ModelModuleCustomSubcategoryThumbnail extends Model {


	// Gives all Categories with necessry data
//for custom block inside menu model
	public function getCategories_custom($parent_id = 0) {
	$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "category c LEFT JOIN " . DB_PREFIX . "category_description cd ON (c.category_id = cd.category_id) LEFT JOIN " . DB_PREFIX . "category_to_store c2s ON (c.category_id = c2s.category_id) WHERE c.parent_id = '" . (int)$parent_id . "' AND cd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND c2s.store_id = '" . (int)$this->config->get('config_store_id') . "'  AND c.status = '1' ORDER BY c.sort_order, LCASE(cd.name)");

	return $query->rows;
	}

	public function getSubCategoryImages($key) {
		$magikslider_image_data = array();

		$magikslider_image_query = $this->db->query("SELECT * FROM  `oc_setting` WHERE  `key` LIKE  'custom_subcategory_thumbnail_module'");
        $info = $magikslider_image_query->rows;


        $subcatimages = unserialize($info[0]['value']);

		foreach ($subcatimages as $mgkimage) {
			$magikslider_image_data[] = array(
				'category_id'       => $mgkimage['category_id'],				
				'image'             => $mgkimage['image']				
			);
		}
		
		return $magikslider_image_data;
	}
		
}
?>