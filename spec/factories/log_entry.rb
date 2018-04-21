FactoryBot.define do
  factory :log_entry do
    user
    date Date.today
    volume 10
  end
end
