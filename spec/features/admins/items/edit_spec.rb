
require 'rails_helper'

RSpec.feature "admin can go to edit an item" do
  scenario "and update that item" do
    admin = create(:user, role: 1)
    visit root_path
    click_on("Login")
    fill_in "user[name]", with: admin.name
    fill_in "user[password]", with: "Password"
    click_on("Log in")
    item = create(:item)
    tag = create(:tag)

    visit "/admin/dashboard"
    click_on "View All Items"

    expect(current_path).to eq("/admin/items")
    expect(page).to have_content(item.name)
    expect(page).to have_content(item.description)
    expect(page).to have_content(item.status)

    click_on("Edit")

    expect(current_path).to eq(edit_admin_item_path(Item.find_by(name: item.name)))

    fill_in "item[name]", with: item.name
    fill_in "item[description]", with: item.description
    fill_in "item[price]", with: item.price
    fill_in "item[image]", with: item.image
    check "#{tag.name}"
    within("p") do
      click_on("Update")
    end

    expect(current_path).to eq(item_path(Item.find_by(name: item.name)))
    expect(page).to have_content("#{item.name} updated")
    expect(page).to have_content(tag.name.titleize)
  end
end
