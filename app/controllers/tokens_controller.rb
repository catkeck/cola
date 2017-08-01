class TokensController < ApplicationController

  def self.find_or_create(store_id)
    token = Token.find_by(date: Date.today, store_id: store_id)
    if code.nil?
      Token.create(date: Date.today, store_id: store_id, code: generate_code)
    else
      token
    end
  end


  private

  def generate_code
    rand(36**4).to_s(36)
  end

end