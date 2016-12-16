# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Promotion.destroy_all
User.destroy_all
Role.destroy_all
Product.destroy_all
Notification.destroy_all
Beacon.destroy_all
Order.destroy_all
HistoricalEvent.destroy_all


5.times do |i|
  Promotion.create!(title: "Promotion ##{i}", description: "A Promotion.", code: "promo#{i}")
  Product.create!(featured: false, cost: "#{100 * i}", title: "product-#{i}", description: "This is product ##{i}")
  User.create!(email: "user-#{i}@paulsens.com", password: "password-#{i}")
  beacon = Beacon.create!(title: "Beacon-#{i}", description: "This is beacon ##{i}")

  5.times do |i_2|
    beacon.notifications.create!(title: "Notification-#{i_2}", description: "This is notification ##{i_2}")
  end
end
