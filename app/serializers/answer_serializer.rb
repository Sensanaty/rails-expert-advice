class AnswerSerializer
  include JSONAPI::Serializer
  set_key_transform :dash

  attributes :content, :user_email, :question_id, :user_id
  belongs_to :question

  attribute :user_email do |answer|
    answer.user.email
  end
end
