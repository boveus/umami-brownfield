require 'rails_helper'

feature "As an admin user" do
  context "when I visit admin dashboard" do
    scenario "I can see all orders" do
      admin = create(:user, role: 1)
      user = create(:user)
      user2 = create(:user)
      order1, order2 = create_list(:order, 2, user: user)
      order3 = create(:order, user: user2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      expect(page).to have_content(user.name)
      expect(page).to have_content(user2.name)
      expect(page).to have_content(order1.status)
      expect(page).to have_content(order2.status)
      expect(page).to have_content(order3.status)
      expect(page).to have_content("There are 3 orders with the status ordered")
    end
    
    scenario "I can filter orders by status" do
      admin = create(:user, role: 1)
      user = create(:user)
      user2 = create(:user)
      order1, order2 = create_list(:order, 2, user: user)
      order3 = create(:order, user: user2, status: "paid")
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_dashboard_path

      expect(page).to have_content(order3.status)
      expect(page).to have_content(user2.name)

      click_on("Ordered")

      expect(page).to_not have_content(user2.name)
      expect(page).to have_content(user.name)
      expect(page).to have_content(order1.status)
      expect(page).to have_content(order2.status)
    end
  end
end
