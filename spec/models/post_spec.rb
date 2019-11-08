require "rails_helper"

RSpec.describe Post, type: :model do

  it "creates a post with a User id and content" do
    user = User.create(
      name: "User",
      username: "User1",
      email: "test@test.com",
      password: "password1^"
    )
    post = Post.create(
      user_id: user.id,
      caption: "Test content"
    )
    expect(post.valid?()).to be(true)
  end

end