<?php
// base class Database
require_once "class_db.inc.php";
require_once "class_db_dbm.inc.php";
require_once "/../application/library/password.php";

// inherites from class Database
// tags and cats class
class User extends Database {
	
	private $login = false;
	
	private $error = array(
		"login" => false,
		"system" => false
	);

	private $result = array(
		//"username"
		//"user_id"
		//"rights"
	);
	
	### constructor
	public function __construct() {
	}

	public function route_request() {
		// route request to appropriate handler
		switch( $this->requestType ) {
			case "POST":
				$data = $this->get_stripped_post_request_date();
				// not the value assigned to the SESSION
				$this->user_name_login 	 	= $data["user_name"];
				$this->user_password_login 	= $data["user_password"];
			break;
			// if request type is not defined
			default:
				throw new Exception("Wrong request type", 1);
		}
	}

	public function get_result()
	{
		return $this->result;
	}

	public function get_errors()
	{
		return $this->error;
	}

	public function get_login() {
		return $this->login;
	}

	public function login()
	{
		$logged_in = false;

		$configs = array( 
			"query" 		=> "SELECT password, username, user_id, rights FROM users WHERE username = ?",
			"stmt"			=> true,
			"params" 		=> "s",
			"data" 			=> array($this->user_name_login),
			// expected column names by db
			// expected values are bound to result
			"expected"		=> array("password", "username", "user_id", "rights") // , ... , ...
		); 
			//prepare statement)
		$dbm = new Database_manager($configs, $this->conn);
		$dbm->prepare_stmt();
		$dbm->exec_select_stmt();
		$res = $dbm->get_result();

		// add cat_ids to ids_to_select
		// do not assign when no value is returned
		if( $res["password"] !== null ) {
			$logged_in = password_verify($this->user_password_login, $res["password"]);
		}
		
		if($logged_in === true) {
			$this->login = true;
			// assign result to results
			$this->result["user_name"] 		= $res["username"];
			$this->result["user_id"] 		= $res["user_id"];
			$this->result["user_rights"] 	= $res["rights"];
			// record login with fetched user data
			$this->record_login();

		} else {
			$this->error["login"] = true;
		}
	}

	private function record_login()
	{
		$configs = array( 
			"query" 		=> "UPDATE users SET last_login = NOW() WHERE user_id = {$this->result['user_id']}",
			"expected"		=> array()
		);

		$dbm = new Database_manager($configs, $this->conn);
		$dbm->exec_update_query();
		$res = $dbm->get_result();

		if($res[0] !== 1) {
			$this->error["system"] = true;
		}

	}
}
