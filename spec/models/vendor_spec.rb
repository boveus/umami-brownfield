require 'rails_helper'

RSpec.describe Vendor, type: :model do
  context "Instance Methods" do
    it "#unique_orders" do
      user = create(:user)
      order = create(:order, user: user)
      order2 = create(:order, user: user)
      vendor = create(:vendor)
      vendor2 = create(:vendor)
      item = create(:item, vendor_id: vendor.id)
      item2 = create(:item, vendor_id: vendor2.id)
      2.times do
        order.items << item
        order.items << item2
      end
      2.times do
        order2.items << item2
      end

      orders = vendor.unique_orders
      binding.pry
      expect(orders.count).to eq(1)
      expect(orders.first.id).to eq(order.id)
    end
  end
end
