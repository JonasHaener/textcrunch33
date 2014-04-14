<?php
// error location 500
## Database management class
require_once "class_db.inc.php";

class Database_manager extends Database {
	
	//private $queryConfigs = array();
	//private $queryTmpl = array();
	private $result = array();
	//private $stmtData = array(); ## assigned by $this->prepQuery()
	private $stmt;
	private $configs;

	public function __construct() {
		// error 501
	}

	protected function dbm_config($configs)
	{
		// error 502
		// assign default values to expected
		// result array
		$expected_val = array();
		foreach($configs["expected"] as $key => $value) {
			$expected_val[$value] = null;
		}	
		$this->configs = $configs;
		// result is assigned null
		// for later use in bind_result()
		$this->result  = $expected_val;
	}


	// accepts multiple ids
	public function dbm_id_exists()
	{
		// error 503
		$configs = $this->configs;
		$table = $configs['table'][0];
		$ids = $configs['data'];
		$found = array();

		foreach($ids as $key => $value) {
			if(!($res = $this->conn->query( "SELECT EXISTS(SELECT 1 FROM {$table} WHERE block_id = {$value}) AS exist" ))) {
				$this->error_and_rollback(503);
				return;
			}
			$result = $res->fetch_assoc();
			if($result['exist'] > 0) {
				$found[] = $value;
			};
		}
		$this->result[ $configs['expected'][0] ] = $found;
	}



	public function dbm_prepare_stmt()
	{
		// error 504
		## paramns must be by reference
		## otherwise bind will THROW ERROR
		## create statement data array
		## with reference values
		$configs 	= $this->configs;
		$toBind 	= array();
		if(!($this->stmt = $this->conn->prepare($configs['query']))) {
			$this->error_and_rollback(504, "stmt incorrect");
			return;
		}
		## $params is String type
		//$params = $table['stmtParams'];
		//$data = $table['data'];
		foreach($configs["data"] as $index => $value)
		{
			$toBind[] = &$configs["data"][$index];
		}
		##Use Reflection class to cirumvent problem when directly using 
		##bind_param method
		$method = new ReflectionMethod('mysqli_stmt', 'bind_param');
		$method->invokeArgs(
			$this->stmt, 
			array_merge( array($configs['params']), $toBind)
		);
	}



	public function dbm_exec_select_stmt()
	{
		// error 505
		$binders = array();
		// create a reference array
		// for call_user_func_array
		foreach($this->result as $key => $value) {
			$binders[] = &$this->result[$key];
		}
		// bind results variables
		call_user_func_array(array($this->stmt, 'bind_result'), $binders);
		// execute stmt
		if(!$this->stmt->execute()) {
			$this->error_and_rollback(505);
			return;			
		}
		$this->stmt->store_result();
		$this->stmt->fetch();
		// free results
		$this->stmt->free_result();
		// close connection
		$this->stmt->close();
	}



	public function dbm_exec_insert_stmt()
	{
		// error 506
		// execute stmt
		if(!$this->stmt->execute()) {
			$this->error_and_rollback(506, "stmt exec failed");
			return;			
		}
		$this->stmt->store_result();

		if($this->stmt->affected_rows > 0) {
			// assign requested result to results
			$this->result = array(
				"insert_id" => $this->stmt->insert_id,
				"affected_rows" => $this->stmt->affected_rows);

		} else {
			$this->result = array(
				"insert_id" => 0,
				"affected_rows" => 0);
		}
		// free results
		$this->stmt->free_result();
		// close connection
		$this->stmt->close();
	}



	public function dbm_exec_insert_query()
	{
		// error 507
		$configs = $this->configs;
		if( !($res = $this->conn->query($configs["query"]))) {
			$this->error_and_rollback(503);
			return;
		}

		if($this->conn->affected_rows > 0) {
			// assign requested result to results
			$this->result = array(
				"insert_id" => $this->conn->insert_id,
				"affected_rows" => $this->conn->affected_rows);

		} else {
			$this->result = array(
				"insert_id" => 0,
				"affected_rows" => 0);
		}
	}



