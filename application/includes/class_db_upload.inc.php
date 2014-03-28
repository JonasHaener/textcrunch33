<?php
// error location 900
// base class Database
require_once "class_db_entry.inc.php";

// inherites Entry for file uploads
class Upload extends Entry {
	
	private $result = array();

	private $file; // temp file

	private $upload_directory = '../file_upload/';

	### constructor
	public function __construct() {
	}

	public function route_request() {
		// error 901
		// route request to appropriate handler
		switch( $this->requestType ) {
			case "POST":
				$files = $this->get_request_data();
				$this->handle_file($files);
			break;
			// if request type is not defined
			default:
				throw new Exception("Wrong request type", 1);
		}
	}

	public function get_result() 
	{
		// wrap into array if first position is not an array
		header('Content-type: application/json');
		http_response_code(200);
		echo json_encode($this->result, true);
	}

	private function handle_file($files) {
		
		// check file validity
		$this->check_file($files);
		
		// move file to uploaded directory
		//$this->move_file();

		// read csv file
		$this->csv_to_array();

	}

	private function check_file($files)
	{
		$file;

		// is the file available
		if(!$file = $files["import"]) {
			handle_error(0, "No such file");
			return;
		}

		// upload error check
		if(!$file["error"] === 0) {
			handle_error(0, "File upload failed");
			return;
		}

		// check size
		if($file["size"] > (1024000)) {
			handle_error(0, "File size to large");
			return;	
		}

		/*
		// check MIME type
	 	$finfo = new finfo(FILEINFO_MIME_TYPE);
	    if (false === array_search(
	        $finfo->file($file["tmp_name"]),
		        array(
		            'jpg' => 'image/jpeg'
		        ), 
	        true
	    
	    )) {
	    	handle_error(0, "Wrong MIME type");
			return;	
	    }
		*/

		// assign file to class now
		$this->file = $file;


	}
	// move file
	

	private function move_file()
	{
		$file_name = $this->file["name"];
		// if error during moving
		if(!move_uploaded_file ($this->file["tmp_name"], $this->upload_directory.$file_name)) {
			handle_error(0, "Could not move file");
		}

	}

	private function is_csv_file($file_name)
	{
		$str = explode(".", $file_name);
		$ext = strtolower(end($str));

		return ( $ext === "csv") ? true : false;
	}

	private function csv_to_array()
	{
		
		$csv_content = array();

		if(!$this->is_csv_file($this->file["name"])) {
			handle_error(0, "Not a CSV file");
			return;
		}

		if (($handle = fopen($this->file["tmp_name"], "r")) !== false) {
		    
		    while (($row = fgetcsv($handle, 1000, ",")) !== false) {
				
				foreach($row as $i => $val) {
					// look for #tag separators
					// split into array
					if(stripos($val, ";")) {
						$row[$i] = explode(";", $val);
					}
				}

		     	$csv_content[] = $row;
		    }
		    
		    fclose($handle);
		
		} else {
			handle_error(0, "Read error on CSV file");
		}

		var_dump($csv_content);


	}

	private function create_entry()
	{
	

	}
}
