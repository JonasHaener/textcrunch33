<?php
session_start();
require_once "includes/config.inc.php";
// create a new entry
require_once "includes/class_db_entry.inc.php";


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
// route request to appropriate handler
$entry->route_request();