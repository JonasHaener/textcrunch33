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
$project->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );
// route request to appropriate handler
$project->route_request();
// write results
$project->get_result();