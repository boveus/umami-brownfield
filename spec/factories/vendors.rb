FactoryGirl.define do
  factory :vendor do
    sequence(:name) { |n| "Generic_Vendor_#{n}" }
    image "https://memegenerator.net/img/instances/500x/30330920/i-dont-always-salt-people-but-when-i-do-its-gail-the-snail.jpg"  
    description: "Fight Milk! The first alcoholic dairy based protein drink for bodyguards!"
  end


end
