require 'rails_helper'

describe 'as a user' do
	describe 'I can visit login page' do
		it 'and login with twitter' do
			visit '/login'
			mock_auth_hash
			click_link "Sign in with Twitter"
			expect(current_path).to eq('/dashboard')
		end
	end
end