require 'rails_helper'

describe "as a platform_manager" do
  describe "when I visit login and log in" do
    it "I should see all businesses, and see a button to take them offliine" do
      user = create(:user)
      user.roles << Role.create(name: "platform_admin", permission_level: 5)
      vendors = create_list(:vendor, 5)
      visit root_path

      click_on("Login")
      fill_in "user[name]", with: user.name
      fill_in "user[password]", with: "Password"
      click_on("Log in")
      
      click_on vendors.first.name
      
      click_on("Take business offline")
      
      click_on("View Items")
      expect(current_path).to eq('/')
      
      
    end
  end
end