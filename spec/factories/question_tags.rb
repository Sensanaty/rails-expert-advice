FactoryBot.define do
  factory :question_tag do
    association :question
    association :tag
  end
end
