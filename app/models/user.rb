class User < ApplicationRecord
  validates :name, :username, :password_digest, presence: true
  validates :access, inclusion: { in: %w(admin cashier customer), message: "%{value} is not a valid access type"}

  #cashier 
  has_secure_password
  
  has_many :cashier_cash_registers, foreign_key: "cashier_id"
  has_many :cash_registers, through: :cashier_cash_registers
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
end
