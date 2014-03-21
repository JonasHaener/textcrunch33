<?php
// base class Database
require_once "class_db.inc.php";
require_once "class_db_dbm.inc.php";

// inherites from class Database
// tags and cats class
class Stats extends Database {
	
	private $result = array();

	### constructor
	public function __construct() {
	}

	public function search_error()
	{
		return $this->error;
	}

	public function route_request() {
		// route request to appropriate handler
		switch( $this->requestType ) {
			case "GET":
				$data = $this->fetch_data = $this->get_request_data();

				if(isset($data["users_stats"]) && $data["users_stats"] === true) {
					$this->get_user_stats();

				} else if(isset($data["other_stats"]) && $data["other_stats"] === true) {
					$this->get_stats();
				
				} else {
					throw new Exception("Stats kind not defined");
				}
			break;
			// if request type is not defined
			default:
				throw new Exception("Wrong request type", 1);
		}
	}

	public function get_result() {
		return $this->result;
	}

	private function get_user_stats()
	{
		
		$users = array();

		## start transaction
 		$this->start_transaction();

 		## username, projects, rights_name, last_login, blocks created
 		$configs = array( 
		 "query"    => "SELECT user_id, username, rights_name, last_login, count(blocks.created) AS blocks_created 
		 				FROM users INNER JOIN blocks USING(user_id)
		 				GROUP BY user_id",
		 "expected" => array("user_id", "username", "rights_name", "last_login", "blocks_created")
		); 
		$dbm = new Database_manager($configs, $this->conn);
		$dbm->exec_select_query_multi(false, false);
		$users = array_merge($dbm->get_result(), $users);
		if($this->process_error()) { 
			$this->register_error_and_close();
			return; 
		}

 		## deleted blocks
 		$configs = array( 
		 "query"    => "SELECT user_id, count(created) AS blocks_deleted FROM blocks_deleted GROUP BY user_id",
		 "expected" => array("user_id", "blocks_deleted")
		); 
		$dbm = new Database_manager($configs, $this->conn);
		$dbm->exec_select_query_multi(false, false);
 		if($this->process_error()) { 
			$this->register_error_and_close();
			return; 
		}		
		$deleted_blocks = $dbm->get_result();

		foreach($users as $i => $usr) {
			$usr_id = $usr["user_id"];
			foreach($deleted_blocks as $n => $del) {
				if($del["user_id"] === $usr_id) {
					$users[$i]["blocks_deleted"] = $del["blocks_deleted"];
				} else {
					$users[$i]["blocks_deleted"] = "0";
				}	
			}
		}

	 	## projects
 		$configs = array( 
		 "query"    => "SELECT user_id, count(*) AS projects FROM projects GROUP BY user_id",
		 "expected" => array("user_id", "projects")
		); 
		$dbm = new Database_manager($configs, $this->conn);
		$dbm->exec_select_query_multi(false, false);
 		if($this->process_error()) { 
			$this->register_error_and_close();
			return; 
		}		
		$projects = $dbm->get_result();	
		
		foreach($users as $i => $usr) {
			$usr_id = $usr["user_id"];
			foreach($projects as $n => $pr) {
				if($pr["user_id"] === $usr_id) {
					$users[$i]["projects"] = $pr["projects"];
				} else {
					$users[$i]["projects"] = "0";
				}	
			}
		}

		$this->result = $users;

		## commit transaction
 		$this->commit_transaction();		
		// close connection
		$this->closeConnection();
	}

	private function get_stats()
	{
		 /* JSON format needed
	        tags: {
	        	total: 0,
	        	total_unused: 0,
	        	unused_listed: ""
	        },
	        blocks: {
				total: 0,
				average_tags: 0
	        },
	        categories: {
				name: "",
				blocks: 0
	        }
	        */

		## start transaction
 		$this->start_transaction();

 		## get tags stats
 		$this->get_tag_stats();

 		## get block stats
		$this->get_block_stats();
		
 		## get category stats
		$this->get_cats_stats();

		## commit transaction
 		$this->commit_transaction();		
		// close connection
		$this->closeConnection();

	}

