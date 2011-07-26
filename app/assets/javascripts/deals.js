$(document).ready(function() {
  $.each($('div[data-time]'), function(index, value) {
    var attr_class = value.getAttribute('class');
    // var contador = attr_class.substring(attr_class.indexOf('contador') + 8, attr_class.length); 
    // atualizaContador(contador);

    atualizaContador(index);
  });
});

function atualizaContador(i) {
  var oferta = $(".contador" + i);
  var tempo = oferta.attr('data-time').split(" ");

  var hoje = new Date();
  var futuro = new Date(Date.UTC(tempo[0], tempo[1] - 1, tempo[2], tempo[3], tempo[4], tempo[5]));

  var ss = parseInt((futuro - hoje) / 1000);
  var mm = parseInt(ss / 60);
  var hh = parseInt(mm / 60);
  var dd = parseInt(hh / 24);

  ss = ss - (mm * 60);
  mm = mm - (hh * 60);
  hh = hh - (dd * 24);

  if (ss < 10) ss = '0' + ss;
  if (mm < 10) mm = '0' + mm;
  if (hh < 10) hh = '0' + hh;

  var faltam = '';
  faltam += (dd && dd > 1) ? dd+'d ' : (dd==1 ? '1d ' : '');
  faltam += (toString(hh).length) ? hh+':' : '';
  faltam += (toString(mm).length) ? mm+':' : '';
  faltam += ss+'';

  if (dd+hh+mm+ss > 0) {
    oferta.html(""+faltam);
    setTimeout(function(){atualizaContador(i)},1000);
  } else {
    oferta.html("Esgotado");
  }
}
