class Visit < ApplicationRecord
  validates :customer_id, :store_id, :position, :start_time, :status, presence: true
  belongs_to :customer, class_name: "User"
  belongs_to :store

  #this is not finished, it is just for testing
  
  def eta
    5.minutes
  end
end
