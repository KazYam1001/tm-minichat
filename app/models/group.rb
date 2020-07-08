class Group < ApplicationRecord
  # associations
  has_many :messages, dependent: :destroy

  # validations
  validates :name, presence: true
end
