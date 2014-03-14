<?php
// base class Database
require_once "class_db.inc.php";
require_once "class_db_dbm.inc.php";

// inherites from class Database
// tags and cats class
class Entry extends Database {
	
	private $result = array();
	private $insert_data;

	// $last_insert_ids holds ids
	// even if they already exist in db
	// holds (category_id, tag_id, block_id, switch_id,
	//		  german_id,..., polish_id) 
	private $last_insert_ids = array();
	public  $error = false;
	
	### constructor
	public function __construct() {
	}

	public function route_request() {
		// route request to appropriate handler
		// check user rights
		$user_right = $this->get_user_rights();
		switch( $this->requestType ) {
			case "POST":
				// rights: CRU
				if($this->get_user_rights() < 3) {
					$this->create_entry();
				} else {
					$this->error = true;
					return;
				}	
			break;
			case "PUT":
				// rights: CRU
				if($this->get_user_rights() < 3) {
					$this->update_entry();
				} else {
					$this->error = true;
					return;
				}		
			break;
			case "PATCH":
				// rights: CRU
				if($this->get_user_rights() < 3) {
					$this->update_entry();
				} else {
					$this->error = true;
					return;
				}		
			break;
			case "DELETE":
				// rights: CRUD
				if($this->get_user_rights() < 2) {
					$this->delete_entry();
				} else {
					$this->error = true;
					return;
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



	private function create_entry() {
		$this->insert_data = $this->get_json_decoded_request_data();
		
		## start transaction
 		$this->start_transaction();
		## get the category_id;
		$this->get_cat_id();
		if($this->error) { 
			$this->rollback_transaction();	
			return; 
		}
		

		## insert block
		$this->insert_block();
		if($this->error) { 
			$this->rollback_transaction();
					
			return;
		}

		## get tag ids
		$this->get_tag_ids();
		if($this->error) { 
		
			$this->rollback_transaction();	
			return;
		}

		## insert into tag switch
		$this->insert_tags_in_tag_switcher();
		if($this->error) { 
			
			$this->rollback_transaction();	
			return;
		}

		## start transaction
 		$this->commit_transaction();		
	
		// close connection
		$this->closeConnection();
	}
	
	
	
	private function update_entry() {
		$this->insert_data = $this->get_json_decoded_request_data();
		
		## start transaction
 		$this->start_transaction();

		## get the category_id;   //WORKS!!
		$this->get_cat_id();
		if($this->error) { 
			print("Get cat id cancelled update");
			$this->rollback_transaction();	
			return; 
		}

		## insert block
		$this->update_block();
		if($this->error) { 
			print("Update block cancelled update");
			$this->rollback_transaction();	
			return;
		}

		## get tag ids
		$this->get_tag_ids();
		if($this->error) { 
			print("Get tag ids cancelled update");
			$this->rollback_transaction();	
			return;
		}

		## remove tags from tag switcher
		// remove all ids and insert tags anew
		$this->remove_tags_in_tag_switcher();
		if($this->error) { 
			print("Tag switcher cancelled update");
			$this->rollback_transaction();	
			return;
		}

		## insert into tag switch
		$this->insert_tags_in_tag_switcher();
		if($this->error) { 
			print("Insert tags in tag switcher cancelled update");
			$this->rollback_transaction();	
			return;
		}

		## start transaction
 		$this->commit_transaction();		
		// close DB connection
		//$this->result[] = "{}"; 
	
		// close connection
		$this->closeConnection();
	}



	private function get_archive_entry( $id_to_delete )
	{
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

		$dbm = new Database_manager($configs, $this->conn);
		$dbm->exec_select_query_multi(false, false);
		$res = $dbm->get_result();

		if( !empty($res) ) {
			foreach($res as $key => $value) {
				$this->content_of_deleted[$key] = $value;
			}
		} else {
			$this->error = true;
			return;
		}
	}



	private function archive_entry()
	{
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

		$dbm = new Database_manager($configs, $this->conn);
		$dbm ->prepare_stmt();
		$dbm ->exec_insert_stmt();
		$res = $dbm->get_result();		
		
		if(!$res['insert_id'] > 0) { 
			$this->error = true;	
		}
	}



	private function delete_entry() {
		$id_to_delete = $this->get_request_data();
		// store entry content to be deleted before deletion
		$this->get_archive_entry( $id_to_delete );

		if($this->error) {
			return;
		}

		## start transaction
 		$this->start_transaction();

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
		$dbm = new Database_manager($configs, $this->conn);
		$dbm->exec_delete_query();
		$res = $dbm->get_result();		
		if($res[0] = 0) { 
			$this->rollback_transaction();	
			return;
		}

		// archive the entry previously fetched
		$this->archive_entry();
		
		// make sure archive data was inserted
		if($this->error) {
			$this->rollback_transaction();
			return;
		}

		## start transaction
 		$this->commit_transaction();		
		// close connection
		$this->closeConnection();
	}



	private function get_cat_id()
	{
		
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
		$dbm = new Database_manager($configs, $this->conn);
		$dbm->prepare_stmt();
		$dbm->exec_select_stmt();
		$res = $dbm->get_result();

		if( $res['category_id'] ) {
			$this->last_insert_ids["category_id"] = $res['category_id'];
		} else {
			$this->error = true;
		}
	}


	
	private function insert_block_handler($configs)
	{
		if(!is_array($configs)) {
			throw new Exception("Array expected");
		}
		// open database object
		$dbm = new Database_manager($configs, $this->conn);
		// if no stmt is needed
		if($configs["stmt"] == false) {
			$dbm -> exec_insert_query();
			
		// if stmt is needed
		} elseif ($configs["stmt"] == true) {
			$dbm ->prepare_stmt();
			$dbm ->exec_insert_stmt();
		// stop if no stmt flag is provided
		} else {
			throw new Exception("Prepared statement flag not set");
		}
		// fetch result
		$res = $dbm->get_result();
		// assign result is available else throw assign error flag
		// to stop execution
		$expected = $configs["expected"][0];
		$id = $res[ $expected ];
		// check for return values
		if( $id !== NULL) {
			// lang_tables are not auto incremented
			// only register block_id from blocks table
			if($configs["expected"][0] === "block_id") {
				$block_id = $res[ $expected ];
				$this->last_insert_ids[ $expected ] = $id;
				// assign id to be returned to front end
				$this->result["block_id"] = $id;
			}
		} else {
			$this->error = true;
		}
	}



	private function insert_block()
	{
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
				"expected" => array("row_id")
			),
			
			"english" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_english(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["english"]),
				"expected" => array("row_id")
			)
			,
			"french" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_french(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["french"]),
				"expected" => array("row_id")
			)

			,
			"dutch" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_dutch(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["dutch"]),
				"expected" => array("row_id")
			),


