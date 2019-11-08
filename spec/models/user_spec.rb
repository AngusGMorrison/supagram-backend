require "rails_helper"

RSpec.describe User, type: :model do

  name = "Test"
  username = "TestUsername"
  email = "test@test.com"
  password = "password1^"

  let(:default_user) {User.create(name: name, username: username, email: email, password: password)}

  it "creates a User with name, username, email and password" do
    user = default_user
    expect(User.first).to eq(user);
  end

  it "must have a name between 2 and 50 characters" do
    user = User.create(
      name: "",
      username: username,
      email: email,
      password: password
    )
    expect(user.valid?()).to be(false)

    user = User.create(
      name: ("a" * 51),
      username: username,
      email: email,
      password: password
    )
    expect(user.valid?()).to be(false)

    expect(default_user.valid?()).to be(true)
  end

  it "must not have a name with special characters other than ' -" do
    user = User.create(
      name: "Te@s_.t",
      username: username,
      email: email,
      password: password
    )
    expect(user.valid?()).to be(false)
  end

  it "must not have a name that contains numbers" do
    user = User.create(
      name: "Test1",
      username: username,
      email: email,
      password: password
    )
    expect(user.valid?()).to be(false)
  end

  it "must have a name that starts with a letter" do
    user = User.create(
      name: " Test",
      username: username,
      email: email,
      password: password
    )
    expect(user.valid?()).to be(false)
  end

  it "must have a name that ends with a letter" do
    user = User.create(
      name: "Test ",
      username: username,
      email: email,
      password: password
    )
    expect(user.valid?()).to be(false)
  end

  it "converts name to title case before save" do
    user = User.create(
      name: "test user",
      username: username,
      email: email,
      password: password
    )
    expect(user.name).to eq("Test User")
  end

  it "must have a username between 4 and 30 characters" do
    user = User.create(
      name: name,
      username: "Tes",
      email: email,
      password: password
    )
    expect(user.valid?()).to be(false)

    user = User.create(
      name: name,
      username: ("T" * 31),
      email: email,
      password: password
    )
    expect(user.valid?()).to be(false)

    expect(default_user.valid?()).to be(true)
  end

  it "must have a unique username" do
    user1 = default_user
    user2 = User.create(
      name: name,
      username: username,
      email: "newemail@test.com",
      password: password
    )
    expect(user2.valid?()).to be(false)
  end

  it "must have a username that starts with a letter, number or _" do
  end

  it "must have a username that ends with a letter, number or _" do
  end

  it "must not have a username with two consecutive . " do
  end

  it "must not contain special characters other than . and _" do
  end

  it "cannot be created without an email" do
  end

  it "must have a unique email" do
  end

  it "cannot be created without a password" do
  end

  it "must have a password of at least 8 characters" do
  end

  it "must have a password with at least 1 special character" do
  end

  it "must have a password with at least 1 number" do
  end

  it "is created with a default avatar" do
    expect(default_user.avatar).to be_truthy()
  end

  it "can have only one attached avatar" do
  end

  it "is created with a default avatar" do
  end

end