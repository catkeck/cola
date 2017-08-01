require 'rails_helper'

RSpec.describe CashierCashRegister, :type => :model do
  let(:valid_admin) {
    User.create(
      name: "Admin User",
      username: "admin_user",
      password: "password",
      access: "admin"
    )
  }
  let(:cashier) {
    User.create(
      name: "Cashier User",
      username: "cashier_user",
      password: "password",
      access: "cashier"
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
  let(:valid_cashier_cash_register) {
    CashierCashRegister.create(
      cashier: cashier,
      cash_register: valid_cash_register,
      status: true
    )
  }
  let(:invalid_cashier_cash_register) {
    CashierCashRegister.create(
      cashier: cashier,
      cash_register: valid_cash_register
    )
  }
  let(:invalid_cashier_cash_register_if_not_cashier) {
    CashierCashRegister.create(
      cashier: valid_admin,
      cash_register: valid_cash_register,
      status: true
    )
  }

  it "is valid with a cashier and cash register" do
    expect(valid_cashier_cash_register).to be_valid
  end

  it "is invalid if it is missing a status" do
    expect(invalid_cashier_cash_register).not_to be_valid
  end

  it "is invalid if user is an admin instead of a cashier" do
    expect(invalid_cashier_cash_register_if_not_cashier).not_to be_valid
  end

end