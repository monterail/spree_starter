# This migration comes from spree_easypost (originally 20180303205234)
class RemoveNameFromSpreeShippingRates < ActiveRecord::Migration[4.2]
  def change
    remove_column :spree_shipping_rates, :name, :string
  end
end
