<?php
// Database parent class
class Database {
	// holds public DB connection
	protected $conn;
	// holds errors
	protected $request;
	protected $request_data;
	protected $requestType;
	protected $url;
	protected $err_conn = false;
	// user_id, user_name ...
	protected $user = array();	
	
	
	// CONNECT TO DATABSE
	public function connect_db($config_host, $config_db_user, $config_db_pwd, $config_database ) {
		// connect to db via mysqli
		$conn = $this->conn = new mysqli($config_host, $config_db_user, $config_db_pwd, $config_database) or die ('Cannot open database');
		// assign error in case
		if ($conn->connect_errno > 0) {
			$this->err_conn = true;
			// return true for cancellation
			return true;
			
		} else  {
			return false;
		}
	}
	
	protected function process_error()
	{
		if($this->conn->errno > 0) {
			return true;
		} else {
			return false;
		}
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
   			$conv[ htmlspecialchars( urldecode( $val[0] )) ] = htmlspecialchars( urldecode( $val[1] )); 
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