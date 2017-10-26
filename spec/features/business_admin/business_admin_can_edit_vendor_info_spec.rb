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

  end
end




# When I log in to my dashboard
# I should see an index of all of the businesses I am an admin for
# when I click on the business and view the business' individual page
# I should see a button to edit the business information for each business
# when i click on the edit button i should be taken to a page to edit the business inFO
