class Store < ApplicationRecord
  validates :name, :latitude, :longitude, :address, :admin_id, presence: true
  validate :user_is_admin, :unique_store

  has_many :visits
  has_many :customers, through: :visits
  has_many :cash_registers
  has_many :cashiers, class_name: "User"
  belongs_to :admin, class_name: "User"
  has_many :tokens

  def user_is_admin
    if !self.admin.is_admin? 
      errors.add(:admin, "must be an admin")
    end
  end

  def unique_store
    stores = Store.select{ |store| store.name == self.name && store.address == self.address}
    if stores.count > 1
      errors.add(:name, "A store with this name and address already exists.")
    end
  end

  def queue
    self.visits.select{ |visit| visit.status == "queued"}
  end

  def average_time
    served_visits = self.visits.select{|visit| visit.status=="served"}
    if served_visits.count == 0
      30
    else 
      served_visits.inject(0){ |sum, visit| sum + visit.end_time.to_i - visit.checkout_time.to_i}/served_visits.count
      5
    end
  end

  def busy_cashiers
    self.visits.select{|visit| visit.status == "serving"}.count
  end

  def all_cashiers
    self.cash_registers.select { |cash_register| cash_register.open?}.count
  end
end
