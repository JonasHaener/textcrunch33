<?php
// error location 900
// base class Database
require_once "class_db_dbm.inc.php";

// inherites from class Database
// tags and cats class
class Stats extends Database_manager {
	
	private $result = array();

	### constructor
	public function __construct() {
	}

	public function route_request() {
		// error 901
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

	public function get_result() 
	{
		// error 902
		header('Content-type: application/json');
		http_response_code(200);
		echo json_encode(array($this->result), true);
	}

	private function get_user_stats()
	{
		// error 903
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
		$this->dbm_config($configs);
		$this->dbm_exec_select_query_multi(false, false);
		$users = array_merge($this->dbm_get_result(), $users);


 		## deleted blocks
 		$configs = array( 
		 	"query"    => "SELECT user_id, count(created) AS blocks_deleted FROM blocks_deleted GROUP BY user_id",
		 	"expected" => array("user_id", "blocks_deleted")
		); 
		$this->dbm_config($configs);
		$this->dbm_exec_select_query_multi(false, false);
		$deleted_blocks = $this->dbm_get_result();

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
		$this->dbm_config($configs);
		$this->dbm_exec_select_query_multi(false, false);
		$projects = $this->dbm_get_result();	
		
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
		// error 904
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
		
		## close connection
		$this->closeConnection();

		## write results
		$this->get_result(); 

	}

	private function get_tag_stats()
	{
		// error 905
		
		## get total number of tags
		$configs = array( 
		 "query"    => "SELECT count(*) AS total FROM tags",
		 "expected" => array("total")
		); 
		$this->dbm_config($configs);
		$this->dbm_exec_select_query(false, false);
		$tags = $this->dbm_get_result();	
		$this->result["tags"]["total"] = $tags["total"][0];


		## get total of unused tags
		$configs = array( 
		 "query"    => "SELECT count(name) AS unused FROM tags WHERE tags.tag_id NOT IN (SELECT tag_id from tag_switch)",
		 "expected" => array("unused")
		); 
		$this->dbm_config($configs);
		$this->dbm_exec_select_query(false, false);
		$tags = $this->dbm_get_result();	
		$this->result["tags"]["total_unused"] = $tags["unused"][0];


		## get names of unused tags
		$configs = array( 
		 "query"    => "SELECT name FROM tags WHERE tags.tag_id NOT IN (SELECT tag_id from tag_switch)",
		 "expected" => array("name")
		); 
		$this->dbm_config($configs);
		$this->dbm_exec_select_query(false, false);
		$tags = $this->dbm_get_result();
		$this->result["tags"]["unused_listed"] = implode($tags["name"], ",");
	}

	private function get_block_stats()
	{
		// error 906
		## get total tags
		$configs = array( 
		 "query"    => "SELECT count(block_id) AS total FROM blocks",
		 "expected" => array("total")
		); 
		$this->dbm_config($configs);
		$this->dbm_exec_select_query(false, false);
		$tags = $this->dbm_get_result();
		$blocks = $this->dbm_get_result();
		$this->result["blocks"]["total"] = $blocks["total"][0];
		
		## get average tags per block
		$configs = array( 
		 "query"    => "SELECT AVG(a.rcount) AS average FROM 
		 			    (SELECT count(*) as rcount FROM tag_switch tw 
		 			   	GROUP BY tw.block_id) a",
		 "expected" => array("average")
		); 
		$this->dbm_config($configs);
		$this->dbm_exec_select_query(false, false);
		$tags = $this->dbm_get_result();
		$blocks = $this->dbm_get_result();
		$this->result["blocks"]["average_tags"] = round($blocks["average"][0], 2, PHP_ROUND_HALF_DOWN);
	}

	private function get_cats_stats()
	{
		// error 907

	    $cat_result = array();

		## get categories names and ids
		$configs = array( 
		 "query"    => "SELECT name FROM categories",
		 "expected" => array("name")
		); 
		$this->dbm_config($configs);
		$this->dbm_exec_select_query_multi(false, false);
		$cats = $this->dbm_get_result();
		foreach($cats as $key => $cat) {
			// assign temp value
			 $cat_result[$cat["name"]] = 0;
		}


		## count blocks
		$configs = array( 
		 "query"    => "SELECT count(blocks.block_id) AS blocks, categories.name 
		 				FROM categories INNER JOIN blocks USING(category_id)
		 				GROUP BY category_id",
		 "expected" => array("name", "blocks")
		);
		$this->dbm_config($configs);
		$this->dbm_exec_select_query_multi(false, false);
		$cats = $this->dbm_get_result();
		// only categories are returned that have blocks assigned to them 
		foreach($cats as $key => $cat) {
			$cat_result[$cat["name"]] = $cat["blocks"];
		}
		// assign result
		$this->result["categories"] = $cat_result;
	}
}
