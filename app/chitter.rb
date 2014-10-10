require 'sinatra'
require 'data_mapper'
require_relative 'users.rb'
require_relative 'datamapper_setup'


	get '/' do
	    'Hello Chitter!'
	end

	get '/register' do
	  	erb :register
	end

	post '/register' do
		@user = User.create(email: params[:email],
			username: params[:username], password: params[:password],
			password_confirmation: params[:password_confirmation])
	end

