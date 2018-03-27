<?php include 'header.php';

$sid = $_GET["sid"];

if($sid) { ?>
    <h1>Supplier # <?php echo $sid ?></h1>
    <?php // Create connection to Oracle
    $conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");

    $query = 'select * from supplier where sid='.$sid.'';
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
    print '</tbody></table></div>'; ?>

    <h1>All Warehouses</h1>

    <?php
    $query2 = 'SELECT w.wid, w.phone, w.unitNo, w.street, w.city, w.province, Tempo.countp FROM supplier s, warehouse w,(select COUNT(DISTINCT pid) AS countp FROM stores st 
WHERE st.sid ='.$sid.') Tempo WHERE w.sid=s.sid AND s.sid='.$sid.'';
    $stid2 = oci_parse($conn, $query2);
    $r2 = oci_execute($stid2);

    // Fetch each row in an associative array
    if($r2) {
        print '<div id="supplierTable" class="table-responsive"><table class="table table-bordered table-hover"><thead><tr>
	    <th scople="col">WID</th>
	    <th scople="col">Phone</th>
	    <th scople="col">unitNo</th>
	    <th scople="col">Street</th>
	    <th scople="col">city</th>
	    <th scople="col">Province</th>
	    <th scople="col"># of products</th>
	    </tr></thead><tbody>';
        while ($row = oci_fetch_array($stid2, OCI_RETURN_NULLS + OCI_ASSOC)) {
            print '<tr>';
            foreach ($row as $item) {
                print '<td>' . ($item !== null ? htmlentities($item, ENT_QUOTES) : '&nbsp') . '</td>';
            }
            print '</tr>';
        }
        print '</tbody></table></div>';
    } else {
        $e = oci_error($stid2);  // For oci_execute errors pass the statement handle
        print htmlentities($e['message']);
        print "\n<pre>\n";
        print htmlentities($e['sqltext']);
        printf("\n%".($e['offset']+1)."s", "^");
        print  "\n</pre>\n";
    }

    oci_close($conn); ?>

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

    <form id="next" method="get">
        <div class="form-group">
            <input class="btn btn-primary" id="submitButton" type="button" value="Next" onClick="submit_supplier_form()" disabled="true">
        </div>
    </form>

<?php	}
include 'footer.php';?>
