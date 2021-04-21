FactoryBot.define do
  factory :answer do
    association :user
    association :question
    content { "MyString" }
  end
end
