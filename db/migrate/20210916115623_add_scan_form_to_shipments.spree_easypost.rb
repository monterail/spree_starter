# This migration comes from spree_easypost (originally 20180225034448)
class AddScanFormToShipments < ActiveRecord::Migration[4.2]
  def change
    add_reference :spree_shipments, :scan_form, index: true
  end
end
