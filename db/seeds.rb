require 'faker'

puts "Destroying old DB entries..."
Doorkeeper::Application.destroy_all
User.destroy_all
Question.destroy_all
Tag.destroy_all
QuestionTag.destroy_all
puts "DB Emptied"

puts "Creating Doorkeeper application"
Doorkeeper::Application.create(name: "expert_advice_web", redirect_uri: "http://localhost:3000/")

puts "Creating a user"

puts "\nemail: user@email.com"
puts "password: password"
user = User.create(email: "user@email.com", password: "password", password_confirmation: "password")
account = user.accounts.build
AccountUser.new(user: user, account: account)

user.save

puts "\nCreating a question belonging to the user"
question = Question.create(
  title: Faker::Quote.famous_last_words,
  content: Faker::Lorem.paragraphs(number: rand(15..25)).join("\n"),
  user: user
)

puts "Creating a tag belonging to the question"
tag = question.tags.create(name: "question-tag")
second_tag = question.tags.create(name: "second-tag")

puts "Creating 20 questions with random content"

20.times do
  random_question = Question.create(
    title: Faker::Quote.famous_last_words,
    content: Faker::Lorem.paragraphs(number: rand(15..25)).join("\n"),
    user: user
  )
  random_question.tags.create(name: Faker::Alphanumeric.alphanumeric(number: rand(7..15)))
  random_question.tags.create(name: "question-tag")

  Answer.create(content: Faker::Quote.famous_last_words, user: user, question: random_question)
end

puts "Creating Answers for original question"

20.times do
  Answer.create(
    content: Faker::Lorem.paragraph,
    user: user,
    question: question
  )
end

puts "\nUser: #{user.inspect}"
puts "Question: #{question.inspect}"
puts "Tag: #{tag.inspect}"
puts "Second Tag: #{second_tag.inspect}"

puts "\nSeeding done!"