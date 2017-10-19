require 'rails_helper'

RSpec.feature "A a guest user(customer)" do
  scenario "sees photos and names of businesses" do
    vendor = create(:vendor)
    vendors = create_list(:vendor, 2)

    items = create_list(:item, 3, vendor_id: vendor.id)
    
    visit '/'


    expect(page).to have_content(vendors[0].name)
    expect(page).to have_content(vendors[1].name)
    expect(page).to have_content(vendor.name)

    click_link vendor.name.titleize

    expect(current_path).to eq("/#{vendor.slug}/items") 
  end

  scenario "can add items from multiple businesses into a single cart" do
    vendors = create_list(:vendor, 3)
    items1 = create_list(:item, 3, vendor_id: vendors[0].id)
    items2 = create_list(:item, 3, vendor_id: vendors[1].id)
    items3 = create_list(:item, 3, vendor_id: vendors[2].id)

    visit '/'

    click_on vendors[0].name.titleize
    click_on("add_shopping_cart", match: :first)

    visit '/'

    click_on vendors[1].name.titleize
    click_on("add_shopping_cart", match: :first)

    visit '/'

    click_on vendors[2].name.titleize
    click_on("add_shopping_cart", match: :first)

    expect(page).to have_css(".order", count: 1)

    click_on(class: 'order_date')
    
    expect(page).to have_content("Order Status: ordered")
    expect(page).to have_content("0.05")
    expect(page).to have_content("Order Total: $0.15")
  end
end
