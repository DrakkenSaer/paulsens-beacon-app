FactoryGirl.define do
  factory :line_item do
    association :order
    association :orderable, factory: :product
  end
end