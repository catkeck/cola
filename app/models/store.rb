class Store < ApplicationRecord
  has_many :visits
  has_many :customers, through: :visits
  has_many :cash_registers
  has_many :cashiers, class_name: "User"
  belongs_to :admin, class_name: "User"
  has_many :tokens

end
