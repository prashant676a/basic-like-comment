FactoryBot.define do
  sequence :email do |n|
    "user#{n}@example.com"
  end

  factory :user do
    name "Prashant"
    # email "prashant@gmail.com"
    email
    password "prashant"
  end

  factory :course do
    name {"A sample course"}
    user
  end
end

# unsaved_user = build(:user)
# saved_user = create(:user)

# user_attributes = attributes_for(:user)



#another feature associations
FactoryBot.define do
  factory :user do
    name "Jeff Morhous"
    email "jeffmorhous@example.com"

    trait :admin do
      role "admin"
    end
  end
end

#build_stubbed -> gem) appearance of persisted record w/o hit database

