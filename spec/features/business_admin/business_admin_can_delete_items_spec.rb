require 'rails_helper'

feature "business admin logs in" do
  context "and they click on edit an item" do
    it "takes them to an item edit page and lets them update items for their business" do
      user = create(:user)
      user.roles << Role.create(name: "business_admin", permission_level: 4)
      user_vendor = create(:vendor)
      user.update(vendor: user_vendor)
      vendor = create_list(:vendor, 5)
      user_vendor.items << create_list(:item, 5)
      item_name = user_vendor.items.first.name

      visit root_path

      click_on("Login")
      fill_in "user[name]", with: user.name
      fill_in "user[password]", with: "Password"
      click_on("Log in")

      click_on user_vendor.name

      click_on "View Items"

      click_on "delete_item_1"

      expect(page).to_not have_content("#{item_name}")

      expect(current_path).to eq(vendor_items_path(user_vendor))
    end
  end
end