			"italian" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_italian(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["italian"]),
				"expected" => array("row_id")
			),


			"polish" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_polish(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["polish"]),
				"expected" => array("row_id")
			),
			
			"spanish" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_spanish(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["spanish"]),
				"expected" => array("row_id")
			),

			"japanese" => array( 
				"stmt" 	   => true,
				"query"    => "INSERT INTO lang_japanese(block_id, content) VALUES (?,?)",
				"params"   => "is",
				"data" 	   => array($this->last_insert_ids["block_id"], $this->insert_data["japanese"]),
				"expected" => array("row_id")
			)		
		);

		foreach($lang_queries as $index => $value) {
			if($this->error === true) {
				//print("Error\n");
				return false;
			} else {
				$this->insert_block_handler($value);
			}
		}
	}



	private function create_tag($tag_name)
	{
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
		$dbm = new Database_manager($configs, $this->conn);
		$dbm ->prepare_stmt();
		$dbm ->exec_insert_stmt();
		// fetch result
		$res = $dbm->get_result();
		// assign result is available else throw assign error flag
		// to stop execution
		$expected = $configs["expected"][0];
		if( $res[ $expected ] !== null) {
			$this->last_insert_ids[ $expected ][] = $res[ $expected ];
		
		} else {
			$this->error = true;
		}
	}
	
	
	
	private function get_tag_ids ()
	{
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
			$dbm = new Database_manager($configs, $this->conn);
			$dbm ->prepare_stmt();
			$dbm ->exec_select_stmt();			
			// fetch result
			$res = $dbm->get_result();
			
			$expected = $configs["expected"][0];
			// assign result is available else throw assign error flag
			// to stop execution
			if( $res[ $expected ] !== null) {
				$this->last_insert_ids[ $expected ][] = $res[ $expected ];
			
			} else {
				$this->create_tag( $value );
			}	
		}
	}



	private function insert_tags_in_tag_switcher ()
	{
		// Get tags ids
		// if tag does not exist created it
		// return tag id
		## main query
		$tag_ids = $this->last_insert_ids['tag_id']; // array
		foreach($tag_ids as $key => $value) {
			$configs = array( 
				"query"    => "INSERT INTO tag_switch(block_id, tag_id) VALUES ( {$this->last_insert_ids['block_id']}, {$value} )",
				"expected" => array("switch_id"), // , ... , ...
				"stmt"	   => false
			);
			$dbm = new Database_manager($configs, $this->conn);
			$dbm -> exec_insert_query();
			$res = $dbm->get_result();
			
			if( $res[ $configs["expected"][0] ] === NULL) {
				$this->error = true;
			}
		}
	}



	private function update_block()
	{
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

		$dbm = new Database_manager($configs, $this->conn);
		$dbm -> exec_update_query();
		$res = $dbm->get_result();

		if( $res[0] = 0) {
			$this->error = true;
			return;
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
			$dbm = new Database_manager($lang_queries[ $lang ], $this->conn);
			$dbm ->prepare_stmt();
			$dbm -> exec_update_stmt();
			$res = $dbm->get_result();
			
			if( $res[0] = 0) {
				$this->error = true;
				return;
			}	
		}
		// return block_id to frontend
		$this->result["block_id"] = $insert_data["block_id"];
	}



	private function remove_tags_in_tag_switcher()
	{
		$configs = array( 
			"query"    => "DELETE FROM tag_switch WHERE block_id =  {$this->insert_data['block_id']}",
			"expected" => array()
		);

		$dbm = new Database_manager($configs, $this->conn);
		$dbm -> exec_delete_query();
		$res = $dbm->get_result();

		if( $res === false) {
			$this->error = true;
			return;
		}	
	}		
}

