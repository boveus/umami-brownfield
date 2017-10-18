class Vendor < ApplicationRecord
  has_many :users
  validates_presence_of :slug

  has_many :items
end
