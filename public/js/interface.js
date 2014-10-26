$(document).ready(function(){
	
	$('#signing_in').hide();
	$('#registration').hide();

	$('#sign_up').on('click', function(){
		$('#registration').show();
		$('#register').on('click', function(){
			$('#registration').hide();
		});
	});

	$('#sign_in').on('click', function(){
		$('#signing_in').show();
		$('#login').on('click', function(){
			$('#signing_in').hide();
		});
	});
});