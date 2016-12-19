# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


HistoricalEvent.destroy_all
Notification.destroy_all
Beacon.destroy_all
Product.destroy_all
Promotion.destroy_all
Order.destroy_all
Role.destroy_all
User.destroy_all


5.times do |i|
  HistoricalEvent.create!(title: "Historical Event #{i}", description: "This is an event in history ##{i}.", date: Time.now - i.years)
  promotion = Promotion.create!(title: "Promotion ##{i}", description: "This is promotion ##{i}", code: "promo#{i}")
  product = Product.create!(cost: "#{100 * (i + 1)}", title: "product-#{i}", description: "This is product ##{i}")
  user = User.create!(email: "user-#{i}@paulsens.com", password: "password-#{i}")
  beacon = Beacon.create!(title: "Beacon-#{i}", description: "This is beacon ##{i}")
  order = user.orders.create!
  order.products << product
  order.promotions << promotion

  5.times do |i_2|
    beacon.notifications.create!(title: "Notification-#{i}-#{i_2}", description: "This is notification ##{i}-#{i_2}")
  end
end
