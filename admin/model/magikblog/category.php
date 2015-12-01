<?php
class ModelMagikblogCategory extends Model {

	public function getBlogcategory($category_id) {
	      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "magikblogcategory r WHERE r.category_id = '" . (int)$category_id . "' ");
	      return $query->row;
	}

	public function getTotalBlogcategories($data = array()) {
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "magikblogcategory";
		$query = $this->db->query($sql);
		return $query->row['total'];
	}

	public function getBlogcategoryall($parent_id){
		$blog_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "magikblogcategory f LEFT JOIN " . DB_PREFIX . "magikblogcategory_description fd ON (f.category_id = fd.category_id) WHERE f.parent_id = '" . (int)$parent_id . "' AND fd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY f.display_order, fd.name ASC");
			foreach ($query->rows as $result) {
				$blog_data[] = array(
					'category_id'     => $result['category_id'],
					'name'      => $this->getCategoryall($result['category_id'], $this->config->get('config_language_id')),
					'status'     => $result['status'],
					'display_order' => $result['display_order']
				);
				$blog_data = array_merge($blog_data, $this->getBlogcategoryall($result['category_id']));
			}
			
		return $blog_data;
	}

	public function getCategoryall($category_id) {
		$query = $this->db->query("SELECT name, parent_id FROM " . DB_PREFIX . "magikblogcategory f LEFT JOIN " . DB_PREFIX . "magikblogcategory_description fd ON (f.category_id = fd.category_id) WHERE f.category_id = '" . (int)$category_id . "' AND fd.language_id = '" . (int)$this->config->get('config_language_id') . "' ORDER BY f.display_order, fd.name ASC");
		$blog_info = $query->row;
		if ($blog_info['parent_id']) {
			return $this->getCategoryall($blog_info['parent_id'], $this->config->get('config_language_id')) . '&nbsp;&nbsp;&gt;&nbsp;&nbsp;'. $blog_info['name'];
		} else {
			return $blog_info['name'];
		}
	}
      
	public function getcategoryDescriptions($category_id) {
		$blogcategory_description_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "magikblogcategory_description WHERE category_id = '" . (int)$category_id . "'");
		foreach ($query->rows as $result) {
			$blogcategory_description_data[$result['language_id']] = array(
				'name' => $result['name'],
				'description' => $result['description'],
				'meta_title' => $result['meta_title'],
				'meta_keyword' => $result['meta_keyword'],
				'meta_description' => $result['meta_description']
				
			);
		}
		return $blogcategory_description_data;
	}

	public function getBlogcategoryStores($category_id){
		$category_store_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "magikblogcategory_to_store WHERE category_id = '" . (int)$category_id . "'");
		foreach ($query->rows as $result) {
			$category_store_data[] = $result['store_id'];
		}
		return $category_store_data;
	}
	public function addBlogcategory($data) {

		$this->event->trigger('pre.admin.magikblogcategory.add', $data);
  
		$this->db->query("INSERT INTO " . DB_PREFIX . "magikblogcategory SET parent_id = '" . (int)$data['parent_id'] . "', display_order = '" . (int)$data['display_order'] . "', status = '" . (int)$data['status'] . "'");

		$category_id = $this->db->getLastId();

		foreach ($data['category_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "magikblogcategory_description SET category_id = '" . (int)$category_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "'");
		}

		if (isset($data['category_store'])) {
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "magikblogcategory_to_store SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		/*if (isset($data['keyword'])) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "url_alias SET query = 'category_id=" . (int)$category_id . "', keyword = '" . $this->db->escape($data['keyword']) . "'");
		}*/

		$this->cache->delete('magikblogcategory');

		$this->event->trigger('post.admin.magikblogcategory.add', $category_id);

		return $category_id;

        }
	
	public function editBlogcategory($category_id, $data){
		$this->db->query("UPDATE " . DB_PREFIX . "magikblogcategory SET parent_id = '" . (int)$data['parent_id'] . "', status = '" . (int)$data['status'] . "', display_order = '" . (int)$data['display_order'] . "' WHERE category_id = '" . (int)$category_id . "'");

		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblogcategory_description WHERE category_id = '" . (int)$category_id . "'");
		foreach ($data['category_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "magikblogcategory_description SET category_id = '" . (int)$category_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['name']) . "', description = '" . $this->db->escape($value['description']) . "', meta_title = '" . $this->db->escape($value['meta_title']) . "', meta_description = '" . $this->db->escape($value['meta_description']) . "', meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "' ");
		}
	  
		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblogcategory_to_store WHERE category_id = '" . (int)$category_id . "'");
		if (isset($data['category_store'])) {		
			foreach ($data['category_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "magikblogcategory_to_store SET category_id = '" . (int)$category_id . "', store_id = '" . (int)$store_id . "'");
			}
		}
	}

	public function deleteBlogcategory($category_id){
		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblogcategory WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblogcategory_description WHERE category_id = '" . (int)$category_id . "'");
		$query = $this->db->query("SELECT category_id FROM " . DB_PREFIX . "magikblogcategory WHERE parent_id = '" . (int)$category_id . "'");
		foreach ($query->rows as $result) {
			$this->deleteBlogcategory($result['category_id']);
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblogcategory_to_store WHERE category_id = '" . (int)$category_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblog_to_category WHERE category_id = '" . (int)$category_id . "'");

		
	}
}