FactoryGirl.define do
  factory :line_item do
    association :order
    association :lineable, factory: :product
  end
end