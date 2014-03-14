<?php
## Database management class
class Database_manager {
	
	private $queryConfigs = array();
	private $queryTmpl = array();
	private $result = array();
	private $stmtData = array(); ## assigned by $this->prepQuery()
	private $err = false;
	public 	$stmt;
	private $conn;
	private $configs;



	public function __construct($configs, $conn) {
		$this->conn = $conn;
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
	public function id_exists()
	{
		$configs = $this->configs;
		$table = $configs['table'][0];
		$ids = $configs['data'];
		$found = array();

		foreach($ids as $key => $value) {
			$res = $this->conn->query( "SELECT EXISTS(SELECT 1 FROM {$table} WHERE block_id = {$value}) AS exist" );
			$result = $res->fetch_assoc();
			if($result['exist'] > 0) {
				$found[] = $value;
			};
		}
		$this->result[ $configs['expected'][0] ] = $found;
	}



	public function prepare_stmt()
	{
		## paramns must be by reference
		## otherwise bind will THROW ERROR
		## create statement data array
		## with reference values
		$configs 	= $this->configs;
		$toBind 	= array();
		$this->stmt = $this->conn->prepare($configs['query']);
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



	public function exec_select_stmt()
	{
		$binders = array();
		// create a reference array
		// for call_user_func_array
		foreach($this->result as $key => $value) {
			$binders[] = &$this->result[$key];
		}
		// bind results variables
		call_user_func_array(array($this->stmt, 'bind_result'), $binders);
		// execute stmt
		$this->stmt->execute();
		$this->stmt->store_result();
		$this->stmt -> fetch();
		// free results
		$this->stmt->free_result();
		// close connection
		$this->stmt->close();
	}



	public function exec_insert_stmt()
	{
		// execute stmt
		$this->stmt->execute();
		$this->stmt->store_result();
		if($this->stmt->affected_rows > 0) {
			// assign requested result to results
			$this->result[ $this->configs['expected'][0] ] = $this->conn->insert_id;
		} else {
			$this->result[ $this->configs['expected'][0] ] = NULL;
		}
		
		// free results
		$this->stmt->free_result();
		// close connection
		$this->stmt->close();
	}



	public function exec_insert_query()
	{
		$res = $this->conn->query($this->configs["query"]);
		if($this->conn->insert_id > 0) {
			// assign requested result to results
			// array
			$this->result[ $this->configs['expected'][0] ] = $this->conn->insert_id;
		
		} else {
			$this->result[ $this->configs['expected'][0] ] = null;
		}
	}



	public function exec_select_query($remove_null, $convert_to_int)
	{
		$configs 	= $this->configs;
		$position 	= $configs['expected'][0];
		
		$temp_results = array();
		$res = $this->conn->query($this->configs["query"]);

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



	public function exec_select_query_multi($remove_null, $convert_to_int)
	{
		$configs 	= $this->configs;
		//$position 	= $configs['expected'][0];
		$positions 	= $configs['expected'];
		$temp_results = array();
		$res = $this->conn->query($this->configs["query"]);

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
	public function exec_select_query_multi_subquery($remove_null, $convert_to_int) {
		$configs 	= $this->configs;
		$positions 	= $configs['expected'];
		$subquery_res = array();
		$query_res 	  = array();


		// subquery fetch
		$res = $this->conn->query($this->configs["subquery"]);
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
			$res = $this->conn->query($this->configs["query"] . $result);
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



	public function exec_update_query()
	{
		$res = $this->conn->query($this->configs["query"]);
		// if error
		if($this->conn->errno > 0) {
			$this->result[] = 0;
		// if no error
		} else {
			$this->result[] = 1;
		}

	} 



	public function exec_update_stmt()
	{
		// execute stmt
		$this->stmt->execute();
		$this->stmt->store_result();
		// if error
		if($this->conn->errno > 0) {
			$this->result[] = 0;
		// if no error
		} else {
			$this->result[] = 1;
		}
		// free results
		$this->stmt->free_result();
		// close connection
		$this->stmt->close();
	}



	public function exec_delete_query()
	{
		$res = $this->conn->query($this->configs["query"]);
		// if error
		if($this->conn->errno > 0) {
			$this->result[] = 0;
		// if no error
		} else {
			$this->result[] = 1;
		}
	}



	public function get_result()
	{
		// return result
		return $this->result;
	}
}	 
