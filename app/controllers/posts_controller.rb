class PostsController < ApplicationController

  unless Rails.env.development?()
    rescue_from SupagramErrors::PostNotFound do |error|
      render json: { errors: error.message }, status: error.http_status
    end
  end

  def show_feed
    @user = get_current_user()
    feed = @user.get_feed(get_feed_start_datetime())
    post_serializer = PostSerializer.new(feed: feed, user: @user)
    render json: post_serializer.serialize_feed_with_user(), status: 200
  end

  # private def get_feed
  #   @user.followed_posts
  #     .where("posts.created_at < ?", get_feed_start_date())
  #     .order(created_at: :desc)
  #     .limit(25)
  # end

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
      post_serializer = PostSerializer.new(post: @post, user: @user)
      render json: post_serializer.serialize_new_post()
    else
      render json: { errors: post.errors }, status: 400
    end
  end

  def like
    @user = get_current_user()
    @post = get_post_from_params()
    params[:user_id] = @user.id

    # Infinite loop occurs if user has already liked post. Fix.
    @like = Like.create(like_params())
    respond_to_like()
  end

  private def like_params
    params.permit(:user_id, :post_id)
  end

  private def respond_to_like()
    if @like.valid?()
      post_serializer = PostSerializer.new(post: @post, user: @user)
      render json: post_serializer.serialize_likes()
    else
      render json: { errors: like.errors }, status: 400
    end
  end

  def unlike
    @user = get_current_user()
    @post = get_post_from_params()
    like = Like.find_by(user_id: @user.id, post_id: @post.id)
    like.destroy()
    respond_to_unlike()
  end

  private def get_post_from_params
    begin
      Post.find(params[:post_id])
    rescue ActiveRecord::RecordNotFound
      raise SupagramErrors::PostNotFound
    end
  end

  private def respond_to_unlike()
    post_serializer = PostSerializer.new(post: @post, user: @user)
    render json: post_serializer.serialize_likes()
  end

end
