class RemoveOpenFromCashRegisters < ActiveRecord::Migration[5.1]
  def change
    remove_column :cash_registers, :open
  end
end
