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
user = User.create(email: "user@email.com", password: "password")

puts "\nCreating a question belonging to the user"
question = Question.create(
  title: "Question Title",
  content: Faker::Lorem.sentence(word_count: 30, random_words_to_add: 15),
  user: user
)

puts "Creating a tag belonging to the question"
tag = question.tags.create(name: "question-tag")

puts "\nUser: #{user.inspect}"
puts "Question: #{question.inspect}"
puts "Tag: #{tag.inspect}"

puts "Seeding done!"