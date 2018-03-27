<?php include 'header.php';
  
  $did = $_GET["did"];
  $rid = $_POST["rid"];
  $sid = $_POST["sid"];
  $status = $_POST["status"];
	if($did) { ?>
		<h1>Distributer # <?php echo $did ?></h1>
	  <?php // Create connection to Oracle
	  $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");

	  $query = 'select * from distributor where did='.$did.'';
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
	  print '</tbody></table></div>'; ?>
		<form id="filter" method="post">
	  <hr>
      <h5>Filter</h5>
      <div class="form-row">
        <div class="col"> 
          <input class="form-control" name="rid" type="text" placeholder="RID" <?php echo(isset($_POST['rid']) ? 'value="'.$_POST['rid'].'"' : '') ?> ><br>
        </div>
        <div class="col">
          <input class="form-control" name="sid" type="text" placeholder="SID" <?php echo(isset($_POST['sid']) ? 'value="'.$_POST['sid'].'"' : '') ?> ><br>
        </div>
        <div class="col">
          <input class="form-control" name="status" type="text" placeholder="Status" <?php echo(isset($_POST['status']) ? 'value="'.$_POST['status'].'"' : '') ?> ><br>
        </div>
        <div class="form-group">
        <input class="btn btn-primary" type="submit" value="Filter">
      </div>
      <hr>
      </div>
      </form>
      <hr>
	  
	  <h1>All Orders</h1>
	  
	  <?php 
	  
	  $query2 = 'select o.oid, o.rid, r.name as restname, s.sid, s.name, o.status from orders o, supplier s, restaurant r where o.rid=r.rid AND o.sid=s.sid AND o.did='.$did.'';
		if ($rid) {
	  $query2 = $query2 .'AND r.rid='.$rid;
	  }
	  if ($sid) {
	  $query2 = $query2 .'AND s.sid='.$sid;
	  }
	  if ($status) {
	  $query2 = $query2 .'AND o.status='.$status;
	  }
	  $stid2 = oci_parse($conn, $query2);
	  $r2 = oci_execute($stid2);
	  
	  // Fetch each row in an associative array
	  print '<div id="distributorTable" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
	    <th scople="col">OID</th>
	    <th scople="col">RID</th>
	    <th scople="col">Rest Name</th>
	    <th scople="col">SID</th>
	    <th scople="col">Supp Name</th>
	    <th scople="col">Status</th>
	    </tr></thead><tbody>';
	  while ($row = oci_fetch_array($stid2, OCI_RETURN_NULLS+OCI_ASSOC)) {
	     print '<tr>';
	     foreach ($row as $item) {
	         print '<td>'.($item !== null ? htmlentities($item, ENT_QUOTES) : '&nbsp').'</td>';
	     }
	     print '</tr>';
	  }
	  print '</tbody></table></div>';
	  
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
	  
	  <form id="next" method="get">
	    <div class="form-group">
	      <input class="btn btn-primary" id="submitButton" type="button" value="Next" onClick="submit_dist_form()" disabled="true">
	    </div>
	  </form>

<?php	}
include 'footer.php';?>
