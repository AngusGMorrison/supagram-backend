class FollowsController < ApplicationController

  def create
    @user = get_current_user()
    params[:follow][:follower_id] = @user.id
    @follow = Follow.create(follow_params())
    respond_to_create_follow()
  end

  private def follow_params
    params.require(:follow).permit(:follower_id, :followed_id)
  end

  private def respond_to_create_follow
    if @follow.valid?()
      follow_serializer = FollowSerializer.new(@follow, @user)
      render json: follow_serializer.serialize(), status: 200
    else
      render_errors()
    end
  end

  def destroy
    @user = get_current_user()
    @follow = Follow.find_by(follower_id: @user.id, followed_id: params[:follow][:followed_id])
    respond_to_destroy_follow()
  end

  private def respond_to_destroy_follow
    if @follow.valid?()
      @follow.destroy()
      follow_serializer = FollowSerializer.new(@follow, @user)
      render json: follow_serializer.serialize(), status: 200
    else
      render_errors()
    end
  end

  private def render_errors
    render json: { errors: @follow.errors }, status: 400
  end

end
