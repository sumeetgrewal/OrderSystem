$(document).ready(function() {  
  $('#table').on('click', 'tbody tr', function(event) {
    $(this).addClass('active').siblings().removeClass('active');
    $('#submitButton').prop("disabled", false);
  });  
});

function submit_form() {
  $value = $('#table .active td').html();
  $('#next').append('<input type="hidden" name="rid" value="'+$value+'" />');
  $("#next").submit();
}