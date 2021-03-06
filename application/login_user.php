<?php
session_start();
// config file
require_once "includes/config.inc.php";
require_once "includes/messages_error.inc.php";
require_once "includes/class_db_user.inc.php";

## configs
$server			= 	$_SERVER;
$request  		=	$_REQUEST;
$request_method =   $server['REQUEST_METHOD'];
$data 			= 	file_get_contents('php://input');
$error 			= 	array();

if($request_method === "POST") {
## make project calls
	$user = new User();
	// sets POST
	$user->set_request($request, $server, $data);
	// connect to database
	$user->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );
	$user->route_request();
	$user->login();

		// if login ok
	if($user->get_login() === true) {
		$res = $user->get_result();
		$_SESSION['user_id'] 	  = $res["user_id"];
		$_SESSION['user_rights']  = $res["user_rights"];
		$_SESSION['user_name']    = $res["user_name"];
		//header("Location: ../public/index.php");
		header("Location: ".get_full_path()."index.php");

	// if login not ok
	} else {
		$errors = $user->get_errors();

		if($errors["login"] === true) {
			$error["login"] = $ERROR_LOGIN;
		}
		
		if($errors["system"] === true) {
		 	$error["login"] = $ERROR_LOGIN;
		}

		// invalidate session name 
		if( isset($_COOKIE[session_name()]) ) {
			setcookie(session_name(), "", time()-86400, "/");
		} 
		// destroy session
		session_destroy();
	}
}