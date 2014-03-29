<?php
require "../application/includes/config_path.inc.php";
session_start();
// invalidate session name 
if( isset($_COOKIE[session_name()]) ) {
	setcookie(session_name(), "", time()-86400, "/");
} 
// destroy session
session_destroy();
header("Location: ".get_full_path()."login.php");
