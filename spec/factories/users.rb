FactoryGirl.define do
  factory :user do
    sequence :name do |i|
      "Name#{i}"
    end
    sequence :email do |i|
      "Me@#{i}"
    end
    address "MyString"
    role = 0
    password "Password"

  factory :business_manager_user do
    sequence :name do |i|
      "Name#{i}"
    end
    sequence :email do |i|
      "Me@#{i}"
    end
    address "MyString"
    password "Password"
    # store FactoryGirl.create(:store)
      after(:create) do |user|
        user.roles << Role.find_or_create_by(name: 'business_manager')
      end
    end
  end
end
