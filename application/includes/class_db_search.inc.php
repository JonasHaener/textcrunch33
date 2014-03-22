<?php
// error location 800
// base class Database
require_once "class_db_dbm.inc.php";

// inherites from class Database
// tags and cats class
class Search extends Database_manager {
	
	private $result = array();
	private $fetch_data;
	private $lang_german 		 = array("german");
	private $lang_english 		 = array("english");
	private $lang_german_english = array("german", "english" );
	private $lang_all 			 = array("german", "english", "french", 
									"dutch", "italian", "polish", "spanish", "japanese");
	// assigned after testing if
	// languages are requested
	private $lang_to_search;
	// holds ids to be fetched from database
	// for evaluation in backend 
	private $ids_to_fetch = array(
		"block_ids"   => array(),
		"block_tags"  => array(),
		"block_cats"  => array()
	);
	// actual ids to return to frontend
	private $ids_to_return = array();

	### constructor
	public function __construct() {
		// error 801
	}

	public function result_size()
	{
		// error 803
	}

	public function route_request() {
		// error 805
		// route request to appropriate handler
		switch( $this->requestType ) {
			case "GET":
				$data = $this->fetch_data = $this->prepare_search_data( $this->get_request_data() );
				// if prefetch is set, prefetch ids
				if(isset($data["prefetch"]) && $data["prefetch"] === true) {
					$this->prefetch_entries();
				// fetch all data
				} else {
					$this->get_entries();
				}
			break;
			// if request type is not defined
			default:
				throw new Exception("Wrong request type", 1);
		}
	}


	public function get_result() {
		// error 806
		http_response_code(200);		
		echo json_encode($this->result, true);
	}


	private function prepare_search_data($data)
	{
		// error 807
		$conv = $data;
		foreach($data as $key => $value) {
			// convert strings true/false into boolean values
			$value = ($value === "false" ) ? boolval(0) : $value;
			$value = ($value === "true" ) ? boolval(1) : $value;
			if(is_string($value) && strpos($value, ';') !== false) {
				$conv[$key] = explode(";", $value);
			
			} elseif(is_bool($value)) {
				$conv[$key] = boolval($value);
			
			} else {
				if($value !== "") {
					$conv[$key] = array($value);
				} else {
					$conv[$key] = array();
				}	
			}
		}
		return $conv;
	}


	private function assign_lang_to_search($configs)
	{
		// error 808
		if($configs['searchAllLang'] === true) {
			$this->lang_to_search = $this->lang_all;
			return true;

		} elseif($configs['searchEnglish'] === true && $configs['searchGerman'] === true) {
			$this->lang_to_search = $this->lang_german_english;	
			return true;

		} elseif($configs['searchEnglish'] === true) {
			$this->lang_to_search = $this->lang_english;
			return true;

		} elseif ($configs['searchGerman'] === true) {
			$this->lang_to_search = $this->lang_german;
			return true;

		} else {
			return false;
		}	
	}

	private function prefetch_entries()
	{
		// error 809
		## start transaction
 		$this->start_transaction();

		## get_blocks with search ids;
		$this->prepare_block_ids();
		
		## get_blocks with search categories
		$this->get_cat_matching_block_ids();

		## get_blocks with search tags
		$this->get_tag_matching_block_ids();

		## sort out duplicates of found block ids
		$this->determine_block_ids();

		## return found block ids
		$this->result = $this->prep_prefetched_ids( $this->ids_to_return );

		## commit transaction
 		$this->commit_transaction();		
		
		## close connection
		$this->closeConnection();
		
		## write result
		$this->get_result();
	}

	private function prep_prefetched_ids($ids)
	{
		// error 810
		$res = array();
		foreach($ids as $id) {
			$res[] = array("block_id" => $id);
		}

		return $res;
	}


	private function get_entries()
	{
		// error 811
		## assign lang to search and if lang are needed at all 
		// stop transaction
		if($this->assign_lang_to_search($this->fetch_data) === false) {
			$this->error = true;
			return;
		}
		## start transaction
 		$this->start_transaction();

		## get_blocks with search ids;
		$this->prepare_block_ids();
	
		## sort out duplicates of found block ids
		$this->determine_block_ids();
	
		## find matches of found block ids
		$this->retrieve_return_block_ids();
	
		## commit transaction
 		$this->commit_transaction();		
		
		## close connection
		$this->closeConnection();

		## write result
		$this->get_result();
	}


