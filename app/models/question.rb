class Question < ApplicationRecord
  validates :user_id, :title, :content, presence: true

  belongs_to :user
end
