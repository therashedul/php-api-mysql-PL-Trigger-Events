<?php
include('config/db.php');

// Escape user inputs for security

$name = mysqli_real_escape_string($conn, $_REQUEST['name']);
$skills = mysqli_real_escape_string($conn, $_REQUEST['skills']);
$address = mysqli_real_escape_string($conn, $_REQUEST['address']);
$designation = mysqli_real_escape_string($conn, $_REQUEST['designation']);
$age = mysqli_real_escape_string($conn, $_REQUEST['age']);

 // print_r($skills);
 // exit;
//stored procedure insert query execution
$sql = "call testapi.create_data('$name', '$skills', '$address', '$designation','$age')";


 // insert into emp (name, skills, address, designation,age) values (p_name,p_skills,p_address, p_designation,p_age);   // stored procedure 

// $sql = "INSERT INTO emp (name, skills, address, designation, age) VALUES ('$name', '$skills', '$address', '$designation','$age')";


if(mysqli_query($conn, $sql)){
    echo "Records added successfully.";
} else{
    echo "ERROR: Could not able to execute $sql. " . mysqli_error($conn);
}
?>
<script>
	setTimeout( function(){
		window.location.href="index+.php"
	}, 1000);
</script>

