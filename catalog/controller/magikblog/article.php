<?php  
class ControllerMagikblogArticle extends Controller {

	public function index() {

		$this->language->load('magikblog/article');
		$this->load->model('tool/image');
		$this->document->addStyle('catalog/view/theme/'.$this->config->get('config_template').'/stylesheet/magikblog.css');
		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_blog_title'),
			'href' => $this->url->link('magikblog/article')
		);

		$data['heading_title'] = $this->language->get('heading_blog_title');
		$data['publish_at_title'] = $this->language->get('publish_at_title');
		$data['text_no_pq_found'] = $this->language->get('text_no_pq_found');
		$data['text_read_more'] = $this->language->get('text_read_more');
		
		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		$limit=20;
		$filter_data = array(
			'start'             => ($page - 1) * $limit,
			'limit'             => $limit
		);

		$this->load->model('magikblog/article');
		$article_total = $this->model_magikblog_article->getTotalArticles($filter_data);
		
		$data['articles'] = array();
		$results = $this->model_magikblog_article->getArticles($filter_data);

		$blogmeta_detail=$this->config->get('magikblog_description');
		$get_language_data=$blogmeta_detail[$this->config->get('config_language_id')];
	
		$data['tag_status'] = $this->config->get('magikblog_allow_tag');
		$this->document->setTitle($get_language_data['metatitle']);
		$this->document->setDescription($get_language_data['metadescription']);
		$this->document->setKeywords($get_language_data['metakeyword']);

