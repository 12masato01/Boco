FactoryBot.define do
  factory :quesiton

  factory :comment do
    association :user
    content { "僕も気になります。" }
    
    trait :for_question do
      association :commentable, factory: :question
    end
  end

end
