require 'rails_helper'

RSpec.describe CashRegister, :type => :model do
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
  let(:valid_cash_register) {
    CashRegister.create(
      store: valid_store,
      register_number: 1
    )
  }
  let(:invalid_cash_register) {
    CashRegister.create(
      store: valid_store
    )
  }

  it "is valid with a store and register number" do
    expect(valid_cash_register).to be_valid
  end

  it "is invalid if it is missing a register number" do
    expect(invalid_cash_register).not_to be_valid
  end

end