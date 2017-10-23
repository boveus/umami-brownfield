require 'rails_helper'

RSpec.feature "As an authenticated user" do
  scenario "cannot visit another user's page'" do

    user1 = create(:user)
    visit root_path
    click_on("Login")
    fill_in "user[name]", with: user1.name
    fill_in "user[password]", with: "Password"
    click_on("Log in")

    order = create(:order, user: user1)
    user2 = create(:user)
    create(:order, user: user2)

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as #{user1.name}")
    expect(page).to have_content("Logout")
    expect(page).to_not have_content("Login")

    visit "/orders/#{user2.orders.last.id}"

    expect(page).to have_content("The page you were looking for doesn't exist")
  end
  
  scenario "cannot visit admin pages" do
    user1 = build(:user)

    visit root_path
    click_on("Login")

    expect(page).to have_content("Create Account")

    click_on("Create")

    fill_in "user[name]", with: user1.name
    fill_in "user[email]", with: user1.email
    fill_in "user[address]", with: user1.address
    fill_in "user[password]", with: user1.password
    click_on("Create")

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Logged in as #{user1.name}")
    expect(page).to have_content("Logout")
    expect(page).to_not have_content("Login")

    visit '/admin/dashboard'

    expect(page).to have_content("The page you were looking for doesn't exist")
  end
end
