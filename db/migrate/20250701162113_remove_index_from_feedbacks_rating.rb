class RemoveIndexFromFeedbacksRating < ActiveRecord::Migration[7.2]
  def change
    remove_index :feedbacks, :rating
  end
end
