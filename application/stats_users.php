<?php
session_start();
// get requests
require_once "includes/class_db_search.inc.php";
// put and delete requests
require_once "includes/class_db_entry.inc.php";
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
	$search = new Search();
	// set user (config file)
	$search->set_user($user);
	// sets GET, POST, UPDATE or DELETE
	$search->set_request($request, $server, $data);
	// connect to database
	$conn_err = $search->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );
	
	if($conn_err) {
		http_response_code(422);
		echo json_encode( array("error" => "error_connection"), true);
	
	} elseif (!$conn_err) {
		// route request to appropriate handler
		$search->route_request();
		header('Content-type: application/json');
		
		// if search error
		if($search->search_error() === true)
		{
			http_response_code(422);
			echo json_encode( array("error" => "error_read"), true);
		
		// result available
		} elseif ( !empty($search->get_result()) ) {
			// result size
			http_response_code(200);
			echo json_encode($search->get_result(), true);
		
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
	$entry = new Entry();
	// set user
	$entry->set_user($user);
	// sets GET, POST, UPDATE or DELETE
	$entry->set_request($request, $server, $data);
	// connect to database
	$conn_err = $entry->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );

	if($conn_err) {
		// 422 Unprocessable Entity
		http_response_code(422);
		echo json_encode( array("error" => "error_connection"), true);
	
	} elseif(!$conn_err) {
		// route request to appropriate handler
		$entry->route_request();

		header('Content-type: application/json');

		if(!$entry->error)
		{
			http_response_code(200);
			echo json_encode($entry->get_result(), true);
		
		} else {
			http_response_code(422);
			echo json_encode( array("error" => "error_update"), true);
		}
	}
}

elseif ($request_method === "DELETE")
{
	$entry = new Entry();
	// set user
	$entry->set_user($user);
	// sets GET, POST, UPDATE or DELETE
	$entry->set_request($request, $server, $data);
	// connect to database
	$conn_err = $entry->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );
	
	if(!$conn_err) {
		// route request to appropriate handler
		$entry->route_request();
		header('Content-type: application/json');
		if(!$entry->error)
		{
			http_response_code(200);
			echo json_encode(array(), true);
		
		} else {
			http_response_code(422);
			echo json_encode(array("error" => "error_delete"), true);
		}

	} else {
		// 422 Unprocessable response	
		header('Content-type: application/json');
		http_response_code(422);
		echo json_encode( array("error" => "error_connection"), true);
	}
}





