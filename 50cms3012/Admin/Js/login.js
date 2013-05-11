// login and reg
$(document).ready(function(){
	if($('#email').val() != ''){$('#email').parent().find('label').hide();}
	if($('#password').val() != ''){$('#password').parent().find('label').hide();}
	if($('#loginarea #verifycode').val() != ''){$('#loginarea #verifycode').parent().find('label').hide();}
	$('#email,#password,#loginarea #verifycode').focus(function(){
		$(this).parent().find('label').hide();
		$(this).addClass('curr');
	}).blur(function(){
		if($(this).val() ==''){$(this).parent().find('label').show();}	
		$(this).removeClass('curr');
	})
	
	$('#regarea .input').focus(function(){
		
		$(this).addClass('curr');
	}).blur(function(){
		
		$(this).removeClass('curr');
	})
	
	setTimeout(function(){$('#BalloonB').fadeIn('slow');},800)
	setTimeout(function(){ $('#BalloonA').fadeIn('slow');},1100)
})

function reloadcode(obj,url) 
{
	obj.src = url+ '&nowtime=' + new Date().getTime();
}


function checkLogin()
{
	if($('#email').val() == '' || $('#password').val() == ''){ return false;}
	$('.subBtn').addClass('loading');
	return true;
}

function checkReg()
{
	$('.regcurr').addClass('loading');
	$("input[name='do']").attr('disabled', true); 
	$('form').submit();

}


var offset = 2247;
var backgroundheight = offset;
function scrollbackground() {
    offset = (offset < 1) ? offset + (backgroundheight - 1) : offset - 1;
    $('#footer').css('background-position', offset + "px");
    setTimeout(function() {
        scrollbackground()
    },
    100)
};
scrollbackground();