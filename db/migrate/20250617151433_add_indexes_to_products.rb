class AddIndexesToProducts < ActiveRecord::Migration[7.2]
  def change
    add_index :products, :name
  end
end
