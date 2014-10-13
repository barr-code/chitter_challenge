require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require_relative 'users.rb'
require_relative 'cheeps.rb'
require_relative 'tags.rb'
require_relative 'datamapper_setup'

enable :sessions
set :session_secret, 'secret'
use Rack::Flash

def current_user
	@current_user ||=User.get(session[:user_id]) if session[:user_id]
end

	get '/' do
		@cheeps = Cheep.all
	    erb :index
	end

	post '/' do
		email, password = params[:email], params[:password]
		user = User.authenticate(email, password)
		if user
			session[:user_id] = user.id
			redirect to('/')
		else
			flash[:errors] = ["The password and/or e-mail address you entered is incorrect."]
			erb :new_session
		end
	end

	post '/cheep' do
		content = params[:cheep]
		user = current_user
		tags = params[:tags].split(' ').map {|tag| Tag.first_or_create(:text => tag)}
		Cheep.create(:content => content, :tags => tags, :user => user)
		redirect to('/')
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
		else
			flash.now[:errors] = @user.errors.full_messages
			erb :register
		end
	end

	get '/sessions/new' do 
		erb :new_session
	end

	delete '/sessions' do 
		flash[:notice] = "Bye bye!"
		session[:user_id] = nil
		redirect to('/')
	end

