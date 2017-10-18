require 'rails_helper'

feature "business manager logs in" do
  it "and it redirects them to their dashboard and only shows their business" do
    user = create(:business_manager_user)
    vendor = create_list(:vendor, 5)

    visit root_path
    click_on("Login")
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: "Password"
    click_on("Log in")

    expect(page).to have_link("Generic_Vendor_1")
    expect(page).to_not have_link("Generic_Vendor_2")
    expect(page).to_not have_link("Generic_Vendor_3")
    expect(page).to_not have_link("Generic_Vendor_4")
    expect(page).to_not have_link("Generic_Vendor_5")
    end
  end
