require 'rails_helper'


feature "As an unathenticated user" do
  scenario "sees all items" do
  vendor = create(:vendor)

  3.times do
    item = create(:item)
    vendor.items << item
  end

  visit items_path

  expect(page).to have_content(Item.first.name)

  end
end
