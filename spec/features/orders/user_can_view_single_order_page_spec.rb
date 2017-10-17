require 'rails_helper'

RSpec.feature "user can view single order" do
  scenario "from orders page" do
    user = create(:user)
    visit root_path
    click_on("Login")
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: "Password"
    click_on("Log in")

    order = create(:order, user: user)
    item = create(:item)
    item2 = create(:item)
    2.times do
      order.items << item
    end
    order.items << item2
    visit orders_path

    click_on order.created_at.strftime('%a %b %e %Y %H:%M')

    expect(current_path).to eq(order_path(order))
    expect(page).to have_content(item.name)
    expect(page).to have_content(item.description)
    expect(page).to have_content("$0.05")
    expect(page).to have_content(order.status)
    expect(page).to have_content(item.description)
    expect(page).to have_content(order.created_at.strftime('%a %b %e %Y %H:%M'))
    expect(page).to have_content("$0.15")
  end
end
