<?php include 'header.php';?>

<?php
  
  $rid = $_POST["rid"];
  $oid = $_POST["oid"];
  $sid = $_POST["sid"];
  $did = $_POST["did"];
  
  if ($rid && $sid && $did) {
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
    $query = 'insert into orders values ((select max(oid) from orders)+1, 0, \'ordered\', sysdate, null, '.$rid.', '.$sid.', '.$did.')';
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);
    
    if (!$r) {
      $e = oci_error($stid);  // For oci_execute errors pass the statement handle
      print '<div class="alert alert-danger">';
      print htmlentities($e['message']);
      print "\n<pre>\n";
      print htmlentities($e['sqltext']);
      printf("\n%".($e['offset']+1)."s", "^");
      print  "\n</pre>\n";
      print '</div>';
    }
    oci_close($conn);
  }
  
  if ($rid) { ?>
    
    <h1>Restaurant #<?php echo $rid ?></h1>
    
    <?php 
	  $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
	        
    $query = 'select * from restaurant where rid='.$rid.'';
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);

    print '<div class="table-responsive"><table class="table table-bordered"><thead><tr>
	    <th scople="col">RID</th>
      <th scople="col">Name</th>
      <th scople="col">Phone</th>
      <th scople="col">Unit No.</th>
      <th scople="col">Street</th>
      <th scople="col">City</th>
      <th scople="col">Province</th>
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
    <h1>Orders For Restaurant #<?php echo $rid ?></h1>
		
		<form id="newOrder" method="post" action="place-new-order.php" class="mb-4">
      <div class="form-group">
	      <input type="hidden" name="rid" value="<?php echo $rid?>" />
        <input class="btn btn-success" id="newOrderButton" type="submit" value="Place New Order">
      </div>
    </form>
    
    <form id="filter" method="post">
      <h5>Search</h5>
      <div class="form-row">
        <div class="col"> 
          <input class="form-control" name="searchOid" type="text" placeholder="OID" <?php echo(isset($_POST['searchOid']) ? 'value="'.$_POST['searchOid'].'"' : '') ?> ><br>
          <input class="form-control" name="searchStatus" type="text" placeholder="Status" <?php echo(isset($_POST['searchStatus']) ? 'value="'.$_POST['searchStatus'].'"' : '') ?> ><br>
          <input class="form-control" name="searchShipDate" type="text" placeholder="Ship Date" <?php echo(isset($_POST['searchShipDate']) ? 'value="'.$_POST['searchShipDate'].'"' : '') ?> ><br>
          <input class="form-control" name="searchDid" type="text" placeholder="DID" <?php echo(isset($_POST['searchDid']) ? 'value="'.$_POST['searchDid'].'"' : '') ?> ><br>
        </div>
        <div class="col">
          <input class="form-control" name="searchCost" type="text" placeholder="Cost" <?php echo(isset($_POST['searchCost']) ? 'value="'.$_POST['searchCost'].'"' : '') ?> ><br>
          <input class="form-control" name="searchOrderDate" type="text" placeholder="Order Date" <?php echo(isset($_POST['searchOrderDate']) ? 'value="'.$_POST['searchOrderDate'].'"' : '') ?> ><br>  
          <input class="form-control" name="searchSid" type="text" placeholder="SID" <?php echo(isset($_POST['searchSid']) ? 'value="'.$_POST['searchSid'].'"' : '') ?> ><br>
        </div>
      </div>
        
      <h5>Hide Columns</h5>
      <div class="form-group"> 
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="showCost" value="show" <?php echo(isset($_POST['showCost'])?'checked="checked"':'') ?> >Cost
        </div>
        
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="showStatus" value="show" <?php echo(isset($_POST['showStatus'])?'checked="checked"':'') ?> >Status
        </div>
        
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="showOrderDate" value="show" <?php echo(isset($_POST['showOrderDate'])?'checked="checked"':'') ?> >Order Date
        </div>
        
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="showShipDate" value="show" <?php echo(isset($_POST['showShipDate'])?'checked="checked"':'') ?> >Ship Date
        </div>
        
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="showRID" value="show" <?php echo(isset($_POST['showRID'])?'checked="checked"':'') ?> >RID
        </div>
        
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="showSID" value="show" <?php echo(isset($_POST['showSID'])?'checked="checked"':'') ?> >SID
        </div>
        
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="showDID" value="show" <?php echo(isset($_POST['showDID'])?'checked="checked"':'') ?> >DID
        </div>
      </div>
        
      <div class="form-group">
        <input type="hidden" name="rid" value="<?php echo $rid ?>" />
        <input class="btn btn-primary" type="submit" value="Filter">
      </div>
      <hr>
    </form>
    
    <?php
    $query = 'SELECT oid,';
    
    $showCost = $_POST['showCost'];
    $showStatus = $_POST['showStatus'];
    $showOrderDate = $_POST['showOrderDate'];
    $showShipDate = $_POST['showShipDate'];
    $showRID = $_POST['showRID'];
    $showSID = $_POST['showSID'];
    $showDID = $_POST['showDID'];
    if ($showCost != 'show') { $query .= ' cost,'; }
    if ($showStatus != 'show') { $query .= ' status,'; }
    if ($showOrderDate != 'show') { $query .= ' orderDate,'; }
    if ($showShipDate != 'show') { $query .= ' shipDate,'; }
    if ($showRID != 'show') { $query .= ' rid,'; }
    if ($showSID != 'show') { $query .= ' sid,'; }
    if ($showDID != 'show') { $query .= ' did,'; }
    
    $query = substr($query, 0, strlen($query)-1);
    
    $query .= ' FROM orders o WHERE rid='.$rid.'';
    
    $searchOid = $_POST['searchOid'];
    $searchCost = $_POST['searchCost'];
    $searchStatus = $_POST['searchStatus'];
    $searchOrderDate = $_POST['searchOrderDate'];
    $searchShipDate = $_POST['searchShipDate'];
    $searchSid = $_POST['searchSid'];
    $searchDid = $_POST['searchDid'];
    if ($searchOid) { $query .= ' AND oid='.$searchOid.''; }
    if ($searchCost) { $query .= ' AND cost='.$searchCost.''; }
    if ($searchStatus) { $query .= ' AND status=\''.$searchStatus.'\''; }
    if ($searchOrderDate) { $query .= ' AND orderDate=\''.$searchOrderDate.'\''; }
    if ($searchShipDate) { $query .= ' AND shipDate=\''.$searchShipDate.'\''; }
    if ($searchSid) { $query .= ' AND sid='.$searchSid.''; }
    if ($searchDid) { $query .= ' AND did='.$searchDid.''; }
    
    $query .= ' order by o.oid';
    
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);
    
    if ($r) {
      // Fetch each row in an associative array
      print '<div id="orderTable" class="table-responsive"><table class="table table-bordered table-hover">
        <thead><tr>';
      if ($showOID != 'show') { print '<th scople="col">OID</th>'; }
      if ($showCost != 'show') { print '<th scople="col">Cost</th>'; }
      if ($showStatus != 'show') { print '<th scople="col">Status</th>'; }
      if ($showOrderDate != 'show') { print '<th scople="col">Order Date</th>'; }
      if ($showShipDate != 'show') { print '<th scople="col">Ship Date</th>'; }
      if ($showRID != 'show') { print '<th scople="col">RID</th>'; }
      if ($showSID != 'show') { print '<th scople="col">SID</th>'; }
      if ($showDID != 'show') { print '<th scople="col">DID</th>'; }
      print '</tr></thead><tbody>';
      $count = 0;
      while ($row = oci_fetch_array($stid, OCI_RETURN_NULLS+OCI_ASSOC)) {
        print '<tr>';
        foreach ($row as $item) {
          print '<td>'.($item !== null ? htmlentities($item, ENT_QUOTES) : '&nbsp').'</td>';
        }
        print '</tr>';
        $count++;
      }
      print '</tbody></table></div>';
      if ($count == 0) { print '<div class="alert alert-warning">No results found.</div>'; }
    } else {
      $e = oci_error($stid);  // For oci_execute errors pass the statement handle
      print '<div class="alert alert-danger">';
      print htmlentities($e['message']);
      print "\n<pre>\n";
      print htmlentities($e['sqltext']);
      printf("\n%".($e['offset']+1)."s", "^");
      print  "\n</pre>\n";
      print '</div>';
    }
    
    oci_close($conn); ?>
    
    <form id="next" method="post" action="order-details.php">
      <div class="form-group">
        <input class="btn btn-primary" id="submitButton" type="button" value="Next" onClick="submit_order_form()" disabled="true">
      </div>
    </form>
    
<?php } else { ?>
    
    <h1>Restaurant</h1>
    
    <?php
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
    
    $deleteRid = $_POST['delete_rid'];
    
    $delteQuery = 'delete from restaurant where rid='.$deleteRid.'';
    $delteStid = oci_parse($conn, $delteQuery);
    $delteR = oci_execute($delteStid);
    
    $query = 'select * from restaurant';
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);
    
    print '<div id="restaurantTable" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
      <th scople="col">RID</th>
      <th scople="col">Name</th>
      <th scople="col">Phone</th>
      <th scople="col">Unit No.</th>
      <th scople="col">Street</th>
      <th scople="col">City</th>
      <th scople="col">Province</th>
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
    
    <form id="deleteRestaurant" method="post">
	    <div class="form-group">
		    <input class="btn btn-danger" id="deleteButton" type="button" value="Delete" onClick="delete_restaurant()" disabled="true">
	    </div>
    </form>
    
    <form id="next" method="post">
      <div class="form-group">
        <input class="btn btn-primary" id="submitButton" type="button" value="Next" onClick="submit_rest_form()" disabled="true">
      </div>
    </form>

<?php } ?>

<?php include 'footer.php';?>
