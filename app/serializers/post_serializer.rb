class PostSerializer

  def self.serialize(post)
    post =  {
      post: {
        user_id: post.user.id,
        username: post.user.username,
        image: post.image,
        caption: post.caption,
        most_recent_likes: post.get_most_recent_likes()
        like_count: post.likes.length
        created_at: post.created_at
      }
    }
    post.to_json()
  end

end