		foreach ($results as $result) {
			$articletags  = array();
		      if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], 780, 520);
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', 780, 520);
				}

				if($result['tags']){
					$mgktags = explode( ",",$result['tags']);
					foreach( $mgktags as $tag ){
					$articletags[trim($tag)] = $this->url->link( 'magikblog/article/tag','mgktag='.trim($tag) );
					}
				}
				else {
					$articletags=array();
				}

			$data['articles'][] = array(
				'name' => $result['name'],
				'thumb' => $image,
				'author' => $result['author'],
				'publish_date' => $result['publish_date'],
				'tags' => $result['tags'],
				'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 800) . '..',
				'href'     => $this->url->link('magikblog/article/view', 'mgkblogarticle_id=' . $result['blog_id']),
				'articletags'=>$articletags
			);
		}
		
		$pagination = new Pagination();
		$pagination->total = $article_total;
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->url = $this->url->link('magikblog/article', '&page={page}');
		$data['pagination'] = $pagination->render();
		$data['results'] = sprintf($this->language->get('text_pagination'), ($article_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($article_total - $limit)) ? $article_total : ((($page - 1) * $limit) + $limit), $article_total, ceil($article_total / $limit));

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/magikblog/article.tpl')) { 
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/magikblog/article.tpl', $data));
		} else { 
			$this->response->setOutput($this->load->view('default/template/magikblog/article.tpl', $data));
		}

	}

	public function view() {
		
		$this->language->load('magikblog/article');
		$this->load->model('tool/image');
		$this->document->addStyle('catalog/view/theme/'.$this->config->get('config_template').'/stylesheet/magikblog.css');
		if (isset($this->request->get['mgkblogarticle_id'])) {
			  $current_article_id = (int)$this->request->get['mgkblogarticle_id'];
		} else {
			  $current_article_id = 0;
		}

		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_blog_title'),
			'href' => $this->url->link('magikblog/article')
		);

		$data['heading_title'] = $this->language->get('heading_blog_title');
		$data['publish_at_title'] = $this->language->get('publish_at_title');
		$data['text_blog_by'] = $this->language->get('text_blog_by');
		$data['text_no_pq_found'] = $this->language->get('text_no_pq_found');
		$data['text_write'] = $this->language->get('text_write');
		$data['text_login'] = sprintf($this->language->get('text_login'), $this->url->link('account/login', '', 'SSL'), $this->url->link('account/register', '', 'SSL'));
		$data['text_note'] = $this->language->get('text_note');
		$data['text_tags'] = $this->language->get('text_tags');
		$data['entry_name'] = $this->language->get('entry_name');
		$data['entry_review'] = $this->language->get('entry_review');
		$data['text_comment'] = $this->language->get('text_comment');
		$data['entry_rating'] = $this->language->get('entry_rating');
		$data['entry_good'] = $this->language->get('entry_good');
		$data['entry_bad'] = $this->language->get('entry_bad');
		$data['button_continue'] = $this->language->get('button_continue');
		$data['text_loading'] = $this->language->get('text_loading');
		

		$data['mgkblogarticle_id'] = (int)$this->request->get['mgkblogarticle_id'];

		$data['articledetail'] = array();
		$data['review_status'] = $this->config->get('magikblog_allow_comment');
		if ($this->config->get('magikblog_allow_guestcomment') || $this->customer->isLogged()) {
				$data['review_guest'] = true;
		} else {
				$data['review_guest'] = false;
		}

		$this->load->model('magikblog/article');
		$results = $this->model_magikblog_article->getArticleview($current_article_id);
		
		$data['breadcrumbs'][] = array(
			'text' => $results[0]['name'],
			'href' => $this->url->link('magikblog/article/view', 'mgkblogarticle_id=' . $this->request->get['mgkblogarticle_id'])
		);
		
		foreach ($results as $result) {
			if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], 780, 520);
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', 780, 520);
				}
			$data['articledetail'] = array(
				'name' => $result['name'],
				'thumb' => $image,
				'author' => $result['author'],
				'publish_date' => $result['publish_date'],
				'description' => html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')
			);
		}

		$data['tag_status'] = $this->config->get('magikblog_allow_tag');
		
		if($result['tags']) {
			$mgktags = explode( ",",$result['tags']);
			$articletags  = array();
					
			foreach( $mgktags as $tag ){
			    $articletags[trim($tag)] = $this->url->link( 'magikblog/article/tag','mgktag='.trim($tag) );
			}
		} else {
			$articletags = array();
		}
				
		$data['articletags'] = $articletags;
		$this->document->setTitle($results[0]['meta_title']);
		$this->document->setDescription($results[0]['meta_description']);
		$this->document->setKeywords($results[0]['meta_keyword']);

		if ($this->config->get('config_google_captcha_status')) {
				$this->document->addScript('https://www.google.com/recaptcha/api.js');

				$data['site_key'] = $this->config->get('config_google_captcha_public');
			} else {
				$data['site_key'] = '';
			}

		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/magikblog/article_view.tpl')) { 
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/magikblog/article_view.tpl', $data));
		} else { 
			$this->response->setOutput($this->load->view('default/template/magikblog/article_view.tpl', $data));
		}
	}

	public function review() {
		$this->language->load('magikblog/article');

		$this->load->model('magikblog/article');

		$data['text_no_comments'] = $this->language->get('text_no_comments');
		$data['text_comments'] = $this->language->get('text_comments');

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}

		$data['comments'] = array();
	  
		$comment_total = $this->model_magikblog_article->getTotalCommentsByArticleId($this->request->get['mgkblogarticle_id']);
	      $data['rssfeed_status'] = $this->config->get('magikblog_allow_rssfeed');
		$results = $this->model_magikblog_article->getCommentsByArticleId($this->request->get['mgkblogarticle_id'], ($page - 1) * 5, 5);

		foreach ($results as $result) {
			$data['comments'][] = array(
				'user'     => $result['user'],
				'comment'       => nl2br($result['comment']),
				'rating'     => (int)$result['rating'],
				'created_at' => date($this->language->get('date_format_short'), strtotime($result['created_at']))
			);
		}

		$pagination = new Pagination();
		$pagination->total = $comment_total;
		$pagination->page = $page;
		$pagination->limit = 5;
		$pagination->url = $this->url->link('magikblog/article/review', 'mgkblogarticle_id=' . $this->request->get['mgkblogarticle_id'] . '&page={page}');

		$data['pagination'] = $pagination->render();

		$data['results'] = sprintf($this->language->get('text_pagination'), ($comment_total) ? (($page - 1) * 5) + 1 : 0, ((($page - 1) * 5) > ($comment_total - 5)) ? $comment_total : ((($page - 1) * 5) + 5), $comment_total, ceil($comment_total / 5));
		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/magikblog/review.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/magikblog/review.tpl', $data));
		} else {
			$this->response->setOutput($this->load->view('default/template/magikblog/review.tpl', $data));
		}
	}

	public function write() {
		$this->load->language('magikblog/article');

		$json = array();

		if ($this->request->server['REQUEST_METHOD'] == 'POST') {
			if ((utf8_strlen($this->request->post['name']) < 3) || (utf8_strlen($this->request->post['name']) > 25)) {
				$json['error'] = $this->language->get('error_name');
			}

			if ((utf8_strlen($this->request->post['text']) < 25) || (utf8_strlen($this->request->post['text']) > 1000)) {
				$json['error'] = $this->language->get('error_text');
			}

			if (empty($this->request->post['rating']) || $this->request->post['rating'] < 0 || $this->request->post['rating'] > 5) {
				$json['error'] = $this->language->get('error_rating');
			}

			if ($this->config->get('config_google_captcha_status') && empty($json['error'])) {
				if (isset($this->request->post['g-recaptcha-response'])) {
					$recaptcha = file_get_contents('https://www.google.com/recaptcha/api/siteverify?secret=' . urlencode($this->config->get('config_google_captcha_secret')) . '&response=' . $this->request->post['g-recaptcha-response'] . '&remoteip=' . $this->request->server['REMOTE_ADDR']);

					$recaptcha = json_decode($recaptcha, true);

					if (!$recaptcha['success']) {
						$json['error'] = $this->language->get('error_captcha');
					}
				} else {
					$json['error'] = $this->language->get('error_captcha');
				}
			}

			if (!isset($json['error'])) {
				$this->load->model('magikblog/article');

				$this->model_magikblog_article->addComment($this->request->get['mgkblogarticle_id'], $this->request->post);

				$json['success'] = $this->language->get('text_success');
			}
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function tag() {

		$this->language->load('magikblog/article');
		$this->load->model('tool/image');
		$this->document->addStyle('catalog/view/theme/'.$this->config->get('config_template').'/stylesheet/magikblog.css');
		$data['breadcrumbs'] = array();
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/home')
		);
		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_blog_title'),
			'href' => $this->url->link('magikblog/article')
		);

		$data['heading_title'] = $this->language->get('heading_title');
		$data['publish_at_title'] = $this->language->get('publish_at_title');
		$data['text_no_pq_found'] = $this->language->get('text_no_pq_found');
		$data['text_read_more'] = $this->language->get('text_read_more');
		$data['mgktag'] = $this->request->get['mgktag'];

		if (isset($this->request->get['page'])) {
			$page = $this->request->get['page'];
		} else {
			$page = 1;
		}
		$limit=20;
		$filter_data = array(
			'filter_tag'  => $data['mgktag'],
			'start'       => ($page - 1) * $limit,
			'limit'       => $limit
		);

		$this->load->model('magikblog/article');
		$articlebytag_total = $this->model_magikblog_article->getTotalArticlesByTag($filter_data);

		$data['tag_status'] = $this->config->get('magikblog_allow_tag');

		$data['articles'] = array();
		$results = $this->model_magikblog_article->getArticlesByTag($filter_data);
		    
		$data['breadcrumbs'][] = array(
			'text' => $this->request->get['mgktag'],
			'href' => $this->url->link('magikblog/article/tag', 'mgktag=' . $this->request->get['mgktag'])
		);
		$data['heading_tag'] = $this->request->get['mgktag'];
		$blogmeta_detail=$this->config->get('magikblog_description');
		$get_language_data=$blogmeta_detail[$this->config->get('config_language_id')];
		
		$data['tag_status'] = $this->config->get('magikblog_allow_tag');
		$this->document->setTitle($get_language_data['metatitle']);
		$this->document->setDescription($get_language_data['metadescription']);
		$this->document->setKeywords($get_language_data['metakeyword']);

		foreach ($results as $result) {
			$articletags  = array();
			if ($result['image']) {
					$image = $this->model_tool_image->resize($result['image'], 780, 520);
				} else {
					$image = $this->model_tool_image->resize('placeholder.png', 780, 520);
				}
				
				$mgktags = explode( ",",$result['tags']);
				foreach( $mgktags as $tag ){
				$articletags[trim($tag)] = $this->url->link( 'magikblog/article/tag','mgktag='.trim($tag) );
				}

			$data['articles'][] = array(
				'name' => $result['name'],
				'thumb' => $image,
				'author' => $result['author'],
				'publish_date' => $result['publish_date'],
				'tags' => $result['tags'],
				'description' => utf8_substr(strip_tags(html_entity_decode($result['description'], ENT_QUOTES, 'UTF-8')), 0, 600) . '..',
				'href'     => $this->url->link('magikblog/article/view', 'mgkblogarticle_id=' . $result['blog_id']),
				'articletags'=>$articletags
			);
		}
		
		$pagination = new Pagination();
		$pagination->total = $articlebytag_total;
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->url = $this->url->link('magikblog/article/tag','mgktag=' . $this->request->get['mgktag']. '&page={page}');
		$data['pagination'] = $pagination->render();
		$data['results'] = sprintf($this->language->get('text_pagination'), ($articlebytag_total) ? (($page - 1) * $limit) + 1 : 0, ((($page - 1) * $limit) > ($articlebytag_total - $limit)) ? $articlebytag_total : ((($page - 1) * $limit) + $limit), $articlebytag_total, ceil($articlebytag_total / $limit));
		  
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['column_right'] = $this->load->controller('common/column_right');
		$data['content_top'] = $this->load->controller('common/content_top');
		$data['content_bottom'] = $this->load->controller('common/content_bottom');
		$data['footer'] = $this->load->controller('common/footer');
		$data['header'] = $this->load->controller('common/header');

		
		if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/magikblog/article_tag.tpl')) { 
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/magikblog/article_tag.tpl', $data));
		} else { 
			$this->response->setOutput($this->load->view('default/template/magikblog/article_tag.tpl', $data));
		}

	}
	
	public function feed(){
	      if($this->config->get('magikblog_allow_rssfeed')){
		    $output='<?xml version="1.0" encoding="UTF-8" ?>';
		    $output.='<rss version="2.0">';
		    $output.= '<channel>';
		    $output .= '<title>' . $this->config->get('config_name') . '</title>';
		    $output .= '<description>' . $this->config->get('config_meta_description') . '</description>';
		    $output .= '<link>' . HTTP_SERVER . '</link>';
		    $this->load->model('magikblog/article');
		    $products = $this->model_magikblog_article->getArticles();
		    foreach ($products as $product) {
			    if ($product['description']) {
			      $output.= '<item>';
			      $output .= '<title>' . $product['name'] . '</title>';	
			      $output .= '<link>' . $this->url->link('magikblog/article/view', 'mgkblogarticle_id=' . $product['blog_id']) . '</link>';
			      $output .= '<description>' . $product['description'] . '</description>';		
			      $output.= '</item>';
			    }
		    }
		    $output .= '</channel>';
		    $output.= '</rss>';

		    $this->response->addHeader('Content-Type: application/rss+xml');
		    $this->response->setOutput($output);
	      }
	}
}

