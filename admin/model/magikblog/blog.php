<?php
class ModelMagikblogBlog extends Model {

	public function createtableBlogTables() {
		
		$checkBlogTable = "SHOW TABLES LIKE '".DB_PREFIX."magikblog' ";
		$queryBlog=$this->db->query($checkBlogTable);
		if($queryBlog->num_rows==0){
		    $createBlogTable = "
			CREATE TABLE " . DB_PREFIX . "magikblog (
			`blog_id` int(11) NOT NULL AUTO_INCREMENT,
			`image` varchar(255) NOT NULL,
			`author` varchar(255) NOT NULL,
			`publish_date` date NOT NULL DEFAULT '0000-00-00',
			`display_order` int(11) default '0',
			`status` tinyint(1) NOT NULL DEFAULT '0',
			`keyword` varchar(255) NOT NULL,
			 PRIMARY KEY (`blog_id`)) default CHARSET=utf8";
			$this->db->query($createBlogTable);

			$this->createDefaultBlogLayout();
		}
		
		$checkBlogDespTable = "SHOW TABLES LIKE '".DB_PREFIX."magikblog_description' ";
		$queryBlogDesp=$this->db->query($checkBlogDespTable);
		if($queryBlogDesp->num_rows==0){
		    $createBlogDespTable = "
			CREATE TABLE " . DB_PREFIX . "magikblog_description (
			`blog_id` int(11) NOT NULL ,
			`language_id` int(11) unsigned NOT NULL,
			`name` text default NULL,
			`description` text NOT NULL,
			`meta_title` varchar(255) NOT NULL,
			`meta_description` varchar(255) NOT NULL,
			`meta_keyword` varchar(255) NOT NULL,
			`tags` varchar(255) NOT NULL,
			PRIMARY KEY (`blog_id`,`language_id`)) default CHARSET=utf8";
			$this->db->query($createBlogDespTable);
		}
		
		$checkBlogCatTable = "SHOW TABLES LIKE '".DB_PREFIX."magikblog_to_category' ";
		$queryBlogCat=$this->db->query($checkBlogCatTable);
		if($queryBlogCat->num_rows==0){
		    $createBlogCatTable = "
			CREATE TABLE " . DB_PREFIX . "magikblog_to_category (
			`blog_id` int(11) NOT NULL ,
			`category_id` int(11) NOT NULL,
			PRIMARY KEY (`blog_id`,`category_id`)) default CHARSET=utf8";
			$this->db->query($createBlogCatTable);
		}

		$checkBlogStoreTable = "SHOW TABLES LIKE '".DB_PREFIX."magikblog_to_store' ";
		$queryBlogStore=$this->db->query($checkBlogStoreTable);
		if($queryBlogStore->num_rows==0){
		    $createBlogStoreTable = "
			CREATE TABLE " . DB_PREFIX . "magikblog_to_store (
			`blog_id` int(11) NOT NULL ,
			`store_id` int(11) NOT NULL,
			PRIMARY KEY (`blog_id`,`store_id`)) default CHARSET=utf8";
			$this->db->query($createBlogStoreTable);
		}

		$checkCategoryTable = "SHOW TABLES LIKE '".DB_PREFIX."magikblogcategory' ";
		$queryCategory=$this->db->query($checkCategoryTable);
		if($queryCategory->num_rows==0){
		    $createCategoryTable = "
			CREATE TABLE " . DB_PREFIX . "magikblogcategory (
			`category_id` int(11) NOT NULL AUTO_INCREMENT,
			`parent_id` int(11) NOT NULL default '0',
			`image` varchar(255) NOT NULL,
			`keyword` varchar(255) NOT NULL,
			`display_order` int(11) default '0',
			`status` tinyint(1) NOT NULL DEFAULT '0',
			PRIMARY KEY (`category_id`)) default CHARSET=utf8";
			$this->db->query($createCategoryTable);
		}

		$checkCategoryDespTable = "SHOW TABLES LIKE '".DB_PREFIX."magikblogcategory_description' ";
		$queryCategoryDesp=$this->db->query($checkCategoryDespTable);
		if($queryCategoryDesp->num_rows==0){
		    $createCategoryDespTable = "
			CREATE TABLE " . DB_PREFIX . "magikblogcategory_description (
			`category_id` int(11) NOT NULL ,
			`language_id` int(11) unsigned NOT NULL,
			`name` varchar(100) NOT NULL default '',
			`description` text DEFAULT NULL,
			`meta_title` varchar(255) NOT NULL,
			`meta_description` varchar(255) NOT NULL,
			`meta_keyword` varchar(255) NOT NULL,
			PRIMARY KEY (`category_id`,`language_id`)) default CHARSET=utf8";
			$this->db->query($createCategoryDespTable);
		}

		$checkCategoryStoreTable = "SHOW TABLES LIKE '".DB_PREFIX."magikblogcategory_to_store' ";
		$queryCategoryStore=$this->db->query($checkCategoryStoreTable);
		if($queryCategoryStore->num_rows==0){
		    $createCategoryStoreTable = "
			CREATE TABLE " . DB_PREFIX . "magikblogcategory_to_store (
			`category_id` int(11) NOT NULL ,
			`store_id` int(11) NOT NULL,
			PRIMARY KEY (`category_id`,`store_id`)) default CHARSET=utf8";
			$this->db->query($createCategoryStoreTable);
		}

		$checkCommentTable = "SHOW TABLES LIKE '".DB_PREFIX."magikblog_comment' ";
		$queryCommentStore=$this->db->query($checkCommentTable);
		if($queryCommentStore->num_rows==0){
		    $createCommentStoreTable = "
			CREATE TABLE " . DB_PREFIX . "magikblog_comment (
			`comment_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
			`blog_id` int(11) unsigned NOT NULL,
			`comment` text NOT NULL,
			`rating` int(1) NOT NULL,
			`status` tinyint(1) NOT NULL DEFAULT '0',
			`created_at` datetime NOT NULL,
			`user` varchar(255) NOT NULL,
			`email` varchar(255) NOT NULL,
			PRIMARY KEY (`comment_id`)) default CHARSET=utf8";
			$this->db->query($createCommentStoreTable);
		}

	}
      
	public function createDefaultBlogLayout() {

		$sql  = "INSERT INTO  `".DB_PREFIX."layout` (
					`layout_id` ,
					`name`
					)
					VALUES (NULL , 'magik blog');";
		$query = $this->db->query( $sql );
		
		$id = $this->db->getLastId();
		
		$sql1 = "INSERT INTO `".DB_PREFIX."layout_route` (
				`layout_route_id` ,
				`layout_id` ,
				`store_id` ,
				`route`
				)
				VALUES (NULL , '".$id."', '0', 'magikblog/article');";
		$query1 = $this->db->query( $sql1 );



		$sql2 = "INSERT INTO `".DB_PREFIX."layout_route` (
				`layout_route_id` ,
				`layout_id` ,
				`store_id` ,
				`route`
				)
				VALUES (NULL , '".$id."', '0', 'magikblog/article/tag');";
		$query2 = $this->db->query( $sql2 );


		$sql3 = "INSERT INTO `".DB_PREFIX."layout_route` (
				`layout_route_id` ,
				`layout_id` ,
				`store_id` ,
				`route`
				)
				VALUES (NULL , '".$id."', '0', 'magikblog/article/view');";
		$query3 = $this->db->query( $sql3 );



		$sql4 = "INSERT INTO `".DB_PREFIX."layout_route` (
				`layout_route_id` ,
				`layout_id` ,
				`store_id` ,
				`route`
				)
				VALUES (NULL , '".$id."', '0', 'magikblog/category');";
		$query4 = $this->db->query( $sql4 );		

	}
	
}