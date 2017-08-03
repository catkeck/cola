class RemoveLatitudeFromStores < ActiveRecord::Migration[5.1]
  def change
    remove_column :stores, :latitude
  end
end
