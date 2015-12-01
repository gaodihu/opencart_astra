<?php
class ModelSaleNewslettersubscription extends Model {
	

      public function createtableNewslettersubscription() {
		
		$checkTable = "SHOW TABLES LIKE '".DB_PREFIX."newslettersubscription' ";
		$query=$this->db->query($checkTable);

		if($query->num_rows==0){

			$createTable = "
			CREATE TABLE " . DB_PREFIX . "newslettersubscription (
			`subscription_id` int(11) NOT NULL AUTO_INCREMENT,
			`email` varchar(128) NOT NULL DEFAULT '',
			`status` tinyint(1) NOT NULL DEFAULT '0',
			`create_time` datetime NOT NULL ,
			PRIMARY KEY (`subscription_id`)) default CHARSET=utf8";
			$this->db->query($createTable);
		}
	}
      
	public function editNewslettersubscription($subscription_id, $data) {

		$this->event->trigger('pre.admin.newslettersubscription.edit', $data);
				

		$this->db->query("UPDATE " . DB_PREFIX . "newslettersubscription SET  status = '".(int)$data['status']."' WHERE subscription_id = '" . (int)$subscription_id . "'");

		
		//$this->cache->delete('product');

		$this->event->trigger('post.admin.newslettersubscription.edit', $subscription_id);
	}

	public function getNewslettersubscriptions($data = array()) {
		$sql = "SELECT r.subscription_id, r.email, r.status,r.create_time FROM " . DB_PREFIX . "newslettersubscription r";

		if (isset($data['filter_status']) && !is_null($data['filter_status'])) {
			$sql .= " AND r.status = '" . (int)$data['filter_status'] . "'";
		}

		$sort_data = array(
			'r.email',
			'r.create_time',
			'r.status'
		);

		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];
		} else {
			$sql .= " ORDER BY r.create_time";
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
	
	public function getNewslettersubscription($subscription_id) {
		$query = $this->db->query("SELECT r.subscription_id, r.email, r.status,r.create_time FROM " . DB_PREFIX . "newslettersubscription r WHERE r.subscription_id = '" . (int)$subscription_id . "' ");

		return $query->row;
	}

	public function deleteNewslettersubscription($subscription_id) {
		$this->event->trigger('pre.admin.newslettersubscription.delete', $subscription_id);

		$this->db->query("DELETE FROM " . DB_PREFIX . "newslettersubscription WHERE subscription_id = '" . (int)$subscription_id . "'");

		//$this->cache->delete('product');

		$this->event->trigger('post.admin.newslettersubscription.delete', $subscription_id);
	}

	public function getTotalNewslettersubscriptions($data = array()) {

		//$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "newslettersubscription  WHERE language_id = '" . (int)$this->config->get('config_language_id') . "'";
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "newslettersubscription";

		if (!empty($data['filter_status'])) {
			$sql .= " AND r.status = '" . (int)$data['filter_status'] . "'";
		}

		if (!empty($data['filter_date_added'])) {
			$sql .= " AND DATE(r.date_added) = DATE('" . $this->db->escape($data['filter_date_added']) . "')";
		}

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getTotalNewslettersubscriptionsmail($data = array()) {

		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "newslettersubscription WHERE status=1" ;

		$query = $this->db->query($sql);

		return $query->row['total'];
	}

	public function getNewslettersubscriptionmail($data = array()) {
		 $status_id=1;
		 $query = $this->db->query("SELECT subscription_id, email, status,create_time FROM " . DB_PREFIX . "newslettersubscription  WHERE status = '" . $status_id . "' ");
		 return $query->rows;
	}

}