require 'bcrypt'

class User

	include DataMapper::Resource

	property :id, Serial
	property :name, String, length: 5..30
	property :email, String, length: 5..50, :unique => true
	property :username, String, length: 5..30, :unique => true
	property :password_digest, Text
	has n, :cheeps, :through => Resource

	attr_reader :password
	attr_accessor :password_confirmation

	validates_confirmation_of :password, :message => "The passwords you entered don't match. Try again."

	def password=(password)
		@password = password
		self.password_digest = BCrypt::Password.create(password)
	end

	def self.authenticate(email, password)
		user = first(:email => email)
		if user && BCrypt::Password.new(user.password_digest) == password
			user
		else
			nil
		end
	end
end