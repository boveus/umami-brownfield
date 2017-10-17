require 'rails_helper'

feature 'Admin' do
  context 'views single order' do
    scenario 'can see all order info' do
      admin = create(:user, role: 1)
      user = create(:user)
      order = create(:order, user: user)
      order.items = create_list(:item, 5)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_order_path(order)

      expect(page).to have_content(order.created_at.strftime('%a %b %e %Y %H:%M'))
      expect(page).to have_content(order.user.name)
      expect(page).to have_content(order.user.address)
      expect(page).to have_content(order.get_quantity(order.items.first.id))
      expect(page).to have_content("$0.05")
      expect(page).to have_content(order.status)
    end
  end
end
