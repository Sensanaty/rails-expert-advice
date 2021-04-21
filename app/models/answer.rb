class Answer < ApplicationRecord
  validates_presence_of :content, :user_id, :question_id

  belongs_to :user
  belongs_to :question
end
