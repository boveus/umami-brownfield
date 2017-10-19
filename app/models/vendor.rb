class Vendor < ApplicationRecord
  validates_presence_of :slug

  has_many :items
end
