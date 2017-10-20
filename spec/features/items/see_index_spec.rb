require 'rails_helper'


xfeature "As an unathenticated user" do
  scenario "sees all items" do

  3.times do
    create(:item)
  end

  visit items_path

  expect(page).to have_content(Item.first.name)

  end
end
