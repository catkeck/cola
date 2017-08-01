class CreateCashierCashRegisters < ActiveRecord::Migration[5.1]
  def change
    create_table :cashier_cash_registers do |t|
      t.integer :cashier_id
      t.integer :cash_register_id
      t.datetime :date

      t.timestamps
    end
  end
end