	// !! ids are never matched against tags and categories
	// fetched separately
	// check they exist during prefetch
	private function prepare_block_ids()
	{
		// error 812
		// convert string to integers
		$ids = array();
		foreach($this->fetch_data["id"] as $key => $value) {
			if( ($value !== "") && (intval($value)) ) {
				$ids[] = intval($value);
			}
		}

		// check if they exits
		$configs = array( 
			"table"			=> array("blocks"),
			"data"			=> $ids,
			"expected"		=> array("block_id")
		);
		

		$this->dbm_config($configs);
		$this->dbm_id_exists();
		$res = $this->dbm_get_result();
		$this->ids_to_fetch["block_ids"] = $res["block_id"];
	}

	private function get_cat_matching_block_ids()
	{
		// error 813
		$cat_names = $this->fetch_data["category"]; //array
		$cat_id_match = array();
		$block_ids = array();

		// ## get cat ids matching catnames ##
		foreach ($cat_names as $key => $cat_name) {
			$configs = array( 
					"query" 		=> "SELECT category_id FROM categories WHERE name = ?",
					"stmt"			=> true,
					"params" 		=> "s",
					"data" 			=> array($cat_name),
					// expected column names by db
					// expected values are bound to result
					"expected"		=> array("category_id") // , ... , ...
				); 
			//prepare statement)
			$this->dbm_config($configs);
			$this->dbm_prepare_stmt();
			$this->dbm_exec_select_stmt();
			$res = $this->dbm_get_result();
			// add cat_ids to ids_to_select
			// do not assign when no value is returned
			if( $res["category_id"] !== null ) {
				$cat_id_match[] = $res["category_id"];
			}
		}

		
		## get block_ids matching ##
		foreach ($cat_id_match as $key => $cat_id) {
			$configs = array( 
					"query" 		=> "SELECT block_id FROM blocks WHERE category_id = {$cat_id}",
					"expected"		=> array("block_id") // , ... , ...
				); 
			//prepare statement)
			$this->dbm_config($configs);
			$this->dbm_exec_select_query(true, true);
			$res = $this->dbm_get_result();
			// add cat_ids to ids_to_select
			// do not assign when no value is returned
			if( !empty($res["block_id"]) ) {
				// array is returned as result
				$block_ids = array_merge($block_ids, $res["block_id"]);
			}
			
		}
		$this->ids_to_fetch["block_cats"] = $block_ids;
	}


	private function get_tag_matching_block_ids()
	{
		// error 814
		$names = $this->fetch_data["tag"]; //array
		// holds tag ids
		$tag_id_match = array();
		$block_ids = array();
		$tag_block_ids_intersect = array();
		// loop all cat_names
		// collect ids

		foreach ($names as $key => $name) {
			$configs = array( 
					"query" 		=> "SELECT tag_id FROM tags WHERE name = ?",
					"stmt"			=> true,
					"params" 		=> "s",
					"data" 			=> array($name),
					// expected column names by db
					// expected values are bound to result
					"expected"		=> array("tag_id") // , ... , ...
				); 
			//prepare statement)
			$this->dbm_config($configs);
			$this->dbm_prepare_stmt();
			$this->dbm_exec_select_stmt();
			$res = $this->dbm_get_result();
			if( $res["tag_id"] !== null ) {
				$tag_id_match[] = $res["tag_id"];
			} 
			// ##!! if one tag is not in DB no entry will match ##
			else {
				$tag_id_match = array();
				return;
			}
		}
		
		## get block_ids matching ##
		foreach ($tag_id_match as $key => $tag_id) {
			$configs = array( 
				"query" 	=> "SELECT block_id FROM tag_switch WHERE tag_id = {$tag_id}",
				"expected"	=> array("block_id") // , ... , ...
			); 
			//prepare statement)
			$this->dbm_config($configs);
			$this->dbm_exec_select_query(true, true);
			$res = $this->dbm_get_result();
			// add cat_ids to ids_to_select
			// do not assign when no value is returned
			$block_ids[] = (!empty($res["block_id"])) ? $res["block_id"] : array();
		}
		
		// all tags will be compared agauinst this
		// root array
		// if no result is found empty array will be used
		if(!empty($block_ids))
		{
			$tag_block_ids_intersect = $block_ids[0];
			foreach ($block_ids as $key => $tags) {
				// root: 1,2,5
				// second 1,2,5 -> 1,2, 5
				// third 1,4
				// empty array will cancel process --> not matches
				// find intersection and merge with $tag_block_ids_intersect array
				$tag_block_ids_intersect = array_intersect($tag_block_ids_intersect, $tags);
			}
			$this->ids_to_fetch["block_tags"] = array_unique($tag_block_ids_intersect);
		}		
	}

