class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :email
end
