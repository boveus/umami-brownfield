require 'rails_helper'


describe 'as a user' do
	describe 'I can visit login page' do
		it 'and login with google' do
			visit '/login'
			mock_auth_hash
			click_link "Sign in with Google"
			expect(current_path).to eq('/dashboard' )
			save_and_open_page
		end
	end
end