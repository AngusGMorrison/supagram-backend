require "rails_helper"

RSpec.describe User, type: :model do

  it "creates a user" do
    User.create(
      name: "Test",
      email: "test@test.com",
      password: "password1",
    )
  end

end