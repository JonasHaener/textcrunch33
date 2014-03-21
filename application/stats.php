<?php
//session_start();

// get requests
require_once "includes/class_db_stats.inc.php";
// config file
require_once "includes/config.inc.php";
require_once "includes/config_user.inc.php";

## configs
$server			= 	$_SERVER;
$request  		=	$_REQUEST;
$request_method =   $server['REQUEST_METHOD'];
$data 			= 	file_get_contents('php://input');

if($request_method === "GET")
{
	
	## make project calls
	$stats = new Stats();
	// set user (config file)
	$stats->set_user($user);
	// sets GET, POST, UPDATE or DELETE
	$stats->set_request($request, $server, $data);
	// connect to database
	$conn_err = $stats->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );
	
	if($conn_err) {
		http_response_code(422);
		echo json_encode( array("error" => "error_connection"), true);
	
	} elseif (!$conn_err) {
		// route request to appropriate handler
		$stats->route_request();
		print("exit called");
		header('Content-type: application/json');
		
		// if search error
		if($stats->search_error() === true)
		{
			http_response_code(422);
			echo json_encode( array("error" => "error_read"), true);
		
		// result available
		} elseif ( !empty($stats->get_result()) ) {
			// result size
			http_response_code(200);
			echo json_encode(array($stats->get_result()), true);
			//echo json_encode(array(array("user_id" => 1)), true);
		
		// if no result
		} else {
			// return [] if no match is found
			http_response_code(200);
			echo json_encode( array() , true);
		}	
	}
}

elseif ($request_method === "POST")
{

}

elseif ($request_method === "PUT" || $request_method === "PATCH")
{
	
}

elseif ($request_method === "DELETE")
{
	
}





