class PostsController < ApplicationController

  unless Rails.env.development?()
    rescue_from SupagramErrors::PostNotFound do |error|
      render json: { errors: error.message }, status: error.http_status
    end

    rescue_from SupagramErrors::PostAlreadyLiked do |error|
      render json: { errors: error.message }, status: error.http_status
    end
  end

  def show_feed
    @user = get_current_user()
    feed = @user.get_followed_feed(get_feed_start_datetime())
    serializer = PostSerializer.new(posts: feed, user: @user)
    response = serializer.serialize_with_user_as_json()
    render json: response, status: 200
  end

  def create
    @user = get_current_user()
    params[:user_id] = @user.id

    @post = Post.create(post_params())
    respond_to_post()
  end

  private def post_params
    params.permit(:user_id, :caption, :image)
  end

  private def respond_to_post()
    if @post.valid?()
      post_serializer = PostSerializer.new(posts: @post, user: @user)
      response = post_serializer.serialize_with_user_as_json()
      render json: response, status: 200
    else
      render json: { errors: post.errors }, status: 400
    end
  end

  def like
    @user = get_current_user()
    @post = get_post_from_params()
    params[:user_id] = @user.id
    @like = Like.create(like_params())
    respond_to_like_toggle()
  end

  def unlike
    @user = get_current_user()
    @post = get_post_from_params()
    @like = Like.find_by(user_id: @user.id, post_id: @post.id)
    @like.destroy()
    respond_to_like_toggle()
  end

  private def get_post_from_params
    begin
      Post.find(params[:post_id])
    rescue ActiveRecord::RecordNotFound
      raise SupagramErrors::PostNotFound
    end
  end

  private def like_params
    params.permit(:user_id, :post_id)
  end

  private def respond_to_like_toggle()
    if @like.valid?()
      post_serializer = PostSerializer.new(posts: @post, user: @user)
      response = post_serializer.serialize_as_json()
      render json: response
    else
      render json: { errors: @like.errors }, status: 400
    end
  end

end
