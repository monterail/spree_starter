# This migration comes from spree_easypost (originally 20180303020138)
class AddTimeZoneToStockLocations < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_stock_locations, :time_zone, :string, :default => "UTC"
  end
end
