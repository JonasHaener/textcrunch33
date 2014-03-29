<?php
// error location 600
require_once "class_db_dbm.inc.php";

// inherites from class Databasemanager
// tags and cats class
class Entry extends Database_manager {
	
	private $result = array();
	protected $insert_data;

	// $last_insert_ids holds ids
	// even if they already exist in db
	// holds (category_id, tag_id, block_id, switch_id,
	//		  german_id,..., polish_id) 
	private $last_insert_ids = array();
	public  $error = false;
	
	### constructor
	public function __construct() {
		// error 601
	}

	// used when other classes access this class
	// creating multiple entries
	protected function ent_reset_class()
	{
		$this->result = array();
		$this->insert_data = array();
		$this->last_insert_ids = array();
		$this->error = false;

	}

	public function route_request() {
		// error 602
		// route request to appropriate handler
		$this->ent_reset_class();
		// check user rights
		$user_right = $this->get_user_rights();
		switch( $this->requestType ) {
			case "POST":
				// rights: CRU
				if($this->get_user_rights() < 3) {
					$this->create_entry();
				}
				break;
			case "PUT":
				// rights: CRU
				if($this->get_user_rights() < 3) {
					$this->update_entry();
				}
			break;
			case "PATCH":
				// rights: CRU
				if($this->get_user_rights() < 3) {
					$this->update_entry();
				}
			break;
			case "DELETE":
				// rights: CRUD
				if($this->get_user_rights() < 2) {
					$this->delete_entry();
				}
			break;
			// if request type is not defined
			default:
				throw new Exception("Wrong request type", 1);
		}
	}



	public function get_result() {
		// error 603
		http_response_code(200);		
		echo json_encode($this->result, true);
	}



	protected function create_entry() {
		// error 604
		$this->insert_data = $this->get_json_decoded_request_data();

		## start transaction
 		$this->start_transaction();
		
		## get the category_id;
		$this->get_cat_id();

		## insert block
		$this->insert_block();

		## get tag ids
		$this->get_tag_ids();

		## insert into tag switch
		$this->insert_tags_in_tag_switcher();

		## start transaction
 		$this->commit_transaction();

 		## return result to frontend
 		$this->get_result();		
	
		// close connection
		$this->closeConnection();
		
	}
	
	
	
	private function update_entry() {
		// error 605
		$this->insert_data = $this->get_json_decoded_request_data();
		
		## start transaction
 		$this->start_transaction();

		## get the category_id;
		$this->get_cat_id();

		## insert block
		$this->update_block();

		## get tag ids
		$this->get_tag_ids();

		## remove tags from tag switcher
		// remove all ids and insert tags anew
		$this->remove_tags_in_tag_switcher();

		## insert into tag switch
		$this->insert_tags_in_tag_switcher();

		## start transaction
 		$this->commit_transaction();

 		## return result to frontend
 		$this->get_result();				
	
		// close connection
		$this->closeConnection();
	}



	protected function get_archive_entry( $id_to_delete )
	{
		// error 606

		// user id fetch
		$this->content_of_deleted = array();

		$query = 	"SELECT
				  	blocks.block_id, 
				  	blocks.category_id, 
				  	lang_german.content AS german, 
					lang_english.content AS english,
					lang_dutch.content AS dutch,
					lang_french.content AS french,
					lang_italian.content AS italian,
					lang_polish.content AS polish,
					lang_japanese.content AS japanese
					FROM 
					blocks 
					INNER JOIN lang_german USING(block_id)
					INNER JOIN lang_english USING (block_id)
					INNER JOIN lang_french USING (block_id)
					INNER JOIN lang_dutch USING (block_id)
					INNER JOIN lang_italian USING (block_id)
					INNER JOIN lang_polish USING (block_id)
					INNER JOIN lang_japanese USING (block_id)
					WHERE
					block_id = {$id_to_delete}";

		$configs = array( 
				"query" 		=> $query,
				"expected"		=> array("block_id", "category_id", "german", "english", "french", "dutch",
									"italian", "polish", "japanese")
				);

		$this->dbm_config($configs);
		$this->dbm_exec_select_query_multi(false, false);
		$res = $this->dbm_get_result();
		foreach($res as $key => $value) {
			$this->content_of_deleted[$key] = $value;
		}
	}



