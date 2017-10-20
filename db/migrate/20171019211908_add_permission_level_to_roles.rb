class AddPermissionLevelToRoles < ActiveRecord::Migration[5.1]
  def change
    add_column :roles, :permission_level, :integer
  end
end
