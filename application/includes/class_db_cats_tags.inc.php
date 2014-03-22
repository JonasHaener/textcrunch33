<?php

// base class Databasemanager
require_once "class_db_dbm.inc.php";

// inherites from class Database
// tags and cats class
class Tags_and_cats extends Database_manager {
	
	private	$result = array(
		"categories" => array(),
		"tags"		 => array()
	);
	public 	$err = array(
		"request" 		=> false,
		"connection"    => false
	);
	
	public function __construct() {
	}	
	
	private function prepResultArr($res, $kind) {
		while ($row = $res -> fetch_assoc()) {
			$this -> result[$kind][] = $row['name'];
		}	
	}
	// read entry
	public function fetch() {
		// sql query for is search
		$query_tags = "SELECT name FROM tags";
		$query_cats = "SELECT name FROM categories ORDER BY name";
		// fetch tags
		if( !($res = $this->conn->query($query_tags))) {
			$this->error_and_close();
			return;
		}
		$this->prepResultArr($res, "tags");
		// fetch categories
		if( !($res = $this->conn->query($query_cats))) {
			$this->error_and_close();
			return;
		}		
		$this->prepResultArr($res, "categories");	
		// close connection	
		$this->closeConnection();
		// write result
		$this->get_result();
	}

	public function get_result()
	{
		header('Content-type: application/json');
		http_response_code(200);
		echo json_encode($this->result, true);
	}
}


