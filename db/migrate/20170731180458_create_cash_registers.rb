class CreateCashRegisters < ActiveRecord::Migration[5.1]
  def change
    create_table :cash_registers do |t|
      t.integer :store_id
      t.integer :register_number
      t.boolean :open

      t.timestamps
    end
  end
end
