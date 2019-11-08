require "rails_helper"

RSpec.describe Like, type: :model do

  before(:all) do
    image_path = "#{::Rails.root}/storage/defaults/default_post_image.png"
    image = { 
      io: File.open(image_path),
      filename: "default_post_image.png",
      content_type: "image/png"
    }

    User.create(
      name: "User",
      username: "User1",
      email: "test1@test.com",
      password: "password1^"
    )
    Post.create(
      user_id: User.first.id,
      caption: "Test content",
      image: image
    )
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