$(document).ready(function(){
	var campo_cadastro = '.email-cadastre';
	$(campo_cadastro).attr('value',$(campo_cadastro).attr('title'));
	$(campo_cadastro).focus(function(){ if($(campo_cadastro).attr('value')!= '' &&  $(campo_cadastro).attr('value')!= $(campo_cadastro).attr('title')) {} else {$(campo_cadastro).attr('value','')}; });
	$(campo_cadastro).blur(function() { if($(campo_cadastro).attr('value')== '') {$(campo_cadastro).attr('value',$(campo_cadastro).attr('title'))};});
	
	$('#cadastrar').click(function()  { 
	
		if($(campo_cadastro).attr('value')!= '' &&  $(campo_cadastro).attr('value')!= $(campo_cadastro).attr('title')) {
			$('#cadastro').submit(); 
		} else {
			$(campo_cadastro).css('background-color','#FFEEEE');
			$(campo_cadastro).css('border-color','#C00');
			$(campo_cadastro).css('color','#C00');
			$(campo_cadastro).attr('value',$(campo_cadastro).attr('title'));
		}
	});
});
