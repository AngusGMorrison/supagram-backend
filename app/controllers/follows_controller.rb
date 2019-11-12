class FollowsController < ApplicationController

  def create
    user = get_current_user()
    params[:follow][:follower_id] = user.id
    @follow = Follow.create(follow_params())
    respond_to_follow()
  end

  private def follow_params
    params.require(:follow).permit(:follower_id, :followed_id)
  end

  private def respond_to_follow
    if @follow.valid?()
      follow_serializer = FollowSerializer.new(@follow)
      render json: follow_serializer.serialize_follow(), status: 200
    else
      render_errors()
    end
  end

  def destroy
    user = get_current_user()
    @follow = Follow.find_by(follower_id: user.id, followed_id: params[:follow][:followed_id])
    if @follow.valid?()
      @follow.destroy()
      follow_serializer = FollowSerializer.new(@follow)
      render json: follow_serializer.serialize_unfollow(), status: 200
    else
      render_errors()
    end
  end

  private def render_errors
    render json: { errors: @follow.errors }, status: 400
  end

end
