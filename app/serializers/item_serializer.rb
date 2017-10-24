class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price 

  def price
    (object.price.to_f)/100
  end
end
