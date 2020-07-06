class Message < ApplicationRecord
  # associations
  belongs_to :group

  # validations
  validates :content, presence: true
end
