class AddRowOrderToProducts < ActiveRecord::Migration
  def change
  	add_column :products, :row_order, :integer
  end
end
