<?php include 'header.php';?>

<?php 
  $oid = $_POST["oid"]; 
  $newPid = $_POST["newPid"]; 
  $newQty = $_POST["newQty"];
  
  if ($newPid && $newQty) {
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
    
    $query = 'insert into contain values ('.$oid.', '.$newPid.', (select sid from product where pid='.$newPid.'), (select sid from product where pid='.$newPid.'), '.$newQty.')';
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);
    
    if ($r) {
      $updateQuery = 'update orders o set o.cost=o.cost+(select (c.quantity*p.price) as totCost from contain c, product p where p.pid=c.pid AND p.pid='.$newPid.' AND c.oid='.$oid.') where o.oid='.$oid.'';
      $updateStid = oci_parse($conn, $updateQuery);
      $updateR = oci_execute($updateStid);  
    } else {
      $e = oci_error($stid);  // For oci_execute errors pass the statement handle
      print htmlentities($e['message']);
      print "\n<pre>\n";
      print htmlentities($e['sqltext']);
      printf("\n%".($e['offset']+1)."s", "^");
      print  "\n</pre>\n";
    }
    
    oci_close($conn);
  }
  
?>
	  
  <h1>Order #<?php echo $oid ?></h1>
	  
  <?php
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
    
    $deletePid = $_POST['delete_pid'];
    
    if ($deletePid) {    
	    $deleteQuery2 = 'update orders o set o.cost=o.cost-(select (c.quantity*p.price) as totCost from contain c, product p where p.pid=c.pid AND p.pid='.$deletePid.' AND c.oid='.$oid.') where o.oid='.$oid.'';
	    $deleteStid2 = oci_parse($conn, $deleteQuery2);
	    $deleteR2 = oci_execute($deleteStid2);
	    
	    $delteQuery = 'delete from contain where pid='.$deletePid.' AND oid='.$oid.'';
	    $delteStid = oci_parse($conn, $delteQuery);
	    $delteR = oci_execute($delteStid);
    }
    
    $query = 'select * from orders where oid='.$oid.'';
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);
    
    print '<div class="table-responsive"><table class="table table-bordered"><thead><tr>
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
    ?>
    
    <h1>Order Details</h1>
    
  <?php 
    $query2 = 'select p.pid, p.name, p.category, p.price, c.quantity from product p, contain c where c.oid='.$oid.' AND c.pid=p.pid';
    $stid2 = oci_parse($conn, $query2);
    $r2 = oci_execute($stid2);
    
    // Fetch each row in an associative array
    print '<div id="productTable" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
      <th scople="col">PID</th>
      <th scople="col">Name</th>
      <th scople="col">Category</th>
      <th scople="col">Price</th>
      <th scople="col">Quantity</th>
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
    
    <form id="addProduct" method="post">
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
    
    <form id="deleteProduct" method="post">
	    <div class="form-group">
  	      <input type="hidden" name="oid" value="<?php echo $oid ?>" />
		    <input class="btn btn-danger" id="deleteButton" type="button" value="Delete" onClick="delete_product()" disabled="true">
	    </div>
    </form>

<?php include 'footer.php';?>
