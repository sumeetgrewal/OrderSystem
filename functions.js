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
});

function submit_form() {
  $value = $('#restaurantTable .active td').html();
  $('#next').append('<input type="hidden" name="rid" value="'+$value+'" />');
  
  $pass = prompt("Please enter password", "");

  if ($pass == $value) {
      $("#next").submit();
  } else {
    alert("Wrong password");
  } 
}

function submit_another_form() {
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
  } else {
    alert("Wrong password");
  }
  
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