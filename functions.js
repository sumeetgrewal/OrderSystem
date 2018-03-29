$(document).ready(function() {  
  $('#restaurantTable').on('click', 'tbody tr', function(event) {
    $(this).addClass('active').siblings().removeClass('active');
    $('#submitButton').prop("disabled", false);
    $('#deleteButton').prop("disabled", false);
  });
  
  $('#orderTable').on('click', 'tbody tr', function(event) {
    $(this).addClass('active').siblings().removeClass('active');
    $('#submitButton').prop("disabled", false);
  }); 
  
  $('#productTable').on('click', 'tbody tr', function(event) {
    $(this).addClass('active').siblings().removeClass('active');
    $('#deleteButton').prop("disabled", false);
  });
  
  $('#distributorTable').on('click', 'tbody tr', function(event) {
    $(this).addClass('active').siblings().removeClass('active');
    $('#submitButton').prop("disabled", false);
  });

  $('#supplierTable').on('click', 'tbody tr', function(event) {
    $(this).addClass('active').siblings().removeClass('active');
    $('#submitButton').prop("disabled", false);
  });
});

function submit_rest_form() {
  $value = $('#restaurantTable .active td').html();
  $('#next').append('<input type="hidden" name="rid" value="'+$value+'" />');
  
  $pass = prompt("Please enter password", "");

  if ($pass == $value) {
    $("#next").submit();
  } else if ($pass == null || $pass == "") {
    // do nothing
  } else {
    alert("Wrong password");
  } 
}

function submit_order_form() {
  $value = $('#orderTable .active td').html();
  $('#next').append('<input type="hidden" name="oid" value="'+$value+'" />');
  $("#next").submit();
}

function submit_dist_form() {
  $value = $('#distributorTable .active td').html();
  $('#next').append('<input type="hidden" name="did" value="'+$value+'" />');
  
  $pass = prompt("Please enter password", "");

  if ($pass == $value) {
    $("#next").submit();
  } else if ($pass == null || $pass == "") {
    // do nothing
  } else {
    alert("Wrong password");
  }
}

function choose_dist_form() {
  $value = $('#distributorTable .active td').html();
  $('#next').append('<input type="hidden" name="did" value="'+$value+'" />');
  $("#next").submit();
}

function submit_supplier_form() {
  $value = $('#supplierTable .active td').html();
  $('#next').append('<input type="hidden" name="sid" value="'+$value+'" />');

  $pass = prompt("Please enter password", "");

  if ($pass == $value) {
    $("#next").submit();
  } else if ($pass == null || $pass == "") {
    // do nothing
  } else {
    alert("Wrong password");
  }
}

function choose_supplier_form() {
  $value = $('#supplierTable .active td').html();
  $('#next').append('<input type="hidden" name="sid" value="'+$value+'" />');
  $("#next").submit();
}

function delete_restaurant() {
	if (confirm('Are you sure you want to delete this restaurant?')) {
		$value = $('#restaurantTable .active td').html();
		$('#deleteRestaurant').append('<input type="hidden" name="delete_rid" value="'+$value+'" />');
		$("#deleteRestaurant").submit();
	} else {
    // Do nothing
	}
}

function delete_product() {
	if (confirm('Are you sure you want to delete this product?')) {
		$value = $('#productTable .active td').html();
		$('#deleteProduct').append('<input type="hidden" name="delete_pid" value="'+$value+'" />');
		$("#deleteProduct").submit();
	} else {
    // Do nothing
	}
}