<?php
class ModelMagikblogComment extends Model {
      
	public function getBlogcomment($comment_id) {
		$query = $this->db->query("SELECT DISTINCT *, (SELECT pd.name FROM " . DB_PREFIX . "magikblog_description pd WHERE pd.blog_id = r.blog_id AND pd.language_id = '" . (int)$this->config->get('config_language_id') . "') AS blog FROM " . DB_PREFIX . "magikblog_comment r WHERE r.comment_id = '" . (int)$comment_id . "'");
		return $query->row;
	}

	public function getTotalComments($data = array()) {
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "magikblog_comment";
		$query = $this->db->query($sql);
		return $query->row['total'];
	}

	
	public function editComment($comment_id, $data){ 
		$this->event->trigger('pre.admin.comment.edit', $data);
		$this->db->query("UPDATE " . DB_PREFIX . "magikblog_comment SET blog_id = '" . (int)$data['blog_id'] . "', comment = '" . $this->db->escape($data['comment']) . "',rating = '" . (int)$data['rating'] . "',status = '" . (int)$data['status'] . "',user = '" . $this->db->escape($data['user']) . "' WHERE comment_id = '" . (int)$comment_id . "'");
		$this->event->trigger('post.admin.comment.edit', $comment_id);

	}
	
	public function deleteComment($comment_id){
		$this->db->query("DELETE FROM " . DB_PREFIX . "magikblog_comment WHERE comment_id = '" . (int)$comment_id . "'");
	}
	
	public function getArticleComments($data = array()) {
		 $sql = "SELECT * FROM " . DB_PREFIX . "magikblog_comment mbc 
			LEFT JOIN " . DB_PREFIX . "magikblog_description md 
			ON (mbc.blog_id = md.blog_id) 
			WHERE md.language_id = '" . (int)$this->config->get('config_language_id') . "'"; 

		if (!empty($data['filter_article'])) {
			$sql .= " AND md.name LIKE '" . $this->db->escape($data['filter_article']) . "%'";
		}

		if (!empty($data['filter_author'])) {
			$sql .= " AND mbc.user LIKE '" . $this->db->escape($data['filter_author']) . "%'";
		}

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND mbc.status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_date_added'])) {
			$sql .= " AND DATE(mbc.created_at) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$sort_data = array(
			'md.name',
			'mbc.user',
			'mbc.status',
			'mbc.created_at'
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

	public function addComment($data) {

		$this->event->trigger('pre.admin.comment.add', $data);
  
		$this->db->query("INSERT INTO " . DB_PREFIX . "magikblog_comment SET blog_id = '" . (int)$data['blog_id'] . "',comment = '" . $this->db->escape($data['comment']) . "',rating = '" . (int)$data['rating'] . "',status = '" . (int)$data['status'] . "',created_at = NOW(),user = '" . $this->db->escape($data['user']) . "'");
		 $blog_id = $this->db->getLastId();
		
		$this->cache->delete('comment');

		$this->event->trigger('post.admin.comment.add', $blog_id);

		return $blog_id;

        }
	
}