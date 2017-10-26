require 'rails_helper'

describe 'as a user' do
	describe 'I can visit login page' do
		it 'and login with google' do
			visit '/login'
			mock_auth_hash_google
			click_link "Sign in with Google"
			expect(current_path).to eq('/dashboard')
      expect(page.body).to have_content("Samuel Snider")
      expect(page.body).to have_content("samuelsnider.s@gmail.com")
		end
	end
end