	private function get_tag_stats()
	{
		## get total number of tags
		$configs = array( 
		 "query"    => "SELECT count(*) AS total FROM tags",
		 "expected" => array("total")
		); 
		$dbm = new Database_manager($configs, $this->conn);
		$dbm->exec_select_query(false, false);
	 	if($this->process_error()) { 
			$this->register_error_and_close();
			return; 
		}	
		$tags = $dbm->get_result();	
		$this->result["tags"]["total"] = $tags["total"][0];


		## get total of unused tags
		$configs = array( 
		 "query"    => "SELECT count(name) AS unused FROM tags WHERE tags.tag_id NOT IN (SELECT tag_id from tag_switch)",
		 "expected" => array("unused")
		); 
		$dbm = new Database_manager($configs, $this->conn);
		$dbm->exec_select_query(false, false);
		if($this->process_error()) { 
			$this->register_error_and_close();
			return; 
		}
		$tags = $dbm->get_result();	
		$this->result["tags"]["total_unused"] = $tags["unused"][0];


		## get names of unused tags
		$configs = array( 
		 "query"    => "SELECT name FROM tags WHERE tags.tag_id NOT IN (SELECT tag_id from tag_switch)",
		 "expected" => array("name")
		); 
		$dbm = new Database_manager($configs, $this->conn);
		$dbm->exec_select_query(false, false);
		if($this->process_error()) { 
			$this->register_error_and_close();
			return; 
		}
		$tags = $dbm->get_result();	
		$this->result["tags"]["unused_listed"] = implode($tags["name"], ",");
	}

	private function get_block_stats()
	{
		## get total tags
		$configs = array( 
		 "query"    => "SELECT count(block_id) AS total FROM blocks",
		 "expected" => array("total")
		); 
		$dbm = new Database_manager($configs, $this->conn);
		$dbm->exec_select_query(false, false);
		if($this->process_error()) { 
			$this->register_error_and_close();
			return; 
		}
		$blocks = $dbm->get_result();
		$this->result["blocks"]["total"] = $blocks["total"][0];
		
		## get average tags per block
		$configs = array( 
		 "query"    => "SELECT AVG(a.rcount) AS average FROM 
		 			    (SELECT count(*) as rcount FROM tag_switch tw 
		 			   	GROUP BY tw.block_id) a",
		 "expected" => array("average")
		); 
		$dbm = new Database_manager($configs, $this->conn);
		$dbm->exec_select_query(false, false);
		if($this->process_error()) { 
			$this->register_error_and_close();
			return; 
		}
		$blocks = $dbm->get_result();
		$this->result["blocks"]["average_tags"] = round($blocks["average"][0], 2, PHP_ROUND_HALF_DOWN);
	}

	private function get_cats_stats()
	{
		/*	
		categories: {
				name: "",
				blocks: 0
	    }
	    */
	    $cat_result = array();

		## get categories names and ids
		$configs = array( 
		 "query"    => "SELECT name FROM categories",
		 "expected" => array("name")
		); 
		$dbm = new Database_manager($configs, $this->conn);
		$dbm->exec_select_query_multi(false, false);
	 	if($this->process_error()) { 
			$this->register_error_and_close();
			return; 
		}	
		$cats = $dbm->get_result();
		foreach($cats as $key => $cat) {
			// assign temp value
			 $cat_result[$cat["name"]] = 0;
		}


		## loop ids 
		$configs = array( 
		 "query"    => "SELECT count(blocks.block_id) AS blocks, categories.name 
		 				FROM categories INNER JOIN blocks USING(category_id)
		 				GROUP BY category_id",
		 "expected" => array("name", "blocks")
		);
		$dbm = new Database_manager($configs, $this->conn);
		$dbm->exec_select_query_multi(false, false);
	 	if($this->process_error()) { 
			$this->register_error_and_close();
			return; 
		}	
		$cats = $dbm->get_result();
		// only categories are returned that have blocks assigned to them 
		foreach($cats as $key => $cat) {
			$cat_result[$cat["name"]] = $cat["blocks"];
		}
		// assign result
		$this->result["categories"] = $cat_result;
	}
}
