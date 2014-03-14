<?php
session_start();
require_once "includes/class_db_cats_tags.inc.php";
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
	$tags = new Tags_and_cats();
	// set user
	// from config file
	$tags->set_user($user);
	// sets GET, POST, UPDATE or DELETE
	$tags->set_request($request, $server, $data);
	// connect to database
	$conn_err = $tags->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );
	
	if($conn_err) {
		http_response_code(422);
	
	} elseif (!$conn_err) {
		// route request to appropriate handler
		$tags->fetch();
		header('Content-type: application/json');
		if( !empty($tags->get_result()) ) {
			http_response_code(200);
			echo json_encode($tags->get_result(), true);
		
		} else {
			// error is returned when no match is found
			http_response_code(200);
			echo json_encode( array(), true);
		}	
	}
}