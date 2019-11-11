class PostsController < ApplicationController

  def create
    @user = get_current_user()
    if @user
      create_post_and_respond()
    else
      render json: { errors: "User not authorized" }, status: 404
    end
  end

  # def like
  #   @user = get_current_user()
  #   if @user
  #     create_like
  # end

  private def create_post_and_respond
    params[:user_id] = @user.id
    post = Post.create(post_params())
    if post.valid?
      post_serializer = PostSerializer.new(post, @user)
      render json: post_serializer.serialize()
    else
      render json: { errors: post.errors }, status: 400
    end
  end

  private def post_params
    params.permit(:user_id, :caption, :image)
  end

  private def like_params
    params.permit(:user_id, :post_id)
  end

end
