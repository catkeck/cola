class CashierCashRegister < ApplicationRecord
  belongs_to :cashier, class_name: 'User'
  belongs_to :cash_register
end
