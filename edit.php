
<div class="container" style="margin-top:30px">
  <div class="row">    
    <div class="col-sm-12">
    	<form method="post" action="update.php">
		  <div class="form-group">
		    <label for="exampleFormControlInput1">Name</label>
		    <input type="hidden" class="form-control" name="id" value="<?= $row['id']; ?>" id="exampleFormControlInput1" >
		    <input type="text" class="form-control" name="name" value="<?= $row['name']; ?>" id="exampleFormControlInput1" >
		  </div> 		   
		  <div class="form-group">
		    <label for="exampleFormControlInput1">Skills</label>
		    <input type="text" class="form-control" name="skills" value="<?= $row['skills']; ?>" id="exampleFormControlInput1" >
		  </div>  
		  <div class="form-group">
		    <label for="exampleFormControlInput1">Designation</label>
		    <input type="text" class="form-control" name="designation" value="<?= $row['designation']; ?>" id="exampleFormControlInput1" p>
		  </div>
		  <div class="form-group">
		    <label for="exampleFormControlTextarea1">Address</label>
		    <textarea class="form-control" id="exampleFormControlTextarea1" name="address" value="<?= $row['address']; ?>"  rows="3"><?= $row['address']; ?></textarea>
		  </div>
		  <div class="form-group">
		    <label for="exampleFormControlInput1">Age</label>
		    <input type="text" class="form-control" name="age" value="<?= $row['age']; ?>" id="exampleFormControlInput1" >
		  </div>  
		  <div class="form-group">
		  	<input type="submit" value="Update" class="btn btn-success float-right" style="margin-bottom: 50px;">
		  </div>
		</form>
    </div> 
  </div>
</div>
