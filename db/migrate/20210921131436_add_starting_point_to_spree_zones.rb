class AddStartingPointToSpreeZones < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_zones, :starting_point, :string
  end
end
