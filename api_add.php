<?php
include('config/db.php');


//Data insert API
$url = "http://localhost/testapi/emp/create.php";
// Escape user inputs for security

$name = mysqli_real_escape_string($conn, $_REQUEST['name']);
$skills = mysqli_real_escape_string($conn, $_REQUEST['skills']);
$designation = mysqli_real_escape_string($conn, $_REQUEST['designation']);
$address = mysqli_real_escape_string($conn, $_REQUEST['address']);
$age = mysqli_real_escape_string($conn, $_REQUEST['age']);

 // print_r($skills);
 // exit;
//stored procedure insert query execution
// $sql = "call testapi.create_data('$name', '$skills', '$address', '$designation','$age')";

// One way data send by post
/* $post_data = "&empName=" . $name . "&empAge=" . $age . "&empSkills=" . $skills. "&empAddress=" . $address. "&empDesignation=" . $designation;  */

 // Another way data send by post
$post_data = [
		'empName'=>$name,
		'empSkills'=>$skills,
		'empDesignation'=>$designation,
		'empAddress'=>$address,
		'empAge'=>$age,
	]; 

// Initiate curl
$ch = curl_init();
// Set the url
curl_setopt($ch, CURLOPT_URL, $url);

// If value 1 give me header information
curl_setopt($ch,CURLOPT_HEADER, 0);

curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

// Html data send post requst 1
curl_setopt($ch, CURLOPT_POST, 1);

// Post data insert use api
curl_setopt($ch,CURLOPT_POSTFIELDS,$post_data); 

// Each data transform connection rebuild don`t get data in cach
 curl_setopt($ch,CURLOPT_FRESH_CONNECT, 1);

// Execute
 $result = curl_exec($ch);

// Error check
if($result === false){
		echo 'Curl error: ' .curl_errno($ch) .'>>'.curl_error($ch);
	}

// Closing
curl_close($ch);
?>
<script>
	setTimeout( function(){
		window.location.href="api_index.php"
	}, 1000);
</script>