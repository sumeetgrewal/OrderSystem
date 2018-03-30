<?php include 'header.php'; ?>

<?php  
  $wid = $_POST["wid"];
	$newPid = $_POST["newPid"]; 
  $newQty = $_POST["newQty"];
  
  if ($newPid && $newQty) {
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
    $checkquery1 = 'select pa.pid from product pa, warehouse wa where wa.wid='.$wid.' AND wa.sid=pa.sid AND pa.pid='.$newPid.' AND pa.pid NOT IN (select p.pid from product p, stores s where s.wid='.$wid.' AND s.pid=p.pid)';
    $checkexists = oci_parse($conn, $checkquery1);
    $r6 = oci_execute($checkexists);
    
    $checkquery2 = 'select pa.pid from product pa, warehouse wa where wa.wid='.$wid.' AND wa.sid=pa.sid AND pa.pid='.$newPid.' AND pa.pid IN (select p.pid from product p, stores s where s.wid='.$wid.' AND s.pid=p.pid)';
		$checknew = oci_parse($conn, $checkquery2);
		$r5 = oci_execute($checknew);
		
		while ($row = oci_fetch_array($checkexists, OCI_RETURN_NULLS + OCI_ASSOC)) {
    	foreach ($row as $item) {
      	if ($item !== null) {
        	$new = $item;
        }
      }
    }
    
    while ($row = oci_fetch_array($checknew, OCI_RETURN_NULLS + OCI_ASSOC)) {
    	foreach ($row as $item) {
      	if ($item !== null) {
        	$exists = $item;
        }
      }
    }
    
		if ($new) {
			$insQuery = 'insert into stores values ('.$wid.', '.$newPid.', (select sid from warehouse where wid='.$wid.'),'.$newQty.', \'Available\')';
			$stid = oci_parse($conn, $insQuery);
			$r3 = oci_execute($stid);
			if (!$r3) {
	      $e = oci_error($stid);
	      print '<div class="alert alert-danger">';
	      print htmlentities($e['message']);
	      print "\n<pre>\n";
	      print htmlentities($e['sqltext']);
	      printf("\n%".($e['offset']+1)."s", "^");
	      print  "\n</pre>\n";
	      print '</div>';
    	  }
		} else if ($exists) {
			$upQuery = 'update stores set onHand = onHand+'.$newQty.' where wid='.$wid.' and pid='.$newPid.'';
			$stid = oci_parse($conn, $upQuery);
			$r3 = oci_execute($stid);
			if (!$r3) {
	      $e = oci_error($stid);
	      print '<div class="alert alert-danger">';
	      print htmlentities($e['message']);
	      print "\n<pre>\n";
	      print htmlentities($e['sqltext']);
	      printf("\n%".($e['offset']+1)."s", "^");
	      print  "\n</pre>\n";
	      print '</div>';
    	  }
		}
    
    oci_close($conn);
  }
?>

<?php
  if ($wid) {
  	// Create connection to Oracle
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
    
    $query = 'select * from warehouse where wid='.$wid.'';
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid); ?>

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
    
    <h1>Warehouse Products</h1>
    
    <?php 
    $query2 = 'select p.pid, p.name, p.category, p.price, s.onHand from product p, stores s where s.wid='.$wid.' AND s.pid=p.pid';
    $stid2 = oci_parse($conn, $query2);
    $r2 = oci_execute($stid2);
    
    print '<div class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
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
    ?>
    
    <form id="newOrder" method="post" action="supplier-product.php" class="mb-4">
      <div class="form-group">
	      <input type="hidden" name="wid" value="<?php echo $wid?>" />
        <input class="btn btn-success" id="newOrderButton" type="submit" value="Add Product">
      </div>
    </form>

<?php 
	} 
?>
	
<?php include 'footer.php'; ?>