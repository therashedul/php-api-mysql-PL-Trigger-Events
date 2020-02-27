<?php
include('config/db.php');
include('inc/header.php');

$view = "call testapi.view_all_data()";
?>
<div class="container" style="margin-top:30px">
  <div class="row">    
    <div class="col-sm-12">
      <table class="table table-hover">
		  <thead>
		    <tr>
		      <th scope="col">#</th>
		      <th scope="col">Name</th>
		      <th scope="col">Skills</th>
		      <th scope="col">Designation</th>
		      <th scope="col">Address</th>
		      <th scope="col">Age</th>
		      <th scope="col">Action</th>
		    </tr>
		  </thead>
		  <tbody>
			<?php
			$result = mysqli_query($conn, $view);
			if (mysqli_num_rows($result) > 0) {
				  while($row = $result->fetch_assoc()) {
				  	?>
			    <tr>
					  <th scope="row"><?php echo $row['id'] ; ?></th>
					    <td><?= $row['name']; ?></td>
					    <td><?= $row['skills']; ?></td>
					    <td><?= $row['designation']; ?></td>
					    <td><?= $row['address']; ?></td>
					    <td><?= $row['age']; ?></td>
					  <td>
			      	<a href="api_edit.php?<?php echo "id=". $row['id']; ?>">Edit</a> / 
			      	<a href="api_delete.php?<?php echo "id=". $row['id']; ?>">Delete</a>
			      </td>
			    </tr>
             <?php
			    }
			}
			else {
			    echo "0 results";
			}
		   ?>  
		  </tbody>
		</table>
       </div>
    </div>
</div>
<?php include('inc/footer.php'); ?>