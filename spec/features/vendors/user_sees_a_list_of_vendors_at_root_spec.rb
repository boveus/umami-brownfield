require 'rails_helper'

feature "user can see a list of vendors at root" do
  scenario "user can see the users" do
    user = create(:user)
    vendor = create_list(:vendor, 5)

    visit root_path

    expect(page).to have_link("Generic_Vendor_1")
    expect(page).to have_link("Generic_Vendor_2")
    expect(page).to have_link("Generic_Vendor_3")
    expect(page).to have_link("Generic_Vendor_4")
    expect(page).to have_link("Generic_Vendor_5")
    end
  end
