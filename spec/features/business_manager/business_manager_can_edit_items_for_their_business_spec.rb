require 'rails_helper'

feature "business manager logs in" do
  context "and they click on edit an item" do
    it "takes them to an item edit page and lets them update items for their business" do
      user = create(:user)
      user.roles << Role.create(name: "business_manager", permission_level: 3)
      user_vendor = create(:vendor)
      user.update(vendor: user_vendor)
      vendor = create_list(:vendor, 5)
      user_vendor.items << create_list(:item, 5)

      visit root_path

      click_on("Login")
      fill_in "user[name]", with: user.name
      fill_in "user[password]", with: "Password"
      click_on("Log in")

      click_on "#{user_vendor.name}"

      click_on "View Items"

      click_on "edit_item_1"

      fill_in "item[name]", with: "New_name"
      fill_in "item[price]", with: "3.50"
      fill_in "item[description]", with: "This item costs three fifty"

      click_on "Update Item"

      expect(current_path).to eq(item_path(user_vendor.items.first))
    end
  end
end
