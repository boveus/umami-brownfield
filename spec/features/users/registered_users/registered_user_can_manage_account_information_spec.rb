require 'rails_helper'

feature "As a registered user" do
  scenario "user can edit their personal information" do
    user1 = create(:user, role: 0)
    vendor1 = create(:vendor)
    item1 = create(:item, vendor_id: vendor1.id)
    vendor2 = create(:vendor)
    item2 = create(:item, vendor_id: vendor2.id)
    user_password_hash = user1.password

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit '/dashboard'

    click_on "Your Profile"

    expect(page).to have_content("Username: #{user1.name}")
    expect(page).to have_content("Email: #{user1.email}")
    expect(page).to have_content("Address: #{user1.address}")
    expect(page).to_not have_content(user1.password)

    click_on "Edit Info"

    fill_in "user[name]", with: "Randy BoBanders"
    fill_in "user[email]", with: "Randy@DirtyBandaids.com"
    fill_in "user[address]", with: "123 Dirty Lane, Denver CO 80233"
    fill_in "user[password]", with: "UndustedCoffeeTable"
    click_on("Update")

    expect(page).to have_content("Username: Randy BoBanders")
    expect(page).to have_content("Email: Randy@DirtyBandaids.com")
    expect(page).to have_content("Address: 123 Dirty Lane, Denver CO 80233")
  end
end
