<?php
// error location 700
// base class Database
require_once "class_db_dbm.inc.php";

// inherites from class Database
// tags and cats class
class Project extends Database_manager{
	
	private $result = array();
	private $is_public = false;
	// collect errors
	// default is false -> no error
	public 	$err = false;
	// holds the last used record id
	public $last_used_record_id = -1;


	### constructor
	public function __construct() {
		//error 701
	}


	public function route_request() {
		//error 703
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
				handle_error(703);
				throw new Exception("Wrong request type", 1);

		}
	}


	public function get_result() {
		//error 704
		switch( $this->requestType ) {
			// fetch all projects
			case "GET":
				http_response_code(200);
				echo json_encode($this->result, true);
				break;
			// create a new project
			case "POST":
				http_response_code(200);
				echo json_encode($this->result, true);
				break;
			// update an existing project
			case "PUT":
				if($this->is_public) {
					handle_error(704, "Public project");
				
				} else {
					http_response_code(200);
					echo json_encode($this->result, true);
				}
				break;
			// delete a new project
			case "DELETE":
				if($this->is_public) {
					handle_error(704, "Public project");
				
				} else {
					http_response_code(200);
					echo json_encode($this->result, true);
				}
				break;
			// if request type is not defined
			default:
				handle_error(704);
				throw new Exception("Wrong request type", 1);
		}		
	}
	
	
	private function check_if_public($project_id) {
		//error 705
		if(!is_int($project_id)) {
			throw new Exception("Integer expected");	
		}
		// query
		$query = "SELECT user_id FROM projects WHERE project_id = {$project_id}"; 
		//prepare statement)
		if(!($call = $this->conn->query($query))) {
			$this->error_and_rollback();
			return;
		}	
		
		$res = $call->fetch_assoc();
		$id = $res["user_id"];
		// switch to false if not public
		if($id === null) {
			$this->error_and_rollback();
			return false;
		}

		if(intval($res["user_id"]) === 0) {
			$this->is_public = true;
		}
		return $this->is_public;
	}
	
	
	private function prep_result($db_data) {
		//error 706
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
		//error 707
		
		## fetch user projects
		$query = "SELECT project_id, project_name, collection FROM projects WHERE user_id = {$this->user['user_id']}";
		if(!($res = $this->conn->query($query))) {
			$this->error_and_rollback();
			return;
		}	
		$this->prep_result($res);
		
		## fetch public projects
		## user id = 0, user does not exist in user table
		$query = "SELECT project_id, project_name, collection FROM projects WHERE user_id = 0";
		if(!($res = $this->conn->query($query))) {
			$this->error_and_rollback();
			return;
		}	
		$this->prep_result($res);

		// close connection	
		$this->closeConnection();
	}
	
	private function create_project() {
		//error 708

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
			// exceute statement
			if(!$stmt->execute()) {
				$this->error_and_rollback();
				return;
			}
			// retrieve last id saved
			$this->result = array ( "project_id" => $this->get_last_insert_id() );
			$this->commit_transaction();
			// free results
			$stmt->free_result();
			// close connection
			$stmt->close();
		
		} else {
			$this->error_and_rollback();
		}
		
		// close DB connection
		$this->closeConnection();
	}

	private function make_project_public($project_id)
	{
		## get project name
		$query = "SELECT project_name FROM projects WHERE project_id = {$project_id}";
		$configs = array(
			"query" 	=> $query,
			"expected" 	=> array("project_name")
		);
		$this->dbm_config($configs);
		$this->dbm_exec_select_query(false, false);
		// get current project name
		$res = $this->dbm_get_result();
		// set public project name
		$pj_name = "_p_{$res["project_name"][0]}";

	
		## set public project name (_p_) and set user_id to public (=0)
		$query = "UPDATE projects SET project_name = '{$pj_name}', user_id = 0 WHERE project_id = '{$project_id}'";
		$configs = array(
			"query" 	=> $query,
			"expected" 	=> array()
		);
		$this->dbm_config($configs);
		
		// start transaction
		$this->start_transaction();
		// run query
		$this->dbm_exec_update_query();
		$res = $this->dbm_get_result();
		// error returns 		
		if($res["affected_rows"] < 0) {
			$this->error_and_rollback();
		}
		$this->result["project_id"] = $project_id;
		$this->result["project_name"] = $pj_name;

		// commit transaction
		$this->commit_transaction();
		// close connection
		$this->closeConnection();
	}

	private function update_project() {
		//error 709

		// parse JSON data
		$data = $this->get_json_decoded_request_data();
		$project_id = intval($data["project_id"]);

		// check if project_id is integer
		if( $project_id <= 0 || !is_int($project_id) ) {
			throw new Exception("Project id of wrong type");
			$this->closeConnection();	
			return;
		}
		
		// do not allow public project to be overwritten
		if($this->check_if_public($project_id)) {
			$this->closeConnection();	
			return;
		}

		if(isset($data["makePublic"]) &&  $data["makePublic"] === true) {
			$this->make_project_public($project_id);
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
			if( !($stmt->execute())) {
				$this->error_and_rollback();
				return;
			}
			// retrieve last id saved
			$this->result = array ( "project_id" => $data['project_id']);
			// commit transaction
			$this->commit_transaction();
			
			// close connection
			$stmt->close();
		
		} else {
			$this->error_and_rollback();
		}
		
		// close DB connection
		$this->closeConnection();
	}

	private function delete_project() {
		//error 710

		$project_id = intval($this->get_request_data(), 10);
		
		// check if project_id is integer
		if( $project_id <= 0 || !is_int($project_id) ) {
			throw new Exception("Project id of wrong type");
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
		if( !($this->conn->query($query))) {
			$this->error_and_rollback();
		}
		// close connection	
		$this->closeConnection();
	}
}

