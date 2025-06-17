class Feedback < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product

  validates :rating, inclusion: { in: 1..5}
end
