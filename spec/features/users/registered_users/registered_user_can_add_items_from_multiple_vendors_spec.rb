require 'rails_helper'

feature "As an registered user" do
  scenario "user can add items from multiple vendors to the cart" do
    user1 = create(:user)
    vendor1 = create(:vendor)
    vendor2 = create(:vendor)

    # As a registered customer
    # When I visit the root path
    visit '/'

    # And I click on a business
    within(:css, "vendor_Generic") do
      click_on "Generic_Vendor_1"
    end
    # And I add items to my cart

    click_on("add_shopping_cart")

    # And I visit the root path again
    visit '/'

    # And I visit a different business
    within(:css, "vendor_Generic") do
      click_on "Generic_Vendor_2"
    end

    # And I add items to my cart
    click_on("add_shopping_cart")

    # And I click on the Cart Icon in the navbar
    click_on("shopping_cart")

    # And I click checkout
    click_on("Checkout")

    # I see the order has been created
    expect(page).to have_css(".order", count: 1)

    # I see a list of the items that were purchased
    click_on(class: 'order')

    # I see order status as ordered
    expect(page).to have_content("Order Status: ordered")

    # I see the order total
    expect(page).to have_content("Order Total: $5.00")

  end
end
