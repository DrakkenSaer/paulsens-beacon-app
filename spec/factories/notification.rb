FactoryGirl.define do 
    factory :notification do
        title "test"
        description "test description"
        entry_message "test entry message"
        exit_message "test exit message"
        association :beacon
    end
end