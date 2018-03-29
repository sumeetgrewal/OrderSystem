<?php include 'header.php'; ?>

<?php  
  $wid = $_POST["wid"];
  if ($wid) {
  	// Create connection to Oracle
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
    
    $query = 'select * from warehouse where wid='.$wid.'';
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);
        ?>
    
    <h1>Warehouse # <?php echo $wid ?></h1>
    <?php 
    
    // Fetch each row in an associative array
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
    
    <h1>Warehouse Products</h1>
    
    <?php 
    $query2 = 'select p.pid, p.name, p.category, p.price, s.onHand from product p, stores s where s.wid='.$wid.' AND s.pid=p.pid';
    $stid2 = oci_parse($conn, $query2);
    $r2 = oci_execute($stid2);
    
    // Fetch each row in an associative array
    print '<div id="productTable" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
      <th scople="col">PID</th>
      <th scople="col">Name</th>
      <th scople="col">Category</th>
      <th scople="col">Price</th>
      <th scople="col">OnHand</th>
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
        }
    ?>

<?php include 'footer.php'; ?>