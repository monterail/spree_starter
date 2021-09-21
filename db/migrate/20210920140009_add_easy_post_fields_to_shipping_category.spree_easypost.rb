# This migration comes from spree_easypost (originally 20171221020700)
class AddEasyPostFieldsToShippingCategory < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_shipping_categories, :use_easypost, :boolean, default: false
  end
end
