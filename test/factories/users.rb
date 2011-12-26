# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name            "Jane"
    last_name             "Roe"
    sequence(:login) {|n| "login#{n}"}                 
    email                 {"#{login}@example.com"}
    password              "badpass"
    password_confirmation "badpass"
  end
end
