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
  end

end
