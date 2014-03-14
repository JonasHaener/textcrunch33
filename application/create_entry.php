<?php
session_start();
// create a new entry
require_once "includes/class_db_entry.inc.php";
require_once "includes/config.inc.php";
require_once "includes/config_user.inc.php";

## configs
$server		= 	$_SERVER;
$request  	=	$_REQUEST;
$data 		= 	file_get_contents('php://input');

## make project calls
$entry = new Entry();
// set user
$entry->set_user($user);
// sets GET, POST, UPDATE or DELETE
$entry->set_request($request, $server, $data);
// connect to database
$conn_err = $entry->connect_db($config_host, $config_db_user, $config_db_pwd, $config_database );

if(!$conn_err) {
	// route request to appropriate handler
	$entry->route_request();
	header('Content-type: application/json');
	if(!$entry->error) {
		http_response_code(200);		
		echo json_encode($entry->get_result(), true);
	
	} else {
		http_response_code(422);
		echo json_encode( array("error" => "error_create"), true);	
	}

} else {
	header('Content-type: application/json');
	http_response_code(422);
	echo json_encode( array("error" => "error_connection"), true);	
}

