require 'sinatra'
require 'data_mapper'
require 'rack-flash'
require 'dm-timestamps'
require_relative 'models/users.rb'
require_relative 'models/cheeps.rb'
require_relative 'models/tags.rb'
require_relative 'datamapper_setup'

enable :sessions
set :session_secret, 'secret'
set :public_folder, Proc.new {File.join(root, "..", "public")}
use Rack::Flash

def current_user
	@current_user ||=User.get(session[:user_id]) if session[:user_id]
end

	get '/' do
		@cheeps = Cheep.all
		erb :layout
	end

	# post '/' do
	# 	email, password = params[:email], params[:password]
	# 	user = User.authenticate(email, password)
	# 	if user
	# 		session[:user_id] = user.id
	# 		redirect to('/')
	# 	else
	# 		flash[:errors] = ["The password and/or e-mail address you entered is incorrect."]
	# 		erb :new_session
	# 	end

	# 	puts user.inspect
	# end

	# post '/cheep' do
	# 	content = params[:cheep]
	# 	user = current_user
	# 	Cheep.create(:content => content, :user => user)
	# 	redirect to('/')
	# end

	# get '/register' do
	#   	erb :register
	# end

	post '/register' do
		content_type :json
		@user = User.create(:name => params[:name], :email => params[:email],
			:username => params[:username], :password => params[:password],
			:password_confirmation => params[:password_confirmation])
		puts @user.inspect
	end

	# get '/sessions/new' do 
	# 	erb :new_session
	# end

	# delete '/sessions' do 
	# 	flash[:notice] = "Bye bye!"
	# 	session[:user_id] = nil
	# 	redirect to('/')
	# end

	get '/api/users' do
		content_type :json
		users = User.all
		return users.to_json
	end

	get '/users/:email/:password' do
		content_type :json
		email, password = params[:email], params[:password]
		user = User.authenticate(email, password)
		# return user.to_json
		puts user.inspect
	end

