class AddVendorIdToItem < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :vendor, foreign_key: true
  end
end
