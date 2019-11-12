class PostSerializer
  include Rails.application.routes.url_helpers

  def initialize(feed: [], post: nil, user: user)
    @feed = feed
    @post = post
    @user = user
  end

  def serialize_new_post()
    user_details = {
      user: {
        post_count: @user.get_post_count()
      }
    }
    serialized_new_post = serialize_post(@post).merge(user_details)
    serialized_new_post.to_json()
  end

  def serialize_feed
    serialized_feed = @feed.map() do |post|
      serialize_post(post)
    end
    serialized_feed.to_json()
  end

  private def serialize_post(post)
    {
      post: {
        id: post.id,
        image_url: post.get_image_url,
        caption: post.caption,
        most_recent_likes: post.get_most_recent_likes(),
        like_count: post.likes.length,
        created_at: post.created_at,
        liked_by_current_user: post.liked_by?(@user),
        author: {
          id: post.user.id,
          username: post.user.username,
          followed_by_current_user: post.user.followed_by?(@user)
        }
      }
    }
  end

  def serialize_likes()
    {
      post: {
        id: @post_id,
        like_count: @post.likes.length,
        liked_by_current_user: @post.liked_by?(@user)
      }
    }.to_json()
  end

end