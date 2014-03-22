<?php
// error location 1000
// base class Database
require_once "class_db_dbm.inc.php";
require_once "/../application/library/password.php";

// inherites from class Database
// tags and cats class
class User extends Database_manager {

	private $login = false;
	private $error_login = array(
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
	 // error 1001
	}

	public function route_request() {
		// error 1002
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
		// error 1003
		return $this->result;
	}

	public function get_errors()
	{
		// error 1004
		return $this->error_login;
	}

	public function get_login()
	{
		// error 1005
		return $this->login;
	}

	public function login()
	{
		// error 1006
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
		$this->dbm_config($configs);
		$this->dbm_prepare_stmt();
		$this->dbm_exec_select_stmt();
		$res = $this->dbm_get_result();

		// add cat_ids to ids_to_select
		// do not assign when no value is returned
		if( $res["password"] !== null ) {
			$logged_in = password_verify($this->user_password_login, $res["password"]);
		}
		
		if($logged_in === true) {
			$this->login = true;
			// assign result to results
			$this->result["user_name"] 	 = $res["username"];
			$this->result["user_id"] 	 = $res["user_id"];
			$this->result["user_rights"] = $res["rights"];
			// record login with fetched user data
			$this->record_login();

		} else {
			$this->error_login["login"] = true;
		}
	}

	private function record_login()
	{
		// error 1007
		$configs = array( 
			"query" 		=> "UPDATE users SET last_login = NOW() WHERE user_id = {$this->result['user_id']}",
			"expected"		=> array()
		);

		$this->dbm_config($configs);
		$this->dbm_exec_update_query();
		$res = $this->dbm_get_result();

		if($res[0] !== 1) {
			$this->error_login["system"] = true;
		}
	}
}
