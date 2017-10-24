require 'rails_helper'

feature "business manager logs in" do
  it "and they can view and modify the status of orders for the business they manage" do
    user = create(:user)
    user2 = create(:user)
    user.roles << Role.create(name: "business_manager", permission_level: 3)
    user_vendor = create(:vendor)
    user.update(vendor: user_vendor)
    vendors = create_list(:vendor, 5)

    order1, order2 = create_list(:order, 2, user: user, vendor: vendors.first)
    order3 = create(:order, user: user2, status: "paid", vendor: user_vendor)

    visit root_path

    click_on("Login")
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: "Password"
    click_on("Log in")

    click_on "View Orders"

    expect(page).to have_content(order3.user.name)
    expect(page).to not_have_content(order1.user.name)

    click_on('cancel order', match: :first)
    expect(page).to not_have_link('cancel order')
    

  end
end
