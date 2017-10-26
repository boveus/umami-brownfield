require 'rails_helper'

feature "business manager logs in" do
  #skipping this for the time being, need to be able to ONLY display
  #the orders and items for a single vendor.
  it "and they can view and modify the status of orders for the business they manage" do
    user = create(:user)
    user2 = create(:user)
    user.roles << Role.create(name: "business_manager", permission_level: 3)
    user_vendor = create(:vendor)
    user.update(vendor: user_vendor)
    vendors = create_list(:vendor, 5)

    user_vendor_items = create_list(:item, 30, vendor: user_vendor)
    other_vendor_items = create_list(:item, 30, vendor: vendors.first)
    order1, order2 = create_list(:order, 2, user: user)
    order3 = create(:order, user: user2, status: "paid")
    order1.items << user_vendor_items
    order2.items << user_vendor_items << other_vendor_items
    order3.items << other_vendor_items

    visit root_path

    click_on("Login")
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: "Password"
    click_on("Log in")

    click_on "#{user_vendor.name}"

    click_on "View Orders"

    click_on('cancel order', match: :first)
    expect(page).to_not have_css("order#{order1.id}")

    click_on "Order: #{order2.id}"

    expect(page).to have_content(order1.user.name)
    expect(page).to_not have_content(order3.user.name)
    expect(page).to have_content(order1.items.first.name)
    expect(page).to have_content(order1.items.fourth.name)
  end
end
