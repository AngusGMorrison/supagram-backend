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
      render json: follow_serializer.serialize(), status: 200
    else
      render json: { errors: @follow.errors }, status: 400
    end
  end

end
