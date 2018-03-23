<?php include 'header.php';?>

<?php $_GET["rid"]; ?>

<?php
  
  $rid = $_GET["rid"];
  if ($rid) { ?>
    
    <h1>Orders For Restaurant #<?php echo $rid ?></h1>
    
    <?php // Create connection to Oracle
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
    
    $query = 'select * from orders o where rid='.$rid.'';
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);
    
    // Fetch each row in an associative array
    print '<div id="table" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
      <th scople="col">OID</th>
      <th scople="col">Cost</th>
      <th scople="col">Status</th>
      <th scople="col">Order Date</th>
      <th scople="col">Ship Date</th>
      <th scople="col">RID</th>
      <th scople="col">SID</th>
      <th scople="col">DID</th>
      </tr></thead><tbody>';
    while ($row = oci_fetch_array($stid, OCI_RETURN_NULLS+OCI_ASSOC)) {
       print '<tr>';
       foreach ($row as $item) {
           print '<td>'.($item !== null ? htmlentities($item, ENT_QUOTES) : '&nbsp').'</td>';
       }
       print '</tr>';
    }
    print '</tbody></table></div>';
    
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
    <input type="button" value="Next" onClick="submit_form()">
    </form>

<?php } ?>

<?php include 'footer.php';?>
