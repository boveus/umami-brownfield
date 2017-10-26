class Vendor < ApplicationRecord
  has_many :users
  validates_presence_of :slug
  

  has_many :items
  has_many :orders, through: :items
  
  enum status: [:online, :offline]
  
  scope :online, -> { where(status: "online")}

  def unique_orders
    orders.uniq
  end
end
