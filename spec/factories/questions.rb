FactoryBot.define do
  factory :question do
    association :user
    title { "Question Title" }
    content { "Lorem Ipsum Dolor Sit Amet" }

    after :create do |question|
      create_list :answer, 3, question: question, user: question.user
      2.times { question.tags.create(name: Faker::Alphanumeric.alphanumeric(number: rand(7..15))) }
    end
  end
end
