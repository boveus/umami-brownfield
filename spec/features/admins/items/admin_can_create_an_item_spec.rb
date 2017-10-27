require 'rails_helper'

RSpec.feature "admin can create an item" do


  scenario "without admin rights" do
    visit root_path

    expect(page).to_not have_content("Create New Item")

    expect{ visit new_admin_item_path }.to raise_error(ActionController::RoutingError)
  end

  scenario "without all item information" do
    admin = create(:user, role: 1)
    visit root_path
    click_on("Login")
    fill_in "user[name]", with: admin.name
    fill_in "user[password]", with: "Password"
    click_on("Log in")
    tag = create(:tag)
    item = build(:item)

    expect(page).to have_content("Create New Item")

    click_on("Create New Item")

    expect(current_path).to eq new_admin_item_path

    fill_in "item[description]", with: item.description
    fill_in "item[price]", with: item.price
    fill_in "item[image]", with: item.image
    check "#{tag.name}"
    within("p") do
      click_on("Create")
    end

    expect(current_path).to eq(admin_items_path)
    expect(page).to have_content("Name can't be blank")
  end

  scenario "without unique name" do
    admin = create(:user, role: 1)
    visit root_path
    click_on("Login")
    fill_in "user[name]", with: admin.name
    fill_in "user[password]", with: "Password"
    click_on("Log in")
    tag = create(:tag)
    item1 = build(:item)
    item2 = create(:item, name: "Saltysalt")

    expect(page).to have_content("Create New Item")

    click_on("Create New Item")

    expect(current_path).to eq new_admin_item_path

    fill_in "item[name]", with: "Saltysalt"
    fill_in "item[description]", with: item1.description
    fill_in "item[price]", with: item1.price
    fill_in "item[image]", with: item1.image
    check "#{tag.name}"
    within("p") do
      click_on("Create")
    end

    expect(current_path).to eq(admin_items_path)
    expect(page).to have_content("Name has already been taken")
  end

  scenario "without unique description" do
    admin = create(:user, role: 1)
    visit root_path
    click_on("Login")
    fill_in "user[name]", with: admin.name
    fill_in "user[password]", with: "Password"
    click_on("Log in")
    tag = create(:tag)
    item1 = build(:item)
    item2 = create(:item, description: "Saltysalt")

    expect(page).to have_content("Create New Item")

    click_on("Create New Item")

    expect(current_path).to eq new_admin_item_path

    fill_in "item[name]", with: item1.name
    fill_in "item[description]", with: "Saltysalt"
    fill_in "item[price]", with: item1.price
    fill_in "item[image]", with: item1.image
    check "#{tag.name}"
    within("p") do
      click_on("Create")
    end

    expect(current_path).to eq(admin_items_path)
    expect(page).to have_content("Description has already been taken")
  end
end
