require 'rails_helper'

feature "business manager logs in" do
  it "and it redirects them to their dashboard and only shows their business" do
    user = create(:user)
    user.roles << Role.create(name: "business_manager")
    user_vendor = create(:vendor)
    user_vendor.users << user
    vendor = create_list(:vendor, 5)


    visit root_path

    click_on("Login")
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: "Password"
    click_on("Log in")

    expect(page).to have_link(user_vendor.name)
    expect(page).to_not have_link(Vendor.second.name)
    expect(page).to_not have_link(Vendor.third.name)
    expect(page).to_not have_link(Vendor.fourth.name)
    expect(page).to_not have_link(Vendor.fifth.name)
    end
  end
