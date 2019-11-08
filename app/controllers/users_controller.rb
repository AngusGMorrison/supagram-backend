class UsersController < ApplicationController

  def sign_in
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render_authentication_success(user)
    else
      render json: { error: "Invalid username or password" }, status: 401
    end
  end

  def sign_up
    user = User.create(user_params())
    if user.valid?()
      render_authentication_success(user)
    else
      render json: { errors: user.errors }
    end
  end

  private def user_params
    params.require(:user).permit(:name, :username, :email, :password)
  end

  private def render_authentication_success(user)
    render json: { 
      token: issue_token(user.id),
      user: {
        username: user.username,
        post_count: user.getPostCount(),
        follower_count: user.getFollowerCount(),
        followed_count: user.getFollowedCount()
      }
    }
  end

end
