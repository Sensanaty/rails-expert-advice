FactoryBot.define do
  factory :answer do
    content { "MyString" }
    user { nil }
    question { nil }
  end
end
