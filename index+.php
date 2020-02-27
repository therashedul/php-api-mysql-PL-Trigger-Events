<?php
include('config/db.php');
include('inc/header.php');
// $sql = "call testapi.view_all_data()";
$view = "call testapi.view_all_data()";
// $sql = 'select * from emp';
?>
<div class="container" style="margin-top:30px">
  <div class="row">    
    <div class="col-sm-12">
    	<form method="post" action="create.php">
		  <div class="form-group">
		    <label for="exampleFormControlInput1">Name</label>
		    <input type="text" class="form-control" name="name" id="exampleFormControlInput1" >
		  </div> 		   
		  <div class="form-group">
		    <label for="exampleFormControlInput1">Skills</label>
		    <input type="text" class="form-control" name="skills" id="exampleFormControlInput1" >
		  </div>  
		  <div class="form-group">
		    <label for="exampleFormControlInput1">Designation</label>
		    <input type="text" class="form-control" name="designation" id="exampleFormControlInput1" p>
		  </div>
		  <div class="form-group">
		    <label for="exampleFormControlTextarea1">Address</label>
		    <textarea class="form-control" id="exampleFormControlTextarea1" name="address" rows="3"></textarea>
		  </div>
		  <div class="form-group">
		    <label for="exampleFormControlInput1">Age</label>
		    <input type="text" class="form-control" name="age" id="exampleFormControlInput1" >
		  </div>  
		  <div class="form-group">
		  	<input type="submit" value="submit" class="btn btn-success float-right" style="margin-bottom: 50px;">
		  </div>
		</form>
    </div> 
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
			      	<a href="view.php">View All </a> / 
			      	<a href="edit.php?<?php echo "id=". $row['id']; ?>">Edit</a> / 
			      	<a href="delete.php?<?php echo "id=". $row['id']; ?>">Delete</a>
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