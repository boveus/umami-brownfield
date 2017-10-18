class AddVendorToUsers < ActiveRecord::Migration[5.1]
  def change
    add_reference :vendors, :user, index: true
  end
end
