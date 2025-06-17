class AddIndexesToFeedbacks < ActiveRecord::Migration[7.2]
  def change
    add_index :feedbacks, :rating
  end
end
