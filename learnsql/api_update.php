<?php
include('config/db.php');

// Escape user inputs for security
$url = "http://localhost/testapi/emp/update.php";

// $id=$_REQUEST['id'];
$id = mysqli_real_escape_string($conn, $_REQUEST['id']);
$name = mysqli_real_escape_string($conn, $_REQUEST['name']);
$skills = mysqli_real_escape_string($conn, $_REQUEST['skills']);
$address = mysqli_real_escape_string($conn, $_REQUEST['address']);
$designation = mysqli_real_escape_string($conn, $_REQUEST['designation']);
$age = mysqli_real_escape_string($conn, $_REQUEST['age']); 

// print_r($name);

// One way data send by post
/* $post_data = "&empName=" . $name . "&empAge=" . $age . "&empSkills=" . $skills. "&empAddress=" . $address. "&empDesignation=" . $designation;  */

 // Another way data send by post
$post_data = [
		'id'=>$id,
		'empName'=>$name,
		'empSkills'=>$skills,
		'empAddress'=>$address,
		'empDesignation'=>$designation,
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


