FactoryBot.define do
  factory :question do
    association :user
    title { "腰が痛い" }
    content {  "腰が痛いです。どうすれば良いでしょうか。"}
  end
end
