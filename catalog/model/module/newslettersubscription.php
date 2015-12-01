<?php
class ModelModuleNewslettersubscription extends Model 
{ 
	public function EmailSubmit($email) 
	{
		$query =  $this->db->query("SELECT email FROM " . DB_PREFIX . "newslettersubscription WHERE email = '".$this->db->escape($email)."' ");

		if($query->row) { return "Already Subscribed!!!";}
		
 		$this->db->query("INSERT INTO " . DB_PREFIX . "newslettersubscription SET email = '".$this->db->escape($email)."' , status = 1, create_time = NOW()");
		
		return "Thank you for your subscription.";
	}
}
?>