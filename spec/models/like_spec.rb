require "rails_helper"

RSpec.describe Like, type: :model do

  before(:all) do
    user_factory = UserFactory.new()
    user = user_factory.create()
    post_factory = PostFactory.new()
    post = post_factory.create()
  end

  it "creates a like with a User id and Post id" do
    like = Like.create(
      user_id: User.first.id,
      post_id: Post.first.id
    )
    expect(like.valid?()).to be(true)
  end

  it "must have a User id" do
    like = Like.create(
      post_id: Post.first.id
    )
    expect(like.valid?()).to be(false)
  end

  it "must have a Post id" do
    like = Like.create(
      user_id: User.first.id
    )
    expect(like.valid?()).to be(false)
  end
  

end