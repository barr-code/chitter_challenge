require 'spec_helper'

feature "listing all my cheeps" do

	def register(name = "Victoria", email = "vika177@gmail.com", username = "barrcode", password = "lolcatz", password_confirmation = "lolcatz")
		visit '/register'
		fill_in :name, :with => name
		fill_in :email, :with => email
		fill_in :username, :with => username
		fill_in :password, :with => password
		fill_in :password_confirmation, :with => password_confirmation
		click_button "Join Chitter"
	end

	def new_cheep(cheep, tags = [])
		within('#new-cheep') do
			fill_in :cheep, :with => cheep
			click_button 'Cheep!'
		end
	end

	before(:each) do
		register
		new_cheep('What up, world?')
	end

	scenario "browsing the homepage" do
		visit '/'
		expect(page).to have_content('barrcode')
		expect(page).to have_content('Victoria')
		expect(page).to have_content('What up, world?')
		expect(page).to have_content(Time.now.strftime("%b %d %r"))
	end

end