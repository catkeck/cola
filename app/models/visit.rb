class Visit < ApplicationRecord
  validates :customer_id, :store_id, :position, :start_time, :status, presence: true
  belongs_to :customer, class_name: "User"
  belongs_to :store

  #this is not finished, it is just for testing
  
  def time_waiting
    (Time.now - start_time).to_i/60
  end

  def position_in_line
    self.position - self.store.queue.first.position+1
  end

  def eta
    5.minutes/60
  end
end
