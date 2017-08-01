class Visit < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :store
end
