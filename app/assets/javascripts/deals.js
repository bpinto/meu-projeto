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

function dateMask(inputData, e){

  if(document.all) // Internet Explorer
    var tecla = event.keyCode;
  else //Outros Browsers
    var tecla = e.which;

  if(tecla > 47 && tecla < 58){ // numeros de 0 a 9
    var data = inputData.value;
    //validar o dia do mês
    if (data.length == 2){
      if(inputData.value >= 1 && inputData.value <= 31) {
        data += '/';
        inputData.value = data;
      }else
        return false;
    }
    //validar o mês (de 1 a 12)
    if (data.length == 5){
      mes = data[3]+""+data[4];
      if(mes >= 1 && mes <= 12) {
        data += '/';
        inputData.value = data;
      }else
        return false;
    }
  }else if(tecla == 47){ //se for a barra, so deixa colocar se estiver na posicao certa
      if (data.length != 2 && data.length != 5){
        return false;
      }
    }
  }else if(tecla == 8 || tecla == 0) // Backspace, Delete e setas direcionais(para mover o cursor, apenas para FF)
    return true;
  else
    return false;
}
