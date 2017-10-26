require 'rails_helper'

describe 'as a user' do
	describe 'I can visit login page' do
		it 'and login with twitter' do
			visit '/login'
			mock_auth_hash_twitter
			click_link "Sign in with Twitter"
			expect(current_path).to eq('/dashboard')
      expect(page.body).to have_content("Samuel Snider")
      expect(page.body).to have_content("fake@twitter.com")
		
		end
	end
end