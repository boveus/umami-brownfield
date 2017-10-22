require 'rails_helper'

RSpec.feature "A registered user" do
  scenario "can view order history" do
    user = create(:user)
    orders = create_list(:order, 3, user_id: user.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    
    visit '/'

    find(:css, ".dropdown-content").click_on("Orders")

    expect(current_path).to eq("/orders")
    expect(page).to have_content(orders[0].status)
    expect(page).to have_content(orders[1].status)
    expect(page).to have_css("tbody tr", count: 3)
  end
end
