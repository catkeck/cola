class AddStatusToCashierCashRegisters < ActiveRecord::Migration[5.1]
  def change
    add_column :cashier_cash_registers, :status, :boolean
  end
end
