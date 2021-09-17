# This migration comes from spree_easypost (originally 20180225025604)
class CreateSpreeScanForms < ActiveRecord::Migration[4.2]
  def change
    create_table :spree_scan_forms do |t|
      t.string :easy_post_scan_form_id
      t.belongs_to :stock_location, index: true
      t.text :scan_form
      t.timestamps null: false
    end
  end
end
