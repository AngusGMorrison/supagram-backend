require "rails_helper"

RSpec.describe User, type: :model do

  it "creates a User with name, username, email and password" do
    user = UserFactory.create()
    expect(User.first).to eq(user);
  end

  it "must have a name" do
    user = UserFactory.create(name: "")
    expect(user.valid?()).to be(false)
  end

  it "must have a name of at least 2 characters" do
    user = UserFactory.create(name: "a")
    expect(user.valid?()).to be(false)
  end

  it "must have a name no longer than 50 characters" do
    user = UserFactory.create(name: ("a" * 51))
    expect(user.valid?()).to be(false)
  end

  it "must not have a name with special characters other than ' -" do
    user = UserFactory.create(name: "Te@s_.t")
    expect(user.valid?()).to be(false)
  end

  it "must not have a name that contains numbers" do
    user = UserFactory.create(name: "Test1")
    expect(user.valid?()).to be(false)
  end

  it "must have a name that starts with a letter" do
    user = UserFactory.create(name: " Test")
    expect(user.valid?()).to be(false)
  end

  it "must have a name that ends with a letter" do
    user = User.create(name: "Test ")
    expect(user.valid?()).to be(false)
  end

  it "converts name to title case before save" do
    user = UserFactory.create(name: "test user")
    expect(user.name).to eq("Test User")
  end

  it "must have a username" do
    user = UserFactory.create(username: "")
    expect(user.valid?()).to be(false)
  end

  it "must have a username of at least 4 characters" do
    user = UserFactory.create(username: "Tes")
    expect(user.valid?()).to be(false)
  end

  it "must have a username of no more than 30 characters" do
    user = UserFactory.create(username: ("a" * 31))
    expect(user.valid?()).to be(false)
  end

  it "must have a unique username" do
    user1 = UserFactory.create()
    user2 = UserFactory.create(username: user1.username)
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
    user = UserFactory.create()
    expect(user.avatar.attached?()).to be(true)
  end

  it "can have only one attached avatar" do
  end

  it "destroys dependent Follows when it is destroyed" do
  end

  it "destroys dependent Likes when it is destroyed" do
  end

end