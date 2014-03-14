<?php
// base class Database
require_once "class_db.inc.php";

// inherites from class Database
// tags and cats class
class Project extends Database {
	
	private $result = array();
	private $is_public = false;
	// collect errors
	// default is false -> no error
	public 	$err = false;
	// holds the last used record id
	public $last_used_record_id = -1;


	### constructor
	public function __construct() {
	}

	
	public function is_public() {
		return $this->is_public;	
	}
	
	
	public function route_request() {
		// route request to appropriate handler
		switch( $this->requestType ) {
			// fetch all projects
			case "GET":
				$this->get_projects();
			break;
			// create a new project
			case "POST":
				$this->create_project();
			break;
			// update an existing project
			case "PUT":
				$this->update_project();
			break;
			// delete a new project
			case "DELETE":
				$this->delete_project();
			break;
			// for testing purposes
			// if request type is not defined
			default:
				throw new Exception("Wrong request type", 1);
		}
	}


	public function get_result() {
		return $this->result;
	}
	
	
	private function check_if_public($project_id) {
		if(!is_int($project_id)) {
			throw new Exception("Integer expected");	
		}
		$this->is_public = true;
	
		// query
		$query = "SELECT user_id FROM projects WHERE project_id = {$project_id}"; 
		//prepare statement)
		$call = $this->conn->query($query);
		
		if($this->process_error()) {
			$this->err = true;
			// reset so as not to falsify error
			$this->is_public = false;
		
		} else {
			$res = $call->fetch_assoc();
			// switch to false if not public
			if(intval($res["user_id"]) !== 0) {
				$this->is_public = false;
			}

		}
		
		return $this->is_public;
	}
	
	
	private function prep_result($db_data) {
		
		$result = array();
		
		// loop datbase result
		if($db_data->num_rows > 0) {
			
			// loop records
			while ($row = $db_data -> fetch_assoc()) {
				// sub array
				$res_arr = array();
				$res_arr["project_id"] 		= $row["project_id"];
				$res_arr["project_name"] 	= $row["project_name"];
				$res_arr["collection"]		= $row["collection"];
		
				$result[] = $res_arr;
			}
			// only assign reseults when results are available
			
		}
		$this->result = array_merge($this->result, $result);
		//free result
		$db_data->free_result();	
	}


	private function get_projects() {
		## fetch user projects
		$query = "SELECT project_id, project_name, collection FROM projects WHERE user_id = {$this->user['user_id']}";
		$res = $this->conn->query($query);
	
		if($this->process_error()) {
			$this->err = true;
			return;	
		}
		
		$this->prep_result($res);

		## fetch public projects
		## user id = 0, user does not exist in user table
		$query = "SELECT project_id, project_name, collection FROM projects WHERE user_id = 0";
		$res = $this->conn->query($query);
		
		if($this->process_error()) {
			$this->err = true;
			return;	
		}		
		
		$this->prep_result($res);

		// close connection	
		$this->closeConnection();
	}
	
	private function create_project() {
		// parse JSON data
		$data = $this->get_json_decoded_request_data();
		// query
		$query = "INSERT INTO projects( user_id, project_name, collection ) VALUES ( ?, ?, ? )"; 
		//prepare statement)
		$stmt = $this->conn->stmt_init();
		// if query yields results execute search
		if ($stmt->prepare( $query )) {
			//var_dump($stmt);
			$stmt->bind_param( 'iss', $this->user['user_id'], $data['project_name'], $data['collection'] );
			
			## start transaction
			$this->start_transaction();
			$stmt->execute();
			
			// detect error
			if($this->process_error()) {
				$this->err = true;
				
			} elseif ($this->get_affected_rows() > 0) {
				// retrieve last id saved
				$this->result = array ( "project_id" => $this->get_last_insert_id() );
				$this->commit_transaction();
				// free results
				$stmt->free_result();
			}
			
			// close connection
			$stmt->close();
		
		} else {
			$this->err = true;	
		}
		
		// close DB connection
		$this->closeConnection();
	}

	private function update_project() {
		// parse JSON data
		$data = $this->get_json_decoded_request_data();
		$project_id = intval($data["project_id"]);

		// check if project_id is integer
		if( $project_id <= 0 || !is_int($project_id) ) {
			// close connection	
			$this->closeConnection();	
			return;
		}
		
		// do not allow public project to be overwritten
		if($this->check_if_public($project_id) || $this->err) {
			$this->closeConnection();	
			return;
		}
		
		// query
		$query = "UPDATE projects SET project_name = ?, collection = ? WHERE project_id = ?"; 
		//prepare statement)
		$stmt = $this->conn->stmt_init();

		// if query yields results execute search
		if ($stmt->prepare( $query )) {
			//var_dump($stmt);
			$stmt->bind_param( 'ssi', $data['project_name'], $data['collection'], $data['project_id']);

			// start transaction
			$this->start_transaction();
			// execute stmt with params
			$stmt->execute();
			
			// detect error
			if(!$this->process_error()) {
				// retrieve last id saved
				$this->result = array ( "project_id" => $data['project_id']);
				// commit transaction
				$this->commit_transaction();
			
			} else {
				$this->err = true;
			}

			// close connection
			$stmt->close();
		
		} else {
			$this->err = true;	
		}
		
		// close DB connection
		$this->closeConnection();
	}

	private function delete_project() {
		$project_id = intval($this->get_request_data(), 10);
		
		// check if project_id is integer
		if( $project_id <= 0 || !is_int($project_id) ) {
			// close connection	
			$this->closeConnection();	
			return;
		}
		
		// do not allow public project to be overwritten
		if($this->check_if_public($project_id) || $this->err) {
			// close DB connection
			$this->closeConnection();	
			return;
		}
		
		// query
		$query = "DELETE FROM projects WHERE project_id = {$project_id}";
		// make db call
		$this->conn->query($query);
		
		if($this->process_error()) {
			// retrieve last id deleted
			$this->err = true;
		}
				
		// close connection	
		$this->closeConnection();
	}
}

