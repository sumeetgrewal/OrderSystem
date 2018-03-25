<?php include 'header.php';?>

<?php $_GET["rid"]; ?>

<?php
  
  $rid = $_GET["rid"];
  if ($rid) { ?>
    
    <h1>Orders For Restaurant #<?php echo $rid ?></h1>
    
    <?php // Create connection to Oracle
      $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug"); 
    ?>
    
    <form id="filter" method="post">
      <h5>Search</h5>
      <div class="form-row">
        <div class="col"> 
          <input class="form-control" name="oid" type="text" placeholder="OID" <?php echo(isset($_POST['oid']) ? 'value="'.$_POST['oid'].'"' : '') ?> ><br>
          <input class="form-control" name="status" type="text" placeholder="Status" <?php echo(isset($_POST['status']) ? 'value="'.$_POST['status'].'"' : '') ?> ><br>
          <input class="form-control" name="shipDate" type="text" placeholder="Ship Date" <?php echo(isset($_POST['shipDate']) ? 'value="'.$_POST['shipDate'].'"' : '') ?> ><br>
          <input class="form-control" name="did" type="text" placeholder="DID" <?php echo(isset($_POST['did']) ? 'value="'.$_POST['did'].'"' : '') ?> ><br>
        </div>
        <div class="col">
          <input class="form-control" name="cost" type="text" placeholder="Cost" <?php echo(isset($_POST['cost']) ? 'value="'.$_POST['cost'].'"' : '') ?> ><br>
          <input class="form-control" name="orderDate" type="text" placeholder="Order Date" <?php echo(isset($_POST['orderDate']) ? 'value="'.$_POST['orderDate'].'"' : '') ?> ><br>  
          <input class="form-control" name="sid" type="text" placeholder="SID" <?php echo(isset($_POST['sid']) ? 'value="'.$_POST['sid'].'"' : '') ?> ><br>
        </div>
      </div>
        
      <h5>Hide Columns</h5>
      <div class="form-group"> 
        <div class="form-check form-check-inline">
          <input class="form-check-input" type="checkbox" name="showOID" value="show" <?php echo(isset($_POST['showOID'])?'checked="checked"':'') ?> >OID
        </div>
        
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
        <input class="btn btn-primary" type="submit" value="Filter">
      </div>
      <hr>
    </form>
    
    <?php
    $query = 'SELECT ';
    
    $showOID = $_POST['showOID'];
    $showCost = $_POST['showCost'];
    $showStatus = $_POST['showStatus'];
    $showOrderDate = $_POST['showOrderDate'];
    $showShipDate = $_POST['showShipDate'];
    $showRID = $_POST['showRID'];
    $showSID = $_POST['showSID'];
    $showDID = $_POST['showDID'];
    if ($showOID != 'show') { $query .= ' oid,'; }
    if ($showCost != 'show') { $query .= ' cost,'; }
    if ($showStatus != 'show') { $query .= ' status,'; }
    if ($showOrderDate != 'show') { $query .= ' orderDate,'; }
    if ($showShipDate != 'show') { $query .= ' shipDate,'; }
    if ($showRID != 'show') { $query .= ' rid,'; }
    if ($showSID != 'show') { $query .= ' sid,'; }
    if ($showDID != 'show') { $query .= ' did,'; }
    
    $query = substr($query, 0, strlen($query)-1);
    
    $query .= ' FROM orders o WHERE rid='.$rid.'';
    
    $oid = $_POST['oid'];
    $cost = $_POST['cost'];
    $status = $_POST['status'];
    $orderDate = $_POST['orderDate'];
    $shipDate = $_POST['shipDate'];
    $sid = $_POST['sid'];
    $did = $_POST['did'];
    if ($oid) { $query .= ' AND oid='.$oid.''; }
    if ($cost) { $query .= ' AND cost='.$cost.''; }
    if ($status) { $query .= ' AND status=\''.$status.'\''; }
    if ($orderDate) { $query .= ' AND orderDate=\''.$orderDate.'\''; }
    if ($shipDate) { $query .= ' AND shipDate=\''.$shipDate.'\''; }
    if ($sid) { $query .= ' AND sid='.$sid.''; }
    if ($did) { $query .= ' AND did='.$did.''; }
    
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);
    
    if ($r) {
      // Fetch each row in an associative array
      print '<div class="table-responsive"><table class="table table-bordered table-hover mb-5">
        <thead><tr>';
      if ($showOID != 'show') { print '<th scople="col">OID</th>'; }
      if ($showCost != 'show') { print '<th scople="col">Cost</th>'; }
      if ($showStatus != 'show') { print '<th scople="col">Status</th>'; }
      if ($showOrderDate != 'show') { print '<th scople="col">Order Date</th>'; }
      if ($showShipDate != 'show') { print '<th scople="col">Ship Date</th>'; }
      if ($showRID != 'show') { print '<th scople="col">RID</th>'; }
      if ($showSID != 'show') { print '<th scople="col">SID</th>'; }
      if ($showDID != 'show') { print '<th scople="col">DID</th>'; }
      print '</tr></thead>
        <tbody>';
      while ($row = oci_fetch_array($stid, OCI_RETURN_NULLS+OCI_ASSOC)) {
         print '<tr>';
         foreach ($row as $item) {
             print '<td>'.($item !== null ? htmlentities($item, ENT_QUOTES) : '&nbsp').'</td>';
         }
         print '</tr>';
      }
      print '</tbody></table></div>';
    } else {
      $e = oci_error($stid);  // For oci_execute errors pass the statement handle
      print htmlentities($e['message']);
      print "\n<pre>\n";
      print htmlentities($e['sqltext']);
      printf("\n%".($e['offset']+1)."s", "^");
      print  "\n</pre>\n";
    }
    
    oci_close($conn);
  } else { ?>
    
    <h1>Restaurants</h1>
    
    <?php // Create connection to Oracle
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
    
    $query = 'select * from restaurant';
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);
    
    // Fetch each row in an associative array
    print '<div id="table" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
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
    
    <form id="next" method="get">
      <div class="form-group">
        <input class="btn btn-primary" id="submitButton" type="button" value="Next" onClick="submit_form()" disabled="true">
      </div>
    </form>

<?php } ?>

<?php include 'footer.php';?>