	private function determine_block_ids()
	{
		// error 815
		$ids   	   = $this-> ids_to_fetch["block_ids"];
		$tags_ids  = $this-> ids_to_fetch["block_tags"];
		$cats_ids  = $this-> ids_to_fetch["block_cats"];
		// these tags are looked for if existent or not
		$looked_for_tags = $this->fetch_data["tag"];
		$looked_for_cats = $this->fetch_data["category"];
		
		// holds retrieved values from all nested tag arrays
		// initial assignment only
		$ids_to_return = $this->ids_to_return;

		## insert ids to $ids_to_return
		// ids are always fetched separately
		$ids_to_return = array_merge($ids_to_return, $ids);
		
		## return duplicates into array
		// duplicates are matches of @category and #tags
		// find intersection only when both $cats and $tags are not empty
		if(!empty($cats_ids) && !empty($tags_ids)) {
				// cat1: 1,2,3,4,6,7 (cats1)(cats2)
				// tags   1,2,3 (ids matching all input tags)
				// [1,2,3]
			$ids_to_return = array_merge( $ids_to_return, array_intersect($tags_ids, $cats_ids) );
		
		// Match for cat BUT not for tag
		} elseif(!empty($looked_for_tags) && !empty($cats_ids)) {
			//  do nothing here

		// Match for tag BUT not for cat
		} elseif(!empty($looked_for_cats) && !empty($tags_ids)) {

		// Need match cat only
		} elseif(!empty($cats_ids)) {
			$ids_to_return = array_merge($ids_to_return, $cats_ids);
	
		// Need match for tag only
		} elseif(!empty($tags_ids)) {
			$ids_to_return = array_merge($ids_to_return, $tags_ids);
		}

		// remove duplicate values after merging with pure id tags
		$ids_to_return = array_unique($ids_to_return);
		// sort does not need variable assignment
		sort($ids_to_return);
		// assign result
		$this->ids_to_return = $ids_to_return;
	}


	private function retrieve_return_block_ids()
	{
		// error 816
		$configs = $this->get_request_data();
		$ids 	 = $this->ids_to_return;
		$tables  = $this->lang_to_search;
		$content = array();
		// error is used to skip searches when no results are found
		$error 	 = false;

		// loop ids to search
		foreach($ids as $index => $id) {
			// loop each table
			$sub_result = array();
			
			## get category name
			$configs = array( 
					"query" 		=> "SELECT name FROM categories WHERE category_id = (SELECT category_id FROM blocks WHERE block_id = {$id})",
					"expected"		=> array("name") // , ... , ...
			);
			$this->dbm_config($configs);
			$this->dbm_exec_select_query(true, true);
			$res = $this->dbm_get_result();
			
			if(!empty($res["name"])) {
				$sub_result["category"] = $res["name"][0];
			
			} else {
				// if no result break and continue loop
				// every result must have a category
				continue;
			}

			## get tag names
			$configs_tags = array( 
					//"query" 		=> "SELECT name FROM tags WHERE tag_id = (SELECT tag_id FROM tag_switch WHERE block_id = {$id})",
					"subquery" 			=> "SELECT tag_id FROM tag_switch WHERE block_id = {$id}",
					"subquery_expected"	=> "tag_id",
					// to be performed on each query
					"query"				=> "SELECT name FROM tags WHERE tag_id =",
					"expected"			=> array("name") // , ... , ...
			);
			$this->dbm_config($configs_tags);
			$this->dbm_exec_select_query_multi_subquery(true, true);
			$res = $this->dbm_get_result();

			// if tag names
			if(!empty($res["name"])) {
				$sub_result["tags"] = $res["name"];
			
			}

			// fetch contents
			foreach($tables as $index => $table) {
				// add prefix of table name
				$table = "lang_".$table;
				$configs = array( 
						"query" 		=> "SELECT content, block_id, lang FROM {$table} WHERE block_id = {$id}",
						"expected"		=> array( "block_id",  "content", "lang") // , ... , ...
				);
				$this->dbm_config($configs);
				$this->dbm_exec_select_query_multi(false, true);
				$res = $this->dbm_get_result();
				//print_r($res);
				if(!empty($res)) {
					foreach ($res as $key => $entry) {
						$sub_result["block_id"] 		= $entry["block_id"];
						$sub_result[ $entry["lang"] ] 	= htmlspecialchars($entry["content"], ENT_QUOTES);
					}
				}
			}
			// check if empty to avoid returning empty array
			// empty arrays cause errors in front end parsing
			if(!empty($sub_result)) {
				// assign language flags
				$sub_result["searchGerman"] 	= $this->fetch_data["searchGerman"];
				$sub_result["searchEnglish"] 	= $this->fetch_data["searchEnglish"];
		 		$sub_result["searchAllLang"] 	= $this->fetch_data["searchAllLang"];
		 		$sub_result["lang_to_update"] 	= $this->lang_to_search;
				$content[] = $sub_result;
			}
		}

		$this->result = $content;
	}
}

