require 'rails_helper'

RSpec.feature "user can view single order" do
  scenario "from orders page" do
    user = create(:user)
    user.roles << Role.create(name: "registered_user", permission_level: 2)
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

    increased_price = item2.price + 1

    item2.update(price: increased_price) #as if admin changes price
    item2.save

    click_on order.created_at.strftime('%a %b %e %Y %H:%M')


    expect(page).to have_content(order.total_price_when_ordered)
  end
end