	public function dbm_exec_select_query($remove_null, $convert_to_int)
	{
		// error 508
		$configs 	= $this->configs;
		$position 	= $configs['expected'][0];
		
		$temp_results = array();
		if( !($res = $this->conn->query($this->configs["query"]))) {
			$this->error_and_rollback(503);
			return;
		}

		if($this->conn->affected_rows > 0) {
			while( $row = $res->fetch_assoc() )
			{
				$val = $row[ $position ];
				if($remove_null && is_null($val) ) {
					continue;

				} elseif ($convert_to_int && is_numeric($val)) {
					$temp_results[ $position ][] = intval($val);
	
				} else {
					$temp_results[ $position ][] = $val;
	
				}
			}
			$this->result[ $position ] = $temp_results[$position];	

		} else {
			$this->result[ $position ] = array();
		}
	}

	public function dbm_exec_select_query_multi($remove_null, $convert_to_int)
	{
		// error 509
		$configs 	= $this->configs;
		//$position 	= $configs['expected'][0];
		$positions 	= $configs['expected'];
		$temp_results = array();
		if( !($res = $this->conn->query($this->configs["query"]))) {
			$this->error_and_rollback(503);
			return;
		}

		if($this->conn->affected_rows > 0) {

			while( $row = $res->fetch_assoc() )
			{
				$temp_arr = array();
				// collects results from one row
				foreach($positions as $index => $position)
				{
					$val = $row[ $position ];
					if($remove_null && is_null($val) ) {
						continue;

					} elseif ($convert_to_int && is_numeric($val)) {
						$temp_arr[ $position ] = intval($val);
		
					} else {
						$temp_arr[ $position ] = $val;
		
					}
				}
				$temp_results[] = $temp_arr;
					
			}
			$this->result = $temp_results;	


		} else {
			$this->result = array();
		}
	}	



	// performs a looping query with subquery
	public function dbm_exec_select_query_multi_subquery($remove_null, $convert_to_int) {
		// error 510
		$configs 	= $this->configs;
		$positions 	= $configs['expected'];
		$subquery_res = array();
		$query_res 	  = array();

		// subquery fetch
		if( !($res = $this->conn->query($this->configs["subquery"]))) {
			$this->error_and_rollback(503);
			return;
		}
		// loop subquery results
		if($this->conn->affected_rows > 0)
		{
			while( $row = $res->fetch_assoc() )
			{
				$subquery_res[] = $row[ $this->configs["subquery_expected"] ];
			}

		} else {
			return array();
		}

		// fetch all query results by looping subquery results
		foreach($subquery_res as $index => $result)
		{
			if( !($res = $this->conn->query($this->configs["query"] . $result))) {
				$this->error_and_rollback(503);
				return;
			}

			if($this->conn->affected_rows > 0) {
				while( $row = $res->fetch_assoc() )
				{
					// loop each expected position in expected configs
					foreach ($positions as $key => $position) {
						$query_res[ $position ][] = $row[ $position ];
					}
				}	

			} else {
				$this->result = array();
			}
		}	
		$this->result = $query_res;

	}



	public function dbm_exec_update_query()
	{
		// error 510
		if( !($this->conn->query($this->configs["query"]))) {
			print_r($this->conn);
			$this->error_and_rollback(503);
			return;
		}
		// if error
		$this->result = array("affected_rows" => $this->conn->affected_rows);
	} 



	public function dbm_exec_update_stmt()
	{
		// error 511
		// execute stmt
		if(!$this->stmt->execute()) {
			$this->error_and_rollback(511, "stmt exec failed");
			return;			
		}
		$this->stmt->store_result();
		// if error
		if($this->conn->affected_rows > 0) {
			// assign requested result to results
			$this->result = array(
				"affected_rows" => $this->conn->affected_rows);

		} else {
			$this->result = array(
				"affected_rows" => 0);
		}
		// free results
		$this->stmt->free_result();
		// close connection
		$this->stmt->close();
	}



	public function dbm_exec_delete_query()
	{
		// error 512
		if( !($res = $this->conn->query($this->configs["query"]))) {
			$this->error_and_rollback(503);
			return;
		}
		// if error
		if($this->conn->affected_rows > 0) {
			// assign requested result to results
			$this->result = array(
				"affected_rows" => $this->conn->affected_rows);

		} else {
			$this->result = array(
				"affected_rows" => 0);
		}
	}



	public function dbm_get_result()
	{
		// error 513
		// return result
		return $this->result;
	}
}	 
