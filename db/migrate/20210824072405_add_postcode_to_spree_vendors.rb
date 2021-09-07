class AddPostcodeToSpreeVendors < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_vendors, :postcode, :string
  end
end
