class RemoveIndexFromProductsName < ActiveRecord::Migration[7.2]
  def change
    remove_index :products, :name
  end
end
