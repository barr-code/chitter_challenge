require 'sinatra'
require 'data_mapper'
require_relative 'users.rb'
require_relative 'datamapper_setup'

enable :sessions

def current_user
	@current_user ||=User.get(session[:user_id]) if session[:user_id]
end

	get '/' do
	    erb :index
	end

	get '/register' do
	  	erb :register
	end

	post '/register' do
		@user = User.create(email: params[:email],
			username: params[:username], password: params[:password],
			password_confirmation: params[:password_confirmation])

		if @user.save
			session[:user_id] = @user.id
			redirect to '/'
		end
	end

