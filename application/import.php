<?php
//session_start();

// get requests
require_once "includes/class_db_stats.inc.php";
// config file
require_once "includes/config.inc.php";
require_once "includes/config_user.inc.php";


//http_response_code(200);
//echo "File received";

## configs
$server			= 	$_SERVER;
$request  		=	$_REQUEST;
$request_method =   $server['REQUEST_METHOD'];
$data 			= 	file_get_contents('php://input');


//var_dump($data);

if($request_method !== "POST") {
	throw new Exception("Wrong request type", 1);
	exit();
}

http_response_code(200);	

var_dump($_FILES["import"]["size"]);



/*	
## make project calls
$stats = new Stats();
// set user (config file)
$stats->set_user($user);
// sets GET, POST, UPDATE or DELETE
$stats->set_request($request, $server, $data);
// connect to database
$stats->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );
// route request to appropriate handler
$stats->route_request();
*/