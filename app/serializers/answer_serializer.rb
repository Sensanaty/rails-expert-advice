class AnswerSerializer
  include JSONAPI::Serializer
  attributes :content, :user_email, :question_id, :user_id

  attribute :user_email do |answer|
    answer.user.email
  end
end
