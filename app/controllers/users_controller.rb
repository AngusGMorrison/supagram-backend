class UsersController < ApplicationController

  def sign_in
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      render json: { token: issue_token(user.id) }
    else
      render json: { error: "Invalid username or password" }, status: 401
    end
  end

  def sign_up
    user = User.create(user_params())
    if user.valid?()
      render json: { token: issue_token(user.id) }
    else
      render json: { errors: user.errors }
    end
  end

  private def user_params
    params.permit(:email, :password)
  end

end
