require 'rails_helper'

feature "As an registered user" do
  scenario "user can add items from multiple vendors to the cart" do
    user1 = create(:user)
    vendor1 = create(:vendor)
    vendor2 = create(:vendor)

    binding.pry
    # As a registered customer
    # When I visit the root path
    visit '/'

    # And I click on a business
    within(:css, "") do
      click_on "Generic_Vendor_1"
    end
    # And I add items to my cart

    click_on("add_shopping_cart")

    # And I visit a different business
    visit '/'
    click_on "Generic_Vendor_2"

    # And I add items to my cart
    click_on
    # And I click checkout
    # I see the order has been created
    # I see a list of the items that were purchased
    # I see order status as ordered
    # I see the order total



  end
end
