class PostsController < ApplicationController

  def create
    @user = get_current_user()
    if @user
      create_post_and_respond()
    else
      render json: { errors: "User not authorized" }, status: 404
    end
  end

  private def create_post_and_respond
    params[:user_id] = @user.id
    post = Post.create(post_params())
    image_url = url_for(post.image)
    if post.valid?
      render PostSerializer.serialize(post, image_url)
    else
      render json: { errors: post.errors }, status: 400
    end
  end

  private def post_params
    params.permit(:user_id, :caption, :image)
  end

end
