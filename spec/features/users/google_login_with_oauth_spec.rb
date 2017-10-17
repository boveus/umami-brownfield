require 'rails_helper'

describe 'as a user' do
	describe 'I can visit login page' do
		it 'and login with google' do
			user = build(:user, role: "admin",
				 									provider: "google_oauth2",
  												uid: "115821578552534939600",
  												oauth_token: "ya29.GlvnBMjVOT2L-FavDrnjwA4EQLTFUgjTyb5TLPLV_o2ogbPgl40YzbYlzoANaNYfaagmDtORisbyVGceVaZjfaTziDVYYksmeDIv2lauxNUhPH6pmBvX7OEqkmhg",
  												oauth_expires_at: Time.parse("Tue, 17 Oct 2017 16:02:44 UTC +00:00"),
  												image: "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg")
			visit '/login'
			# within find('.loginBtn') do
  		# 	find().click
			# end
			click_link "Sign in with Google"
			expect(current_path).to eq(root_path)
		end
	end
end