require 'rails_helper'

feature "business admin logs in" do
  it "and they add a new item" do
    user = create(:user)
    user.roles << Role.create(name: "business_admin", permission_level: 4)
    user_vendor = create(:vendor, name: "AdminBatman")
    user.update(vendor: user_vendor)
    vendor = create_list(:vendor, 5)
    user_vendor.items << create_list(:item, 5)
    item_name = user_vendor.items.first.name

    visit root_path

    click_on("Login")
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: "Password"
    click_on("Log in")

    click_on "AdminBatman"

    click_on "View Items"

    click_on "Add New Item"
    # I should be taken to a page to fill create a new item with attributes for my business

    expect(current_path).to eq(new_vendor_item_path(user_vendor))

    # After I fill in the item's attributes
    fill_in "item[name]", with: "New_name"
    fill_in "item[price]", with: "350"
    fill_in "item[description]", with: "This item costs three fifty"

    # And I click on 'submit'
    click_on "Create Item"

    # I should be taken to the item's show page
    expect(current_path).to eq(item_path(user_vendor.items.last))

    # And the item should be added to my main page
    expect(page).to have_content("New_name")
    expect(page).to have_content("3.50")
    expect(page).to have_content("This item costs three fifty")
    #And when I visit user dashboard I see the item as well

    visit dashboard_path
    click_on "AdminBatman"
    click_on "View Items"

    expect(page).to have_content("New_name")
  end
end
