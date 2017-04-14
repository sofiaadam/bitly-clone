$(document).ready(function() {
  $('form').submit(function(event) {
    event.preventDefault();
    $.ajax({
      url: '/urls',
      method: 'post',
      data: $(this).serialize(),
      dataType: 'json',
      // callbacks
      beforeSend: function() {
        $('form input').val('Loading...');
      },

      complete: function() {
        $('form input').val('CUT!');
      },

      success: function(data) {
        $('tr:first-child').after('<tr> <td>' + data.long_url + '</td> <td>' + data.short_url + '</td> </tr>')
      },

      error: function(data) {
        $('#flash').html(data.responseText)
      }
    })
  })
});