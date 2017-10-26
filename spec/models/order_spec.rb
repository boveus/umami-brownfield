require 'rails_helper'

RSpec.describe Order, type: :model do
  it {should validate_presence_of :user}
  # it {should validate_presence_of :items}
  describe "Enum" do
    it "has default status of ordered" do
      user = create(:user)
      order = create(:order, user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(:user)

      expect(order.status).to eq('ordered')
      order.paid!
      expect(order.status).to eq('paid')
    end

    it "can change status" do
      user = create(:user)
      order = create(:order, user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(:user)

      expect(order.status).to eq('ordered')
      order.paid!
      expect(order.status).to eq('paid')
    end

    it "can change status again" do
      user = create(:user)
      order = create(:order, user: user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(:user)

      expect(order.status).to eq('ordered')
      order.paid!
      expect(order.status).to eq('paid')
      order.completed!
      expect(order.status).to eq('completed')
    end

  end

  describe "Instance Methods" do
    it '#total_price' do
      user = create(:user)
      order = create(:order, user: user)
      item_list = create_list(:item, 3)
      # tag.items << item_list
      order.items << item_list
      expect(order.total_price).to eq(0.15)
    end

    it '#get_quantity' do
      user = create(:user)
      order = create(:order, user: user)
      item_list = create_list(:item, 5)
      order.items << item_list

      expect(order.get_quantity(order.id)).to eq(1)
    end

    it '#get_item_total' do
      user = create(:user)
      order = create(:order, user: user)
      item_list = create_list(:item, 5)
      order.items << item_list

      expect(order.get_item_total(order.items.first.id)).to eq(0.05)
    end
  end
end
