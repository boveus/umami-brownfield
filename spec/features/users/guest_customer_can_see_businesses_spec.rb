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

    click_on("shopping_cart")

    expect(page).to have_css("tbody tr", count: 4)
    expect(page).to have_link('Login or Create Account to Checkout')
    expect(page).to have_content("0.05")
    expect(page).to have_content("Order Total: $0.15")
    expect(page).to have_link(vendors[0].name)
    expect(page).to have_link(vendors[1].name)
    expect(page).to have_link(vendors[2].name)
  end

  scenario "can create account before completing checkout" do
    vendor = create(:vendor)
    items = create_list(:item, 3, vendor_id: vendor.id)

    visit '/'

    click_on vendor.name.titleize
    click_on("add_shopping_cart", match: :first)

    click_on("shopping_cart")

    expect(current_path).to eq("/cart")

    click_on("Login or Create Account to Checkout")

    expect(current_path).to eq("/login")

    click_on("Create Account")

    expect(current_path).to eq("/users/new")

    fill_in "Name", with: "Walter"
    fill_in "Email", with: "worthyadversary@thedude.com"
    fill_in "Address", with: "123 Street Blvd, City, ST 12345"
    fill_in "Password", with: "therearerules"

    click_on "Create"

    expect(current_path).to eq("/dashboard") 
    expect(page).to have_content("Walter")
    expect(page).to have_content("worthyadversary@thedude.com")
    expect(page).to have_content("123 Street Blvd, City, ST 12345")

    click_on("shopping_cart")

    click_on("Checkout")

    expect(current_path).to eq("/orders")
    expect(page).to have_css("tbody tr", count: 1)
    expect(page).to have_content("ordered")
  end

  scenario "can login before completing checkout" do
    user = create(:user)
    vendor = create(:vendor)
    items = create_list(:item, 3, vendor_id: vendor.id)

    visit '/'

    click_on vendor.name.titleize
    click_on("add_shopping_cart", match: :first)

    click_on("shopping_cart")

    expect(current_path).to eq("/cart")

    click_on("Login or Create Account to Checkout")

    expect(current_path).to eq("/login")

    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: "Password" 

    click_on("Log in")

    expect(current_path).to eq("/dashboard")
    expect(page).to have_content("user.name")
    expect(page).to have_content("user.email")

    click_on("shopping_cart")

    expect(current_path).to eq("/cart")

    click_on("Checkout")

    expect(current_path).to eq("/orders")
    expect(page).to have_css("tbody tr", count: 1)
    expect(page).to have_content("ordered")
  end
end
