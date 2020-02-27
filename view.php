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
			      	<a href="edit.php?<?php echo "id=". $row['id']; ?>">Edit</a> / 
			      	<a href="delete.php?<?php echo "id=". $row['id']; ?>">Delete</a>
			      </td>
			    </tr>
             <?php
			    }
			}
			else {   echo "0 results";	}
		   ?>  
		  </tbody>
		</table>
       </div>
    </div>
</div>
<?php include('inc/footer.php'); ?>

---------------------------- update Okay ----------------------------------------------
BEGIN
 UPDATE  achive_blogs SET 
    ucategory_id = new.acategory_id, 
    ublog_title = new.ablog_title,
    ushort_description = new.ashort_description,
    ulong_description = new.along_description,      
    utag = new.atag,
    ublog_image = new.ablog_image,
    ustatus = new.astatus
    WHERE ublog_id = new.id;
END
--------------------------Insert OKay-------------------------------

INSERT into achive_blogs (ucategory_id, ublog_title, ushort_description, ulong_description, utag, ublog_image, ustatus, ublog_id) VALUES(new.acategory_id, new.ablog_title, new.ashort_description, new.along_description, new.atag, new.ablog_image, new.astatus, new.id)

--------------------------------- Okay update------------------------------------------------------
BEGIN
   IF (select count(*) from achive_blogs WHERE add_id = new.id)=1
     THEN
        UPDATE  achive_blogs SET 
            ucategory_id = new.acategory_id, 
            ublog_title = new.ablog_title,
            ushort_description = new.ashort_description,
            ulong_description = new.along_description,      
            utag = new.atag,
            ublog_image = new.ablog_image,
            ustatus = new.astatus,
            ublog_id = new.ablog_id
            WHERE add_id = new.id;
        ELSE
            INSERT into achive_blogs (ucategory_id, ublog_title, ushort_description, ulong_description, utag, ublog_image, ustatus, ublog_id, add_id) VALUES(new.acategory_id, new.ablog_title, new.ashort_description, new.along_description, new.atag, new.ablog_image, new.astatus, new.ablog_id, new.id);
   END IF;
END

