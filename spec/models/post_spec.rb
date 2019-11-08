require "rails_helper"

RSpec.describe Post, type: :model do

  it "creates a post with a User id, content and image" do
    image_path = "#{::Rails.root}/storage/defaults/default_post_image.png"
    image = { 
      io: File.open(image_path),
      filename: "default_post_image.png",
      content_type: "image/png"
    }

    user = User.create(
      name: "User",
      username: "User1",
      email: "test@test.com",
      password: "password1^"
    )
    post = Post.create(
      user_id: user.id,
      caption: "Test content",
      image: image
    )
    expect(post.valid?()).to be(true)
  end

  it "must have a User id" do
  end

  it "must have content" do
  end

  it "must have an image" do
  end

  it "destroys dependent Likes when it is destroyed" do
  end

end