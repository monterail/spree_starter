class AddCoordinatesToSpreeZone < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_zones, :latitude, :float
    add_column :spree_zones, :longitude, :float
  end
end
