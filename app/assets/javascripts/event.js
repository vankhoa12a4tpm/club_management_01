$(document).ready(function () {
  $('.expense').hide();
  $('#event_event_category').change(function(){
    var cat = $('#event_event_category').val();
    if (cat==3){
      $('.expense').hide();
    }else{
      $('.expense').show();
    }
  });
});
