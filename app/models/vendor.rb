class Vendor < ApplicationRecord
  has_many :users
  validates_presence_of :slug
  

  has_many :items
  has_many :orders, through: :items
  
  enum status: [:online, :offline]
  
  scope :online, -> { where(status: "online")}

  def all_business_managers
    users.select('users.*')
      .joins(:roles)
      .where('roles.permission_level = 3')
  end

  def unique_orders
    orders.uniq
  end
end
