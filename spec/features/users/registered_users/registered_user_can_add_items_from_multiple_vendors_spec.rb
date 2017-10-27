require 'rails_helper'

feature "As an registered user" do
  scenario "user can add items from multiple vendors to the cart" do
    user1 = create(:user, role: 0)
    user1.roles << Role.create(name: "registered_user", permission_level: 2)
    vendor1 = create(:vendor)
    item1 = create(:item, vendor_id: vendor1.id)
    vendor2 = create(:vendor)
    item2 = create(:item, vendor_id: vendor2.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit '/'

    click_on vendor1.name.titleize
    click_on("add_shopping_cart")

    visit '/'
    click_on vendor2.name.titleize
    click_on("add_shopping_cart")

    click_on("shopping_cart")
    click_on("Checkout")

    expect(page).to have_css(".order", count: 1)

    click_on(class: 'order_date')

    expect(page).to have_content("Order Status: ordered")
    expect(page).to have_content("$0.05")
    expect(page).to have_content("Order Total: $0.10")
  end
end
