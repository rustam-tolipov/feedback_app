class Product < ApplicationRecord
  has_many :feedbacks, dependent: :destroy
end
