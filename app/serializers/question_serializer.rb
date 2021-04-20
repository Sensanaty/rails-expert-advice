class QuestionSerializer
  include JSONAPI::Serializer

  attributes :title, :content, :user_id, :tags
end
