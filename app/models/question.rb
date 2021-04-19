class Question < ApplicationRecord
  validates :user_id, :title, :content, presence: true

  belongs_to :user
  has_many :question_tags, dependent: :destroy
  has_many :tags, through: :question_tags
end
