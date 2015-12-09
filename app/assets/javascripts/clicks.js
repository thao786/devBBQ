  $(document).ready(function(){
    $('#new_click').on('ajax:success',function(e, data, status, xhr){
      $('#result').text(data);
    }).on('ajax:error',function(e, xhr, status, error){
      $('#reportalert').text('Failed.');
    });
  });
