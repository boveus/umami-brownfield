require 'rails_helper'

describe "as a guest user" do
	describe "when I visit login page" do
		it "I can click 'forgot my password' and reset it through two factor authentication" do
			user = create(:user,name: "JustJoshin", email: "josh@example.com", verification_code: "12345", phone_number: "+13039296066")
			old_pass = user.password
			new_pass = "newpass"
			visit '/login'
			click_on "Forgot my password"
			expect(current_path).to eq('/password-reset')
			fill_in 'user[email]', with: "josh@example.com"
			click_on 'commit'
			expect(current_path).to eq("/confirmations/new.#{user.id}")
      User.first.update!(verification_code: "12345", password: "n/a")
			expect(page).to have_css('.instructions')
			fill_in "verification_code", with: "12345"
      click_on "Confirm"
      expect(current_path).to eq("/users/password-edit.#{user.id}")
			fill_in 'user[password]', with: "#{new_pass}"
			fill_in 'user[password_confirmation]', with: "#{new_pass}"
			click_on "Update Password"
			expect(current_path).to eq(root_path)
			visit '/login'
			fill_in 'user[name]', with: "JustJoshin"
			fill_in 'user[password]', with: "#{old_pass}"
      click_on "Log in"
			expect(current_path).to eq('/login')
			visit '/login'
			fill_in 'user[name]', with: "JustJoshin"
			fill_in 'user[password]', with: "#{new_pass}"
      click_on "Log in"
      save_and_open_page
			expect(page.body).to include('JustJoshin')
		end
	end
end
