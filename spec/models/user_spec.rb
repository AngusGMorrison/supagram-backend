require "rails_helper"

def createBaseUser
  User.create(
    name: "Test",
    email: "test@test.com",
    password: "password1",
  )
end

RSpec.describe User, type: :model do

  it "creates a User with name, email and password" do
    user = createBaseUser
    expect(User.first).to eq(user);
  end

  it "must have a name between 2 and 50 characters" do
  end

  it "must have a username between 4 and 30 characters" do
  end

  it "must have a unique username" do
  end

  it "cannot be created without an email" do
  end

  it "must have a unique email" do
  end

  it "cannot be created without a password" do
  end

  it "must have a password between 8 and 30 characters" do
  end

  it "must have a password with at least 1 special character" do
  end

  it "must have a password with at least 1 number" do
  end

  it "can have an attached avatar" do
    user = createBaseUser
    avatarPath = "#{::Rails.root}/storage/defaults/default_avatar.png"
    user.avatar.attach(io: File.open(avatarPath), filename: "default_avatar.png", content_type: "image/png")
    expect(user.avatar).to be_truthy
  end

  it "is created with a default avatar" do
  end

end