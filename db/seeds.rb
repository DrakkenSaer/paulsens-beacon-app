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


resource_interval = 100
resource_roles = { user: ["customer", "employee", "admin"] }

admin_user = User.create!( email: "test@test.com", password: "password123" )

resource_roles[:user].each do |role|
    Role.create!(name: role)
    admin_user.add_role(role)
end

resource_interval.times do |i|
    user = User.new( email: Faker::Internet.email, 
                        password: Faker::Internet.password, 
                        phone: Faker::PhoneNumber.phone_number,
                        address: Faker::Address.street_address)
    user.save!
    user.add_role resource_roles[:user].sample
end

resource_interval.times do |i|
    Beacon.create!( title: Faker::Company.name + "_#{i}", 
                  description: Faker::Lorem.paragraph )

    HistoricalEvent.create!( title: Faker::Company.name + "_#{i}",
                    description: Faker::Lorem.paragraph,
                    date: Date.today.prev_day(i))
                    
    Product.create!( title: Faker::Commerce.product_name + "_#{i}",
                    description: Faker::Lorem.paragraph,
                    cost: Faker::Commerce.price)
                    
                    
    Promotion.create!( title: Faker::Company.name + "_#{i}",
                    description: Faker::Lorem.paragraph,
                    code: Faker::Commerce.promotion_code,
                    expiration: Faker::Date.between(Date.today, i.days.from_now),
                    cost: Faker::Commerce.price,
                    redeem_count: Faker::Number.between(1, 100))
end

Beacon.all.each_with_index do |beacon, index|
    5.times do |i|
      beacon.notifications.create!(title: Faker::Commerce.product_name + "_#{index}_#{i}", description: Faker::Lorem.paragraph, entry_message: "Welcome to Paulsen's", exit_message: "Thank you for stopping by!")
    end
end

User.all.each do |user|
  products = Product.all.sample(5)
  promotions = Promotion.all.sample(5)
  order = user.orders.build
  order.products << products
  order.promotions << promotions
  order.save!
end

# 5.times do |i|
#   HistoricalEvent.create!(title: "Historical Event #{i}", description: "This is an event in history ##{i}.", date: Time.now - i.years)
#   promotion = Promotion.create!(title: "Promotion ##{i}", description: "This is promotion ##{i}", code: "promo#{i}")
#   product = Product.create!(cost: "#{100 * (i + 1)}", title: "product-#{i}", description: "This is product ##{i}")
#   user = User.create!(email: "user-#{i}@paulsens.com", password: "password-#{i}")
#   beacon = Beacon.create!(title: "Beacon-#{i}", description: "This is beacon ##{i}")
#   order = user.orders.create!
#   order.products << product
#   order.promotions << promotion

#   5.times do |i_2|
#     beacon.notifications.create!(title: "Notification-#{i}-#{i_2}", description: "This is notification ##{i}-#{i_2}")
#   end
# end
