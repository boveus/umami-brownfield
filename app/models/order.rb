class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :items, through: :order_items

  validates :user, presence: true
  # scope :status, -> (status) { where status: status }
  # validates :items, presence: true
  enum status: [:ordered, :paid, :cancelled, :completed]

  def total_price
    "$#{Money.new(items.sum(:price))}"
  end

  def get_quantity(id)
    items.where(id: id).count
  end

  def get_item_total(item_id)
    "$#{Money.new((get_quantity(item_id) * items.find(item_id).price))}"
  end

  def total_quantity
    items.count
  end

  def self.get_status_count
    group(:status).count
  end

  def item_total_when_ordered(item_id)
    get_quantity(item_id) * order_items.find_by(item_id: item_id).item_price_record
  end

  def total_price_when_ordered
    order_items.sum(:item_price_record)
  end
end
