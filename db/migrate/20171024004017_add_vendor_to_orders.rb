class AddVendorToOrders < ActiveRecord::Migration[5.1]
  def change
    add_reference :users, :vendor, foreign_key: true
  end
end
