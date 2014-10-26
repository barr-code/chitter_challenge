$(document).ready(function(){
	
	$('#signing_in').hide();
	$('#registration').hide();

	$('#sign_up').on('click', function(){
		$('#registration').show();
		$('#register').on('click', function(){
			$.post('/register', {
				name: $('#r_name').val(),
				email: $('#r_email').val(),
				username: $('#r_username').val(),
				password: $('#r_password').val(),
				password_confirmation: $('#password_confirmation').val(),
			});

			$('#registration').hide();
			$('#sign_up').hide();
		});
	});

	$('#sign_in').on('click', function(){
		$('#signing_in').show();
		$('#login').on('click', function(){
			$('#signing_in').hide();
		});
	});
});