require 'rails_helper'

feature "business admin logs in" do
  it "and they can see business manager and change their role" do
    user = create(:user)
    user.roles << Role.create(name: "business_admin", permission_level: 4)
    user_vendor = create(:vendor)
    user.update(vendor: user_vendor)
    users = create_list(:user, 2, vendor_id: user_vendor.id)
    users.each { |user| user.roles << Role.create(name: "business_manager", permission_level: 3) }

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit '/dashboard'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Business Admin Dashboard")
    expect(page).to have_content(user_vendor.name)

    click_on(user_vendor.name)

    expect(current_path).to eq(vendor_path(user_vendor))

    expect(page).to have_content(users[0].name)
    expect(page).to have_content(users[1].name)
  end
end
