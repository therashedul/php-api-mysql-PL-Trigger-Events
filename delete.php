<?php
include('config/db.php');

// Escape user inputs for security

$id=$_REQUEST['id'];

//stored procedure Delete query execution
$sql = "call testapi.delete_emp('$id');";

if(mysqli_query($conn, $sql)){
    echo "Records Delete successfully.";
} else{
    echo "ERROR: Could not able to execute $sql. " . mysqli_error($conn);
}
header('location:index+.php');
?>
<script>
	setTimeout( function(){
		window.location.href="view.php"
	}, 1000);
</script>