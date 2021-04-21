class Question < ApplicationRecord
  validates :user_id, :title, :content, presence: true

  belongs_to :user
  has_many :question_tags, dependent: :delete_all
  has_many :tags, through: :question_tags
  has_many :answers, dependent: :destroy
end
