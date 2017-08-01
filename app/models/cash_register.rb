class CashRegister < ApplicationRecord
  has_many :cashier_cash_registers
  has_many :cashiers, through: :cashier_cash_registers
  belongs_to :store

end
