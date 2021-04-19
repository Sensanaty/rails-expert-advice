FactoryBot.define do
  factory :question do
    association :user
    title { "Question Title" }
    content { "Lorem Ipsum Dolor Sit Amet" }
  end
end
