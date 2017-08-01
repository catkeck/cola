class Store < ApplicationRecord
  validates :name, :latitude, :longitude, :address, :admin_id, presence: true

  has_many :visits
  has_many :customers, through: :visits
  has_many :cash_registers
  has_many :cashiers, class_name: "User"
  belongs_to :admin, class_name: "User"
  has_many :tokens

end
