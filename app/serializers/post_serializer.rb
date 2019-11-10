class PostSerializer
  include Rails.application.routes.url_helpers

  def initialize(post)
    @post = post
  end

  def serialize
    {
      post: {
        user_id: @post.user.id,
        username: @post.user.username,
        image_url: get_image_url(),
        caption: @post.caption,
        # most_recent_likes: post.get_most_recent_likes(),
        like_count: @post.likes.length
        # created_at: post.created_at
      }
    }.to_json()
  end

  private def get_image_url
    url_for(@post.image)
  end

end