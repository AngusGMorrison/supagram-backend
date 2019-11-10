class UsersController < ApplicationController

  def sign_in
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render_authentication_success(user)
    else
      render json: { errors: "Invalid username or password" }, status: 401
    end
  end

  def sign_up
    user = User.create(user_params())
    if user.valid?()
      render_authentication_success(user)
    else
      render json: { errors: user.errors }, status: 400
    end
  end

  private def user_params
      params.require(:user).permit(:name, :username, :email, :password)
  end

  private def render_authentication_success(user)
    render json: {
      token: issue_token({ user_id: user.id }),
      user: {
        username: user.username,
        post_count: user.get_post_count(),
        follower_count: user.get_follower_count(),
        followed_count: user.get_followed_count()
      }
    }
  end

end
