$(document).ready(function() {
  $('#login-link').click(function(event){
    event.preventDefault(); // Prevent link from following its href
    $("#box-login").animate({"height": "toggle"}, { duration: 200 });
  });
});
