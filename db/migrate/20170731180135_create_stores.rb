class CreateStores < ActiveRecord::Migration[5.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.integer :latitude
      t.integer :longitude
      t.string :address
      t.integer :admin_id
      t.timestamps
    end
  end
end
