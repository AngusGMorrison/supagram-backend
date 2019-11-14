class PostSerializer

  def initialize(posts:, user:)
    @posts = posts
    @serialized_user = UserSerializer.new(user: user).serialize()
  end

  def serialize_as_json
    serialize().to_json()
  end
  
  def serialize
    { posts: serialize_each_post() }
  end
  
  def serialize_with_user_as_json
    serialize_with_user.to_json()
  end

  def serialize_with_user
    {
      posts: serialize_each_post(),
      user: @serialized_user
    }
  end

  private def serialize_each_post
    if @posts.is_a?(ActiveRecord::AssociationRelation)
      @posts.map() { |post| serialize_post(post) }
    else
      serialize_post(@posts)
    end
  end

  private def serialize_post(post)
    {
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
  end

end