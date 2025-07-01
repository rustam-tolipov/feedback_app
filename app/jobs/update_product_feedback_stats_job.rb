class UpdateProductFeedbackStatsJob < ApplicationJob
  queue_as :default

  def perform(product_id)
    product = Product.find_by(id: product_id)
    return unless product

    avg = product.feedbacks.average(:rating).to_f.round(2)
    count = product.feedbacks.count

    product.update_columns(
      average_rating: avg,
      feedback_count: count
    )
  end
end
