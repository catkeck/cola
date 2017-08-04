class Visit < ApplicationRecord
  validates :customer_id, :store_id, :position, :start_time, :status, presence: true
  belongs_to :customer, class_name: "User"
  belongs_to :store
  #belongs_to :cashier, class_name: "User"

  def time_waiting
    (Time.now - start_time).to_i/60
  end

  def position_in_line
    self.position - self.store.queue.first.position+1
  end

  def eta
    if self.store.all_cashiers == 0
      nil
    elsif (self.store.all_cashiers - self.store.busy_cashiers) >= position_in_line 
      0
    else
      self.store.average_time*position_in_line/self.store.all_cashiers
    end
  end
end
