require 'rails_helper'

feature 'Admin' do
  scenario 'cannont modify any other users data' do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit dashboard_path

    expect(page).to have_content('Admin Dashboard')
  end

  scenario 'cannot view User page' do
    admin = create(:user, role: 1)
    user  = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit users_path(user)

    expect(current_path).to_not eq(dashboard_path)
  end
end
