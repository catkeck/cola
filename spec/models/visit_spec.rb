require 'rails_helper'

RSpec.describe Visit, :type => :model do
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
      access: "cashier")
  }
  let(:customer) {
    User.create(
      name: "Customer",
      username: "customer_user",
      password: "password",
      access: "customer"
    )
  }
  let(:valid_store) {
    Store.create(
      name: "Walmart",
      latitude: 500.02,
      longitude: 100.04,
      address: "1 Wallaby Way, Seattle, Washington, 10000",
      admin: valid_admin
    )
  }
  let(:valid_visit) {
    Visit.create(
      customer: customer,
      store: valid_store,
      position: 1,
      start_time: Time.now,
      status: "queued"
    )
  }
  let(:invalid_visit) {
    Visit.create(
      customer: customer,
      position: 1,
      start_time: Time.now,
      status: "queued"
    )
  }
  let(:incorrect_creator) {
    Visit.create(
      customer: cashier,
      position: 1,
      start_time: Time.now,
      status: "queued"
    )
  }

  it "is valid with a customer, store, position, start_time, and status" do
    expect(valid_visit).to be_valid
  end

  it "is invalid if it is missing a store" do
    expect(invalid_visit).not_to be_valid
  end

  it "is invalid if the creator is a cashier" do
    expect(incorrect_creator).not_to be_valid
  end

end