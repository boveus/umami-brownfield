class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :status

  has_many :orders
  has_many :tags

  def price
    (object.price.to_f)/100
  end
end
