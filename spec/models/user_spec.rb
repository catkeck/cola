require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:valid_user) {
    User.create(
      name: "Admin User",
      username: "admin_user",
      password: "password",
      access: "admin"
    )
  }
  let(:invalid_user) {
    User.create(
      name: "Invalid User"
    )
  }
  let(:invalid_access_user) {
    User.create(
      name: "Admin User",
      username: "admin_user",
      password: "password",
      access: "potato"
    )
  }
  let(:cashier) {
    User.create(
      name: "Cashier User",
      username: "cashier_user",
      password: "password",
      access: "cashier")
  }

  it "is valid with a name, username, and password" do
    expect(valid_user).to be_valid
  end

  it "is invalid without username or password" do
    expect(invalid_user).not_to be_valid
  end

  it "is invalid with not permitted access type" do
    expect(invalid_access_user).not_to be_valid
  end

  it "is an admin" do
    expect(valid_user.is_admin?).to eq(true)
  end

  it "is not an admin" do
    expect(cashier.is_admin?).to eq(false)
  end

end