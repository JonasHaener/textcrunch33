<?php
// 300 class_db.inc.php
// 400 class_db_cats_tags.inc.php
// 500 class_db_dbm.inc.php
// 600 class_db_entry.inc.php
// 700 class_db_projects.inc.php
// 800 class_db_search.inc.php
// 900 class_db_stats.inc.php
// 1000 class_db_user.inc.php
// 2000


function handle_error($error_code, $message = "") {
	http_response_code(422);
	echo json_encode(array("Error_code: " => $error_code, "Error_message: " => $message));
	exit();
}