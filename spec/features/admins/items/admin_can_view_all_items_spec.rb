require 'rails_helper'

RSpec.feature "admin can view all items" do
  xscenario "from admin dashboard" do
    admin = create(:user, role: 1)
    visit root_path
    click_on("Login")
    fill_in "user[name]", with: admin.name
    fill_in "user[password]", with: "Password"
    click_on("Log in")
    item = create(:item)

    visit "/admin/dashboard"
    click_on "View All Items"

    expect(current_path).to eq("/admin/items")
    expect(page).to have_content(item.name)
    expect(page).to have_content(item.description)
    expect(page).to have_content(item.status)

    click_on("Edit")

    expect(current_path).to eq(edit_admin_item_path(Item.find_by(name: item.name)))
  end
end
