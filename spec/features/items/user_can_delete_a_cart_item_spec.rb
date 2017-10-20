xfeature "Visitor adds items to cart" do
  context "clicks on remove item" do
    scenario "item is removed from cart" do
      item1 = create(:item)

      visit items_path

      click_on("add_shopping_cart")

      click_on("shopping_cart")

      expect(page).to have_content(Money.new(item1.price, "USD"))

      click_on("Remove")

      expect(page).to_not have_content(item1.price)
    end
  end
end
