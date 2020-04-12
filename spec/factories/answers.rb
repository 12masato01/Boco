FactoryBot.define do
  factory :answer do
    association :user
    association :question
    content { "このような解決策があります。" }
  end
end
