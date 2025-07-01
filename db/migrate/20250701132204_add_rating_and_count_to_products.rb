class AddRatingAndCountToProducts < ActiveRecord::Migration[7.2]
  def change
    add_column :products, :average_rating, :float, default: 0.0, null: false
    add_column :products, :feedback_count, :integer, default: 0, null: false
  end
end
