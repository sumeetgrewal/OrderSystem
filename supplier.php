<?php include 'header.php';

$sid = $_POST["sid"];
$minMax = $_POST["filter"];

if($sid) { ?>
    <h1>Supplier #<?php echo $sid ?></h1>
    <?php // Create connection to Oracle
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");

    $query = 'select * from supplier where sid='.$sid.'';
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);

    // Fetch each row in an associative array
    print '<div class="table-responsive"><table class="table table-bordered"><thead><tr>
	    <th scople="col">SID</th>
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

    <h5>Find Max or Min</h5>
    <form id="max_min_numProducts" method="post">
    <div class="form-group">
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="filter" value="max" <?php echo($_POST['filter']=="max" ? 'checked="checked"': '' )?> >MAX
        </div>
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="filter" value="min" <?php echo($_POST['filter']=="min" ? 'checked="checked"': '' )?> >MIN
        </div>
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="filter" value="all" <?php echo($_POST['filter']=="all" ? 'checked="checked"': '' ) 
            
            ?> >ALL 
        </div>
    </div>
    <div class="form-group">
        <input type="hidden" name="sid" value="<?php echo $sid ?>" />
        <input class="btn btn-primary" type="submit" value="Find">
    </div>
    </form>
        <h5>Find Warehouses Containing All Products from Supplier</h5>
    <form id="division" method="post">
    <div class="form-group">
        <div class="form-check form-check-inline">
            <input class="form-check-input" type="radio" name="filter" value="division" <?php echo($_POST['filter']=="division" ? 'checked="checked"': ' ')?>  ><br>
        </div>
    </div>
    <div class="form-group">
      <input type="hidden" name="sid" value="<?php echo $sid ?>" />
      <input class="btn btn-primary" type="submit" value="Find">
    </div>
    </form>
    <h1>All Warehouses</h1>

    <?php
	$query2 = 'SELECT w.wid, w.phone, w.unitNo, w.street, w.city, w.province, Tempo.countp FROM supplier s, warehouse w,(select COUNT(DISTINCT st.pid) AS countp, st.wid FROM stores st WHERE sid = '.$sid.'GROUP BY wid) Tempo WHERE Tempo.wid = w.wid AND w.sid=s.sid AND s.sid='.$sid.'' ;
	if (minMax) {
		if ($minMax == 'division') {
    		$query3 = 'select prodcount from 
    						(select count(pid) as prodcount, sid 
    						from product group by sid) 
    					where sid='.$sid.'';
     		$stid3 = oci_parse($conn, $query3);
     		$r3 = oci_execute($stid3);
			while ($row = oci_fetch_array($stid3, OCI_RETURN_NULLS + OCI_ASSOC)) {
         	   foreach ($row as $item) {
            		if ($item !== null) {
         		   	  $numproducts = $item;
            		}
            	}
         	}
        	$query2 = 'SELECT w.wid, w.phone, w.unitNo, w.street, w.city, w.province, Tempo.countp 
						FROM supplier s, warehouse w,
							(select COUNT(DISTINCT st.pid) AS countp, st.wid 
							FROM stores st WHERE sid = '.$sid.'GROUP BY wid) Tempo 
						WHERE Tempo.wid = w.wid AND w.sid=s.sid AND s.sid='.$sid.' AND Tempo.countp = '.$numproducts.'';
    	} 
    	else if ($minMax == 'min') {
     	   $query2 = 'SELECT * FROM (SELECT w.wid, w.phone, w.unitNo, w.street, w.city, w.province, Tempo.countp 
				FROM supplier s, warehouse w, (select COUNT(DISTINCT st.pid) AS countp, st.wid 
								FROM stores st 
								WHERE sid = '.$sid.' GROUP BY wid) Tempo 
				WHERE Tempo.wid = w.wid AND w.sid=s.sid AND s.sid='.$sid.'
				order by Tempo.countp) aa
				WHERE countP = (SELECT MIN(bb.countP) as numProducts FROM (SELECT w.wid, w.phone, w.unitNo, w.street, w.city, w.province, Tempo.countp 
				FROM supplier s, warehouse w, (select COUNT(DISTINCT st.pid) AS countp, st.wid 
								FROM stores st 
								WHERE sid = '.$sid.' GROUP BY wid) Tempo 
				WHERE Tempo.wid = w.wid AND w.sid=s.sid AND s.sid='.$sid.'
				order by Tempo.countp) bb)';
     	 }
    	else if ($minMax == 'max') {
        		$query2 = 'SELECT * FROM (SELECT w.wid, w.phone, w.unitNo, w.street, w.city, w.province, Tempo.countp 
				FROM supplier s, warehouse w, (select COUNT(DISTINCT st.pid) AS countp, st.wid 
								FROM stores st 
							
							WHERE sid = '.$sid.' GROUP BY wid) Tempo 
				WHERE Tempo.wid = w.wid AND w.sid=s.sid AND s.sid='.$sid.'
				order by Tempo.countp) aa
		WHERE countP = (SELECT MAX(bb.countP) as numProducts FROM (SELECT w.wid, w.phone, w.unitNo, w.street, w.city, w.province, Tempo.countp 
				FROM supplier s, warehouse w, (select COUNT(DISTINCT st.pid) AS countp, st.wid 
								FROM stores st 
								WHERE sid = '.$sid.' GROUP BY wid) Tempo 
				WHERE Tempo.wid = w.wid AND w.sid=s.sid AND s.sid='.$sid.'
				order by Tempo.countp) bb)';
        }
     	else if ($minMax == 'all') {
        	$query2 = 'SELECT w.wid, w.phone, w.unitNo, w.street, w.city, w.province, Tempo.countp FROM supplier s, warehouse w,(select COUNT(DISTINCT st.pid) AS countp, st.wid FROM stores st WHERE sid = '.$sid.'GROUP BY wid) Tempo WHERE Tempo.wid = w.wid AND w.sid=s.sid AND s.sid='.$sid.'' ;
		}
	} 
	
    $stid2 = oci_parse($conn, $query2);
    $r2 = oci_execute($stid2);

    // Fetch each row in an associative array
    if($r2) {
        print '<div id="warehouseTable" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
	    <th scople="col">WID</th>
	    <th scople="col">Phone</th>
	    <th scople="col">unitNo</th>
	    <th scople="col">Street</th>
	    <th scople="col">city</th>
	    <th scople="col">Province</th>
	    <th scople="col"># of products</th>
	    </tr></thead><tbody>';
	      $count = 0;
        while ($row = oci_fetch_array($stid2, OCI_RETURN_NULLS + OCI_ASSOC)) {
            print '<tr>';
            foreach ($row as $item) {
                print '<td>' . ($item !== null ? htmlentities($item, ENT_QUOTES) : '&nbsp') . '</td>';
            }
            print '</tr>';
            $count++;
        }
        print '</tbody></table></div>';
        if ($count == 0) { print '<div class="alert alert-warning">No results found.</div>'; }
    } else {
        $e = oci_error($stid2);  // For oci_execute errors pass the statement handle
        print '<div class="alert alert-danger">';
        print htmlentities($e['message']);
        print "\n<pre>\n";
        print htmlentities($e['sqltext']);
        printf("\n%".($e['offset']+1)."s", "^");
        print  "\n</pre>\n";
        print '</div>';
    }

   	
    oci_close($conn); ?>
    <form id="next" method="post" action="warehouse-product.php">
        <div class="form-group">
          <input type="hidden" name="sid" value="<?php echo $sid ?>" />
          <input class="btn btn-primary" id="submitButton" type="button" value="Next" onClick="submit_warehouse_form()" disabled="true">
        </div>
   	</form>
<?php } else { ?>
    <h1>Supplier</h1>
    <?php // Create connection to Oracle
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");

    $query = 'select * from supplier';
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);

    // Fetch each row in an associative array
    print '<div id="supplierTable" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
	    <th scople="col">SID</th>
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
            <input class="btn btn-primary" id="submitButton" type="button" value="Next" onClick="submit_supplier_form()" disabled="true">
        </div>
    </form>

<?php	}
include 'footer.php';?>
