FactoryBot.define do
  factory :answer do
    title { "MyString" }
    content { "MyText" }
    expert { nil }
    question { nil }
  end
end
