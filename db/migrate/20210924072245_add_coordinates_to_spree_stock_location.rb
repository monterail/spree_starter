class AddCoordinatesToSpreeStockLocation < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_stock_locations, :latitude, :float
    add_column :spree_stock_locations, :longitude, :float
  end
end
