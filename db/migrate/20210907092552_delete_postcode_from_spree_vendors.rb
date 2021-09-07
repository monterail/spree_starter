class DeletePostcodeFromSpreeVendors < ActiveRecord::Migration[6.1]
  def up
    remove_column :spree_vendors, :postcode, :string
  end

  def down
    add_column :spree_vendors, :postcode, :string
  end
end
