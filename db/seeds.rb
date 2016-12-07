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


5.times do |i|
  Promotion.create(title: "Promotion ##{i}", description: "A Promotion.", code: "promo#{i}")

  User.create(email: "user-#{i}@paulsens.com", password: "password-#{i}", password_confirmation: "password-#{i}")
end