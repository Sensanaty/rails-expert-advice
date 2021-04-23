class QuestionSerializer
  include JSONAPI::Serializer
  set_key_transform :dash

  attributes :title, :content, :user_id, :user_email, :tags
  has_many :answers

  attribute :user_email do |question|
    question.user.email
  end
end
