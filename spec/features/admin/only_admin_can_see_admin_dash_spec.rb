require 'rails_helper'

feature 'User' do
  context 'as registered admin' do
    scenario 'can see admin dashboard' do
      admin = create(:user, role: 1)

      visit '/login'
      fill_in "user[name]", with: admin.name
      fill_in "user[password]", with: admin.password
      click_on("Log in")

      expect(page).to have_content('Admin Dashboard')
    end
  end
end
