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

  scope :search, ->(query) {
    where("lower(name) LIKE ?", "%#{query.downcase}%") if query.present?
  }

  scope :filter_by_rating, ->(rating) {
    return all if rating.blank?

    where("average_rating >= ?", rating.to_f)
  }
end
