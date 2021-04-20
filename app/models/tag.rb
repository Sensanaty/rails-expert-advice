class Tag < ApplicationRecord
  before_save -> (tag) { tag.name.downcase! }
  validates :name, presence: true
  validate :name_format

  has_many :question_tags, dependent: :destroy
  has_many :questions, through: :question_tags

  private

  def name_format
    # Any combination of alphanumerical characters, case insensitive
    # 0 or 1 of . , or _ followed by more alphanumericals
    # A maximum of 3 periods, dashes or underscores allowed in 1 tag
    format_regex = /\A[^\W_]+(?:[-_.][^\W_]+){0,3}\z/
    errors.add(:name, "'#{name}' is not a valid tag name") unless name.match?(format_regex)
  end
end
