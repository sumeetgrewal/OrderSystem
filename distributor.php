<?php include 'header.php';
  
  $did = $_POST["did"];
  $rid = $_POST["rid"];
  $sid = $_POST["sid"];
  $status = $_POST["status"];
	if($did) { ?>
		<h1>Distributer #<?php echo $did ?></h1>
	  <?php // Create connection to Oracle
	  $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");

	  $query = 'select * from distributor where did='.$did.'';
	  $stid = oci_parse($conn, $query);
	  $r = oci_execute($stid);
	  
	  // Fetch each row in an associative array
	  print '<div class="table-responsive"><table class="table table-bordered"><thead><tr>
	    <th scople="col">DID</th>
	    <th scople="col">Name</th>
	    <th scople="col">Phone</th>
	    </tr></thead><tbody>';
	  while ($row = oci_fetch_array($stid, OCI_RETURN_NULLS+OCI_ASSOC)) {
	     print '<tr>';
	     foreach ($row as $item) {
	         print '<td>'.($item !== null ? htmlentities($item, ENT_QUOTES) : '&nbsp').'</td>';
	     }
	     print '</tr>';
	  }
	  print '</tbody></table></div>'; ?>
	  <hr>
		<form id="filter" method="post">
      <h5>Filter</h5>
      <div class="form-row">
        <div class="col"> 
          <input class="form-control" name="rid" type="text" placeholder="Restaurant Name" <?php echo(isset($_POST['rid']) ? 'value="'.$_POST['rid'].'"' : '') ?> ><br>
        </div>
        <div class="col">
          <input class="form-control" name="sid" type="text" placeholder="Supplier Name" <?php echo(isset($_POST['sid']) ? 'value="'.$_POST['sid'].'"' : '') ?> ><br>
        </div>
        <div class="col">
          <input class="form-control" name="status" type="text" placeholder="Status" <?php echo(isset($_POST['status']) ? 'value="'.$_POST['status'].'"' : '') ?> ><br>
        </div>
      </div>
      
      <h5>Join orders for distributer #<?php echo $did ?> with</h5>
      <div class="form-group"> 
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="joinRestaurant" value="join" <?php echo(isset($_POST['joinRestaurant'])?'checked="checked"':'') ?> >Restaurant
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="joinSupplier" value="join" <?php echo(isset($_POST['joinSupplier'])?'checked="checked"':'') ?> >Supplier
        </div>
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="joinWarehouse" value="join" <?php echo(isset($_POST['joinWarehouse'])?'checked="checked"':'') ?> >Warehouse
        </div>
      </div>
      
      <div class="form-group">
        <input type="hidden" name="did" value="<?php echo $did ?>" />
        <input class="btn btn-primary" type="submit" value="Filter and Join">
      </div>
    </form>
    <hr>
      
<!--
      <form id="join" method="post">
	      
	      <div class="form-group">
	        <input class="btn btn-primary" type="submit" value="Join">
	      </div>
      </form>
-->
	  
	  <h1>All Orders</h1>
	  
	  <?php 
	  
	  $joinRestaurant = $_POST['joinRestaurant'];
	  $joinSupplier = $_POST['joinSupplier'];
	  $joinWarehouse = $_POST['joinWarehouse'];
	  
	  $query2 = 'select o.oid, ';
	  if ($joinRestaurant == 'join') { $query2 .= 'r.name as restName, r.unitNo as restUnitNo, r.street as restStreet, r.city as restCity, r.province as restProvince, '; }
	  if ($joinSupplier == 'join') { $query2 .= 's.name as suppName, '; }
	  if ($joinWarehouse == 'join') { $query2 .= 'w.unitNo as warehouseUnitNo, w.street as warehouseStreet, w.city as warehouseCity, w.province as warehouseProvince, '; }
	  
	  $query2 .= 'o.status from orders o,';
	  if ($joinRestaurant == 'join') { $query2 .= ' restaurant r,'; }
	  if ($joinSupplier == 'join' && $joinWarehouse != 'join') { $query2 .= ' supplier s,'; }
	  if ($joinWarehouse == 'join') { $query2 .= ' supplier s, warehouse w,'; }
	  $query2 = substr($query2, 0, strlen($query2)-1);
	  
	  $query2 .= ' where o.did='.$did.' ';
	  if ($joinRestaurant == 'join') { $query2 .= 'AND o.rid=r.rid '; }
	  if ($joinSupplier == 'join' && $joinWarehouse != 'join') { $query2 .= 'AND o.sid=s.sid '; }
	  if ($joinWarehouse == 'join') { $query2 .= 'AND s.sid=w.sid AND o.sid=s.sid '; }
	  $query2 = substr($query2, 0, strlen($query2)-1);
		
		if ($rid) { $query2 = $query2 .' AND r.name= \''.$rid.'\''; }
	  if ($sid) { $query2 = $query2 .' AND s.name= \''.$sid.'\''; }
	  if ($status) { $query2 = $query2 .' AND o.status = \''.$status.'\''; }
	  $stid2 = oci_parse($conn, $query2);
	  $r2 = oci_execute($stid2);
	  
	  if ($r2) {
	  // Fetch each row in an associative array
	  print '<div id="distributorTable" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>';
		print '<th scople="col">OID</th>';
		if ($joinRestaurant == 'join') { print '<th scople="col">Restaurant Name</th><th scople="col">To: Unit No.</th><th scople="col">To: Street</th><th scople="col">To: City</th><th scople="col">To: Province</th>'; }
		if ($joinSupplier == 'join') { print '<th scople="col">Supplier Name</th>'; }
		if ($joinWarehouse == 'join') { print '<th scople="col">From: Unit No.</th><th scople="col">From: Street</th><th scople="col">From: City</th><th scople="col">From: Province</th>'; }
			print '<th scople="col">Status</th>';
	    print '</tr></thead><tbody>';
	    
	  $count = 0;
	  while ($row = oci_fetch_array($stid2, OCI_RETURN_NULLS+OCI_ASSOC)) {
	     print '<tr>';
	     foreach ($row as $item) {
	         print '<td>'.($item !== null ? htmlentities($item, ENT_QUOTES) : '&nbsp').'</td>';
	     }
	     print '</tr>';
	     $count++;
	  }
	  print '</tbody></table></div>';
	  if ($count == 0) { print '<p>No results found.</p>'; }
	  } else {
      $e = oci_error($stid2);  // For oci_execute errors pass the statement handle
      print htmlentities($e['message']);
      print "\n<pre>\n";
      print htmlentities($e['sqltext']);
      printf("\n%".($e['offset']+1)."s", "^");
      print  "\n</pre>\n";
    }
	  
	  oci_close($conn); ?>
	  
<?php } else { ?>
		<h1>Distributor</h1>
	  <?php // Create connection to Oracle
	  $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
	  
	  $query = 'select * from distributor';
	  $stid = oci_parse($conn, $query);
	  $r = oci_execute($stid);
	  
	  // Fetch each row in an associative array
	  print '<div id="distributorTable" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
	    <th scople="col">DID</th>
	    <th scople="col">Name</th>
	    <th scople="col">Phone</th>
	    </tr></thead><tbody>';
	  while ($row = oci_fetch_array($stid, OCI_RETURN_NULLS+OCI_ASSOC)) {
	     print '<tr>';
	     foreach ($row as $item) {
	         print '<td>'.($item !== null ? htmlentities($item, ENT_QUOTES) : '&nbsp').'</td>';
	     }
	     print '</tr>';
	  }
	  print '</tbody></table></div>';
	  
	  oci_close($conn); ?>
	  
	  <form id="next" method="post">
	    <div class="form-group">
	      <input class="btn btn-primary" id="submitButton" type="button" value="Next" onClick="submit_dist_form()" disabled="true">
	    </div>
	  </form>

<?php	}
include 'footer.php';?>
