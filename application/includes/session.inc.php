<?php
session_start();
if( isset($_SESSION['user_rights']) ) {
    $user   = $_SESSION['user_name'];
    $domain = $_SESSION['user_rights']; // user right
    date_default_timezone_set('UTC');
    $year   = date("Y");

} else {
	// destroy session
	Header("Location: logout.php");
}  