$(document).ready(function(){
	
	$('#signing_in').hide();
	$('#signing_up').hide();

	$('#sign_up').on('click', function(){
		$('#signing_up').show();
	});

	$('#sign_in').on('click', function(){
		$('#signing_in').show();
		
	});
});