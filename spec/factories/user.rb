FactoryBot.define do
  
  factory :user do
    name { "Prashant" }
    sequence :email do |n|
      "user#{n}@example.com"
    end
    password { "494949" }
  end
end
