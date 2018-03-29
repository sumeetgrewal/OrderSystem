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
		print 'new product';
		// INSERT NEW TUPLE HERE
		$insQuery = 'insert into stores values ('.$wid.', '.$newPid.', (select sid from warehouse where wid='.$wid.'),'.$newQty.', Available)';
		$stid = oci_parse($conn, $insQuery);
		$r3 = oci_execute($stid);
		// REFRESH PAGE AUTOMATICALLY
		print ' added';
		}
		else if ($exists) {
		print 'product already stored';
		//  UPDATE EXISTING TUPLE HERE
		$upQuery = 'update stores set onHand = onHand+'.$newQty.' where wid='.$wid.' and pid='.$newPid.'';
		$stid = oci_parse($conn, $upQuery);
		$r3 = oci_execute($stid);
		print ' updated';
			}
		//     $query = 'insert into contain values ('.$oid.', '.$newPid.', (select sid from product where pid='.$newPid.'), (select sid from product where pid='.$newPid.'), '.$newQty.')';
//     $stid = oci_parse($conn, $query);
//     $r = oci_execute($stid);
//     
//     if ($r) {
//       $updateQuery = 'update orders o set o.cost=o.cost+(select (c.quantity*p.price) as totCost from contain c, product p where p.pid=c.pid AND p.pid='.$newPid.' AND c.oid='.$oid.') where o.oid='.$oid.'';
//       $updateStid = oci_parse($conn, $updateQuery);
//       $updateR = oci_execute($updateStid);  
//     } else {
//       $e = oci_error($stid);  // For oci_execute errors pass the statement handle
//       print htmlentities($e['message']);
//       print "\n<pre>\n";
//       print htmlentities($e['sqltext']);
//       printf("\n%".($e['offset']+1)."s", "^");
//       print  "\n</pre>\n";
//     }
    
    oci_close($conn);
  }

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
<!-- 
    <form id="next" method="post" action="supplier-product.php">
        <div class="form-group">
        	<input type="hidden" name="wid" value="<?php echo $wid ?>" />
            <input class="btn btn-primary" id="submitButton" type="button" value="Next" onClick="submit_sup_prod_form()" disabled="true">
        </div>
    </form>
 -->
    <form id="newOrder" method="post" action="supplier-product.php" class="mb-4">
      <div class="form-group">
	      <input type="hidden" name="wid" value="<?php echo $wid?>" />
        <input class="btn btn-success" id="newOrderButton" type="submit" value="Add Product">
      </div>
    </form>
<?php }
include 'footer.php'; ?>