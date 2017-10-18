# As an authenticated Admin: I can create an item.
#
# An item must have a title, description and price.
# An item must belong to at least one category.
# The title and description cannot be empty.
# The title must be unique for all items in the system.
# The price must be a valid decimal numeric value and greater than zero.
# The photo is optional. If not present, a stand-in photo is used. (PAPERCLIP)

require 'rails_helper'

RSpec.feature "admin can create an item" do
  xscenario "from main page" do
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

    fill_in "item[name]", with: item.name
    fill_in "item[description]", with: item.description
    fill_in "item[price]", with: item.price
    fill_in "item[image]", with: item.image
    check "#{tag.name}"
    within("p") do
      click_on("Create")
    end

    expect(current_path).to eq(item_path(Item.find_by(name: item.name)))
    expect(page).to have_content("#{item.name} Created")
    expect(page).to have_content(tag.name.titleize)
  end

  scenario "without admin rights" do
    visit root_path

    expect(page).to_not have_content("Create New Item")

    visit new_admin_item_path

    expect(page).to have_content("404")
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

  xscenario "without image" do
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

    fill_in "item[name]", with: item.name
    fill_in "item[description]", with: item.description
    fill_in "item[price]", with: item.price
    check "#{tag.name}"
    within("p") do
      click_on("Create")
    end

    expect(current_path).to eq(item_path(Item.find_by(name: item.name)))
    expect(page).to have_content("#{item.name} Created")
    expect(page).to have_xpath("//img[@src='http://img.providr.com/n-SALT-628x314.jpg']")
    expect(page).to have_content(tag.name.titleize)
  end
end
