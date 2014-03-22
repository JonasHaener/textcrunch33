<?php
require_once "error_handling.php";
// Database parent class
class Database {
	// holds public DB connection
	protected $conn;
	// holds errors
	protected $request;
	protected $request_data;
	protected $requestType;
	protected $url;
	// user_id, user_name ...
	protected $user = array();	
	
	
	// CONNECT TO DATABSE
	public function connect_db($config_host, $config_db_user, $config_db_pwd, $config_database ) {
		// connect to db via mysqli
		$conn = $this->conn = new mysqli($config_host, $config_db_user, $config_db_pwd, $config_database) or die ('Cannot open database');
		// assign error in case
		if ($conn->connect_errno > 0) {
			handle_error(50, "connection");
			$this->closeConnection();
		}
	}

	public function check_process_error($error_code, $message ="")
	{
		if($this->conn->error) {
			$this->closeConnection();
			handle_error($error_code, $message);
			return true;

		} else {
			return false;
		}
	}

	private function prep_trace_stack($stack)
	{
		$mess = "";
		foreach($stack as $i => $value) {
			$mess.= basename($value["file"])." :: ".$value["line"]."--end--";
		}
		return $mess;
	}
		
	public function error_and_close($error_code, $message ="") 
	{
		$trace = debug_backtrace();
		$message = ($message === "") ? $this::prep_trace_stack($trace) : $message;
		$this->closeConnection();
		handle_error($error_code, $message);
	}


	public function error_and_rollback($error_code, $message ="", $rollback = true) 
	{
		$trace = debug_backtrace();
		$message = ($message === "") ? $this::prep_trace_stack($trace) : $message;
		$this->rollback_transaction();
		$this->closeConnection();
		handle_error($error_code, $message);
	}
	

	protected function get_user_rights()
	{
		return $this->user["user_rights"];
	}



	public function set_user($user)
	{
		$this->user["user_id"] 		= $user["user_id"];
		$this->user["user_rights"] 	= $user["user_rights"];
	}



	public function set_request($request, $server, $data) {
		$this->server = $server;
		$request_type = $this->requestType 	= $server['REQUEST_METHOD'];
		$this->url 	  = $server['REQUEST_URI'];
		// grabs the submitted data by front end
		// POST, GET
		$this->set_request_data( $data, $request_type );
	}



	private function url_decode_variables($query_string)
	{
		$qarr = explode('&', $query_string); 
		$conv = array();
		foreach($qarr as $key => $val) { 
  		 	$val = explode('=', $val);
  			// convert boolean string values to boolean		 	
  		 	if(strtolower($val[1]) === "true") {
  		 		$val[1] = true;
  		 	
  		 	} elseif(strtolower($val[1]) === "false") {
  		 		$val[1] = false;
  		 	}
   			// if boolean do not apply urldecode
   			$conv[ urldecode($val[0]) ] = ( is_bool($val[1]) ) ? $val[1] : urldecode( $val[1] ); 
		}
		return $conv; 
	}



	// SET URL DATA
	private function set_request_data($data, $request_type) {
		// GET and DELETE -> get data from URL
		// POST and PUT -> file_get_contents('php://input')
		switch( $request_type ) {
			case "GET":
				// retrieve arguments when path.php/?...
				if(strpos($this->url, "?") !== false)
				{
					$e = explode('?', $this->url );
					if(is_array($e))
					{
						$this->request_data = $this->url_decode_variables(end($e));
					}
							
				} else {
					// get value after "/"	
					$e = explode('/', $this->url );
					$this->request_data = end($e);
				}
			break;
			case "POST":
				$this->request_data = $data;
			break;
			case "PUT":
				$this->request_data = $data;
			break;
			case "PATCH":
				$this->request_data = $data;
			break;
			case "DELETE":
				$e = explode('/', $this->url );
				$this->request_data = end($e);
			break;
				throw new Exception("Wrong request type", 1);
			default:
		}
	}



	public function get_stripped_post_request_date()
	{
		$stripped = array();
		$data = $this->request_data;

		if(strpos($data, "&") !== false) {
			$packs = explode('&', $data );
			foreach($packs as $key => $value) {
				$e = explode('=', $value );
				$stripped[$e[0]] = $e[1];
			}
		} elseif(strpos($data, "=")) {
			$e = explode('=', $data );
			$stripped[$e[0]] = $e[1];
		} else {
			// return original
			$stripped = $data;
		}
		return $stripped;
	}
	
	
	
	protected function get_request_data() {
		return $this->request_data;
	}



	protected function get_json_decoded_request_data() {
		$data = json_decode( $this->request_data, true );
		if($data) {
			return $data;
		
		} else {
			throw new Exception("Cannot convert Json data", 1);
		}
	}
	
	

	public function getRequestType() {
		return $this->requestType;
	}	



	// get connection error
	public function getConnErr() {
		return $this->err_conn;
	}



	public function closeConnection() {
		$this -> conn -> close();
	}



	protected function get_last_insert_id() {
		return $this->conn->insert_id;
	}



	protected function get_affected_rows() {
		return $this->conn->affected_rows;
	}



	protected function start_transaction() {
		$this->conn->query("START TRANSACTION");
	}



	protected function commit_transaction() {
		$this->conn->query("COMMIT");
	}



	protected function rollback_transaction() {
		$this->conn->query("ROLLBACK");
	}
}