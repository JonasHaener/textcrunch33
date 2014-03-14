<?php
session_start();
require_once "includes/class_db_projects.inc.php";
require_once "includes/config.inc.php";
require_once "includes/config_user.inc.php";

## configs
$server			= 	$_SERVER;
$request  		=	$_REQUEST;
$data 			= 	file_get_contents('php://input');
$request_method =   $server['REQUEST_METHOD'];

## make project calls
$project = new Project();
// set user (config file)
$project->set_user($user);
// sets GET, POST, UPDATE or DELETE
$project->set_request($request, $server, $data);
// connect to database
$conn_err = $project->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );

if(!$conn_err) {
	// route request to appropriate handler
	$project->route_request();
	header('Content-type: application/json');
	
	if(!$project->err)
	{
		// GET request
		if($request_method === "GET") {
			http_response_code(200);
			echo json_encode($project->get_result(), true);

		// PUT or POST request	
		} elseif($request_method === "PUT" OR $request_method === "POST") {
			
			
			if($project->is_public()) {
				http_response_code(422);
				echo json_encode( array("error" => "error_public"), true);
			
			} else {
				http_response_code(200);
				echo json_encode($project->get_result(), true);
			}
			
		} elseif($request_method === "DELETE") {
			if($project->is_public()) {
				http_response_code(422);
				echo json_encode( array("error" => "error_public"), true);
			
			} else {
				http_response_code(204);
			}
		} 
	
	// if project error		
	} else {
		http_response_code(422);
		echo json_encode( array("error" => "error_create_update_delete"), true);
	}

} else {
	header('Content-type: application/json');
	http_response_code(422);
	echo json_encode( array("error" => "error_connection"), true);
}
