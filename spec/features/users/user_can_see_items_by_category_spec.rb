require 'rails_helper'

RSpec.feature "user can see items by category" do
  scenario "from main page" do
    tag1, tag2, tag3, tag4 = create_list(:tag, 4)
    item1, item2, item3, item4 = create_list(:item, 4)
    item1.tags << tag1
    item2.tags << [tag1, tag2]
    item3.tags << tag4
    item4.tags << tag3

    visit("/#{tag1.name}")

    expect(page).to have_content(item1.name)
    expect(page).to have_content(item2.name)

    visit("/#{tag2.name}")

    expect(page).to have_content(item2.name)

    expect(page).to_not have_content(item1.name)

    visit("/#{tag3.name}")

    expect(page).to have_content(item4.name)

    visit("/#{tag4.name}")

    expect(page).to have_content(item3.name)
  end
end
