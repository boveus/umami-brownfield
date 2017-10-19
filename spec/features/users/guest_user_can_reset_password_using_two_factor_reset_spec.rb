describe "as a guest user" do
	describe "when I visit login page" do
		it "I can click 'forgot my password' and reset it through two factor authentication" do
			user = create(:user)
			old_pass = user.password
			new_pass = "newpass"
			visit '/login'
			click_on "Forgot my password"
			expect(current_path).to eq('/password-reset')
			
			fill_in 'Email', with: "josh@exaple.com"
			click_on 'Submit'
			
			expect(current_path).to eq('/password-confirmation')
			expect(page).to have_css('.instructions')
			fill_in "Confirmation Code", with: 12345
			fill_in 'Password', with: "#{new_pass}"
			fill_in 'Password Confirmation', with: "#{new_pass}"
			click_on "Submit"
			
			expect(current_path).to eq('/dashboard')
			expect(current_user).to eq(user)
			click_on "Logout"
			
			expect(current_path).to eq(root_path)
			visit '/login'
			fill_in 'user[name]', with: "JustJoshin"
			fill_in 'user[password]', with: "#{old_pass}"
			expect(current_path).to eq('/login')
			
			visit '/login'
			fill_in 'user[name]', with: "JustJoshin"
			fill_in 'user[password]', with: "#{new_pass}"
			expect(current_path).to eq('/dashboard')
		end
	end
end