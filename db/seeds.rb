# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

Item.destroy_all
Tag.destroy_all
Vendor.destroy_all
User.destroy_all
Order.destroy_all

items = CSV.foreach "./db/items.csv", headers: true, header_converters: :symbol


#create vendors
20.times do
  VendorCreator.new(Faker::Company.unique.name, Faker::Company.logo, Faker::Lorem.paragraph(1)).execute
end

items.each do |row|
  row = row.to_h
  row[:status] = row[:status].to_i
  item = Item.new(row)
  item.vendor_id = Vendor.all.sample.id
  item.save
end

460.times do
  Item.create!(price: rand(500..1000), image: (Faker::Placeholdit.image), name: (Faker::Commerce.product_name + rand(1..1000).to_s), description: Faker::Lorem.paragraph(1), vendor_id: Vendor.all.sample.id)
end

 Tag.create!(name: "Infused")
 Tag.create!(name: "Black")
 Tag.create!(name: "Red")
 Tag.create!(name: "Pink")
 Tag.create!(name: "Flake")
 Tag.create!(name: "Coarse")
 Tag.create!(name: "Fine")
 Tag.create!(name: "accessories")
 Tag.create!(name: "salt")

 20.times do
  Tag.create!(name: Faker::Address.unique.country)
 end
 
 user_collection = User.all
 item_collection = Item.all

 1000.times do
   User.create!(name: Faker::Name.unique.name, address: Faker::Address.street_address, email: Faker::Internet.email, password: "123")
   puts "Ding #{User.all.count}"
   10.times do
     Order.create!(user_id: user_collection.sample.id, items: (item_collection.sample(rand(1..4))) )
   end
 end

 tag_collection = Tag.all
 order_collection = Order.all
 order_items = OrderItem.all


 item_collection.each do |item|
   item.tags << tag_collection.sample(rand(1..5))
 end


  order_items.each do |order_item|
    order_item.item_price_at_order unless order_item.item_price_record
    order_item.save
  end
