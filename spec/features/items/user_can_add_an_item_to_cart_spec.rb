feature "As a user visiting the site" do
  context "and clicks on the add to cart button" do
    scenario "the item is added to the cart" do
      item1 = create(:item)

      visit items_path

      click_on("add_shopping_cart")

      expect(page).to have_content("You now have 1 #{item1.name}.")
    end
  end
  context "and adds items to the cart" do
    scenario "visits cart and sees items" do
      item1 = create(:item)

      visit items_path

      click_on("add_shopping_cart")

      expect(page).to have_content("You now have 1 #{item1.name}.")

      click_on("shopping_cart")

      expect(current_path).to eq('/cart')

      expect(page).to have_content(item1.name)
      expect(page).to have_content(Money.new(item1.price, "USD"))

      expect(page).to have_content("Order Total:")

    end
  end
end
