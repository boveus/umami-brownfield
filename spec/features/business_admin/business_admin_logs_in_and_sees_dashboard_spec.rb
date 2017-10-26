require 'rails_helper'

feature "business admin logs in" do
  it "and it redirects them to their dashboard and only shows their business" do
    user = create(:user)
    user.roles << Role.create(name: "business_admin", permission_level: 4)
    user_vendor = create(:vendor)
    user.update(vendor: user_vendor)
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

# When I log in to my dashboard
# I should see the business admin dashboard
# and when I click on the business' individual page
# I should see a button to edit the business information for each business
# when i click on the edit button i should be taken to a page to edit the business inFO
