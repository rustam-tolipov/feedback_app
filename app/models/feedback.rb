class Feedback < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :product

  validates :rating, inclusion: { in: 1..5 }

  after_commit :update_product_feedback_stats, on: [:create, :update, :destroy]

  private

  def update_product_feedback_stats
    UpdateProductFeedbackStatsJob.perform_later(product_id)
  end
end
