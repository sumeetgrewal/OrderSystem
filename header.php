<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="ie=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
  <link rel="profile" href="http://gmpg.org/xfn/11">
  <?php 
    $pageName = basename($_SERVER['PHP_SELF'], '.php');
    $pageName = str_replace('-', ' ', $pageName);
    $pageName = ucwords($pageName);
  ?>
  <title><?php echo "Order System | " . $pageName ?></title>
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
  <link rel="stylesheet" href="style.css">
</head>

<body>
  
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4">
    <div class="container">
      <a class="navbar-brand" href="restaurant.php">Order System</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarNavDropdown">
        <ul class="navbar-nav">
          <li class="nav-item <?php if (
            basename($_SERVER['PHP_SELF'], '.php') == "restaurant" || 
            basename($_SERVER['PHP_SELF'], '.php') == "place-new-order" ||
            basename($_SERVER['PHP_SELF'], '.php') == "order-details") { echo "active"; } ?>">
            <a class="nav-link" href="restaurant.php">Restaurant</a>
          </li>
          <li class="nav-item <?php if (
	          basename($_SERVER['PHP_SELF'], '.php') == "supplier" ||
	          basename($_SERVER['PHP_SELF'], '.php') == "warehouse-product") { echo "active"; } ?>">
            <a class="nav-link" href="supplier.php">Supplier</a>
          </li>
          <li class="nav-item <?php if (basename($_SERVER['PHP_SELF'], '.php') == "distributor") {echo "active";}; ?>">
            <a class="nav-link" href="distributor.php">Distributor</a>
          </li>
        </ul>
      </div>
    </div>
  </nav>
  
  <div class="container">
    <div class="row">
      <div class="col-12">
