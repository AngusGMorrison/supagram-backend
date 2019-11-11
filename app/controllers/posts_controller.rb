class PostsController < ApplicationController

  unless Rails.env.development?()
    rescue_from SupagramErrors::PostNotFound do |error|
      render json: { errors: error.message }, status: error.http_status
    end
  end

  def create
    user = get_current_user()
    params[:user_id] = user.id

    post = Post.create(post_params())
    respond_to_post(post, user)
  end

  private def respond_to_post(post, user)
    if post.valid?()
      post_serializer = PostSerializer.new(post)
      render json: post_serializer.serialize_new_post(user)
    else
      render json: { errors: post.errors }, status: 400
    end
  end

  def like
    user = get_current_user()
    post = get_post_to_like()
    params[:user_id] = user.id

    like = Like.create(like_params())
    respond_to_like(like, post)
  end

  private def get_post_to_like
    begin
      Post.find(params[:post_id])
    rescue ActiveRecord::RecordNotFound
      raise SupagramErrors::PostNotFound
    end
  end

  private def respond_to_like(like, post)
    if like.valid?()
      post_serializer = PostSerializer.new(post)
      render json: post_serializer.serialize_new_like()
    else
      render json: { erros: like.errors }, status: 400
    end
  end

  private def post_params
    params.permit(:user_id, :caption, :image)
  end

  private def like_params
    params.permit(:user_id, :post_id)
  end

 

end
