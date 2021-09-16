# This migration comes from spree_easypost (originally 20180314041118)
class AddNumberToSpreeScanForms < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_scan_forms, :number, :string
  end
end
