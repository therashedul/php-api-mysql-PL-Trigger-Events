<?php
include('config/db.php');

// Escape user inputs for security

$id=$_REQUEST['id'];
// Connection end
$url = "http://localhost/testapi/emp/delete.php?id=$id";

// One way data send by post
/* $post_data = "&empName=" . $name . "&empAge=" . $age . "&empSkills=" . $skills. "&empAddress=" . $address. "&empDesignation=" . $designation;  */


// Initiate curl
$ch = curl_init();
// Set the url
curl_setopt($ch, CURLOPT_URL, $url);

// If value 1 give me header information
curl_setopt($ch,CURLOPT_HEADER, 0);

curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

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