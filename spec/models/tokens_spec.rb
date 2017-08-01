require 'rails_helper'

RSpec.describe Token, :type => :model do
  let(:valid_admin) {
    User.create(
      name: "Admin User",
      username: "admin_user",
      password: "password",
      access: "admin"
    )
  }
  let(:valid_store) {
    Store.create(
      name: "Walmart",
      latitude: 500.02,
      longitude: 100.04,
      address: "1 Wallaby Way, Seattle, Washington 10000",
      admin: valid_admin
    )
  }
  let(:token_1) {
    Token.generate_code
  }
  let(:token_2) {
    Token.generate_code
  }
  let(:valid_token) {
    Token.create(
      store: valid_store,
      code: token_1,
      date: Date.today
    )
  }
  let(:invalid_token) {
    Token.create(
      store: valid_store,
      date: Date.today
    )
  }
  it "generates a new code when generate_code is called" do
      expect(token_1).not_to eq(token_2)
  end

  it "is valid if it has a store, code, and date" do
    expect(valid_token).to be_valid
  end

  it "is invalid if it is missing a code" do
    expect(invalid_token).not_to be_valid
  end



end