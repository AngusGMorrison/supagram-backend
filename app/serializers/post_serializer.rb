class PostSerializer

  def initialize(posts:, user:)
    @posts = posts
    @serialized_user = UserSerializer.new(user: user).serialize()
  end

  def serialize_new_post_as_json
    serialize_new_post.to_json()
  end

  private def serialize_new_post
    serialized_post = serialize_posts()
    serialized_post.merge(@serialized_user)
  end

  def serialize_posts
    if @posts.is_a?(ActiveRecord::AssociationRelation)
      @posts.map() { |post| serialize_post(post) }
    else
      serialize_post(@posts)
    end
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
        id: @posts.id,
        like_count: @posts.likes.length,
        liked_by_current_user: @posts.liked_by?(@user)
      }
    }.to_json()
  end

end