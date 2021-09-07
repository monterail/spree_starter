class AddCoordinatesToSpreeVendors < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_vendors, :latitude, :float
    add_column :spree_vendors, :longitude, :float
  end
end
