<?php
class ModelMagikblogArticle extends Model {
      
	public function getBlogarticle($blog_id) {
	      $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "magikblog m WHERE m.blog_id = '" . (int)$blog_id . "' ");
	      return $query->row;
	}
	public function getTotalArticles($data = array()) {
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "magikblog";
		$query = $this->db->query($sql);
		return $query->row['total'];
	}

	public function getBlogarticleStores($blog_id){
		$article_store_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "magikblog_to_store WHERE blog_id = '" . (int)$blog_id . "'");
		foreach ($query->rows as $result) {
			$article_store_data[] = $result['store_id'];
		}
		return $article_store_data;
	}

	public function getarticleDescriptions($blog_id) {
		$article_description_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "magikblog_description WHERE blog_id = '" . (int)$blog_id . "'");
		foreach ($query->rows as $result) {
			$article_description_data[$result['language_id']] = array(
				'name' => $result['name'],
				'description' => $result['description'],
				'meta_title' => $result['meta_title'],
				'meta_description' => $result['meta_description'],
				'meta_keyword' => $result['meta_keyword'],
				'tags' => $result['tags']
			);
		}
		return $article_description_data;
	}

	public function getBlogarticlecategory($blog_id){
		$category_store_data = array();
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "magikblog_to_category WHERE blog_id = '" . (int)$blog_id . "'");
		foreach ($query->rows as $result) {
			$category_store_data[] = $result['category_id'];
		}
		return $category_store_data;
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
	public function getArticles($data = array()) { 
		$sql = "SELECT * FROM " . DB_PREFIX . "magikblog m 
			LEFT JOIN " . DB_PREFIX . "magikblog_description md 
			ON (m.blog_id = md.blog_id) 
			WHERE md.language_id = '" . (int)$this->config->get('config_language_id') . "'"; 

		if (!empty($data['filter_article'])) {
			$sql .= " AND md.name LIKE '" . $this->db->escape($data['filter_article']) . "%'";
		}
		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND m.status = '" . (int)$data['filter_status'] . "'";
		}

		$sort_data = array(
			'md.name',
			'm.status'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY md.name";
		}

		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}

		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}

			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}

		$query = $this->db->query($sql);

		return $query->rows;
	}

	public function addArticle($data) {

		$this->event->trigger('pre.admin.article.add', $data);
  
		$this->db->query("INSERT INTO " . DB_PREFIX . "magikblog SET author = '" . $this->db->escape($data['author']) . "',publish_date = '" . $this->db->escape($data['publishdate']) . "',display_order = '" . (int)$data['display_order'] . "', status = '" . (int)$data['status'] . "'");

		$blog_id = $this->db->getLastId();

		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "magikblog SET image = '" . $this->db->escape($data['image']) . "' WHERE blog_id = '" . (int)$blog_id . "'");
		}

		foreach ($data['article_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "magikblog_description SET blog_id = '" . (int)$blog_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['articlename']) . "', description = '" . $this->db->escape($value['description']) . "',
					  meta_title = '" . $this->db->escape($value['meta_title']) . "',meta_description = '" . $this->db->escape($value['meta_description']) . "',meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "',tags = '" . $this->db->escape($value['tag']) . "'");
		}

		if (isset($data['article_store'])) {
			foreach ($data['article_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "magikblog_to_store SET blog_id = '" . (int)$blog_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		if (isset($data['article_category'])) {
			foreach ($data['article_category'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "magikblog_to_category SET blog_id = '" . (int)$blog_id . "', category_id = '" . (int)$category_id . "'");
			}
		}
		$this->cache->delete('article');

		$this->event->trigger('post.admin.article.add', $blog_id);

		return $blog_id;

        }

	public function editArticle($blog_id, $data){ 

		$this->db->query("UPDATE " . DB_PREFIX . "magikblog SET status = '" . (int)$data['status'] . "', display_order = '" . (int)$data['display_order'] . "' WHERE blog_id = '" . (int)$blog_id . "'");
		if (isset($data['image'])) {
			$this->db->query("UPDATE " . DB_PREFIX . "magikblog SET image = '" . $this->db->escape($data['image']) . "' WHERE blog_id = '" . (int)$blog_id . "'");
		}
		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblog_description WHERE blog_id = '" . (int)$blog_id . "'");
		foreach ($data['article_description'] as $language_id => $value) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "magikblog_description SET blog_id = '" . (int)$blog_id . "', language_id = '" . (int)$language_id . "', name = '" . $this->db->escape($value['articlename']) . "', description = '" . $this->db->escape($value['description']) . "',
					  meta_title = '" . $this->db->escape($value['meta_title']) . "',meta_description = '" . $this->db->escape($value['meta_description']) . "',meta_keyword = '" . $this->db->escape($value['meta_keyword']) . "',tags = '" . $this->db->escape($value['tag']) . "'");
		}
	  
		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblog_to_store WHERE blog_id = '" . (int)$blog_id . "'");
		if (isset($data['article_store'])) {		
			foreach ($data['article_store'] as $store_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "magikblog_to_store SET blog_id = '" . (int)$blog_id . "', store_id = '" . (int)$store_id . "'");
			}
		}

		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblog_to_category WHERE blog_id = '" . (int)$blog_id . "'");
		if (isset($data['article_category'])) {		
			foreach ($data['article_category'] as $category_id) {
				$this->db->query("INSERT INTO " . DB_PREFIX . "magikblog_to_category SET blog_id = '" . (int)$blog_id . "', category_id = '" . (int)$category_id . "'");
			}
		}

	}
    
	public function deleteArticle($blog_id){
		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblog WHERE blog_id = '" . (int)$blog_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblog_description WHERE blog_id = '" . (int)$blog_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblog_to_category WHERE blog_id = '" . (int)$blog_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblog_to_store WHERE blog_id = '" . (int)$blog_id . "'");
		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblog_comment WHERE blog_id = '" . (int)$blog_id . "'");
	}
	
}