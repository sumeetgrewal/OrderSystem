<?php include 'header.php';
	
	$rid = $_POST['rid'];
	$sid = $_POST['sid'];
	$minMax = $_POST["filter"];
	
	if ($sid) { ?>
		
		<h1>Choose A Distributor</h1>
		
		<?php // Create connection to Oracle
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
    
    $query = 'select s.sid, s.name, s.phone, cast(avg(p.price) as numeric(10,2)) from supplier s, product p where s.sid=p.sid group by s.sid, s.name, s.phone order by s.sid';
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);

		$query2 = 'select * from distributor d, contracts c where d.did=c.did AND c.sid='.$sid.'';
    $stid2 = oci_parse($conn, $query2);
    $r2 = oci_execute($stid2);
    
    // Fetch each row in an associative array
    print '<div id="distributorTable" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
      <th scople="col">SID</th>
      <th scople="col">Name</th>
      <th scople="col">Phone</th>
      <th scople="col">Average Price</th>
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
    
    <form id="next" method="post" action="restaurant.php">
        <div class="form-group">
	        <input type="hidden" name="rid" value="<?php echo $rid?>" />
	        <input type="hidden" name="sid" value="<?php echo $sid?>" />
          <input class="btn btn-primary" id="submitButton" type="button" value="Next" onClick="choose_dist_form()" disabled="true">
        </div>
    </form>
    
<?php	} else { ?>
	
    <h1>Choose A Supplier</h1>
    
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
          <input class="form-check-input" type="radio" name="filter" value="all" <?php echo($_POST['filter']=="all" ? 'checked="checked"': '' )?> >ALL 
      </div>
    </div>
    <div class="form-group">
      <input type="hidden" name="rid" value="<?php echo $rid?>" />
      <input class="btn btn-primary" type="submit" value="Find">
    </div>
    </form>
    <hr>
    
    <?php // Create connection to Oracle
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");
    
    $query = 'select s.sid, s.name, s.phone, cast(avg(p.price) as numeric(10,2)) from supplier s, product p where s.sid=p.sid group by s.sid, s.name, s.phone order by s.sid';
    
    if ($minMax == 'max') {
      $query = 'select v.sid, v.name, v.phone, v.avgPrice from (select s.sid, s.name, s.phone, cast(avg(p.price) as numeric(10,2)) as avgPrice from supplier s, product p where s.sid=p.sid group by s.sid, s.name, s.phone order by s.sid) v where v.avgPrice = (select max(avgPrice) from (select s.sid, s.name, s.phone, cast(avg(p.price) as numeric(10,2)) as avgPrice from supplier s, product p where s.sid=p.sid group by s.sid, s.name, s.phone order by s.sid))';
    } else if ($minMax == 'min') {
      $query = 'select v.sid, v.name, v.phone, v.avgPrice from (select s.sid, s.name, s.phone, cast(avg(p.price) as numeric(10,2)) as avgPrice from supplier s, product p where s.sid=p.sid group by s.sid, s.name, s.phone order by s.sid) v where v.avgPrice = (select min(avgPrice) from (select s.sid, s.name, s.phone, cast(avg(p.price) as numeric(10,2)) as avgPrice from supplier s, product p where s.sid=p.sid group by s.sid, s.name, s.phone order by s.sid))';
    } else {
      $query = 'select s.sid, s.name, s.phone, cast(avg(p.price) as numeric(10,2)) from supplier s, product p where s.sid=p.sid group by s.sid, s.name, s.phone order by s.sid';
    }
    
    $stid = oci_parse($conn, $query);
    $r = oci_execute($stid);
    
    // Fetch each row in an associative array
    print '<div id="supplierTable" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
      <th scople="col">SID</th>
      <th scople="col">Name</th>
      <th scople="col">Phone</th>
      <th scople="col">Average Price</th>
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
    
    <form id="next" method="post" action="select-supplier.php">
        <div class="form-group">
	        <input type="hidden" name="rid" value="<?php echo $rid?>" />
          <input class="btn btn-primary" id="submitButton" type="button" value="Next" onClick="choose_supplier_form()" disabled="true">
        </div>
    </form>

<?php } ?>

<?php include 'footer.php';?>
