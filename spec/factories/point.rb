FactoryGirl.define do
  factory :points, class: 'Point' do
    value 123
    type 'Point'
    association :cashable, factory: :user
  end
end
