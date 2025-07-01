class Product < ApplicationRecord
  has_many :feedbacks, dependent: :destroy

  scope :search, ->(query) {
    where("name ILIKE ?", "%#{sanitize_sql_like(query)}%") if query.present?
  }

  scope :filter_by_rating, ->(rating) {
    rating.present? ? where("average_rating >= ?", rating.to_f) : all
  }
end
