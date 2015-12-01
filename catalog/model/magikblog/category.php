<?php
class ModelMagikblogCategory extends Model {
	
	public function categoryParentChildTree($parent_id = 0, $spacing = '', $category_tree_array = '') {

	      if (!is_array($category_tree_array))
	      $category_tree_array = array();
 
	      $sql = $this->db->query("SELECT * FROM " . DB_PREFIX . "magikblogcategory mbc LEFT JOIN " . DB_PREFIX . "magikblogcategory_description mbcd ON(mbc.category_id=mbcd.category_id) LEFT JOIN " . DB_PREFIX . "magikblogcategory_to_store mbcs ON(mbc.category_id=mbcs.category_id) 
					 WHERE mbc.parent_id='" . (int)$parent_id . "' AND mbcd.language_id='" . (int)$this->config->get('config_language_id') . "' AND mbcs.store_id='" . (int)$this->config->get('config_store_id') . "' AND mbc.status=1 ORDER BY mbc.display_order, LCASE(mbcd.name)");
	
	      if ( $sql->num_rows > 0) {

		foreach ($sql->rows as $rowCategories) {
		    $category_tree_array[] = array("category_id" => $rowCategories['category_id'], "name" => $spacing . $rowCategories['name']);
		    $category_tree_array = $this->categoryParentChildTree($rowCategories['category_id'], '&nbsp;&nbsp;&nbsp;&nbsp;'.$spacing . '&nbsp;', $category_tree_array);
		}
		
	      }
	      
	      return $category_tree_array;
	}

	public function getTotalBlogCategories($data = array()){ 

		  $sql = "SELECT COUNT(mb.blog_id) AS total FROM " . DB_PREFIX . "magikblog mb
			  LEFT JOIN " . DB_PREFIX . "magikblog_description mbd ON (mb.blog_id = mbd.blog_id) 
                          LEFT JOIN " . DB_PREFIX . "magikblog_to_store mb2s ON (mb.blog_id = mb2s.blog_id) 
                          LEFT JOIN " . DB_PREFIX . "magikblog_to_category mbc ON (mb.blog_id = mbc.blog_id)
                          WHERE mbc.category_id = '" . (int)$data['filter_category_id'] . "' AND mbd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND mb2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND mb.status = '1'";
		
		  $sql = $this->db->query($sql);
		  return $sql->row['total'];

	}

	public function getCategoryByName($data = array()){
		  $sql = "SELECT mbcd.name as name,mbcd.meta_title AS meta_title,mbcd.meta_description AS meta_description,mbcd.meta_keyword AS meta_keyword FROM " . DB_PREFIX . "magikblogcategory mbc LEFT JOIN " . DB_PREFIX . "magikblogcategory_description mbcd ON(mbc.category_id=mbcd.category_id)
			  WHERE mbc.category_id = '" . (int)$data['filter_category_id'] . "'";
		
		  $sql = $this->db->query($sql);
		  return $sql->rows;
	}
  
	public function getArticles($data = array()){
		$sql = "SELECT * FROM " . DB_PREFIX . "magikblog mb
					   LEFT JOIN " . DB_PREFIX . "magikblog_description mbd ON (mb.blog_id = mbd.blog_id) 
                                           LEFT JOIN " . DB_PREFIX . "magikblog_to_store mb2s ON (mb.blog_id = mb2s.blog_id) 
                                           LEFT JOIN " . DB_PREFIX . "magikblog_to_category mbc ON (mb.blog_id = mbc.blog_id)
                                           WHERE mbc.category_id = '" . (int)$data['filter_category_id'] . "' AND mbd.language_id = '" . (int)$this->config->get('config_language_id') . "' AND mb2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND mb.status = '1'";

		$sql .= " ORDER BY mb.display_order ASC, mb.publish_date DESC";

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}
		$sql = $this->db->query($sql);

		return $sql->rows;
	}

	public function getLatestposts($data = array()){

		$sql = "SELECT DISTINCT(mbc.blog_id),mb.image,mb.publish_date,mbd.name,mbd.description  FROM " . DB_PREFIX . "magikblog mb
					   LEFT JOIN " . DB_PREFIX . "magikblog_description mbd ON (mb.blog_id = mbd.blog_id) 
                                           LEFT JOIN " . DB_PREFIX . "magikblog_to_store mb2s ON (mb.blog_id = mb2s.blog_id) 
					   LEFT JOIN " . DB_PREFIX . "magikblog_to_category mbc ON (mb.blog_id = mbc.blog_id)
                                           WHERE mbd.language_id = '" . (int)$this->config->get('config_language_id') . "' 
					   AND mb2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND mb.status = '1'";

	      if (!empty($data['filter_exclude_category'])) {
			  $sql .= " AND mbc.category_id not in (" . $data['filter_exclude_category'] . ") ";
		}
		$sql .=" ORDER BY mb.display_order ASC, mb.publish_date DESC";
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$sql = $this->db->query($sql);

		return $sql->rows;
	}

	public function getHomepageposts($data = array()){ 

		$sql = "SELECT DISTINCT(mbc.blog_id),mb.image,mb.publish_date,mbd.name,mbd.description  FROM " . DB_PREFIX . "magikblog mb
					   LEFT JOIN " . DB_PREFIX . "magikblog_description mbd ON (mb.blog_id = mbd.blog_id) 
                                           LEFT JOIN " . DB_PREFIX . "magikblog_to_store mb2s ON (mb.blog_id = mb2s.blog_id) 
					   LEFT JOIN " . DB_PREFIX . "magikblog_to_category mbc ON (mb.blog_id = mbc.blog_id)
                                           WHERE mbd.language_id = '" . (int)$this->config->get('config_language_id') . "' 
					   AND mb2s.store_id = '" . (int)$this->config->get('config_store_id') . "' AND mb.status = '1'";

	      if (!empty($data['filter_exclude_category'])) {
			  $sql .= " AND mbc.category_id not in (" . $data['filter_exclude_category'] . ") ";
		}
		$sql .=" ORDER BY mb.display_order ASC, mb.publish_date DESC";
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$sql = $this->db->query($sql);

		return $sql->rows;
	}
}
