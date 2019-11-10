class PostsController < ApplicationController

  def create
    user = User.find_by(id: decode_token())
    if user
      post = Post.create(postParams())
      if post.valid?
        render json: {
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
    else
      render json: { errors: "User not authorized" }, status: 404
    end
  end

  private def postParams
    params.require(:post).permit(:user_id, :caption, :image)
  end

end
