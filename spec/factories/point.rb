FactoryGirl.define do
  factory :credits, class: 'Credit' do
    value 123
    type 'Credit'
    association :cashable, factory: :user
  end
end
