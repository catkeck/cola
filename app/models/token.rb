class Token < ApplicationRecord
  validates :store_id, :code, :date, presence: true
  belongs_to :store

  def self.find_or_create(store_id)
    token = Token.find_by(date: Date.today, store_id: store_id)
    if token.nil?
      Token.create(date: Date.today, store_id: store_id, code: self.generate_code)
    else
      token
    end
  end

  private

  def self.generate_code
    rand(36**4).to_s(36)
  end

end