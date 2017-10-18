class AddSlugToVendors < ActiveRecord::Migration[5.1]
  def change
    add_column :vendors, :slug, :string
  end
end
