class Product < ApplicationRecord
  has_many :feedbacks, dependent: :destroy

  scope :with_rating_data, -> {
    base = Product
    .left_joins(:feedbacks)
    .group('products.id')
    .select(
      'products.*',
      'coalesce(avg(feedbacks.rating), 0) as average_rating',
      'count(feedbacks.id) as feedback_count'
      )

      from(base, :products)
  }
end
