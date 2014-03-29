<?php
// error location 900
// base class Database
require_once "class_db_entry.inc.php";

// inherites Entry for file uploads
class Upload extends Entry {
	
	private $file; // temp file

	private $upload_directory = '../file_upload/';

	private $result = 0;

	### constructor
	public function __construct() {
	}

	public function route_request() {
		// error 901
		// route request to appropriate handler
		switch( $this->requestType ) {
			case "POST":
				$files = $this->get_request_data();
				$this->upload_csv_file($files);
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
		echo json_encode(array("created" => $this->result), true);
	}

	private function upload_csv_file($files) {
		
		// check file validity
		// assign file to class now
		$file = $this->file = $this->validate_csv_file($files);

		// read csv file
		$this->create_entries();

		// move file to uploaded directory
		if(!move_uploaded_file ($file["tmp_name"], $this->upload_directory.$file["name"])) {
			handle_error(0, "Could not move file");
		}

	}

	private function validate_csv_file($files)
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
		if($file["size"] > (2048000)) {
			handle_error(0, "File size too large");
			return;
		}

		return $file;
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




	}
	// move file
	
	private function is_csv_file($file_name)
	{
		$str = explode(".", $file_name);
		$ext = strtolower(end($str));

		return ( $ext === "csv") ? true : false;
	}

	private function csv_to_array($file)
	{
		
		$csv_content = array();

		if(!$this->is_csv_file($file["name"])) {
			handle_error(0, "Not a CSV file");
			return;
		}

		//read file
		if (($handle = fopen($file["tmp_name"], "r")) !== false) {
		    
		    while (($row = fgetcsv($handle, 1000, ",")) !== false) {
		     	$csv_content[] = $row;
		    }
		    
		    fclose($handle);
		
		} else {
			handle_error(0, "Read error on CSV file");
		}

		return $csv_content;


	}

	private function create_entries()
	{
		// read csv file
		$upload_data = $this->csv_to_array($this->file);
		// will hold data for upload
		$blocks = array();

		/* data received:
			array(
				array(
					...
					...
				),
				array(
					...
					...
				)
			)
			// pos 0 category
			// pos 1 tags ";"
			// pos 2 german
			// pos 3 english
			// pos 4 french
			// pos 5 dutch
			// pos 6 italian
			// pos 7 polish
			// pos 8 japanese	
		*/
		
		// loop outer umbrella array
		foreach($upload_data as $index => $data) {

			// skip table headers
			if($index === 0) {
				continue;
			}

			// array must be length of 9
			if(count($data) !== 10) {
				// do not block further reading of data
				continue;
			}

			$blocks[] = array(
				"category" 	=> $data[0],
				"tags" 		=> explode(";", $data[1]),
				"german" 	=> $data[2],
				"english" 	=> $data[3],
				"french" 	=> $data[4],
				"dutch" 	=> $data[5],
				"italian" 	=> $data[6],
				"polish" 	=> $data[7],
				"spanish" 	=> $data[8],
				"japanese" 	=> $data[9]
			);

		}

		foreach($blocks as $key => $block) {
			$this->ent_reset_class();
			// assign values to Class Entry
			$this->insert_data = $block;
			
			## start transaction
	 		$this->start_transaction();
			
			## get the category_id;
			$this->get_cat_id();

			## insert block
			$this->insert_block();

			## get tag ids
			$this->get_tag_ids();

			## insert into tag switch
			$this->insert_tags_in_tag_switcher();

			## start transaction
	 		$this->commit_transaction();

	 		## update result
	 		$this->result += 1; 
		
		}

		// close connection
		$this->closeConnection();
		
		## return result to frontend
	 	$this->get_result();	

	}
}
