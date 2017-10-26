require 'rails_helper'

describe 'as a user' do
	describe 'I can visit login page' do
		it 'and login with facebook' do
			visit '/login'
			mock_auth_hash_facebook
			click_link "Sign in with Facebook"
			expect(current_path).to eq('/dashboard')
      expect(page.body).to have_content("Logged in as Sam Snider")
      expect(page.body).to have_content("sam_redins@yahoo.com")
		end
	end
end