# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ShippedItem.delete_all
Item.delete_all
Shipment.delete_all

p 'running seed'
items = []
4.times do
  items << (Item.create!(name: Faker::Appliance.unique.equipment, quantity: 10))
end

shipments = []
3.times do
  shipments << Shipment.create!
end

items[2..3].each do |item|
  ShippedItem.create(item: item, quantity: 5, shipment: shipments[0])
end

items[2..3].each do |item|
  ShippedItem.create(item: item, quantity: 1, shipment: shipments[2])
end

shipments[2].shipped!

Faker::Appliance.unique.clear

p 'seeding complete'
