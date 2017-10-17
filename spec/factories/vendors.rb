FactoryGirl.define do
  factory :vendor do
    sequence(:name) { |n| "Generic_Vendor_#{n}" }
  end
end
