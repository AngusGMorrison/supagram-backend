require "rails_helper"

RSpec.describe Follow, type: :model do

  before(:all) do
    user_factory = UserFactory.new()
    3.times { user_factory.create() }
  end

  it "creates a Follow joining 2 users" do
    follow = Follow.create(
      followed_id: User.first.id,
      follower_id: User.second.id
    )
    expect(follow.valid?()).to be(true)
  end

  it "cannot be created without a followed_id" do
    follow = Follow.create(
      follower_id: User.second.id
    )
    expect(follow.valid?()).to be(false)
  end

  it "cannot be created without a follower_id" do
    follow = Follow.create(
      followed_id: User.second.id
    )
    expect(follow.valid?()).to be(false)
  end

  it "correctly returns a User's followers" do
    Follow.create(followed_id: User.first.id, follower_id: User.second.id)
    Follow.create(followed_id: User.first.id, follower_id: User.third.id)
    expect(User.first.followers.length).to eq(2)
  end

  it "correctly returns a User's followed Users" do
    Follow.create(followed_id: User.first.id, follower_id: User.second.id)
    Follow.create(followed_id: User.third.id, follower_id: User.second.id)
    expect(User.second.followed.length).to eq(2)
  end

  xit "prevents duplicates" do
  end

end