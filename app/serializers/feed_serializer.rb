class FeedSerializer

  def initialize(feed:, current_user:)
    @user_serializer = UserSerializer.new(user: current_user)
    @post_serializer = PostSerializer.new(posts: feed, user: current_user)
  end

  def serialize_as_json
    serialize.to_json()
  end

  def serialize
    serialized_feed = { feed: @post_serializer.serialize_posts() }
    serialized_user = @user_serializer.serialize()
    serialized_feed.merge(serialized_user)
  end

end