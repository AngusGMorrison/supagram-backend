class PostSerializer

  def initialize(feed: [], post: nil, user:)
    @feed = feed
    @post = post
    @user = user
  end

  def serialize_new_post
    user_details = get_serialized_user_details()
    serialized_new_post = serialize_post(@post).merge(user_details)
    serialized_new_post.to_json()
  end

  def serialize_feed_with_user
    serialized_feed_with_user = serialize_feed().merge(get_serialized_user_details())
    serialized_feed_with_user.to_json()
  end

  private def serialize_feed
    {
      feed: @feed.map() { |post| serialize_post(post) }
    } 
  end

  private def get_serialized_user_details
    user_serializer = UserSerializer.new(@user)
    user_serializer.serialize_user()
  end

  private def serialize_post(post)
    {
      post: {
        id: post.id,
        image_url: post.get_image_url(),
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

  def serialize_profile(profile_owner)
    user_serializer = UserSerializer.new(profile_owner)
    serialized_profile_owner = user_serializer.serialize_profile_owner()
    serialized_profile_feed = serialize_feed()
    serialized_profile_feed_with_owner = serialized_profile_feed.merge(serialized_profile_owner)
    serialized_profile_feed_with_owner.to_json()
  end

end