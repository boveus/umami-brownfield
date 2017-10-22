require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of :name}
  it {should validate_presence_of :email}
  it {should validate_presence_of :address}
  it {should validate_presence_of :password}
  it {should validate_uniqueness_of :name}
  it {should validate_uniqueness_of :email}
  describe "Class methods" do
    it "returns a user's highest role or default if user has no role" do
      user = create(:user)
      user2 = create(:user)
      user3 = create(:user)
      bus_man = Role.create(name: "business_manager", permission_level: 3)
      reg_man = Role.create(name: "registered_user", permission_level: 2)
      plat_man = Role.create(name: "platform_manager", permission_level: 5)
      user.roles << bus_man << reg_man
      user2.roles << reg_man << bus_man << plat_man


      expect(user.top_level_role).to eq("business_manager")
      expect(user2.top_level_role).to eq("platform_manager")
      expect(user3.top_level_role).to eq("default")
    end
  end
end
