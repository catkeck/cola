class User < ApplicationRecord
  validates :name, :username, :password_digest, presence: true
  validates :username, uniqueness: true
  validates :access, inclusion: { in: %w(admin cashier customer), message: "%{value} is not a valid access type"}
  validate :customer_has_phone_number

  #cashier 
  has_secure_password
  
  has_many :cashier_cash_registers, foreign_key: "cashier_id"
  has_many :cash_registers, through: :cashier_cash_registers
  has_many :visits, foreign_key: "cashierr_id"

  #customer
  has_many :visits, foreign_key: "customer_id"

  #admin
  has_many :stores, foreign_key: "admin_id"
  belongs_to :store, optional: true

  def is_admin?
    self.access == "admin"
  end

  def is_cashier?  
    self.access == "cashier"
  end

  def is_customer?
    self.access == "customer"
  end

  def first_name
    self.name.split(" ").first
  end

  def has_cash_register?
    !!self.cashier_cash_registers.find_by(status: true)
  end

  def current_cash_register
    ccr = self.cashier_cash_registers.find_by(status: true)
    ccr.nil? ? nil : ccr.cash_register
  end

  def close_cash_register
    self.cashier_cash_registers.each do |ccr|
      ccr.close
    end
  end

  def customer_has_phone_number
    if self.is_customer? && !self.phone_number.present?
      errors.add(:phone_number, "can't be blank")
    end
  end
end