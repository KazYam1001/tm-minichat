class Group < ApplicationRecord
  # validations
  validates :name, presence: true
end
