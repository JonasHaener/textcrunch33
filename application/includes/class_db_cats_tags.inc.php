<?php

// base class Database
require_once "class_db.inc.php";

// inherites from class Database
// tags and cats class
class Tags_and_cats extends Database {
	
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
		$res = $this -> conn -> query($query_tags);
		$this->prepResultArr($res, "tags");

		$res -> free_result();
		// fetch categories
		$res = $this -> conn -> query($query_cats);
		$this->prepResultArr($res, "categories");	
		$res -> free_result();
		// close connection	
		$this->closeConnection();
	}

	public function get_result()
	{
		return $this->result;
	}
}


