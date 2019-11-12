class PostSerializer
  include Rails.application.routes.url_helpers

  def initialize(post, user)
    @post = post
    @user = user
  end

  def serialize_new_post()
    {
      post: {
        id: @post.id,
        creator_id: @post.user.id,
        username: @post.user.username,
        image_url: @post.get_image_url,
        caption: @post.caption,
        most_recent_likes: @post.get_most_recent_likes(),
        like_count: @post.likes.length,
        created_at: @post.created_at,
        liked_by_user: @post.liked_by?(@user)
      },
      user: {
        post_count: @user.get_post_count()
      }
    }.to_json()
  end

  def serialize_likes()
    {
      post: {
        id: @post_id,
        like_count: @post.likes.length,
        liked_by_user: @post.liked_by?(@user)
      }
    }.to_json()
  end

  def serialize_feed_post
  end

end