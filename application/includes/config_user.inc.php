<?php
$user = array(
	"user_id" 		=> isset($_SESSION["user_id"]) ?  $_SESSION["user_id"] : 0,
	"user_name" 	=> isset($_SESSION["user_name"]) ? $_SESSION["user_name"] : "",
	"user_rights" 	=> isset($_SESSION["user_rights"]) ? $_SESSION["user_rights"] : -1
);