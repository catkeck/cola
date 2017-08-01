class AddCashierIdToVisits < ActiveRecord::Migration[5.1]
  def change
    add_column :visits, :cashier_id, :integer
  end
end
