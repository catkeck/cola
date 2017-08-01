require 'rails_helper'

RSpec.describe User, :type => :model do
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
  let(:invalid_store) {
    Store.create(
      latitude: 500.02,
      longitude: 100.04,
      address: "1 Wallaby Way, Seattle, Washington 10000",
      admin: valid_admin
    )
  }
  it "is valid with a name, latitude, longitude, address, and admin_id" do
    expect(valid_store).to be_valid
  end

  it "is invalid if it is missing a name" do
    expect(invalid_store).not_to be_valid
  end

end