	protected function archive_entry()
	{
		// error 607
		$entry = $this->content_of_deleted;
		$query = 	"INSERT INTO blocks_deleted (
				  	old_block_id,
				  	category_id,
				  	user_id,
				  	german,
				  	english,
				  	french,
				  	dutch,
				  	italian,
				  	polish,
				  	japanese)
					VALUES (?,?,?,?,?,?,?,?,?,?)";
		
		$configs = array( 
				"query" 		=> $query,
				"expected"		=> array("insert_id"),
				"params"   => "iiisssssss",
				"data" 	   => array(
					$entry[0]['block_id'],
					$entry[0]['category_id'],
					$this->user['user_id'],
					$entry[0]['german'],
					$entry[0]['english'],
					$entry[0]['french'],
					$entry[0]['dutch'],
					$entry[0]['italian'],
					$entry[0]['polish'],
					$entry[0]['japanese']
				)
		); 

		$this->dbm_config($configs);
		$this ->dbm_prepare_stmt();
		$this ->dbm_exec_insert_stmt();
		$res = $this->dbm_get_result();
		if($res["affected_rows"] < 1) {
			$this->error_and_rollback(610);
		}
	}



	protected function delete_entry() {
		// error 608
		$id_to_delete = $this->get_request_data();
		
		## start transaction
 		$this->start_transaction();
		// store entry content to be deleted before deletion
		$this->get_archive_entry( $id_to_delete );
		// archive the entry previously fetched
		$this->archive_entry();

 		## delete entries
 		$configs = array(
 			"query" => "DELETE FROM 
 						textcrunch.blocks,
 						textcrunch.tag_switch,
 						textcrunch.lang_german, 
 						textcrunch.lang_english, 
 						textcrunch.lang_french,
 						textcrunch.lang_dutch,
						textcrunch.lang_italian,
						textcrunch.lang_spanish,
						textcrunch.lang_polish,
						textcrunch.lang_japanese
						USING
						textcrunch.blocks,
						textcrunch.tag_switch, 
						textcrunch.lang_german, 
						textcrunch.lang_english, 
						textcrunch.lang_french,
						textcrunch.lang_dutch,
						textcrunch.lang_italian,
						textcrunch.lang_spanish,
						textcrunch.lang_polish,
						textcrunch.lang_japanese
						WHERE
						blocks.block_id 	= lang_german.block_id
						AND blocks.block_id = lang_english.block_id
						AND blocks.block_id = lang_french.block_id
						AND blocks.block_id = lang_dutch.block_id
						AND blocks.block_id = lang_italian.block_id
						AND blocks.block_id = lang_spanish.block_id
						AND blocks.block_id = lang_polish.block_id
						AND blocks.block_id = lang_japanese.block_id
						AND blocks.block_id = tag_switch.block_id 
						AND blocks.block_id = {$id_to_delete}",
			
			"expected" => array()
		);		 
		$this->dbm_config($configs);
		$this->dbm_exec_delete_query();
		$res = $this->dbm_get_result();
		if($res["affected_rows"] < 1) {
			$this->error_and_rollback(610);
		}
		## start transaction
 		$this->commit_transaction();		
		// close connection
		$this->closeConnection();
		// close connection
		$this->get_result();
	}



	protected function get_cat_id()
	{
		// error 609
		$category_name 	= trim( $this->insert_data['category'] );
		$query 	 = "SELECT category_id FROM categories WHERE name = ?";
		$configs = array( 
				"query" 		=> $query,
				"stmt"			=> true,
				"params" 		=> "s",
				"data" 			=> array($category_name),
				// expected column names by db
				// expected values are bound to result
				"expected"		=> array("category_id") // , ... , ...
			); 
		//prepare statement)
		$this->dbm_config($configs);
		$this->dbm_prepare_stmt();
		$this->dbm_exec_select_stmt();
		$res = $this->dbm_get_result();

		if( $res['category_id'] ) {
			$this->last_insert_ids["category_id"] = $res['category_id'];
		} else {
			$this->error_and_rollback(609);
		}
	}


	
	protected function insert_block_handler($configs)
	{
		// error 610
		if(!is_array($configs)) {
			throw new Exception("Array expected");
		}
		// open database object
		$this->dbm_config($configs);
		// if no stmt is needed
		if($configs["stmt"] == false) {
			$this->dbm_exec_insert_query();
			//print($this->conn->affected_rows);
			
		// if stmt is needed
		} elseif ($configs["stmt"] == true) {
			$this->dbm_prepare_stmt();
			$this->dbm_exec_insert_stmt();
		// stop if no stmt flag is provided
		} else {
			throw new Exception("Prepared statement flag not set");
		}

		// fetch result
		$res = $this->dbm_get_result();
		if($res["affected_rows"] < 1) {
			$this->error_and_rollback(610);
		}
		
		// only register block_id from blocks table
		if(!empty($configs["expected"]) && $configs["expected"][0] === "block_id") {
			$this->last_insert_ids["block_id"] = $res["insert_id"];
			// assign id to be returned to front end
			$this->result["block_id"] = $res["insert_id"];
			
		}
	}



	protected function insert_block()
	{
		// error 611
		$user_id 	  = $this->user["user_id"];
		$insert_data  = $this->insert_data;
		
		## main query
		$main_query = array( 
			"query"    => "INSERT INTO blocks(category_id, user_id) VALUES ( {$this->last_insert_ids["category_id"]}, {$user_id} )",
			"expected" => array("block_id"), // , ... , ...
			"stmt"	   => false
		);

		// handle separately as category_id must be set first
		$this->insert_block_handler($main_query);

		## language queries
		$lang_queries = array(
			"german" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_german(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["german"]),
				"expected" => array()
			),
			
			"english" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_english(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["english"]),
				"expected" => array()
			)
			,
			"french" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_french(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["french"]),
				"expected" => array()
			)

			,
			"dutch" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_dutch(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["dutch"]),
				"expected" => array()
			),


			"italian" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_italian(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["italian"]),
				"expected" => array()
			),


			"polish" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_polish(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["polish"]),
				"expected" => array()
			),
			
			"spanish" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_spanish(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["spanish"]),
				"expected" => array()
			),

			"japanese" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_japanese(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["japanese"]),
				"expected" => array()
			)		
		);

		foreach($lang_queries as $index => $value) {
			$this->insert_block_handler($value);
		}
	}



	protected function create_tag($tag_name)
	{
		// error 612
		// create tag
		// return tag id
		$configs = array( 
			"query"    => "INSERT INTO tags(name, user_id) VALUES ( ?, ? )",
			"expected" => array("tag_id"), // , ... , ...
			"params"   => "si",
			"stmt" 	   => true,
			"data"     => array($tag_name, $this->user['user_id'])			
		);
		// open database object
		$this->dbm_config($configs);
		$this->dbm_prepare_stmt();
		$this->dbm_exec_insert_stmt();
		$res = $this->dbm_get_result();
		if($res["insert_id"] < 1) {
			$this->error_and_rollback(612);
		}
		$this->last_insert_ids["tag_id"][] = $res["insert_id"];

	}
	
	
	
	protected function get_tag_ids ()
	{
		// error 613
		

		$tags = $this->insert_data['tags']; // array
		// return if no tags to commit
		if(count($tags) <= 0) {
			return;
		}

		foreach($tags as $key => $value) {
			// check if error exists
			// especially important after creating new tags
			if($this->error) {
				return;
			}
			$configs = array( 
				"stmt"	   => true,
				"query"    => "SELECT tag_id FROM tags WHERE name = ?",
				"params"   => "s",
				"data" 	   => array($value), // tags is array,
				"expected" => array("tag_id") // , ... , ...
			);
			// open database object
			$this->dbm_config($configs);
			$this->dbm_prepare_stmt();
			$this->dbm_exec_select_stmt();
			
			// fetch result
			$res = $this->dbm_get_result();
			// assign result is available else throw assign error flag
			// to stop execution
			if( $res["tag_id"] !== null) {
				$this->last_insert_ids["tag_id"][] = $res["tag_id"];
			
			} else {
				$this->create_tag( $value );
			}
		}
	}



	protected function insert_tags_in_tag_switcher ()
	{
		// error 614
		// Get tags ids
		// if tag does not exist created it
		// return tag id
		## main query
		$tag_ids = $this->last_insert_ids['tag_id']; // array
		foreach($tag_ids as $key => $value) {
			$configs = array( 
				"query"    => "INSERT INTO tag_switch(block_id, tag_id) VALUES ( {$this->last_insert_ids['block_id']}, {$value} )",
				"expected" => array(), // , ... , ...
				"stmt"	   => false
			);
			$this->dbm_config($configs);
			$this->dbm_exec_insert_query();
			$res = $this->dbm_get_result();
			if($res["insert_id"] < 1) {
				$this->error_and_rollback(612);
			}
		}
	}



	protected function update_block()
	{
		// error 615
		$user_id 	  = $this->user["user_id"];
		$insert_data  = $this->insert_data;
		//print_r($insert_data);
		// assigned for function reuse of entry creator functions
		$this->last_insert_ids["block_id"] = $insert_data["block_id"];
		
		## main query
		$configs = array( 
			"query"    => "UPDATE blocks SET category_id = {$this->last_insert_ids['category_id']}, user_id = {$user_id}
						   WHERE block_id = {$insert_data['block_id']}",
			"expected" => array()
		);

		$this->dbm_config($configs);
		$this->dbm_exec_update_query();
		$res = $this->dbm_get_result();
		// error returns 		
		if($res["affected_rows"] < 0) {
			$this->error_and_rollback(615);
		}

		##languages
		$languages = array("german", "english", "french", "dutch", "italian", "polish", "spanish", "japanese");
		## language queries
		$lang_queries = array(
			"german" => array( 
				"stmt" 	   => true,
				"query"    => "UPDATE lang_german SET content = ? WHERE  block_id = ?",
				"params"   => "si",
				"data" 	   => array($insert_data["german"], $insert_data["block_id"]),
				"expected" => array()
			),
			
			"english" => array( 
				"stmt" 	   => true,
				"query"    => "UPDATE lang_english SET content = ? WHERE  block_id = ?",
				"params"   => "si",
				"data" 	   => array($insert_data["english"], $insert_data["block_id"]),
				"expected" => array()
			)
			,
			"french" => array( 
				"stmt" 	   => true,
				"query"    => "UPDATE lang_french SET content = ? WHERE  block_id = ?",
				"params"   => "si",
				"data" 	   => array($insert_data["french"], $insert_data["block_id"]),
				"expected" => array()
			)

			,
			"dutch" => array( 
				"stmt" 	   => true,
				"query"    => "UPDATE lang_dutch SET content = ? WHERE  block_id = ?",
				"params"   => "si",
				"data" 	   => array($insert_data["dutch"], $insert_data["block_id"]),
				"expected" => array()
			),

			"italian" => array( 
				"stmt" 	   => true,
				"query"    => "UPDATE lang_italian SET content = ? WHERE  block_id = ?",
				"params"   => "si",
				"data" 	   => array($insert_data["italian"], $insert_data["block_id"]),
				"expected" => array()
			),

			"polish" => array( 
				"stmt" 	   => true,
				"query"    => "UPDATE lang_polish SET content = ? WHERE  block_id = ?",
				"params"   => "si",
				"data" 	   => array($insert_data["polish"], $insert_data["block_id"]),
				"expected" => array()
			),
			
			"spanish" => array( 
				"stmt" 	   => true,
				"query"    => "UPDATE lang_spanish SET content = ? WHERE  block_id = ?",
				"params"   => "si",
				"data" 	   => array($insert_data["spanish"], $insert_data["block_id"]),
				"expected" => array()
			),

			"japanese" => array( 
				"stmt" 	   => true,
				"query"    => "UPDATE lang_japanese SET content = ? WHERE  block_id = ?",
				"params"   => "si",
				"data" 	   => array($insert_data["japanese"], $insert_data["block_id"]),
				"expected" => array()
			)		
		);
		
		// only update languages that are not blank
		// front end only sends that need to be updated
		foreach($insert_data["lang_to_update"] as $index => $lang) {
			$this->dbm_config($lang_queries[ $lang ]);
			$this->dbm_prepare_stmt();
			$this->dbm_exec_update_stmt();
			$res = $this->dbm_get_result();
			if($res["affected_rows"] < 0) {
				$this->error_and_rollback(615);
			}
		}
		// return block_id to frontend
		$this->result["block_id"] = $insert_data["block_id"];
	}



	protected function remove_tags_in_tag_switcher()
	{
		// error 616
		$configs = array( 
			"query"    => "DELETE FROM tag_switch WHERE block_id =  {$this->insert_data['block_id']}",
			"expected" => array()
		);

		$this->dbm_config($configs);
		$this->dbm_exec_delete_query();
		$res = $this->dbm_get_result();
		if($res["affected_rows"] < 1) {
			$this->error_and_rollback(616);
		}
	}		
}

