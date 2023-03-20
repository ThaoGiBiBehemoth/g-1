class Task < ApplicationRecord
  belongs_to :user
  validates :title,   presence: true, length: {maximum: 50}
  validates :descrip, presence: true, length: {maximum: 250}
end
