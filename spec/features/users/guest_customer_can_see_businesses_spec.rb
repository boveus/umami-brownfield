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
end
