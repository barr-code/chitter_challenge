require 'spec_helper'

def register(email = "vika177@gmail.com", username = "barrcode", password = "lolcatz", password_confirmation = "lolcatz")
	visit '/register'
	fill_in :email, :with => email
	fill_in :username, :with => username
	fill_in :password, :with => password
	fill_in :password_confirmation, :with => password_confirmation
	click_button "Join Chitter"
end


feature "User registers for Chitter" do 
	scenario "before having an account" do 
		expect{register}.to change(User, :count).by 1
	end

	scenario "signed up and signed in" do 
		register 
		expect(page).to have_content("Welcome, barrcode!")
		expect(User.first.email).to eq("vika177@gmail.com")
	end
end