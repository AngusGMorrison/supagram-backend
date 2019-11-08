require "rails_helper"

RSpec.describe Follow, type: :model do

  before(:all) do
    user1 = User.create(
      name: "User",
      username: "User1",
      email: "test1@test.com",
      password: "password1^"
    )
    user2 = User.create(
      name: "User",
      username: "User2",
      email: "test2@test.com",
      password: "password1^"
    )
    user3 = User.create(
      name: "User",
      username: "User3",
      email: "test3@test.com",
      password: "password1^"
    )
  end

  it "creates a Follow joining 2 users" do
    follow = Follow.create(
      followed_id: User.first.id,
      follower_id: User.second.id
    )
    expect(follow.valid?()).to be(true)
  end

  it "correctly returns a User's followers" do
    Follow.create(
      followed_id: User.first.id,
      follower_id: User.second.id
    )
    Follow.create(
      followed_id: User.first.id,
      follower_id: User.third.id
    )
    expect(User.first.followers.length).to eq(2)
  end

  it "correctly returns a User's followed Users" do
    Follow.create(
      followed_id: User.first.id,
      follower_id: User.second.id
    )
    Follow.create(
      followed_id: User.third.id,
      follower_id: User.second.id
    )
    expect(User.second.followed.length).to eq(2)
  end

  it "prevents duplicates" do
  end

end