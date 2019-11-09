require "rails_helper"

RSpec.describe Post, type: :model do

  post_factory = PostFactory.new()

  it "creates a Post with a User id, content and image" do
    post = post_factory.create()
    expect(post.valid?()).to be(true)
  end

  it "must have a User id" do
    post = post_factory.create_without_id()
    expect(post.valid?()).to be(false)
  end

  it "does not require a caption" do
    post = post_factory.create_without_caption()
    expect(post.valid?()).to be(true)
  end

  it "must have an image" do
    post = post_factory.create_without_image()
    expect(post.valid?()).to be(false)
  end

  it "attaches its image on creation" do
    post = post_factory.create()
    expect(post.image.attached?()).to be(true)
  end

  it "destroys dependent Likes when it is destroyed" do
  end

end