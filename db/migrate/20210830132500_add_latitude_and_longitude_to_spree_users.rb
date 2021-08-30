class AddLatitudeAndLongitudeToSpreeUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :spree_users, :latitude, :float
    add_column :spree_users, :longitude, :float
  end
end
