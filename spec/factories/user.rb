FactoryGirl.define do 
    factory :user do
        email { "steve@steve.com" }
        password "password"
        password_confirmation "password"
    
        factory :admin do
            after(:create) {|user| user.add_role(:admin)}
        end
    end
end