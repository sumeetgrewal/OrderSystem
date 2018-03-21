<?php include 'header.php';?>
  
<?php
// Create connection to Oracle
$conn = oci_connect("ora_r1i0b", "a16019151", "dbhost.ugrad.cs.ubc.ca:1522/ug");

$query = 'select * from distributor';
$stid = oci_parse($conn, $query);
$r = oci_execute($stid);

// Fetch each row in an associative array
print '<div class="table-responsive"><table class="table table-striped"><thead><tr>
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

oci_close($conn);

?>

<?php include 'footer.php';?>
