# This migration comes from spree_easypost (originally 20141223014356)
class AddCustomerShipments < ActiveRecord::Migration[4.2]
  def change
    create_table "spree_customer_shipments" do |t|
      t.belongs_to  :return_authorization
      t.string      :number
      t.decimal     :weight, :precision => 8, :scale => 2
      t.string      :easypost_shipment_id  
      t.string      :tracking   
      t.text        :tracking_label
      t.timestamps  null: false
    end

    add_index :spree_customer_shipments, :return_authorization_id
    add_index :spree_customer_shipments, :tracking
    add_index :spree_customer_shipments, :number
  end
end
