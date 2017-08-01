class CashRegister < ApplicationRecord
  validates :register_number, :store_id, presence: true
  has_many :cashier_cash_registers
  has_many :cashiers, through: :cashier_cash_registers
  belongs_to :store

  def open?
    !!self.cashier_cash_registers.find_by(status: true)
  end

  def current_cashier
    self.cashier_cash_registers.find_by(status: true).cashier
  end

end
