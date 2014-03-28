<?php
//session_start();

// get requests
require_once "includes/class_db_upload.inc.php";
// config file
require_once "includes/config.inc.php";
require_once "includes/config_user.inc.php";


//http_response_code(200);
//echo "File received";

## configs
$server			= 	$_SERVER;
$request  		=	$_REQUEST;
$request_method =   $server['REQUEST_METHOD'];
//$data 			= 	file_get_contents('php://input');
$files 			= 	$_FILES;


//var_dump($data);

if($request_method !== "POST") {
	throw new Exception("Wrong request type", 1);
	exit();
}

## make project calls
$stats = new Upload();
// set user (config file)
$stats->set_user($user);
// sets GET, POST, UPDATE or DELETE
$stats->set_request($request, $server, $files);
// connect to database
$stats->connect_db( $config_host, $config_db_user, $config_db_pwd, $config_database );
// route request to appropriate handler
$stats->route_request();


//http_response_code(200);	

//var_dump($_FILES["import"]["size"]);


//var_dump($_FILES["import"]);
//var_dump($_FILES["import"]["error"]);


/*
if (($handle = fopen("{$_FILES['import']["name"]}", "r")) !== FALSE) {
    while (($data = fgetcsv($handle, 1000, ",")) !== FALSE) {
        $num = count($data);
        echo "<p> $num fields in line $row: <br /></p>\n";
        $row++;
        for ($c=0; $c < $num; $c++) {
            echo $data[$c] . "<br />\n";
        }
    }
    fclose($handle);
}
*/


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