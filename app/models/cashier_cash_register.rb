class CashierCashRegister < ApplicationRecord
  validates :cashier_id, :cash_register_id, :status, presence: true
  validate :user_is_cashier

  belongs_to :cashier, class_name: 'User'
  belongs_to :cash_register

  def close
    self.status = false
    self.save
  end

  def user_is_cashier
    if !self.cashier.is_cashier? 
      errors.add(:cashier, "must be a cashier")
    end
  end

end
