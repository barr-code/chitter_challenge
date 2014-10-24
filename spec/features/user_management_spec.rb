require 'spec_helper'

def register(name = "Victoria", email = "vika177@gmail.com", username = "barrcode", password = "lolcatz", password_confirmation = "lolcatz")
	visit '/register'
	fill_in :name, :with => name
	fill_in :email, :with => email
	fill_in :username, :with => username
	fill_in :password, :with => password
	fill_in :password_confirmation, :with => password_confirmation
	click_button "Join Chitter"
end

def sign_in(email, password)
		visit '/sessions/new'
		fill_in :email, with: email
		fill_in :password, with: password
		click_on 'Sign In'
end


feature "User registers for Chitter" do 
	scenario "before having an account" do 
		expect{register}.to change(User, :count).by 1
	end

	scenario "signed up and signed in" do 
		register 
		expect(page).to have_content("Welcome, barrcode!")
		expect(User.first.email).to eq("vika177@gmail.com")
		expect(User.first.name).to eq("Victoria")
	end

	scenario "signing up with password confirmation that doesn't match" do 
		expect {register('test@test.com', 'testhandle', 'lolcatz', 'lolcat')}.to change(User, :count).by 0
		expect(current_path).to eq '/register'
		expect(page).to have_content "The passwords you entered don't match. Try again."
	end

	scenario "trying to sign up with an already registered email address" do
		register
		expect {register}.to change(User, :count).by 0
		expect(page).to have_content("There is already a Chitter account registered to this email address.")

	end

	scenario "trying to sign up with an already registered username" do
		register
		expect { register }.to change(User, :count).by 0
		expect(page).to have_content("This username is taken. Try another name.")
	end
end

feature "User signs in and out" do
	before(:each) do
		User.create(:email => 'vika177@gmail.com', :username => 'barrcode', :password => 'lolcatz',
			:password_confirmation => 'lolcatz') 
	end

	scenario "signing in" do
		sign_in('vika177@gmail.com', 'lolcatz')
		expect(page).to have_content ('Welcome, barrcode!')
	end

	scenario "signing in with the wrong password" do
		sign_in('vika177@gmail.com', 'lolnope')
		expect(page).to have_content "The password and/or e-mail address you entered is incorrect."
	end

	scenario "signing out" do 
		sign_in('vika177@gmail.com', 'lolcatz')
		click_button "Sign out"
		expect(page).to have_content "Bye bye!"
	end
end

feature "posting cheeps" do 
	before(:each) do 
		User.create(:email => 'vika177@gmail.com', :username => 'barrcode', :password => 'lolcatz', :password_confirmation => 'lolcatz')
	end

	scenario "while signed out" do 
		visit '/'
		expect(page).to have_content "Sign up to start Cheeping!"
	end

	scenario "while signed in" do 
		sign_in('vika177@gmail.com', 'lolcatz')
		expect(current_path).to eq '/'
		expect(page).to have_content "Compose a new Cheep:"
	end

end