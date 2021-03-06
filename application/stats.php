<?php
session_start();
// config file
require_once "includes/config.inc.php";
// get requests
require_once "includes/class_db_stats.inc.php";


## configs
$server			= 	$_SERVER;
$request  		=	$_REQUEST;
$request_method =   $server['REQUEST_METHOD'];
$data 			= 	file_get_contents('php://input');

if($request_method !== "GET") {
	throw new Exception("Wrong request type", 1);
	exit();
}
	
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
