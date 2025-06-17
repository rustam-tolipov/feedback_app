class Feedback < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product

  validates :rating, include: { in: 1..5}
  validates :comment
end
