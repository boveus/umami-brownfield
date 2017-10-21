require 'rails_helper'

feature "user can see a list of vendors at root" do
  scenario "user can see the users" do
    user = create(:user)
    vendor = create_list(:vendor, 5)

    visit root_path

    expect(page).to have_link(Vendor.first.name.titleize)
    expect(page).to have_link(Vendor.second.name.titleize)
    expect(page).to have_link(Vendor.third.name.titleize)
    expect(page).to have_link(Vendor.fourth.name.titleize)
    expect(page).to have_link(Vendor.fifth.name.titleize)
    end
  end
