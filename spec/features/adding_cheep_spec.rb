require 'spec_helper'

def sign_in(email, password)
		visit '/sessions/new'
		fill_in :email, with: email
		fill_in :password, with: password
		click_on 'Sign In'
end

def new_cheep(cheep, tags = [])
		within('#new-cheep') do
			fill_in :cheep, :with => cheep
			fill_in :tags, :with => tags.join(' ')
			click_button 'Cheep!'
		end
end

feature "user adds a new cheep" do 
	before(:each) do
		User.create(:email => 'vika177@gmail.com', :username => 'barrcode', :password => 'lolcatz',
			:password_confirmation => 'lolcatz') 
	end

	scenario "while browsing the homepage" do 
		visit '/'
		expect(Cheep.count).to eq 0
	end

	scenario "adding a cheep" do 
		sign_in('vika177@gmail.com', 'lolcatz')
		new_cheep('Hello, world!')
		expect(current_path).to eq '/'
		expect(page).to have_content 'Hello, world!'
	end
end