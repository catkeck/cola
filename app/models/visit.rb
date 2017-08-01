class Visit < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :store

  #this is not finished, it is just for testing
  
  def eta
    5.minutes
  end
end
