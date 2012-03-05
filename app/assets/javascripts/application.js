// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require jquery.maskMoney
//= require_tree .

$(document).ready(function() {
    $('#help dd').hide();

    $('#help dt a').click(function(){
      if ($($('#help dt a')[0]).hasClass("ativo")) {
        $(this).removeClass('ativo');
      } else {
        $(this).addClass('ativo');
      }

      $(this).parent().next('dd').slideToggle('slow');
    });

    setTimeout(hideFlashes, 2500);
 });

var hideFlashes = function() {
  $('#flash_notice, #flash_warning, #flash_error').fadeOut(1500);
}