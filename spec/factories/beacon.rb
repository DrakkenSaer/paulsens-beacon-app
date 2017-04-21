FactoryGirl.define do
  factory :beacon do
    title Faker::Lorem.word
    description Faker::Lorem.sentence
    uuid "#{ SecureRandom.uuid }"
    major_uuid Random.rand(1000..9999)
    minor_uuid Random.rand(1000..9999)
  end
end