require 'rails_helper'

xfeature "A user visits the item index" do
  context "and clicks on an item name" do
    scenario "and sees the show page for that item" do
      item = create(:item)

      visit items_path

      click_on(item.name)

      expect(page).to have_content(item.description)
      expect(page).to have_content(item.status.titleize)
    end
  end
end
