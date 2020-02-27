<?php
include('config/db.php');

// Escape user inputs for security

// $id=$_REQUEST['id'];
$id = mysqli_real_escape_string($conn, $_REQUEST['id']);
$name = mysqli_real_escape_string($conn, $_REQUEST['name']);
$skills = mysqli_real_escape_string($conn, $_REQUEST['skills']);
$address = mysqli_real_escape_string($conn, $_REQUEST['address']);
$designation = mysqli_real_escape_string($conn, $_REQUEST['designation']);
$age = mysqli_real_escape_string($conn, $_REQUEST['age']); 
//stored procedure insert query execution
$sql = "call testapi.update_emp('$id','$name', '$skills', '$address', '$designation','$age')";

if(mysqli_query($conn, $sql)){
    echo "Records Update successfully.";
} else{
    echo "ERROR: Could not able to execute $sql. " . mysqli_error($conn);
}
// header('location:index+.php');
?>
<script>
	setTimeout( function(){
		window.location.href="view.php"
	}, 1000);
</script>


