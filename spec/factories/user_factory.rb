FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "factory_user#{n}@example.com"
    end
    password 'password'
  end
end
