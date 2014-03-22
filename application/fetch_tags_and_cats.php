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
	$tags->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );
	// get tags and categories
	$tags->fetch();
}