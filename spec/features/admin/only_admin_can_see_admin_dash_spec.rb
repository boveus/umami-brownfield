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

  context 'as a regular user' do
    scenario "can't see admin dashboard" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit admin_dashboard_path

      expect(page).to_not have_content('Admin Dashboard')
    end
  end
end
