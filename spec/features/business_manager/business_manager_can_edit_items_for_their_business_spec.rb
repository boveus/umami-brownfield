require 'rails_helper'

feature "business manager logs in" do
  scenario "and they click on edit an item"
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

    click_on "Generic_Vendor_1"

    click_on("Edit Items")

    expect(page).to have_content(user_vendor.items.first.name)
    expect(page).to have_content(user_vendor.items.first.price)
    expect(page).to have_content(user_vendor.items.first.description)

    fill_in "item[name]", with: "New_name"
    fill_in "item[price]", with: "3.50"
    fill_in "item[description]", with: "This item costs three fifty"

    click_on "update item"

    expect(current_path).to eq(edit_admin_item_path)
    end
  end
