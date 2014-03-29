<?php
session_start();
// config file
require_once "includes/config.inc.php";
// get requests
require_once "includes/class_db_search.inc.php";
// put and delete requests
require_once "includes/class_db_entry.inc.php";


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
	$search->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );
	// route
	$search->route_request();
}

elseif ($request_method === "PUT" || $request_method === "PATCH")
{
	$entry = new Entry();
	// set user
	$entry->set_user($user);
	// sets GET, POST, UPDATE or DELETE
	$entry->set_request($request, $server, $data);
	// connect to database
	$entry->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );
	// route
	$entry->route_request();
}

elseif ($request_method === "DELETE")
{
	$entry = new Entry();
	// set user
	$entry->set_user($user);
	// sets GET, POST, UPDATE or DELETE
	$entry->set_request($request, $server, $data);
	// connect to database
	$entry->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );
	// route
	$entry->route_request();
}





