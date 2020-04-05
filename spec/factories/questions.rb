FactoryBot.define do
  factory :question do
    sequence(:title) { |n| "test_name#{n}"}
    sequence(:email) { |n| "test_email#{n}@example.com"}
    password { "password" }
    password_confirmation { "password" }
  end
  end
end
