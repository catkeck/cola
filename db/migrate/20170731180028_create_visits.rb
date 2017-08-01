class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.integer :customer_id
      t.integer :store_id
      t.integer :position
      t.datetime :start_time
      t.datetime :checkout_time
      t.datetime :end_time
      t.string :status

      t.timestamps
    end
  end
end
