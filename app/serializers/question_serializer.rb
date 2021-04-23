class QuestionSerializer
  include JSONAPI::Serializer
  set_key_transform :dash

  attributes :title, :content, :user_id, :tags
  has_many :answers
end
