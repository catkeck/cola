class CashRegister < ApplicationRecord
  validates :register_number, :store_id, presence: true
  has_many :cashier_cash_registers
  has_many :cashiers, through: :cashier_cash_registers
  belongs_to :store

end
