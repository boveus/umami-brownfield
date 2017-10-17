class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order

  before_create :item_price_at_order

  def item_price_at_order
    self.item_price_record = item.price
  end

end
