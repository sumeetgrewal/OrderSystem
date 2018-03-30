<?php include 'header.php'; ?>

<?php  
  $pid = $_POST["pid"];
  $wid = $_POST["wid"];	
  $oid = $_POST["oid"];
  
  if ($oid) { ?>
	  
	  <h1>Supplier Products</h1>
	  
	  <?php 
		$conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
		  
	  $query2 = 'select p.pid, p.name, p.category, p.price from product p, orders o where o.sid=p.sid AND o.oid = '.$oid.'';
	  $stid2 = oci_parse($conn, $query2);
	  $r2 = oci_execute($stid2);
	  
	  print '<div id="productTable" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
	    <th scople="col">PID</th>
	    <th scople="col">Name</th>
	    <th scople="col">Category</th>
	    <th scople="col">Price</th>
	    </tr></thead><tbody>';
	  while ($row = oci_fetch_array($stid2, OCI_RETURN_NULLS+OCI_ASSOC)) {
	  	print '<tr>';
			foreach ($row as $item) {
				print '<td>'.($item !== null ? htmlentities($item, ENT_QUOTES) : '&nbsp').'</td>';
	  	}
			print '</tr>';
		}
		print '</tbody></table></div>';
	  	
	  oci_close($conn); 
	  ?>
	  
	  <form id="addProduct" method="post" action="order-details.php">
		    <div class="form-group">  
		      <div class="form-row">
	  	      <div class="col"> <input class="form-control" type="text" name="newPid" placeholder="PID"> </div>
	  	      <div class="col"> <input class="form-control" type="text" name="newQty" placeholder="QTY"> </div>
	  	    </div>
		    </div>
		    
		    <div class="form-group">
	  	    <input type="hidden" name="oid" value="<?php echo $oid ?>" />
		    <input class="btn btn-secondary" id="addProductButton" type="submit" value="Add Product">
	    </div>
	  </form>
	  
<?php	
		} else {

	  $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
	  
	  $query = 'select * from warehouse where wid='.$wid.'';
	  $stid = oci_parse($conn, $query);
	  $r = oci_execute($stid);
	  ?>
	  
	  <h1>Warehouse # <?php echo $wid ?></h1>
	  
	  <?php 
	  print '<div class="table-responsive"><table class="table table-bordered"><thead><tr>
	    <th scople="col">WID</th>
	    <th scople="col">Phone</th>
	    <th scople="col">unitNo</th>
	    <th scople="col">Street</th>
	    <th scople="col">city</th>
	    <th scople="col">Province</th>
	    <th scople="col">SID</th>
	    </tr></thead><tbody>';
	  while ($row = oci_fetch_array($stid, OCI_RETURN_NULLS+OCI_ASSOC)) {
	  	print '<tr>';
			foreach ($row as $item) {
	    	print '<td>'.($item !== null ? htmlentities($item, ENT_QUOTES) : '&nbsp').'</td>';
	  	}
			print '</tr>';
	  }
	  print '</tbody></table></div>';
	  ?>
	  
	  <h1>Supplier Products</h1>
	  
	  <?php 
	  $query2 = 'select p.pid, p.name, p.category, p.price from product p, warehouse w where w.sid=p.sid AND w.wid = '.$wid.'';
	  $stid2 = oci_parse($conn, $query2);
	  $r2 = oci_execute($stid2);
	  
	  print '<div id="productTable" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
	    <th scople="col">PID</th>
	    <th scople="col">Name</th>
	    <th scople="col">Category</th>
	    <th scople="col">Price</th>
	    </tr></thead><tbody>';
	  while ($row = oci_fetch_array($stid2, OCI_RETURN_NULLS+OCI_ASSOC)) {
	  	print '<tr>';
			foreach ($row as $item) {
				print '<td>'.($item !== null ? htmlentities($item, ENT_QUOTES) : '&nbsp').'</td>';
	  	}
			print '</tr>';
		}
		print '</tbody></table></div>';
	  	
	  oci_close($conn); 
	  ?>
	  
	  <form id="addProduct" method="post" action="warehouse-product.php">
		    <div class="form-group">  
		      <div class="form-row">
	  	      <div class="col"> <input class="form-control" type="text" name="newPid" placeholder="PID"> </div>
	  	      <div class="col"> <input class="form-control" type="text" name="newQty" placeholder="QTY"> </div>
	  	    </div>
		    </div>
		    
		    <div class="form-group">
	  	    <input type="hidden" name="wid" value="<?php echo $wid ?>" />
		    <input class="btn btn-secondary" id="addProductButton" type="submit" value="Add Product">
	    </div>
	  </form>
  
<?php 
	} 
?>
  
<?php include 'footer.php'; ?>
