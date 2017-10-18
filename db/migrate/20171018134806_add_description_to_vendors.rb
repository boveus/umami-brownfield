class AddDescriptionToVendors < ActiveRecord::Migration[5.1]
  def change
    add_column :vendors, :description, :string
  end
end
