require 'rails_helper'

feature "business admin logs in" do
  it "and they can view and modify the vendors information" do
    user = create(:user)
    user.roles << Role.create(name: "business_admin", permission_level: 4)
    user_vendor = create(:vendor)
    user.update(vendor: user_vendor)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Business Admin Dashboard")
    expect(page).to have_content(user_vendor.name)

    click_on(user_vendor.name)

    expect(current_path).to eq(vendor_path(user_vendor))

    click_on "Edit Vendor Info"

    expect(current_path).to eq(edit_vendor_path(user_vendor))

    fill_in "vendor[name]", with: "Salty Bob's Bitter Stuff Stand"
    fill_in "vendor[image]", with: "https://usercontent1.hubstatic.com/12507408_f520.jpg"
    fill_in "vendor[description]", with: "Country Boy Will Survive. Pass me a Busch!"

    click_on "Update"

    expect(current_path).to eq(vendor_path(user_vendor))

    expect(page).to have_content("Salty Bob's Bitter Stuff Stand")
    expect(page).to have_css("#image")
    expect(page).to have_content("Country Boy Will Survive. Pass me a Busch!")
  end
end
