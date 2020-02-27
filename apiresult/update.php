<?php

// Another database connection start 
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "testapi";
$conn = mysqli_connect($servername, $username, $password, $dbname) or die("Connection failed: " . mysqli_connect_error());
if (mysqli_connect_errno()) {
    printf("Connect failed: %s\n", mysqli_connect_error());
    exit();
}

// Connection end

$name = "Rasel karim";
$age = "12";
$skills = "css";
$address = "Dhaka";
$designation = "web";

$url = "http://localhost/testapi/emp/update.php";

// One way data send by post
/* $post_data = "&empName=" . $name . "&empAge=" . $age . "&empSkills=" . $skills. "&empAddress=" . $address. "&empDesignation=" . $designation;  */

 // Another way data send by post
$post_data = [
				'id'=>51,
				'empName'=>$name,
				'empAge'=>$age,
				'empSkills'=>$skills,
				'empAddress'=>$address,
				'empDesignation'=>$designation,
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

// Another database another table data Update
/*
 if($result == 1){
      $sql = "UPDATE emp SET name='karim', age='12', skills='css', address='Dhaka', designation='house wife' WHERE id = 3";    
         mysqli_query($conn,$sql);
     }
*/
print_r($result);
