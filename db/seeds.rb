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
Question.create(
  title: (Faker::Quote.famous_last_words).gsub(/\.\z/, "?"),
  content: Faker::Lorem.paragraphs(number: rand(15..25)).join("\n"),
  user: user
)

puts "Creating 20 questions with random content"

20.times do
  Question.create(
    title: (Faker::Quote.famous_last_words).gsub!(/[.!]\z/, "?"),
    content: Faker::Lorem.paragraphs(number: rand(15..25)).join("\n"),
    user: user
  )
end

puts "Creating answers for every question"

Question.all.each do |question|
  rand(5..10).times do
    Answer.create(
      content: Faker::Food.description,
      user: user,
      question: question
    )
  end

  question.tags.create(name: "question-tag")
end

puts "\nSeeding done!"