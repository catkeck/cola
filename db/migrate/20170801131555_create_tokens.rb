class CreateTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :tokens do |t|
      t.date :date
      t.string :code
      t.integer :store_id
      t.timestamps
    end
  end
end
