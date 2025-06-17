class ChangeUserIdOnFeedbacks < ActiveRecord::Migration[7.2]
  def change
    change_column_null :feedbacks, :user_id, true
  end
end
