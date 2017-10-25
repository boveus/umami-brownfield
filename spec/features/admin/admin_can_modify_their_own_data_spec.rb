require 'rails_helper'

xfeature 'Admin' do
  scenario 'can edit their own information' do
    admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit edit_admin_user_path(admin)

    fill_in('Name', with: 'Godspeed')
    fill_in('Password', with: '123')
    click_on('Update')
    
    expect(admin.name).to eq('Godspeed')
    expect(current_path).to eq(admin_dashboard_path)
  end
end